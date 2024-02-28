Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652282B9A7
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 22:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709159944; cv=none; b=vDIbsH153vxcD70D3tcxyPafVQjxSUWwPQnVeAl7XmMvtXPzYe/4rwMVfw8kDmuBzqAn13TWb5947+ToahKw8NnAFO4KrUBZLxLjFd9BhkS1hOhPaDXudaqX3D/KVRHi2kiMYNuHBc439SPKvh4C9vzNmS+1Qe0XTPCjpDdRb6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709159944; c=relaxed/simple;
	bh=oDCbBZ/iVcTn4h9Gh29vyWvbHXNp7Fv1kQzd2REFOJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRb4HaxYB75eNzFxzkY4GTG/j8oMyD0ik/Gxw3sxD6wijLgQyEeVig5n5FpqbCYg1S9DsNWl0liwnuJeeayX47DMo1gjwtvLnpjxEMn3t07MF2PjHQTNatmMm3mv18d2rK/PkHFBvV9jY8lyW6djF9QzFnT25FEFy3NfRbCzN6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23692 invoked by uid 109); 28 Feb 2024 22:39:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 28 Feb 2024 22:39:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26772 invoked by uid 111); 28 Feb 2024 22:39:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 28 Feb 2024 17:39:03 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 28 Feb 2024 17:39:00 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Benjamin Flesch <benjaminflesch@icloud.com>
Subject: [PATCH 7/9] upload-pack: always turn off save_commit_buffer
Message-ID: <20240228223900.GG1158131@coredump.intra.peff.net>
References: <20240228223700.GA1157826@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240228223700.GA1157826@coredump.intra.peff.net>

When the client sends us "want $oid" lines, we call parse_object($oid)
to get an object struct. It's important to parse the commits because we
need to traverse them in the negotiation phase. But of course we don't
need to hold on to the commit messages for each one.

We've turned off the save_commit_buffer flag in get_common_commits() for
a long time, since f0243f26f6 (git-upload-pack: More efficient usage of
the has_sha1 array, 2005-10-28). That helps with the commits we see
while actually traversing. But:

  1. That function is only used by the v0 protocol. I think the v2
     protocol's code path leaves the flag on (and thus pays the extra
     memory penalty), though I didn't measure it specifically.

  2. If the client sends us a bunch of "want" lines, that happens before
     the negotiation phase. So we'll hold on to all of those commit
     messages. Generally the number of "want" lines scales with the
     refs, not with the number of objects in the repo. But a malicious
     client could send a lot in order to waste memory.

As an example of (2), if I generate a request to fetch all commits in
git.git like this:

  pktline() {
    local msg="$*"
    printf "%04x%s\n" $((1+4+${#msg})) "$msg"
  }

  want_commits() {
    pktline command=fetch
    printf 0001
    git cat-file --batch-all-objects --batch-check='%(objectname) %(objecttype)' |
      while read oid type; do
        test "$type" = "commit" || continue
        pktline want $oid
      done
      pktline done
      printf 0000
  }

  want_commits | GIT_PROTOCOL=version=2 valgrind --tool=massif git-upload-pack . >/dev/null

before this patch upload-pack peaks at ~125MB, and after at ~35MB. The
difference is not coincidentally about the same as the sum of all commit
object sizes as computed by:

  git cat-file --batch-all-objects --batch-check='%(objecttype) %(objectsize)' |
  perl -alne '$v += $F[1] if $F[0] eq "commit"; END { print $v }'

In a larger repository like linux.git, that number is ~1GB.

In a repository with a full commit-graph file this will have no impact
(and the commit graph would save us from parsing at all, so is a much
better solution!). But it's easy to do, might help a little in
real-world cases (where even if you have a commit graph it might not be
fully up to date), and helps a lot for a worst-case malicious request.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/upload-pack.c | 2 ++
 upload-pack.c         | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/upload-pack.c b/builtin/upload-pack.c
index 9b021ef026..15afb97260 100644
--- a/builtin/upload-pack.c
+++ b/builtin/upload-pack.c
@@ -8,6 +8,7 @@
 #include "replace-object.h"
 #include "upload-pack.h"
 #include "serve.h"
+#include "commit.h"
 
 static const char * const upload_pack_usage[] = {
 	N_("git-upload-pack [--[no-]strict] [--timeout=<n>] [--stateless-rpc]\n"
@@ -37,6 +38,7 @@ int cmd_upload_pack(int argc, const char **argv, const char *prefix)
 
 	packet_trace_identity("upload-pack");
 	disable_replace_refs();
+	save_commit_buffer = 0;
 
 	argc = parse_options(argc, argv, prefix, options, upload_pack_usage, 0);
 
diff --git a/upload-pack.c b/upload-pack.c
index 2a5c52666e..3970bb9b30 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -526,8 +526,6 @@ static int get_common_commits(struct upload_pack_data *data,
 	int got_other = 0;
 	int sent_ready = 0;
 
-	save_commit_buffer = 0;
-
 	for (;;) {
 		const char *arg;
 
-- 
2.44.0.rc2.424.gbdbf4d014b


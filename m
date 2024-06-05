Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A950A1922FC
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 08:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717574596; cv=none; b=TjqxOLdWF2u4bGZgkQoXDYJs+tGY6shKE2ITrVCRbEP+JuF40mxZrh44FzuvSCuTBHAc0IM/Ez+op7XIqMJKJe1nS4AVUl1wqsZrlsGakK4nOBxovSgE+wTr3CIx0CurRkWmxeOi8kkOATIEiNQKI7MuolB/b3S+z/VGlOKqvxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717574596; c=relaxed/simple;
	bh=d8vt3PKTY6kn07tiTnsznhkUPq5/VXOyn/tSpNSy9yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/vyKcgDt1wUcWzv2jDzxHCqjw6+wYTP/xqX8BSAk18z7fRurfAIhjF0djPcoD0QPV+3t7wb2AVnG1Aq6xxQ+eVLUArufuvOQMOU+R2aFI0rLWdHhni3Po6g9bW+LlZjPlOhpp+eWOjCs6SJnx5FOYoe4NZlqbpXx1r39hzcIvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23032 invoked by uid 109); 5 Jun 2024 08:03:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 05 Jun 2024 08:03:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27727 invoked by uid 111); 5 Jun 2024 08:03:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 05 Jun 2024 04:03:07 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 5 Jun 2024 04:03:08 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] dir.c: skip .gitignore, etc larger than INT_MAX
Message-ID: <20240605080308.GA2345232@coredump.intra.peff.net>
References: <20240531120034.GA442032@coredump.intra.peff.net>
 <xmqqh6eehvj4.fsf@gitster.g>
 <20240604103947.GC1781455@coredump.intra.peff.net>
 <xmqqikyowqjj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqikyowqjj.fsf@gitster.g>

On Tue, Jun 04, 2024 at 10:45:04AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I was hoping to avoid making up an arbitrary number. But your question
> > about gitattributes reminded me that we already did something similar in
> > 3c50032ff5 (attr: ignore overly large gitattributes files, 2022-12-01).
> > There it's a hard-coded 100MB limit (without even a config option).
> >
> > Maybe we should just do the same here?
> 
> Hmph, I thought the 100MB was only for blobs, as we stream the input
> we read from a regular file, but we do have the same limit there
> presumably to match what we do to blobs?  I do not mind that, but I
> do not mind leaving it a future "consolidate various size limits on
> control files used by Git" patch, that unifies the limit for attrs,
> excludes, gitmodules, .git/config, etc.

I think we enforce the limit for files, too. Which makes sense, as we'd
read .gitattributes checked out from an untrusted tree. Even if we
stream it line by line, we still end up scaling some structures with the
total number of lines (and of course the file length also bounds the
line length, though I think we have an even shorter line length limit).

I do not mind if consolidation waits for later, but I guess the
immediate question is whether we'd prefer to reduce the limit set by my
patch to a more security-conservative value. It would be easy to swap
out INT_MAX for a 100MB #define on top.

Maybe this?

-- >8 --
Subject: [PATCH] dir.c: reduce max pattern file size to 100MB

In a2bc523e1e (dir.c: skip .gitignore, etc larger than INT_MAX,
2024-05-31) we put capped the size of some files whose parsing code and
data structures used ints. Setting the limit to INT_MAX was a natural
spot, since we know the parsing code would misbehave above that.

But it also leaves the possibility of overflow errors when we multiply
that limit to allocate memory. For instance, a file consisting only of
"a\na\n..." could have INT_MAX/2 entries. Allocating an array of
pointers for each would need INT_MAX*4 bytes on a 64-bit system, enough
to overflow a 32-bit int.

So let's give ourselves a bit more safety margin by giving a much
smaller limit. The size 100MB is somewhat arbitrary, but is based on the
similar value for attribute files added by 3c50032ff5 (attr: ignore
overly large gitattributes files, 2022-12-01).

There's no particular reason these have to be the same, but the idea is
that they are in the ballpark of "so huge that nobody would care, but
small enough to avoid malicious overflow". So lacking a better guess, it
makes sense to use the same value. The implementation here doesn't share
the same constant, but we could change that later (or even give it a
runtime config knob, though nobody has complained yet about the
attribute limit).

And likewise, let's add a few tests that exercise the limits, based on
the attr ones. In this case, though, we never read .gitignore from the
index; the blob code is exercised only for sparse filters. So we'll
trigger it that way.

Signed-off-by: Jeff King <peff@peff.net>
---
 dir.c                               | 10 ++++++++--
 t/t0008-ignores.sh                  |  8 ++++++++
 t/t6112-rev-list-filters-objects.sh | 12 ++++++++++++
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index 914060edfd..ad2b7ebe2d 100644
--- a/dir.c
+++ b/dir.c
@@ -32,6 +32,12 @@
 #include "tree.h"
 #include "hex.h"
 
+ /*
+  * The maximum size of a pattern/exclude file. If the file exceeds this size
+  * we will ignore it.
+  */
+#define PATTERN_MAX_FILE_SIZE (100 * 1024 * 1024)
+
 /*
  * Tells read_directory_recursive how a file or directory should be treated.
  * Values are ordered by significance, e.g. if a directory contains both
@@ -1149,7 +1155,7 @@ static int add_patterns(const char *fname, const char *base, int baselen,
 		}
 	}
 
-	if (size > INT_MAX) {
+	if (size > PATTERN_MAX_FILE_SIZE) {
 		warning("ignoring excessively large pattern file: %s", fname);
 		free(buf);
 		return -1;
@@ -1211,7 +1217,7 @@ int add_patterns_from_blob_to_list(
 	if (r != 1)
 		return r;
 
-	if (size > INT_MAX) {
+	if (size > PATTERN_MAX_FILE_SIZE) {
 		warning("ignoring excessively large pattern blob: %s",
 			oid_to_hex(oid));
 		free(buf);
diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index 361446b2f4..02a18d4fdb 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -945,4 +945,12 @@ test_expect_success SYMLINKS 'symlinks not respected in-tree' '
 	test_grep "unable to access.*gitignore" err
 '
 
+test_expect_success EXPENSIVE 'large exclude file ignored in tree' '
+	test_when_finished "rm .gitignore" &&
+	dd if=/dev/zero of=.gitignore bs=101M count=1 &&
+	git ls-files -o --exclude-standard 2>err &&
+	echo "warning: ignoring excessively large pattern file: .gitignore" >expect &&
+	test_cmp expect err
+'
+
 test_done
diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
index 43e1afd44c..0387f35a32 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -701,4 +701,16 @@ test_expect_success 'expand blob limit in protocol' '
 	grep "blob:limit=1024" trace
 '
 
+test_expect_success EXPENSIVE 'large sparse filter file ignored' '
+	blob=$(dd if=/dev/zero bs=101M count=1 |
+	       git hash-object -w --stdin) &&
+	test_must_fail \
+		git rev-list --all --objects --filter=sparse:oid=$blob 2>err &&
+	cat >expect <<-EOF &&
+	warning: ignoring excessively large pattern blob: $blob
+	fatal: unable to parse sparse filter data in $blob
+	EOF
+	test_cmp expect err
+'
+
 test_done
-- 
2.45.2.807.g3b5fadc4da


Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ADB13D51E
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 06:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755671440; cv=none; b=R3k1n31YdHVGmOORWI/AarVcFeELFt18VPrgS31z6prWINgTeXMai8H93BIZLQ2ck6AIDts5FNCjpVOj9c1wmAcHErZ233pRAzt9SKYHHXSDAWPZ0LEtN8D/hZfp7GRrAUprny9Jcz3Dbj8P87sjmcIbVrblZgZNs0HzAjyQiu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755671440; c=relaxed/simple;
	bh=QvpEXJAzgTZR79vH/h2QqUPlqZyHPVEbA0E9r1LAKx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCjj19HiPVYejqIZwE/h5bhvaQhm5lel0ayfVvXKmo0gY3a7Su9ZJhvptOCCKBXoHU2GmYhRlOCPjhhN3K+J/jm5KJa/gJumjFelA610KUE8tWv7XRnjwIhOPpBl4DYwSRHfWsMH4hUo8ekKoU+NNekRe7RzFymmRKt37tqzfPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Be4HOafC; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Be4HOafC"
Received: (qmail 35043 invoked by uid 109); 20 Aug 2025 06:30:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=QvpEXJAzgTZR79vH/h2QqUPlqZyHPVEbA0E9r1LAKx4=; b=Be4HOafC7/IYZ3cazwPKwM78pwUnQyXufJWRKuk7kq64k2a3deANG9Aah+yJRkWuS9yARR38yZwkckxjO7yPwuMV7NTZ1xw3zGRbXSkRXqUaZ+x0+uoFOt/J5q7ts+pzK3755/S6XhiFqfd7iutRAT6jSN87QP6q0vj7iqN90a57cR/Gtz6qBKA/ZtNICbjrQk63sO0dNQAWLx0oq11V8mnPJRRCpWelqxcKSiss+M3ocSQRwKy5u8jJXEPXgXZJUtQw19mU3LdtCNfSm6+Gj17Xy/E2kWBeWh1eVNoStTeIrnw58GP1NYXs4ahjfM/M3QJP7tClO3mWuHcpsRVitw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 20 Aug 2025 06:30:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 53350 invoked by uid 111); 20 Aug 2025 06:30:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 20 Aug 2025 02:30:34 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 20 Aug 2025 02:30:34 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, phillip.wood@dunelm.org.uk,
	Cheng <prophecheng@stu.pku.edu.cn>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: [replacement PATCH 4/5] describe: handle blob traversal with no
 commits
Message-ID: <20250820063034.GA1087703@coredump.intra.peff.net>
References: <20250818205812.GA1018043@coredump.intra.peff.net>
 <20250818210312.GD1024556@coredump.intra.peff.net>
 <aKQwP01nulsquhzi@pks.im>
 <20250819165947.GA1050577@coredump.intra.peff.net>
 <aKVQSNgYgt2RO8hd@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aKVQSNgYgt2RO8hd@pks.im>

On Wed, Aug 20, 2025 at 06:34:16AM +0200, Patrick Steinhardt wrote:

> > Ah, no. We did that in b229d18a80 (validate_headref: tighten
> > ref-matching to just branches, 2009-01-29), but had to revert it in
> > e9cc02f0e4 (symbolic-ref: allow refs/<whatever> in HEAD, 2009-02-13) to
> > keep compatibility for topgit. :(
> 
> Well, that's certainly from before my time in the Git project :) I guess
> changing semantics now would be quite risky. Reintroducing this change
> feels out of the picture, but an alternative one could think about is to
> validate that HEAD always points to a commit(-ish?).

Yeah, that's _probably_ OK. I don't remember how topgit works at all,
but I think its custom refs do at least point to commits.

> But ultimately I'm not sure it's even worth it. If people really want to
> shoot themselves into the foot they'll find a way to do so.

Yeah, agreed that it's probably not urgent.

> > Still, I'm not sure it's something I'd want to base a test on. Maybe if
> > there is a big comment that says "It is OK to invalidate and remove this
> > test if we ever tighten symbolic-ref" it would be OK?
> 
> That sounds reasonable to me, yeah.

OK. Here's a replacement for patch 4, then, with a test. Nothing else in
the series should need to be touched.

-- >8 --
Subject: [PATCH] describe: handle blob traversal with no commits

When describing a blob, we traverse from HEAD, remembering each commit
we saw, and then checking each blob to report the containing commit.
But if we haven't seen any commits at all, we'll segfault (we store the
"current" commit as an oid initialized to the null oid, causing
lookup_commit_reference() to return NULL).

This shouldn't be able to happen normally. We always start our traversal
at HEAD, which must be a commit (a property which is enforced by the
refs code). But you can trigger the segfault like this:

  blob=$(echo foo | git hash-object -w --stdin)
  echo $blob >.git/HEAD
  git describe $blob

We can instead catch this case and return an empty result, which hits
the usual "we didn't find $blob while traversing HEAD" error.

This is a minor lie in that we did "find" the blob. And this even hints
at a bigger problem in this code: what if the traversal pointed to the
blob as _not_ part of a commit at all, but we had previously filled in
the recorded "current commit"? One could imagine this happening due to a
tag pointing directly to the blob in question.

But that can't happen, because we only traverse from HEAD, never from
any other refs. And the intent of the blob-describing code is to find
blobs within commits.

So I think this matches the original intent as closely as we can (and
again, this segfault cannot be triggered without corrupting your
repository!).

The test here does not use the formula above, which works only for the
files backend (and not reftables). Instead we use another loophole to
create the bogus state using only Git commands. See the comment in the
test for details.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/describe.c  |  6 ++++--
 t/t6120-describe.sh | 16 ++++++++++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index f7bea3c8c5..72b2e1162c 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -507,8 +507,10 @@ static void process_object(struct object *obj, const char *path, void *data)
 
 	if (oideq(pcd->looking_for, &obj->oid) && !pcd->dst->len) {
 		reset_revision_walk();
-		describe_commit(&pcd->current_commit, pcd->dst);
-		strbuf_addf(pcd->dst, ":%s", path);
+		if (!is_null_oid(&pcd->current_commit)) {
+			describe_commit(&pcd->current_commit, pcd->dst);
+			strbuf_addf(pcd->dst, ":%s", path);
+		}
 		free_commit_list(pcd->revs->commits);
 		pcd->revs->commits = NULL;
 	}
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index feec57bcbc..2c70cc561a 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -423,6 +423,22 @@ test_expect_success 'describe blob on an unborn branch' '
 	test_grep "cannot search .* on an unborn branch" actual
 '
 
+# This test creates a repository state that we generally try to disallow: HEAD
+# is pointing to an object that is not a commit. The ref update code forbids
+# non-commit writes directly to HEAD or to any branch in refs/heads/.  But we
+# can use the loophole of pointing HEAD to another non-branch ref (something we
+# should forbid, but don't for historical reasons).
+#
+# Do not take this test as an endorsement of the loophole! If we ever tighten
+# it, it is reasonable to just drop this test entirely.
+test_expect_success 'describe blob on a non-commit HEAD' '
+	oldbranch=$(git symbolic-ref HEAD) &&
+	test_when_finished "git symbolic-ref HEAD $oldbranch" &&
+	git symbolic-ref HEAD refs/tags/test-blob &&
+	test_must_fail git describe test-blob 2>actual &&
+	test_grep "blob .* not reachable from HEAD" actual
+'
+
 test_expect_success ULIMIT_STACK_SIZE 'name-rev works in a deep repo' '
 	i=1 &&
 	while test $i -lt 8000
-- 
2.51.0.326.gecbb38d78e


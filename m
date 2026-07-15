Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D7B2DA757
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 06:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784095533; cv=none; b=NlEKNtfhlCmmC3FAEa5Tp+x3cLkTnPYa4wQT1dLDYqrr6kdXaoTNGFNyW6AFJyV0Rd3j0x+mXk7WhdC29HOPm6IuPshkG9kCgDbvZz2vweR9Wt+Ujq/ccI4AGTPqqPafuIEbPiu/bjbVrUiKx00y5j6VTjzQGH0KPgSecnfJ1kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784095533; c=relaxed/simple;
	bh=+T9R6kGaXbv2SNWtRcE05OH+zG2mkusTQjoW7gyPV7M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JpCpyyeaXF1I8gMCRwwbVyweXLMa1ZoX22Y843THrPDU9QBvfb5B/laYRsS3SDfzoiqig2aiTODtcQEv4AK4GGN5ocZAVwHdz/2YG5f+sCGqNkxMxetoOqMRtcFdpaIE/zEvJmQ7vT6eXegxgeedmrW2qqAQa8AXeX3PPYclP1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=aDwiNIR6; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="aDwiNIR6"
Received: (qmail 29521 invoked by uid 106); 15 Jul 2026 06:05:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:mime-version:content-type; s=20240930; bh=+T9R6kGaXbv2SNWtRcE05OH+zG2mkusTQjoW7gyPV7M=; b=aDwiNIR6If/M+VzgB7bRdxgII3d3ADPrZ0gLN/zmYT1hm95FdR2sv+smTxpvWeFgO8ec0clkY4cLktknSY9zT20B1Y8HyC7t25LmyPXxQbwF43eypqVGshmokYlfsDBgHf9Epx6hlL0/08hyw8Y7m6z1nOsn3v++1x30ZzridlYBvAzdQOm4OGrQUJs8J6HkI/afc48gimgUwG50T6xqbl3Hw76V6yuA6a5PQy2CQKiqZ0K/74uKgIvCt3F6neYuzxpIC8acg6WLvVkN1/BT91GLMMd5hDobZZFriDwqF/r6d1v6XjugmYKRSxIcwQNe2Z8hA9FrZgScr7ooXoKFOg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Jul 2026 06:05:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 59115 invoked by uid 111); 15 Jul 2026 06:05:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Jul 2026 02:05:28 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 15 Jul 2026 02:05:23 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] diff: ignore unmerged paths outside prefix with --relative
 --cached
Message-ID: <20260715060523.GA517940@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

A diff using --relative ignores entries outside the current directory.
This results in a segfault when we try to process an unmerged entry
that's outside of our prefix, since we end up with a NULL diff_filepair
and use it without checking that it's valid.

I think this bug goes back to 76399c0195 (diff.c: return filepair from
diff_unmerge(), 2011-04-22). Prior to that, diff_unmerge() knew to skip
entries outside of our prefix, due to cd676a5136 (diff --relative:
output paths as relative to the current subdirectory, 2008-02-12). Back
then the caller didn't care that we hadn't added anything to the queue.
In 76399c0195 that changed; we now returned the pair (or NULL), and the
caller in do_oneway_diff() was then called fill_filespec() itself. And
it does so without checking for NULL, causing a segfault.

The obvious fix is to skip the fill_filespec() call (after which we just
return), which this patch does.

There's another call to diff_unmerge() in run_diff_files(). That case
was already fixed by 8174627b3d (diff-lib: ignore paths that are outside
$cwd if --relative asked, 2021-08-22), but of course it didn't help us
for --cached.

That commit also claims that checking the result of diff_unmerge() is
not enough, as we'd want other code paths to skip the entry, too (even
if they wouldn't segfault). But as far as I can tell, that is not true
for --cached. We eventually end up in diff_queue_addremove() or in
diff_queue_change(), both of which know to return early when we're
outside of the prefix.

Arguably we could be checking at the top of oneway_diff() whether the
path is interesting at all. That would not only avoid this code path
entirely, but would also possibly save a small amount of work. But since
everything else appears to work OK, I went for the smallest fix here to
avoid any regression.

Specifically, a comment in oneway_diff() claims we're supposed to
advance o->pos, which we might fail to do if we return early. Though
that "advance" seems to have gone away in da165f470e (unpack-trees.c:
prepare for looking ahead in the index, 2010-01-07), so it is possible
the comment is simply out of date.  We can explore that separately;
checking for a NULL return from diff_unmerge() seems like a sensible
thing to do regardless.

We can piggy-back on the tests added by 8174627b3d; we're just checking
the --cached variant.

Signed-off-by: Jeff King <peff@peff.net>
---
+cc Junio, as you may have some wisdom on that further exploration.

 diff-lib.c               | 2 +-
 t/t4045-diff-relative.sh | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/diff-lib.c b/diff-lib.c
index ae91027a02..a23119b852 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -467,7 +467,7 @@ static void do_oneway_diff(struct unpack_trees_options *o,
 	if (cached && idx && ce_stage(idx)) {
 		struct diff_filepair *pair;
 		pair = diff_unmerge(&revs->diffopt, idx->name);
-		if (tree)
+		if (pair && tree)
 			fill_filespec(pair->one, &tree->oid, 1,
 				      tree->ce_mode);
 		return;
diff --git a/t/t4045-diff-relative.sh b/t/t4045-diff-relative.sh
index 2c8493fe66..167be0bdcc 100755
--- a/t/t4045-diff-relative.sh
+++ b/t/t4045-diff-relative.sh
@@ -245,4 +245,13 @@ test_expect_failure 'diff --relative with change in subdir' '
 	test_cmp expected out
 '
 
+test_expect_success 'diff --relative --cached with change in subdir' '
+	git switch br3 &&
+	test_when_finished "git merge --abort" &&
+	test_must_fail git merge sub1 &&
+	echo file0 >expected &&
+	git -C subdir diff --relative --name-only --cached >out &&
+	test_cmp expected out
+'
+
 test_done
-- 
2.55.0.612.g68473ef936

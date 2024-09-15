Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59C3946C
	for <git@vger.kernel.org>; Sun, 15 Sep 2024 11:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726399228; cv=none; b=ltC1PiRk0P8twjRLIDMI63FSlljLovSNLZxWMy2Z/JCKPd6Zr8xNvnW67CAieJbzCBBcwIuhqKwQKitWcTqhBr0p3QAcDkw/nq4RQrvJAQZNX+CqqLNfcHN1y+ofS81IdSd7C9szPofE6CNuE794H28K8Oh5tzDc09TOEjU+6d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726399228; c=relaxed/simple;
	bh=olBECQvHqpoO1j3w+Cspd8Rw61CiZJJSCE86Kbx76IQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KaubGd0bYRe3pNkl4Rq6p7jLQwoJRkUES7OybFN1b1f88uSYj9Eq81f4ZPO8YXjnTHUeO6RL1QGheg5bvCb7HllQnqPXbvJ9EzBTc/znBvLnpKvrFhoUfGKh8zNZg2cI6ejR6H4erTC2Jgt19jDYFwCXjtaREsj11VLalUSHusI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 8082 invoked by uid 109); 15 Sep 2024 11:20:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 15 Sep 2024 11:20:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22108 invoked by uid 111); 15 Sep 2024 11:20:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 15 Sep 2024 07:20:25 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 15 Sep 2024 07:20:24 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 2/2] git-jump: ignore deleted files in diff mode
Message-ID: <20240915112024.GB2017851@coredump.intra.peff.net>
References: <20240915111119.GA2017770@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240915111119.GA2017770@coredump.intra.peff.net>

If you do something like this:

  rm file_a
  echo change >file_b
  git jump diff

then we'll generate two quickfix entries for the diff, one for each
file. But the one for the deleted file is rather pointless. There's no
content to show since the file is gone, and in fact we open the editor
with the path /dev/null!

In vim, at least, the result is a confusing annoyance: the editor opens
with an empty buffer, and you have to skip past it to the useful
quickfix entry (after scratching your head and figuring out that no,
nothing is broken).

Let's skip such entries entirely. There's nothing useful to show, since
the point is that the file has been deleted.

It is possible that you could be doing a diff whose post-image is not
the working tree, and then you'd perhaps be jumping to the deleted
content (or at least something that was in the same spot). But I don't
think it's worth worrying about that case. For one thing, using git-jump
for such diffs is a bad idea in general, as it's going to sometimes move
you to the wrong spot. And two, a deletion is always going to have one
hunk starting at line 1, which is not that interesting to jump to in the
first place.

Signed-off-by: Jeff King <peff@peff.net>
---
 contrib/git-jump/git-jump | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
index 78e7394406..3f69675961 100755
--- a/contrib/git-jump/git-jump
+++ b/contrib/git-jump/git-jump
@@ -44,7 +44,7 @@ open_editor() {
 mode_diff() {
 	git diff --no-prefix --relative "$@" |
 	perl -ne '
-	if (m{^\+\+\+ (.*)}) { $file = $1; next }
+	if (m{^\+\+\+ (.*)}) { $file = $1 eq "/dev/null" ? undef : $1; next }
 	defined($file) or next;
 	if (m/^@@ .*?\+(\d+)/) { $line = $1; next }
 	defined($line) or next;
-- 
2.46.1.893.gc4b01a7614

Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43212946C
	for <git@vger.kernel.org>; Sun, 15 Sep 2024 11:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726399130; cv=none; b=bKsroy9sgeeacy+JBKJ02aALvUUHkfsjcNfyJbVSCEySxDFJ9lGGw66vtLy9HDHf8f7Dv5goq830ROAwAewDUICSTjUiu59EM6x/H9Xa+G2UHVIkZeowqufPunYSynmyjgMdJVJinMLHZJqKq6FuZxEBMvvHf3q9c2uYPXVk8K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726399130; c=relaxed/simple;
	bh=AWvO4A5sPhM5wSOhFX1u6qrSKL98cHfASogKYhsuP+s=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMlAJptqMSdg5YeP73Vrkrqge2ZlCA8299dE3s4zshtlkAOS5cFssNT5uvABYQvbtXDo8b8jn2z1LmA8jQ1PXMnNkiJy7Vv9Jj5M7EKPf/fF32mJNPAlKqLqowRhsve8nAHjs/o71+N9MuSGaxAJHM/teVy8Etucka5ANMq0BAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 8069 invoked by uid 109); 15 Sep 2024 11:18:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 15 Sep 2024 11:18:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22075 invoked by uid 111); 15 Sep 2024 11:18:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 15 Sep 2024 07:18:46 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 15 Sep 2024 07:18:46 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 1/2] git-jump: always specify column 1 for diff entries
Message-ID: <20240915111846.GA2017851@coredump.intra.peff.net>
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

When we generate a quickfix entry for a diff hunk, we provide just the
filename and line number along with the content, like:

  file:1: contents of the line

This can be a problem if the line itself looks like a quickfix header.
For example (and this is adapted from a real-world case that bit me):

  echo 'static_lease 10:11:12:13:14:15:16 10.0.0.1' >file
  git add file
  echo change >file

produces:

  file:1: static_lease 10:11:12:13:14:15:16 10.0.0.1

which is ambiguous. It could be line 1 of "file", or line 11 of the file
"file:1: static_lease 10", and so on. In the case of vim's default
config, it seems to prefer the latter (you can configure "errorformat"
with a variety of patterns, but out of the box it matches some common
ones).

One easy way to fix this is to provide a column number, like:

  file:1:1: static_lease 10:11:12:13:14:15:16 10.0.0.1

which causes vim to prefer line 1 of "file" again (due to the preference
order of the various patterns in the default errorformat).

There are other options. For example, at least in my version of vim,
wrapping the file in quotation marks like:

  "file":1: static_lease 10:11:12:13:14:15:16 10.0.0.1

also works. That perhaps would the right thing even if you had the silly
file name "file:1:1: foo 10". But it's not clear what would happen if
you had a filename with quotes in it.

This feature is inherently scraping text, and there's bound to be some
ambiguities. I don't think it's worth worrying too much about unlikely
filenames, as its the file content that is more likely to introduce
unexpected characters.

So let's just go with the extra ":1" column specifier. We know this is
supported everywhere, as git-jump's "grep" mode already uses it (and
thus doesn't exhibit the same problem).

The "merge" mode is mostly immune to this, as it only matches "<<<<<<<"
conflict marker lines. It's possible of course to have a marker that
says "foo 10:11" later in the line, but in practice these will only have
branches and perhaps file names, so it's probably not worth worrying
about (and fixing it would involve passing --column to the system grep,
which may not be portable).

I also gave some thought as to whether we could put something more
useful than "1" in the column field for diffs. In theory we could find
the first changed character of the line, but this is tricky in practice.
You'd have to correlate before/after lines of the hunk to decide what
changed. So:

  -this is a foo line
  +this is a bar line

is easy (column 11). But:

  -this is a foo line
  +another line
  +this is a bar line

is harder.

This commit certainly doesn't preclude trying to do something more
clever later, but it's a much deeper rabbit hole than just fixing the
syntactic ambiguity.

Signed-off-by: Jeff King <peff@peff.net>
---
 contrib/git-jump/git-jump | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
index 47e0c557e6..78e7394406 100755
--- a/contrib/git-jump/git-jump
+++ b/contrib/git-jump/git-jump
@@ -50,7 +50,7 @@ mode_diff() {
 	defined($line) or next;
 	if (/^ /) { $line++; next }
 	if (/^[-+]\s*(.*)/) {
-		print "$file:$line: $1\n";
+		print "$file:$line:1: $1\n";
 		$line = undef;
 	}
 	'
-- 
2.46.1.893.gc4b01a7614


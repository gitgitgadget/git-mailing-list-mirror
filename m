Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A382C6B3
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 21:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 8803 invoked by uid 109); 14 Dec 2023 21:47:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 14 Dec 2023 21:47:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11676 invoked by uid 111); 14 Dec 2023 21:47:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 14 Dec 2023 16:47:46 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 14 Dec 2023 16:47:46 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Carlos =?utf-8?B?QW5kcsOpcyBSYW3DrXJleiBDYXRhw7Fv?= <antaigroupltda@gmail.com>
Subject: [PATCH 1/2] t5100: make rfc822 comment test more careful
Message-ID: <20231214214746.GA2798346@coredump.intra.peff.net>
References: <20231214214444.GB2297853@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231214214444.GB2297853@coredump.intra.peff.net>

When processing "From" headers in an email, mailinfo "unquotes" quoted
strings and rfc822 parenthesized comments. For quoted strings, we
actually remove the double-quotes, so:

  From: "A U Thor" <someone@example.com>

become:

  Author: A U Thor
  Email: someone@example.com

But for comments, we leave the outer parentheses in place, so:

  From: A U (this is a comment) Thor <someone@example.com>

becomes:

  Author: A U (this is a comment) Thor
  Email: someone@example.com

So what is the comment "unquoting" actually doing? In our code, being in
a comment section has exactly two effects:

  1. We'll unquote backslash-escaped characters inside a comment
     section.

  2. We _won't_ unquote double-quoted strings inside a comment section.

Our test for comments in t5100 checks this:

  From: "A U Thor" <somebody@example.com> (this is \(really\) a comment (honestly))

So it is covering (1), but not (2). Let's add in a quoted string to
cover this.

Moreover, because the comment appears at the end of the From header,
there's nothing to confirm that we correctly found the end of the
comment section (and not just the end-of-string). Let's instead move it
to the beginning of the header, which means we can confirm that the
existing quoted string is detected (which will only happen if we know
we've left the comment block).

As expected, the test continues to pass, but this will give us more
confidence as we refactor the code in the next patch.

Signed-off-by: Jeff King <peff@peff.net>
---
I did this as a separate patch so it is easy to see that the existing
code already passes the test (i.e., our refactor is a true noop in terms
of behavior, and not fixing or breaking anything).

 t/t5100/comment.expect | 2 +-
 t/t5100/comment.in     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5100/comment.expect b/t/t5100/comment.expect
index 7228177984..bd71956a47 100644
--- a/t/t5100/comment.expect
+++ b/t/t5100/comment.expect
@@ -1,4 +1,4 @@
-Author: A U Thor (this is (really) a comment (honestly))
+Author: (this is (really) a "comment" (honestly)) A U Thor
 Email: somebody@example.com
 Subject: testing comments
 Date: Sun, 25 May 2008 00:38:18 -0700
diff --git a/t/t5100/comment.in b/t/t5100/comment.in
index c53a192dfe..0b7e903b06 100644
--- a/t/t5100/comment.in
+++ b/t/t5100/comment.in
@@ -1,5 +1,5 @@
 From 1234567890123456789012345678901234567890 Mon Sep 17 00:00:00 2001
-From: "A U Thor" <somebody@example.com> (this is \(really\) a comment (honestly))
+From: (this is \(really\) a "comment" (honestly)) "A U Thor" <somebody@example.com>
 Date: Sun, 25 May 2008 00:38:18 -0700
 Subject: [PATCH] testing comments
 
-- 
2.43.0.363.g1d22a8f302


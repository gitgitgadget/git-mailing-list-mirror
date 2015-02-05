From: Jeff King <peff@peff.net>
Subject: [PATCH] decimal_width: avoid integer overflow
Date: Thu, 5 Feb 2015 03:14:19 -0500
Message-ID: <20150205081419.GA7666@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 05 09:14:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJHZz-0003Ix-59
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 09:14:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705AbbBEIOX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2015 03:14:23 -0500
Received: from cloud.peff.net ([50.56.180.127]:45340 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752099AbbBEIOW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2015 03:14:22 -0500
Received: (qmail 10474 invoked by uid 102); 5 Feb 2015 08:14:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 05 Feb 2015 02:14:22 -0600
Received: (qmail 28830 invoked by uid 107); 5 Feb 2015 08:14:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 05 Feb 2015 03:14:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Feb 2015 03:14:19 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263366>

The decimal_width function originally appeared in blame.c as
"lineno_width", and was designed for calculating the
print-width of small-ish integer values (line numbers in
text files). In ec7ff5b, it was made into a reusable
function, and in dc801e7, we started using it to align
diffstats.

Binary files in a diffstat show byte counts rather than line
numbers, meaning they can be quite large (e.g., consider
adding or removing a 2GB file). decimal_width is not up to
the challenge for two reasons:

  1. It takes the value as an "int", whereas large files may
     easily surpass this. The value may be truncated, in
     which case we will produce an incorrect value.

  2. It counts "up" by repeatedly multiplying another
     integer by 10 until it surpasses the value.  This can
     cause an infinite loop when the value is close to the
     largest representable integer.

     For example, consider using a 32-bit signed integer,
     and a value of 2,140,000,000 (just shy of 2^31-1).
     We will count up and eventually see that 1,000,000,000
     is smaller than our value. The next step would be to
     multiply by 10 and see that 10,000,000,000 is too
     large, ending the loop. But we can't represent that
     value, and we have signed overflow.

     This is technically undefined behavior, but a common
     behavior is to lose the high bits, in which case our
     iterator will certainly be less than the number. So
     we'll keep multiplying, overflow again, and so on.

This patch changes the argument to a uintmax_t (the same
type we use to store the diffstat information for binary
filese), and counts "down" by repeatedly dividing our value
by 10.

Signed-off-by: Jeff King <peff@peff.net>
---
Note that besides taking a larger type, we also switch to an unsigned
type. I don't think a signed value makes any sense here (do we include
the "-" or not?), and certainly would not have behaved correctly with
the old code. I did a quick look over all the callers, and they all look
to be conceptually unsigned.

 cache.h | 2 +-
 pager.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index f704af5..04951dd 100644
--- a/cache.h
+++ b/cache.h
@@ -1498,7 +1498,7 @@ extern const char *pager_program;
 extern int pager_in_use(void);
 extern int pager_use_color;
 extern int term_columns(void);
-extern int decimal_width(int);
+extern int decimal_width(uintmax_t);
 extern int check_pager_config(const char *cmd);
 
 extern const char *editor_program;
diff --git a/pager.c b/pager.c
index f6e8c33..98b2682 100644
--- a/pager.c
+++ b/pager.c
@@ -133,12 +133,12 @@ int term_columns(void)
 /*
  * How many columns do we need to show this number in decimal?
  */
-int decimal_width(int number)
+int decimal_width(uintmax_t number)
 {
-	int i, width;
+	int width;
 
-	for (width = 1, i = 10; i <= number; width++)
-		i *= 10;
+	for (width = 1; number >= 10; width++)
+		number /= 10;
 	return width;
 }
 
-- 
2.3.0.rc1.287.g761fd19

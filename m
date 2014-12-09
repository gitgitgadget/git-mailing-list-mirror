From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/7] parse_color: refactor color storage
Date: Tue, 9 Dec 2014 16:01:26 -0500
Message-ID: <20141209210126.GA14305@peff.net>
References: <20141120151418.GA23607@peff.net>
 <20141120151704.GD23680@peff.net>
 <54875825.7060008@kdbg.org>
 <20141209202135.GB12001@peff.net>
 <548760FA.50209@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Scott Baker <bakers@canbytel.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Dec 09 22:01:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyRuX-0006HX-EE
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 22:01:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130AbaLIVB3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 16:01:29 -0500
Received: from cloud.peff.net ([50.56.180.127]:50753 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751570AbaLIVB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 16:01:29 -0500
Received: (qmail 22680 invoked by uid 102); 9 Dec 2014 21:01:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Dec 2014 15:01:28 -0600
Received: (qmail 4289 invoked by uid 107); 9 Dec 2014 21:01:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Dec 2014 16:01:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Dec 2014 16:01:26 -0500
Content-Disposition: inline
In-Reply-To: <548760FA.50209@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261168>

On Tue, Dec 09, 2014 at 09:52:10PM +0100, Johannes Sixt wrote:

> This patch would actually be my personal preference. The comment near
> the literal makes it all clear.

Thanks. Here it is ready to be applied.

Junio, this goes on top of the jk/colors topic.

-- >8 --
Subject: [PATCH] parse_color: drop COLOR_BACKGROUND macro

Commit 695d95d (parse_color: refactor color storage,
2014-11-20) introduced two macros, COLOR_FOREGROUND and
COLOR_BACKGROUND. The latter conflicts with a system macro
defined on Windows, breaking compilation there.

The simplest solution is to just get rid of these macros
entirely. They are constants that are only used in one place
(since the whole point of 695d95d was to avoid repeating
ourselves). Their main function is to make the magic
character constants more readable, but we can do the same
thing with a comment.

Reported-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Jeff King <peff@peff.net>
---
 color.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/color.c b/color.c
index e2a0a99..809b359 100644
--- a/color.c
+++ b/color.c
@@ -144,9 +144,6 @@ int color_parse(const char *value, char *dst)
 	return color_parse_mem(value, strlen(value), dst);
 }
 
-#define COLOR_FOREGROUND '3'
-#define COLOR_BACKGROUND '4'
-
 /*
  * Write the ANSI color codes for "c" to "out"; the string should
  * already have the ANSI escape code in it. "out" should have enough
@@ -245,12 +242,14 @@ int color_parse_mem(const char *value, int value_len, char *dst)
 		if (!color_empty(&fg)) {
 			if (sep++)
 				*dst++ = ';';
-			dst = color_output(dst, &fg, COLOR_FOREGROUND);
+			/* foreground colors are all in the 3x range */
+			dst = color_output(dst, &fg, '3');
 		}
 		if (!color_empty(&bg)) {
 			if (sep++)
 				*dst++ = ';';
-			dst = color_output(dst, &bg, COLOR_BACKGROUND);
+			/* background colors are all in the 4x range */
+			dst = color_output(dst, &bg, '4');
 		}
 		*dst++ = 'm';
 	}
-- 
2.2.0.454.g7eca6b7

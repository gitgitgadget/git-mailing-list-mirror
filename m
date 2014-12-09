From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/7] parse_color: refactor color storage
Date: Tue, 9 Dec 2014 15:21:35 -0500
Message-ID: <20141209202135.GB12001@peff.net>
References: <20141120151418.GA23607@peff.net>
 <20141120151704.GD23680@peff.net>
 <54875825.7060008@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Scott Baker <bakers@canbytel.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Dec 09 21:21:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyRHy-0004QB-Vk
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 21:21:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752553AbaLIUVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 15:21:39 -0500
Received: from cloud.peff.net ([50.56.180.127]:50694 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751587AbaLIUVh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 15:21:37 -0500
Received: (qmail 19155 invoked by uid 102); 9 Dec 2014 20:21:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Dec 2014 14:21:37 -0600
Received: (qmail 3653 invoked by uid 107); 9 Dec 2014 20:21:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Dec 2014 15:21:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Dec 2014 15:21:35 -0500
Content-Disposition: inline
In-Reply-To: <54875825.7060008@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261157>

On Tue, Dec 09, 2014 at 09:14:29PM +0100, Johannes Sixt wrote:

> Am 20.11.2014 um 16:17 schrieb Jeff King:
> > +#define COLOR_FOREGROUND '3'
> > +#define COLOR_BACKGROUND '4'
> 
> This (COLOR_BACKGROUND) causes an ugly redefinition warning on Windows,
> because we inherit a definition from a Windows header. How would you
> like it fixed? A different name or #undef in front of it?

I think a different name would be fine. The constants are actually only
used once each. Their main function is to avoid a confusing parameter
'3' to the color_output function. But we could use the literal
constants with a parameter, like:

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

We could also pass in integer "30" and "40", and then format it with %d
inside color_output. I don't know if that would be more obvious or not.

-Peff

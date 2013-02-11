From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCHv2] parse-options: report uncorrupted multi-byte options
Date: Tue, 12 Feb 2013 00:13:48 +0100
Message-ID: <1360624428-4728-1-git-send-email-kusmabite@gmail.com>
Cc: gitster@pobox.com, peff@peff.net, matthieu.moy@grenoble-inp.fr,
	tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 12 00:14:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U52Zg-0002xG-53
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 00:14:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759982Ab3BKXNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 18:13:49 -0500
Received: from mail-ee0-f50.google.com ([74.125.83.50]:59745 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757154Ab3BKXNs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 18:13:48 -0500
Received: by mail-ee0-f50.google.com with SMTP id e51so3506508eek.23
        for <git@vger.kernel.org>; Mon, 11 Feb 2013 15:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=FKbLcAXf4SL2O3YzswHYJrsuRwXf3GoNaREGRdnIsOo=;
        b=ZiteIAwQUlsnZV0Lk7pd8fuUYw1Dpy+XEormQs8JSv7EV/QlWbiCFG9HIeC7EffjOR
         hNZAksd7FI9v60Py0OnrYc3Ni6/KosvbTR/2XPl751oC3ujgS0Kl5hExS+4NuiLJdfNZ
         8aps3HHulS7RfjqRSVtkCvMozQWgBM1Km7uOpoFBiYZBJlISrMSd9IxR+zFvm9j0XLJZ
         IR7OZmgKz58sYVKj8EYOssCJB0Gp/R97nNteaJ8nqghzWpUIeVJxAktoLZzJcfMjHDji
         FT23aKvvdrIuj9OrdufDAK2P+a/JDZdWbmUhGU10qd43AX1YNrfjTl20jXcwoSH0CxiR
         P/yw==
X-Received: by 10.14.210.132 with SMTP id u4mr54958614eeo.19.1360624424622;
        Mon, 11 Feb 2013 15:13:44 -0800 (PST)
Received: from localhost (cm-84.215.107.111.getinternet.no. [84.215.107.111])
        by mx.google.com with ESMTPS id o3sm65007042eem.15.2013.02.11.15.13.42
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 11 Feb 2013 15:13:43 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216104>

Because our command-line parser considers only one byte at the time
for short-options, we incorrectly report only the first byte when
multi-byte input was provided. This makes user-erros slightly
awkward to diagnose for instance under UTF-8 locale and non-English
keyboard layouts.

Make the reporting code report the whole argument-string when a
non-ASCII short-option is detected.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
Improved-by: Jeff King <peff@peff.net>
---

Here's a second attempt at fixing error-reporting with UTF-8 encoded
input, this time without corrupting other non-ascii multi-byte
encodings.

I decided to change the text from what Jeff suggested; all we know is
that it's non-ASCII. It might be Latin-1 or some other non-ASCII,
single byte encoding. And since we're trying not to care, let's also
try to not be overly specific :)

I wasn't entirely sure who to attribute for the improvement, so I just
picked Jeff; he provided some code. That decision might not be correct,
feel free to change it.

 parse-options.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/parse-options.c b/parse-options.c
index 67e98a6..6a39446 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -461,8 +461,11 @@ int parse_options(int argc, const char **argv, const char *prefix,
 	default: /* PARSE_OPT_UNKNOWN */
 		if (ctx.argv[0][1] == '-') {
 			error("unknown option `%s'", ctx.argv[0] + 2);
-		} else {
+		} else if (isascii(*ctx.opt)) {
 			error("unknown switch `%c'", *ctx.opt);
+		} else {
+			error("unknown non-ascii option in string: `%s'",
+			    ctx.argv[0]);
 		}
 		usage_with_options(usagestr, options);
 	}
-- 
1.8.1.1

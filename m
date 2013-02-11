From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: =?UTF-8?q?=5BPATH/RFC=5D=20parse-options=3A=20report=20invalid=20UTF-8=20switches?=
Date: Mon, 11 Feb 2013 14:34:47 +0100
Message-ID: <1360589687-9233-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 11 14:35:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4tY2-0005Kp-5D
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 14:35:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757278Ab3BKNfX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Feb 2013 08:35:23 -0500
Received: from mail-ee0-f43.google.com ([74.125.83.43]:57892 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757203Ab3BKNfW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 08:35:22 -0500
Received: by mail-ee0-f43.google.com with SMTP id c50so3256206eek.16
        for <git@vger.kernel.org>; Mon, 11 Feb 2013 05:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=tUTxBCl05AmfDxQAGbcur5Yko27DJW+9O7n/P3UBa2A=;
        b=j9pFOZgwSX0JQp+NjOOX+l15oRJSoouEfeHUcMMbzJfLi4SXoZEJhsrrVaEJqBJrAF
         KGtnc9pCVBc6WuZe2NDLBZqfatqs3ouHW23B6z/W6Ef7jMMGCkRVQ8Qgwcp1AUlPIwr+
         nICaX83WyOXgb3WcbYN0sHeiZyO9crAwF7zckjPjDI/BOmcYbd7XCGbpJ7sTzRy9FeUx
         lVIa5xK1fIDR/hp6fLvM0ten8VwEt/hnrjM1OcT13aiHwlpF5RtmP7K9S/HUHzabKXFy
         MJLcXRY1vtns7d81lrvv5BArdwEQCTcXEZSK0h9QkmPqxKOxBnneXtFZFmKVYt2nacz+
         0bLw==
X-Received: by 10.14.199.135 with SMTP id x7mr49999563een.18.1360589721254;
        Mon, 11 Feb 2013 05:35:21 -0800 (PST)
Received: from erik-linux.hue.no ([77.40.159.131])
        by mx.google.com with ESMTPS id s3sm24180908eem.4.2013.02.11.05.35.19
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 11 Feb 2013 05:35:20 -0800 (PST)
X-Mailer: git-send-email 1.7.11.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216031>

Even though parse-options doesn't support UTF-8 switches (which
makes sense; non-ascii switches would be difficult to enter on
some keyboard layouts), it can be useful to report incorrectly
entered UTF-8 switches to make the output somewhat less ugly
for those of us with keyboard layouts with UTF-8 characters on
it.

Make the reporting code grok UTF-8 in the option sequence, and
write a variable-width output sequence.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
As being both clumsy and Norwegian, I some times to enter the
Norwegian bizarro-letters ('=C3=A6', '=C3=B8' and '=C3=A5') instead of =
the
correct ones when entering command-line options.

However, since git only looks at one byte at the time for
short-options, it ends up reporting a partial UTF-8 sequence
in such cases, leading to corruption of the output.

The "real fix" would probably be to add proper multi-byte
support to the short-option parser, but this serves little
purpose in Git; we don't internationalize the command-line
switches.

So perhaps this is a suitable band-aid instead?

 parse-options.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/parse-options.c b/parse-options.c
index 67e98a6..20dc742 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -3,6 +3,7 @@
 #include "cache.h"
 #include "commit.h"
 #include "color.h"
+#include "utf8.h"
=20
 static int parse_options_usage(struct parse_opt_ctx_t *ctx,
 			       const char * const *usagestr,
@@ -462,7 +463,9 @@ int parse_options(int argc, const char **argv, cons=
t char *prefix,
 		if (ctx.argv[0][1] =3D=3D '-') {
 			error("unknown option `%s'", ctx.argv[0] + 2);
 		} else {
-			error("unknown switch `%c'", *ctx.opt);
+			const char *next =3D ctx.opt;
+			utf8_width(&next, NULL);
+			error("unknown switch `%.*s'", (int)(next - ctx.opt), ctx.opt);
 		}
 		usage_with_options(usagestr, options);
 	}
--=20
1.7.11.7

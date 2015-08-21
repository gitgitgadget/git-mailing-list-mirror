From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 03/10] test-regex: expose full regcomp() to the command line
Date: Fri, 21 Aug 2015 19:47:13 +0700
Message-ID: <1440161240-28554-4-git-send-email-pclouds@gmail.com>
References: <1436880280-18194-1-git-send-email-pclouds@gmail.com>
 <1440161240-28554-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, plamen.totev@abv.bg,
	l.s.r@web.de, Eric Sunshine <sunshine@sunshineco.com>,
	tboegi@web.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 21 14:58:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSlu9-0003xc-7Z
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 14:58:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752779AbbHUM6l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2015 08:58:41 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33218 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534AbbHUM6k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 08:58:40 -0400
Received: by pacgr6 with SMTP id gr6so9356165pac.0
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 05:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=KS0vuVYvFSZ2Lp6LSS+fUO2ZKVe7Z7TwmPxmdSBdGq0=;
        b=J79N9xgGyzvjYeyvzamd9WLLnOwqzc0moMJ6/3LV43bDhxcL9iWqOOAjpYjpF27SVO
         7nfcxjmSGiJKD5dMJdSmlRQfr6xCApjdeGvXyjsUusVZH1/kHxi+o56O6F64DIPO8RIb
         1EP5UyGsfeK8Cfx7msQRp/BdGxLdLZsF39cNybREcDa8fga45jlMF1Md2Mc+ZCffVdUZ
         bwJxIJDkLNwI2/Z9x9In57ciXHtEVDuqKVsZ2WYONmBK/IiiU5q1N82XF4Mxvzsp6k9/
         v305RMsp6upQQfWXQxZOHLRWuNRtREUovgDD9X/4bdZ98kObrWu//+Svc6JEUFTz/r1X
         R06w==
X-Received: by 10.66.140.70 with SMTP id re6mr17314582pab.31.1440161920057;
        Fri, 21 Aug 2015 05:58:40 -0700 (PDT)
Received: from lanh ([171.232.84.126])
        by smtp.gmail.com with ESMTPSA id e6sm7828707pas.35.2015.08.21.05.58.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2015 05:58:39 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 21 Aug 2015 19:58:36 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1440161240-28554-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276291>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 test-regex.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++--=
----
 1 file changed, 50 insertions(+), 6 deletions(-)

diff --git a/test-regex.c b/test-regex.c
index 0dc598e..3b5641c 100644
--- a/test-regex.c
+++ b/test-regex.c
@@ -1,19 +1,63 @@
 #include "git-compat-util.h"
+#include "gettext.h"
+
+struct reg_flag {
+	const char *name;
+	int flag;
+};
+
+static struct reg_flag reg_flags[] =3D {
+	{ "EXTENDED",	 REG_EXTENDED	},
+	{ "NEWLINE",	 REG_NEWLINE	},
+	{ "ICASE",	 REG_ICASE	},
+	{ "NOTBOL",	 REG_NOTBOL	},
+#ifdef REG_STARTEND
+	{ "STARTEND",	 REG_STARTEND	},
+#endif
+	{ NULL, 0 }
+};
=20
 int main(int argc, char **argv)
 {
-	char *pat =3D "[^=3D{} \t]+";
-	char *str =3D "=3D{}\nfred";
+	const char *pat;
+	const char *str;
+	int flags =3D 0;
 	regex_t r;
 	regmatch_t m[1];
=20
-	if (regcomp(&r, pat, REG_EXTENDED | REG_NEWLINE))
+	if (argc =3D=3D 1) {
+		/* special case, bug check */
+		pat =3D "[^=3D{} \t]+";
+		str =3D "=3D{}\nfred";
+		flags =3D REG_EXTENDED | REG_NEWLINE;
+	} else {
+		argv++;
+		pat =3D *argv++;
+		str =3D *argv++;
+		while (*argv) {
+			struct reg_flag *rf;
+			for (rf =3D reg_flags; rf->name; rf++)
+				if (!strcmp(*argv, rf->name)) {
+					flags |=3D rf->flag;
+					break;
+				}
+			if (!rf->name)
+				die("do not recognize %s", *argv);
+			argv++;
+		}
+		git_setup_gettext();
+	}
+
+	if (regcomp(&r, pat, flags))
 		die("failed regcomp() for pattern '%s'", pat);
-	if (regexec(&r, str, 1, m, 0))
-		die("no match of pattern '%s' to string '%s'", pat, str);
+	if (regexec(&r, str, 1, m, 0)) {
+		if (argc =3D=3D 1)
+			die("no match of pattern '%s' to string '%s'", pat, str);
+		return 1;
+	}
=20
 	/* http://sourceware.org/bugzilla/show_bug.cgi?id=3D3957  */
-	if (m[0].rm_so =3D=3D 3) /* matches '\n' when it should not */
+	if (argc =3D=3D 1 && m[0].rm_so =3D=3D 3) /* matches '\n' when it sho=
uld not */
 		die("regex bug confirmed: re-build git with NO_REGEX=3D1");
=20
 	exit(0);
--=20
2.3.0.rc1.137.g477eb31

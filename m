From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 00/10] icase match on non-ascii
Date: Fri, 21 Aug 2015 19:47:10 +0700
Message-ID: <1440161240-28554-1-git-send-email-pclouds@gmail.com>
References: <1436880280-18194-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, plamen.totev@abv.bg,
	l.s.r@web.de, Eric Sunshine <sunshine@sunshineco.com>,
	tboegi@web.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 21 14:58:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSltm-0003jU-OQ
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 14:58:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752533AbbHUM6S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2015 08:58:18 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35945 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbbHUM6R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 08:58:17 -0400
Received: by pawq9 with SMTP id q9so52511827paw.3
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 05:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=hjhs+0GD8q1bw4lA82A10uXNalgIHl/qiJxzMBJJ3pg=;
        b=Nd/yng7wdXciL6aGgoJsqz2fTPiKMjUWdNU1q718Tl/r5XuCxS0Ltkw3Kly4xX3aCu
         C/avAqyLS5zxcIbrkhje4Eo6TXj/umS5PhfheNl31Ntamb1zrSmIlfLWZuggxtLIbuD2
         Ajt87HZ4qc4Bsb0C+lDAIF5CAA1A20bkV1F/xCpEuWuCP4WhsFvFyXp9wJETOYf1Cbgx
         SC+Kem51hqmG8ynfom1BZiX4MO2Ant3a0M+ixZQfM6Xs7SRfp34QSWAwmY+z9FHFXWGs
         N2XOYWEkvup+RI/Y88zCqQIxWMIx5uG1WxkvIsgqtih07BLukcrZkMiLpe3T4pb5VR5H
         qM2A==
X-Received: by 10.68.112.227 with SMTP id it3mr17273667pbb.132.1440161896945;
        Fri, 21 Aug 2015 05:58:16 -0700 (PDT)
Received: from lanh ([171.232.84.126])
        by smtp.gmail.com with ESMTPSA id la4sm7781000pbc.76.2015.08.21.05.58.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2015 05:58:15 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 21 Aug 2015 19:58:08 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1436880280-18194-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276288>

Sorry it took more than a month for a simple reroll. Free time (with
energy left) is rare these days. v4 adds system regex's icase support
detection and only runs tests in these cases. This should fix test
failures on Windows where compat regex does not support icase.

Diff from v3 below

diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-a=
scii.sh
index d07fa20..a5475bb 100755
--- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -11,7 +11,11 @@ test_expect_success GETTEXT_LOCALE 'setup' '
 	export LC_ALL
 '
=20
-test_expect_success GETTEXT_LOCALE 'grep literal string, no -F' '
+test_have_prereq GETTEXT_LOCALE &&
+test-regex "HALL=C3=93" "Hall=C3=B3" ICASE &&
+test_set_prereq REGEX_LOCALE
+
+test_expect_success REGEX_LOCALE 'grep literal string, no -F' '
 	git grep -i "TILRAUN: Hall=C3=B3 Heimur!" &&
 	git grep -i "TILRAUN: HALL=C3=93 HEIMUR!"
 '
@@ -31,7 +35,7 @@ test_expect_success GETTEXT_LOCALE,LIBPCRE 'grep pcre=
 utf-8 string with "+"' '
 	test_cmp expected actual
 '
=20
-test_expect_success GETTEXT_LOCALE 'grep literal string, with -F' '
+test_expect_success REGEX_LOCALE 'grep literal string, with -F' '
 	git grep --debug -i -F "TILRAUN: Hall=C3=B3 Heimur!"  2>&1 >/dev/null=
 |
 		 grep fixed >debug1 &&
 	echo "fixedTILRAUN: Hall=C3=B3 Heimur!" >expect1 &&
@@ -43,7 +47,7 @@ test_expect_success GETTEXT_LOCALE 'grep literal stri=
ng, with -F' '
 	test_cmp expect2 debug2
 '
=20
-test_expect_success GETTEXT_LOCALE 'grep string with regex, with -F' '
+test_expect_success REGEX_LOCALE 'grep string with regex, with -F' '
 	printf "^*TILR^AUN:.* \\Hall=C3=B3 \$He[]imur!\$" >file &&
=20
 	git grep --debug -i -F "^*TILR^AUN:.* \\Hall=C3=B3 \$He[]imur!\$" 2>&=
1 >/dev/null |
@@ -57,7 +61,7 @@ test_expect_success GETTEXT_LOCALE 'grep string with =
regex, with -F' '
 	test_cmp expect2 debug2
 '
=20
-test_expect_success GETTEXT_LOCALE 'pickaxe -i on non-ascii' '
+test_expect_success REGEX_LOCALE 'pickaxe -i on non-ascii' '
 	git commit -m first &&
 	git log --format=3D%f -i -S"TILRAUN: HALL=C3=93 HEIMUR!" >actual &&
 	echo first >expected &&
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

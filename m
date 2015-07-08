From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 7/9] grep/pcre: support utf-8
Date: Wed,  8 Jul 2015 17:38:37 +0700
Message-ID: <1436351919-2520-8-git-send-email-pclouds@gmail.com>
References: <1436186551-32544-1-git-send-email-pclouds@gmail.com>
 <1436351919-2520-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: plamen.totev@abv.bg, l.s.r@web.de,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 08 12:38:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCmkf-0006vp-HD
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 12:38:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbbGHKit convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jul 2015 06:38:49 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35401 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964821AbbGHKip (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 06:38:45 -0400
Received: by pactm7 with SMTP id tm7so129736625pac.2
        for <git@vger.kernel.org>; Wed, 08 Jul 2015 03:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=PVStU0YjgC4uoel+Z4Bfw6s8eooAOxDNxIMwWNynXus=;
        b=eWnpJfdBS2AVnFa57Qgh6UCiiktfLX/ofgULXsdECIrHruuir5cqYZfa4ToJMQVPDi
         hCeSqDnPsA5pWniNFiJHXa9gN55a13aingMuHnCcpxGt/HiPsFh/9FVmVpyP1oKzKY9n
         v8uer2M+6wLQwGYssJhhXJqp4ZeXCNKcpOufBaVB7SttXJA8ZVPLrU4LDhFcvIa12mfT
         lL4U0/XkhKG3phfaYFZCKr7JZFg3um3ypqCNeYE2/mRRjpl3Sbt16QUz7p3wX2x8hjy5
         l5YP08eSK0ko18vB3Ftbss3MQbnnueACPY5xYz8EKM5zQVXiL83oRBXoAiV1f0se1Sgr
         H+8g==
X-Received: by 10.70.128.226 with SMTP id nr2mr19180541pdb.139.1436351924446;
        Wed, 08 Jul 2015 03:38:44 -0700 (PDT)
Received: from lanh ([115.73.45.219])
        by smtp.gmail.com with ESMTPSA id dp1sm2042805pbb.53.2015.07.08.03.38.41
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2015 03:38:43 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 08 Jul 2015 17:39:30 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1436351919-2520-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273665>

In the previous change in this function, we add locale support for
single-byte encodings only. It looks like pcre only supports utf-* as
multibyte encodings, the others are left in the cold (which is
fine). We need to enable PCRE_UTF8 so pcre can parse the string
correctly before folding case.

Noticed-by: Plamen Totev <plamen.totev@abv.bg>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 grep.c                          | 2 ++
 t/t7812-grep-icase-non-ascii.sh | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/grep.c b/grep.c
index c79aa70..7c9e437 100644
--- a/grep.c
+++ b/grep.c
@@ -326,6 +326,8 @@ static void compile_pcre_regexp(struct grep_pat *p,=
 const struct grep_opt *opt)
=20
 	if (opt->ignore_case) {
 		p->pcre_tables =3D pcre_maketables();
+		if (is_utf8_locale())
+			options |=3D PCRE_UTF8;
 		options |=3D PCRE_CASELESS;
 	}
=20
diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-a=
scii.sh
index c945589..1306cc0 100755
--- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -16,6 +16,12 @@ test_expect_success GETTEXT_LOCALE 'grep literal str=
ing, no -F' '
 	git grep -i "TILRAUN: HALL=C3=93 HEIMUR!"
 '
=20
+test_expect_success GETTEXT_LOCALE,LIBPCRE 'grep pcre string' '
+	git grep --perl-regexp    "TILRAUN: H.ll=C3=B3 Heimur!" &&
+	git grep --perl-regexp -i "TILRAUN: H.ll=C3=B3 Heimur!" &&
+	git grep --perl-regexp -i "TILRAUN: H.LL=C3=93 HEIMUR!"
+'
+
 test_expect_success GETTEXT_LOCALE 'grep literal string, with -F' '
 	git grep --debug -i -F "TILRAUN: Hall=C3=B3 Heimur!"  2>&1 >/dev/null=
 |
 		 grep fixed >debug1 &&
--=20
2.3.0.rc1.137.g477eb31

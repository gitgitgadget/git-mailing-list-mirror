From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] grep: use regcomp() for icase search with non-ascii patterns
Date: Mon,  6 Jul 2015 19:42:31 +0700
Message-ID: <1436186551-32544-1-git-send-email-pclouds@gmail.com>
References: <2008630603.1189842.1436182096558.JavaMail.apache@nm33.abv.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: plamen.totev@abv.bg,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 14:42:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZC5if-0003eQ-6M
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 14:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754169AbbGFMlw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jul 2015 08:41:52 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:33895 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725AbbGFMlv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 08:41:51 -0400
Received: by pdbep18 with SMTP id ep18so105595605pdb.1
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 05:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=47baAGHaRQWHOwDsD6paUFDSzpLm9xXl/r/hdkjuqzY=;
        b=HY2NIWC6E8o0BM9lR/fKT4YLTe0ffEmhCPcr1d6bN7e03D3O4n2D/kbOhjdiz+ikoV
         zp9k2cx8yvcpn+a6HbUDBrkpe9BXoW6YJN4k7Kgcl+wt/yGwy052/3L0QTfgtyrtrXTf
         6Yas5w8jfzsurr/oeyPg+mUp9kEmMxzl+8y5n4w46Jyg6Q9ij8HAjFFVomf568OuWvF0
         uRmadUfttmfkG7ZTqFeXGzJfWUtuDknafqHBESolKFOizRIQvXPrEQ/i217LHtF2D6od
         WOKSzq00ekDQ7It4u9fhWUcrKfxbLQqqar6fVbCZNNBKarOdM1IjJ6LkHfz6X5Pb5Nb4
         4GTw==
X-Received: by 10.70.31.5 with SMTP id w5mr100821267pdh.3.1436186511023;
        Mon, 06 Jul 2015 05:41:51 -0700 (PDT)
Received: from lanh ([115.73.39.13])
        by mx.google.com with ESMTPSA id gi6sm18167662pbd.69.2015.07.06.05.41.48
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2015 05:41:50 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 06 Jul 2015 19:42:34 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <2008630603.1189842.1436182096558.JavaMail.apache@nm33.abv.bg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273384>

Noticed-by: Plamen Totev <plamen.totev@abv.bg>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 grep.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/grep.c b/grep.c
index b58c7c6..48db15a 100644
--- a/grep.c
+++ b/grep.c
@@ -378,7 +378,7 @@ static void free_pcre_regexp(struct grep_pat *p)
 }
 #endif /* !USE_LIBPCRE */
=20
-static int is_fixed(const char *s, size_t len)
+static int is_fixed(const char *s, size_t len, int ignore_icase)
 {
 	size_t i;
=20
@@ -391,6 +391,13 @@ static int is_fixed(const char *s, size_t len)
 	for (i =3D 0; i < len; i++) {
 		if (is_regex_special(s[i]))
 			return 0;
+		/*
+		 * The builtin substring search can only deal with case
+		 * insensitivity in ascii range. If there is something outside
+		 * of that range, fall back to regcomp.
+		 */
+		if (ignore_icase && (unsigned char)s[i] >=3D 128)
+			return 0;
 	}
=20
 	return 1;
@@ -398,18 +405,19 @@ static int is_fixed(const char *s, size_t len)
=20
 static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 {
+	int ignore_icase =3D opt->regflags & REG_ICASE || p->ignore_case;
 	int err;
=20
 	p->word_regexp =3D opt->word_regexp;
 	p->ignore_case =3D opt->ignore_case;
=20
-	if (opt->fixed || is_fixed(p->pattern, p->patternlen))
+	if (opt->fixed || is_fixed(p->pattern, p->patternlen, ignore_icase))
 		p->fixed =3D 1;
 	else
 		p->fixed =3D 0;
=20
 	if (p->fixed) {
-		if (opt->regflags & REG_ICASE || p->ignore_case)
+		if (ignore_case)
 			p->kws =3D kwsalloc(tolower_trans_tbl);
 		else
 			p->kws =3D kwsalloc(NULL);
--=20
2.3.0.rc1.137.g477eb31

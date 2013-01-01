From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 07/10] test-wildmatch: add "perf" command to compare wildmatch and fnmatch
Date: Tue,  1 Jan 2013 09:44:08 +0700
Message-ID: <1357008251-10014-8-git-send-email-pclouds@gmail.com>
References: <1357008251-10014-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 01 03:45:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tprqs-0000Oa-4X
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 03:45:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909Ab3AACoz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Dec 2012 21:44:55 -0500
Received: from mail-da0-f51.google.com ([209.85.210.51]:64555 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864Ab3AACoy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 21:44:54 -0500
Received: by mail-da0-f51.google.com with SMTP id i30so5974457dad.10
        for <git@vger.kernel.org>; Mon, 31 Dec 2012 18:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=SL6jUd3GUonzzQQ49JnzcGunopziE0zgI3+xz4NQE7U=;
        b=Loam4WDBO624o4xY1AqxMLdlBA0RrAEBUa6nNhBaygF/xe7xSH683CPhcDxXkdZy01
         CnHDt/76jH6en+YObZMeKRms6QUEtF8Eg7IWqTLdbSKsKVlME6wr/7sDHldfknwd4SPA
         MnnbZQyFIjLhCSYh8NNyN7fI2fbZ+/mfVnmGNHav+wgWenDPFXr3YksZSeGICt6iPIvX
         5Tyv1v0B+6WfhRReasvgpTrJji8QQM4GeIQ5epR/BvREQg3AsAUO9Q/qRSrJ6cCe1D12
         wxfHEjPZ5s2fmvTqoxz1e8Pulv2scD8T7JYWhYAptaupWoIBphRqqhiI6jSQpZvDhykg
         Ltig==
X-Received: by 10.68.143.100 with SMTP id sd4mr123673771pbb.107.1357008293933;
        Mon, 31 Dec 2012 18:44:53 -0800 (PST)
Received: from lanh ([115.74.57.25])
        by mx.google.com with ESMTPS id ir4sm25816274pbc.41.2012.12.31.18.44.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 31 Dec 2012 18:44:53 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 01 Jan 2013 09:44:57 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357008251-10014-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212390>

It takes a text file, a pattern, a number <n> and pathname flag. Each
line in the text file is matched against the pattern <n> times. If
"pathname" is given, FNM_PATHNAME is used.

test-wildmatch is built with -O2 and tested against glibc 2.14.1 (also
-O2) and compat/fnmatch. The input file is linux-2.6.git file list.
<n> is 2000. The complete command list is at the end.

wildmatch is beaten in the following cases. Apparently it needs some
improvement in FNM_PATHNAME case:

glibc, '*/*/*' with FNM_PATHNAME:
wildmatch 8s 1559us
fnmatch   1s 11877us or 12.65% faster

compat, '*/*/*' with FNM_PATHNAME:
wildmatch 7s 922458us
fnmatch   2s 905111us or 36.67% faster

compat, '*/*/*' without FNM_PATHNAME:
wildmatch 7s 264201us
fnmatch   2s 1897us or 27.56% faster

compat, '[a-z]*/[a-z]*/[a-z]*' with FNM_PATHNAME:
wildmatch 8s 742827us
fnmatch   0s 922943us or 10.56% faster

compat, '[a-z]*/[a-z]*/[a-z]*' without FNM_PATHNAME:
wildmatch 8s 284520us
fnmatch   0s 6936us or 0.08% faster

The rest of glibc numbers
-------------------------

'Documentation/*'
wildmatch 1s 529479us
fnmatch   1s 98263us or 71.81% slower

'drivers/*'
wildmatch 1s 988288us
fnmatch   1s 192049us or 59.95% slower

'Documentation/*' pathname
wildmatch 1s 557507us
fnmatch   1s 93696us or 70.22% slower

'drivers/*' pathname
wildmatch 2s 161626us
fnmatch   1s 230372us or 56.92% slower

'[Dd]ocu[Mn]entation/*'
wildmatch 1s 776581us
fnmatch   1s 471693us or 82.84% slower

'[Dd]o?u[Mn]en?ati?n/*'
wildmatch 1s 770770us
fnmatch   1s 555727us or 87.86% slower

'[Dd]o?u[Mn]en?ati?n/*' pathname
wildmatch 1s 783507us
fnmatch   1s 537029us or 86.18% slower

'[A-Za-z][A-Za-z]??*'
wildmatch 4s 110386us
fnmatch   4s 926306us or 119.85% slower

'[A-Za-z][A-Za-z]??'
wildmatch 3s 918114us
fnmatch   3s 686175us or 94.08% slower

'[A-Za-z][A-Za-z]??*' pathname
wildmatch 4s 453746us
fnmatch   4s 955856us or 111.27% slower

'[A-Za-z][A-Za-z]??' pathname
wildmatch 3s 896646us
fnmatch   3s 733828us or 95.82% slower

'*/*/*'
wildmatch 7s 287985us
fnmatch   1s 74083us or 14.74% slower

'[a-z]*/[a-z]*/[a-z]*' pathname
wildmatch 8s 796659us
fnmatch   1s 568409us or 17.83% slower

'[a-z]*/[a-z]*/[a-z]*'
wildmatch 8s 316559us
fnmatch   3s 430652us or 41.25% slower

The rest of compat numbers
--------------------------

'Documentation/*'
wildmatch 1s 520389us
fnmatch   0s 62579us or 4.12% slower

'drivers/*'
wildmatch 1s 955354us
fnmatch   0s 190109us or 9.72% slower

'Documentation/*' pathname
wildmatch 1s 561675us
fnmatch   0s 55336us or 3.54% slower

'drivers/*' pathname
wildmatch 2s 106100us
fnmatch   0s 219680us or 10.43% slower

'[Dd]ocu[Mn]entation/*'
wildmatch 1s 750810us
fnmatch   0s 542721us or 31.00% slower

'[Dd]o?u[Mn]en?ati?n/*'
wildmatch 1s 724791us
fnmatch   0s 538948us or 31.25% slower

'[Dd]o?u[Mn]en?ati?n/*' pathname
wildmatch 1s 731403us
fnmatch   0s 537474us or 31.04% slower

'[A-Za-z][A-Za-z]??*'
wildmatch 4s 28555us
fnmatch   1s 67297us or 26.49% slower

'[A-Za-z][A-Za-z]??'
wildmatch 3s 838279us
fnmatch   0s 880005us or 22.93% slower

'[A-Za-z][A-Za-z]??*' pathname
wildmatch 4s 379476us
fnmatch   1s 55643us or 24.10% slower

'[A-Za-z][A-Za-z]??' pathname
wildmatch 3s 830910us
fnmatch   0s 849699us or 22.18% slower

The following commands are used:

LANG=3DC ./test-wildmatch perf /tmp/filelist.txt 'Documentation/*' 2000
LANG=3DC ./test-wildmatch perf /tmp/filelist.txt 'drivers/*' 2000
LANG=3DC ./test-wildmatch perf /tmp/filelist.txt 'Documentation/*' 2000=
 pathname
LANG=3DC ./test-wildmatch perf /tmp/filelist.txt 'drivers/*' 2000 pathn=
ame
LANG=3DC ./test-wildmatch perf /tmp/filelist.txt '[Dd]ocu[Mn]entation/*=
' 2000
LANG=3DC ./test-wildmatch perf /tmp/filelist.txt '[Dd]o?u[Mn]en?ati?n/*=
' 2000
LANG=3DC ./test-wildmatch perf /tmp/filelist.txt '[Dd]o?u[Mn]en?ati?n/*=
' 2000 pathname
LANG=3DC ./test-wildmatch perf /tmp/filelist.txt '[A-Za-z][A-Za-z]??*' =
2000
LANG=3DC ./test-wildmatch perf /tmp/filelist.txt '[A-Za-z][A-Za-z]??' 2=
000
LANG=3DC ./test-wildmatch perf /tmp/filelist.txt '[A-Za-z][A-Za-z]??*' =
2000 pathname
LANG=3DC ./test-wildmatch perf /tmp/filelist.txt '[A-Za-z][A-Za-z]??' 2=
000 pathname
LANG=3DC ./test-wildmatch perf /tmp/filelist.txt '*/*/*' 2000
LANG=3DC ./test-wildmatch perf /tmp/filelist.txt '*/*/*' 2000 pathname
LANG=3DC ./test-wildmatch perf /tmp/filelist.txt '[a-z]*/[a-z]*/[a-z]*'=
 2000 pathname
LANG=3DC ./test-wildmatch perf /tmp/filelist.txt '[a-z]*/[a-z]*/[a-z]*'=
 2000

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 test-wildmatch.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 73 insertions(+)

diff --git a/test-wildmatch.c b/test-wildmatch.c
index a5f4833..ac86800 100644
--- a/test-wildmatch.c
+++ b/test-wildmatch.c
@@ -1,9 +1,82 @@
 #include "cache.h"
 #include "wildmatch.h"
=20
+static int perf(int ac, char **av)
+{
+	struct timeval tv1, tv2;
+	struct stat st;
+	int fd, i, n, flags1 =3D 0, flags2 =3D 0;
+	char *buffer, *p;
+	uint32_t usec1, usec2;
+	const char *lang;
+	const char *file =3D av[0];
+	const char *pattern =3D av[1];
+
+	lang =3D getenv("LANG");
+	if (lang && strcmp(lang, "C"))
+		die("Please test it on C locale.");
+
+	if ((fd =3D open(file, O_RDONLY)) =3D=3D -1 || fstat(fd, &st))
+		die_errno("file open");
+
+	buffer =3D xmalloc(st.st_size + 2);
+	if (read(fd, buffer, st.st_size) !=3D st.st_size)
+		die_errno("read");
+
+	buffer[st.st_size] =3D '\0';
+	buffer[st.st_size + 1] =3D '\0';
+	for (i =3D 0; i < st.st_size; i++)
+		if (buffer[i] =3D=3D '\n')
+			buffer[i] =3D '\0';
+
+	n =3D atoi(av[2]);
+	if (av[3] && !strcmp(av[3], "pathname")) {
+		flags1 =3D WM_PATHNAME;
+		flags2 =3D FNM_PATHNAME;
+	}
+
+	gettimeofday(&tv1, NULL);
+	for (i =3D 0; i < n; i++) {
+		for (p =3D buffer; *p; p +=3D strlen(p) + 1)
+			wildmatch(pattern, p, flags1, NULL);
+	}
+	gettimeofday(&tv2, NULL);
+
+	usec1 =3D (uint32_t)tv2.tv_sec * 1000000 + tv2.tv_usec;
+	usec1 -=3D (uint32_t)tv1.tv_sec * 1000000 + tv1.tv_usec;
+	printf("wildmatch %ds %dus\n",
+	       (int)(usec1 / 1000000),
+	       (int)(usec1 % 1000000));
+
+	gettimeofday(&tv1, NULL);
+	for (i =3D 0; i < n; i++) {
+		for (p =3D buffer; *p; p +=3D strlen(p) + 1)
+			fnmatch(pattern, p, flags2);
+	}
+	gettimeofday(&tv2, NULL);
+
+	usec2 =3D (uint32_t)tv2.tv_sec * 1000000 + tv2.tv_usec;
+	usec2 -=3D (uint32_t)tv1.tv_sec * 1000000 + tv1.tv_usec;
+	if (usec2 > usec1)
+		printf("fnmatch   %ds %dus or %.2f%% slower\n",
+		       (int)((usec2 - usec1) / 1000000),
+		       (int)((usec2 - usec1) % 1000000),
+		       (float)(usec2 - usec1) / usec1 * 100);
+	else
+		printf("fnmatch   %ds %dus or %.2f%% faster\n",
+		       (int)((usec1 - usec2) / 1000000),
+		       (int)((usec1 - usec2) % 1000000),
+		       (float)(usec1 - usec2) / usec1 * 100);
+	return 0;
+}
+
 int main(int argc, char **argv)
 {
 	int i;
+
+	if (!strcmp(argv[1], "perf"))
+		return perf(argc - 2, argv + 2);
+
 	for (i =3D 2; i < argc; i++) {
 		if (argv[i][0] =3D=3D '/')
 			die("Forward slash is not allowed at the beginning of the\n"
--=20
1.8.0.rc2.23.g1fb49df

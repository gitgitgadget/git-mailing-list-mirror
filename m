From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] attr: fix off-by-one directory component length calculation
Date: Tue, 15 Jan 2013 20:35:24 +0700
Message-ID: <1358256924-31578-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ross Lagerwall <rosslagerwall@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20AVILA?= <avila.jn@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 14:35:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tv6g9-00054C-Cz
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 14:35:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756806Ab3AONfY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jan 2013 08:35:24 -0500
Received: from mail-da0-f52.google.com ([209.85.210.52]:34652 "EHLO
	mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756470Ab3AONfU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 08:35:20 -0500
Received: by mail-da0-f52.google.com with SMTP id f10so35814dak.39
        for <git@vger.kernel.org>; Tue, 15 Jan 2013 05:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=L13aWOOgnMv5zbtvdhfiAS+NmrciF0ETRd6RJBRcf8I=;
        b=zh6jTD1HYs7VLK5iAabcKBne/XCwJGkhpZSJj8tl7waSdcX9S3EWVjlU6CA+zKFv6g
         bhbNwnjKz1qkhrQyMjj2YmPNtJp3n3CP8ANHD8UEtWM6+S8ifPTRWO9YuqsP6Bb3saY7
         9LDNGQSfMPC8dYUcfJuGlLwBscqliPuDdTen0nJlRMrxO31vK6+ikz8ULH+f9n4T/fo3
         /AMFZlit2ZR3C87gAADvvW0YxLzdus+qhiGopIQXl/OIvqn7goxVOsWkUnHk1A7pOLsR
         B86BnaSvze33erDB4vBQX5kmVl2zFIhZ2kHraq6LrPU8U/+/13WrqWi0H9a1yyU00ulx
         KKPw==
X-Received: by 10.68.130.170 with SMTP id of10mr264485093pbb.131.1358256920196;
        Tue, 15 Jan 2013 05:35:20 -0800 (PST)
Received: from lanh ([115.74.52.72])
        by mx.google.com with ESMTPS id vq4sm10229325pbc.67.2013.01.15.05.35.14
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Jan 2013 05:35:19 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 15 Jan 2013 20:35:31 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213634>

94bc671 (Add directory pattern matching to attributes - 2012-12-08)
uses find_basename() to calculate the length of directory part in
prepare_attr_stack. This function expects the directory without the
trailing slash (as "origin" field in match_attr struct is without the
trailing slash). find_basename() includes the trailing slash and
confuses push/pop algorithm.

Consider path =3D "abc/def" and the push down code:

	while (1) {
		len =3D strlen(attr_stack->origin);
		if (dirlen <=3D len)
			break;
		cp =3D memchr(path + len + 1, '/', dirlen - len - 1);
		if (!cp)
			cp =3D path + dirlen;

dirlen is 4, not 3, without this patch. So when attr_stack->origin is
"abc", it'll miss the exit condition because 4 <=3D 3 is wrong. It'll
then try to push "abc/" down the attr stack (because "cp" would be
NULL). So we have both "abc" and "abc/" in the stack.

Next time when "abc/ghi" is checked, "abc/" is popped out because of
the off-by-one dirlen, only to be pushed back in again by the above
code. This repeats for all files in the same directory. Which means
at least one failed open syscall per file, or more if .gitattributes
exists.

This is the perf result with 10 runs on git.git:

Test                                     94bc671^          94bc671     =
              HEAD
-----------------------------------------------------------------------=
-----------------------------------
7810.1: grep worktree, cheap regex       0.02(0.01+0.04)   0.05(0.03+0.=
05) +150.0%   0.02(0.01+0.04) +0.0%
7810.2: grep worktree, expensive regex   0.25(0.94+0.01)   0.26(0.94+0.=
02) +4.0%     0.25(0.93+0.02) +0.0%
7810.3: grep --cached, cheap regex       0.11(0.10+0.00)   0.12(0.10+0.=
02) +9.1%     0.10(0.10+0.00) -9.1%
7810.4: grep --cached, expensive regex   0.61(0.60+0.01)   0.62(0.61+0.=
01) +1.6%     0.61(0.60+0.00) +0.0%

Reported-by: Ross Lagerwall <rosslagerwall@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 This may be an indication that our perf framework is never actively us=
ed :-(

 attr.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/attr.c b/attr.c
index 466c93f..bb9a470 100644
--- a/attr.c
+++ b/attr.c
@@ -584,6 +584,13 @@ static void prepare_attr_stack(const char *path)
 	dirlen =3D find_basename(path) - path;
=20
 	/*
+	 * find_basename() includes the trailing slash, but we do
+	 * _not_ want it.
+	 */
+	if (dirlen)
+		dirlen--;
+
+	/*
 	 * At the bottom of the attribute stack is the built-in
 	 * set of attribute definitions, followed by the contents
 	 * of $(prefix)/etc/gitattributes and a file specified by
--=20
1.8.0.rc2.23.g1fb49df

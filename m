From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/2] dir.c: make last_exclude_matching_from_list() run til the end
Date: Sun, 13 Sep 2015 08:19:00 +0700
Message-ID: <1442107141-24265-2-git-send-email-pclouds@gmail.com>
References: <1440334214-32131-1-git-send-email-pclouds@gmail.com>
 <1442107141-24265-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 03:19:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zavwy-000755-MV
	for gcvg-git-2@plane.gmane.org; Sun, 13 Sep 2015 03:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755007AbbIMBTP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Sep 2015 21:19:15 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33949 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754976AbbIMBSx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2015 21:18:53 -0400
Received: by padhy16 with SMTP id hy16so108825439pad.1
        for <git@vger.kernel.org>; Sat, 12 Sep 2015 18:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=kYIXkGjq6yhjo4QNw/V3Yl5ZRdkRMgOsFhqxjPWfqX0=;
        b=MCnJuMu+UcE3Sl1qjyulaX+JnOkZhDgicpWqqMl9eeFTpMJUlXf5yi705L7aa6bQ1Z
         1RDS3EYFHuSXya4f8pSvkV4l+dAS2+BWq6V6aPhzmsENejpblYEjkipgqo7KouRTuazx
         X/Xnrq2IZJGOBnj213vVQIkO32DBIxHTPmN2fQzhFXhGjkEg8/69xA5VNOIeBOaWVMtT
         gSuXvN6WDAS7DC0wabebUZF46LDFwG6Kan4Y+LbwAVmLXu4JM4bs4X15diAze9KHPpNc
         7swhwdfzD6Ny0wE5KQcd7zB9ObboUoPC4NjBr1KOfMXnPbvSHsxhDBU9PjvnlL3iHGW4
         CZ9w==
X-Received: by 10.66.102.41 with SMTP id fl9mr16070103pab.93.1442107133043;
        Sat, 12 Sep 2015 18:18:53 -0700 (PDT)
Received: from lanh ([171.233.230.25])
        by smtp.gmail.com with ESMTPSA id ll8sm8025692pab.39.2015.09.12.18.18.50
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Sep 2015 18:18:52 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Sep 2015 08:19:12 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1442107141-24265-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277751>

The next patch adds some post processing to the result value before it'=
s
returned to the caller. Make all branches reach the end of the function=
,
so we can do it all in one place.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/dir.c b/dir.c
index c00c7e2..3a7630a 100644
--- a/dir.c
+++ b/dir.c
@@ -901,6 +901,7 @@ static struct exclude *last_exclude_matching_from_l=
ist(const char *pathname,
 						       int *dtype,
 						       struct exclude_list *el)
 {
+	struct exclude *exc =3D NULL; /* undecided */
 	int i;
=20
 	if (!el->nr)
@@ -922,18 +923,22 @@ static struct exclude *last_exclude_matching_from=
_list(const char *pathname,
 			if (match_basename(basename,
 					   pathlen - (basename - pathname),
 					   exclude, prefix, x->patternlen,
-					   x->flags))
-				return x;
+					   x->flags)) {
+				exc =3D x;
+				break;
+			}
 			continue;
 		}
=20
 		assert(x->baselen =3D=3D 0 || x->base[x->baselen - 1] =3D=3D '/');
 		if (match_pathname(pathname, pathlen,
 				   x->base, x->baselen ? x->baselen - 1 : 0,
-				   exclude, prefix, x->patternlen, x->flags))
-			return x;
+				   exclude, prefix, x->patternlen, x->flags)) {
+			exc =3D x;
+			break;
+		}
 	}
-	return NULL; /* undecided */
+	return exc;
 }
=20
 /*
--=20
2.3.0.rc1.137.g477eb31

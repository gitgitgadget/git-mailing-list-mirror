From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/4] exclude: reuse last basename comparison
Date: Thu,  7 Jun 2012 14:53:37 +0700
Message-ID: <1339055617-23028-4-git-send-email-pclouds@gmail.com>
References: <1339055617-23028-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 07 09:54:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScXY0-0006hI-1b
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 09:54:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756847Ab2FGHyU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jun 2012 03:54:20 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:62813 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756660Ab2FGHyT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 03:54:19 -0400
Received: by dady13 with SMTP id y13so507338dad.19
        for <git@vger.kernel.org>; Thu, 07 Jun 2012 00:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=DgO79lFYMa/VMGaRUEGEaucNd34qT3byt21kbAHYxBQ=;
        b=V/LHiGdcuXFih5mU/j2x6tozk0naQ4uUVNSWZYrNMM7WFqK4dfpkSOLCBQOKik4vAU
         IiPrd1vlQYzWH/xVLQTfSj8qbQ2hz1wodxwaSWM5pygh4ofJjVtdgwQyZlWz2pRy0Pu1
         kHjGwrjlVJ7OooudMxH3o+Id+2QXGcYgpIapWsfo+YHDZ8epr3IM8yFN58whqYSg5sIT
         2rM8lmHFNVEv6p02EKhPtZRPte9bVDHUrXZplFwioFwMa4B1Qp51qNSlTaC/s39KhpYM
         k2ltkcoNn9imUiDUC4cJhxbrKCcdJBcaq8XWN4rY9c9vPhmtD/MjonqMc8fI0rmUHM9M
         VI7g==
Received: by 10.68.225.201 with SMTP id rm9mr6310743pbc.71.1339055658945;
        Thu, 07 Jun 2012 00:54:18 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id jw3sm3250072pbc.65.2012.06.07.00.54.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Jun 2012 00:54:18 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 07 Jun 2012 14:54:06 +0700
X-Mailer: git-send-email 1.7.11.rc1.185.g281ad67
In-Reply-To: <1339055617-23028-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199379>

If two consecutive patterns share the same "base" and we just compared
base against pathname last time, we can just reuse the last comparison
result.

This optmization is made with read_directory() in mind. Notice that
all exclude patterns share the same "base" pointer, which is basebuf[]
from "struct dir" (given indirectly by prep_exclude()) and patterns
from the same .gitignore will stay in the same order. This opens an
opportunity for this optimization when there are a lot of patterns in
subdirectories-with-long-path-name/.gitignore.

Other users of excluded_from_list() unlikely take advantage of this,
unless add_excludes() learns to pre-compare two consecutive bases and
save the result, so excluded_from_list() can perform a cheap "are
these two bases the same" check.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I haven't put more thought/work on optimizing the big top .gitignore
 case yet.  But something like this is probably worth doing anyway.
 Pathspec might use the same optimization. If a user does (notice no
 quotes)
=20
 git something long/path/to/here/*.[ch]

 we would need to compare "long/path/to/here" all over again (I
 haven't checked the code though).

 dir.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index 94fe9f8..2964076 100644
--- a/dir.c
+++ b/dir.c
@@ -511,6 +511,7 @@ int excluded_from_list(const char *pathname,
 		       struct exclude_list *el)
 {
 	int i;
+	int last_basecmp =3D el->nr, basecmp_result;
=20
 	if (!el->nr)
 		return -1;	/* undefined */
@@ -552,9 +553,25 @@ int excluded_from_list(const char *pathname,
 			prefix--;
 		}
=20
-		if (pathlen < x->baselen ||
-		    (x->baselen && pathname[x->baselen-1] !=3D '/') ||
-		    strncmp_icase(pathname, x->base, x->baselen))
+		if (i < el->nr - 1 &&
+		    last_basecmp =3D=3D i + 1 &&
+		    x->base    =3D=3D el->excludes[last_basecmp]->base &&
+		    x->baselen =3D=3D el->excludes[last_basecmp]->baselen)
+			/*
+			 * we have the same "base" as last time and
+			 * last time we came here too (i.e. no break
+			 * or continue from the above code), reuse
+			 * basecmp_result
+			 */
+			;
+		else
+			/* anything other than zero is ok, we don't
+			   really care about the sorting order */
+			basecmp_result =3D pathlen < x->baselen ||
+				(x->baselen && pathname[x->baselen - 1] !=3D '/') ||
+				strncmp_icase(pathname, x->base, x->baselen);
+		last_basecmp =3D i;
+		if (basecmp_result)
 			continue;
=20
 		namelen =3D x->baselen ? pathlen - x->baselen : pathlen;
--=20
1.7.11.rc1.185.g281ad67

From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/10] wildmatch: remove static variable force_lower_case
Date: Fri,  5 Oct 2012 11:41:05 +0700
Message-ID: <1349412069-627-7-git-send-email-pclouds@gmail.com>
References: <1349412069-627-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 09:39:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TK2Uy-0003Hb-6g
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 09:39:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704Ab2JEHiy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Oct 2012 03:38:54 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:47242 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300Ab2JEHix (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2012 03:38:53 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so1403985pad.19
        for <git@vger.kernel.org>; Fri, 05 Oct 2012 00:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=URvv4Lq80724JYQC4vyNbfquL6HqzNh33xpg+L6LdrI=;
        b=W5ZTYYzCalibhMHli6hXVC0nD5y7rKto6IjFNcR9dINc5mUiRgP1OyERjPPzKQ+xTF
         12Mmw3d0NRRmeRapLVMPT50IAwgtGS4ikZfDCznplitkLDIud7jdAsZJ4927eEo4Pqsb
         AP3UFaJSIjlPKQmQDwHB9z0Z32DykF8pxb3B4HFYKvR3MElpOKFRvDhxjuXx8P+DfQuD
         959+qiza2U3Xyuvi9aWcYi0QfnqCLNpIE3p51BENWtu/L/ls3GAwIGo8yHEeKw6wQbrt
         jVFKNCITUvZdVyCADUTDbnpORwrh2zTPNy0qUMdkHzUW5V7jh/DiWTb8BPmsOt/4K+OZ
         Az0g==
Received: by 10.66.78.6 with SMTP id x6mr18479215paw.41.1349412098358;
        Thu, 04 Oct 2012 21:41:38 -0700 (PDT)
Received: from tre ([115.74.45.10])
        by mx.google.com with ESMTPS id c1sm5373514pay.19.2012.10.04.21.41.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Oct 2012 21:41:37 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 05 Oct 2012 11:41:46 +0700
X-Mailer: git-send-email 1.7.10.1.641.g9354186
In-Reply-To: <1349412069-627-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207089>

One place less to worry about thread safety

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 wildmatch.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/wildmatch.c b/wildmatch.c
index f3a1731..e824eb2 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -57,11 +57,10 @@
 int wildmatch_iteration_count;
 #endif
=20
-static int force_lower_case =3D 0;
-
 /* Match pattern "p" against the a virtually-joined string consisting
  * of "text" and any strings in array "a". */
-static int dowild(const uchar *p, const uchar *text, const uchar*const=
 *a)
+static int dowild(const uchar *p, const uchar *text,
+		  const uchar*const *a, int force_lower_case)
 {
     uchar p_ch;
=20
@@ -121,7 +120,7 @@ static int dowild(const uchar *p, const uchar *text=
, const uchar*const *a)
 		    t_ch =3D *text;
 		    continue;
 		}
-		if ((matched =3D dowild(p, text, a)) !=3D FALSE) {
+		if ((matched =3D dowild(p, text, a, force_lower_case)) !=3D FALSE) {
 		    if (!special || matched !=3D ABORT_TO_STARSTAR)
 			return matched;
 		} else if (!special && t_ch =3D=3D '/')
@@ -291,7 +290,7 @@ int wildmatch(const char *pattern, const char *text=
)
 #ifdef WILD_TEST_ITERATIONS
     wildmatch_iteration_count =3D 0;
 #endif
-    return dowild((const uchar*)pattern, (const uchar*)text, nomore) =3D=
=3D TRUE;
+    return dowild((const uchar*)pattern, (const uchar*)text, nomore, 0=
) =3D=3D TRUE;
 }
=20
 /* Match the "pattern" against the forced-to-lower-case "text" string.=
 */
@@ -302,9 +301,7 @@ int iwildmatch(const char *pattern, const char *tex=
t)
 #ifdef WILD_TEST_ITERATIONS
     wildmatch_iteration_count =3D 0;
 #endif
-    force_lower_case =3D 1;
-    ret =3D dowild((const uchar*)pattern, (const uchar*)text, nomore) =
=3D=3D TRUE;
-    force_lower_case =3D 0;
+    ret =3D dowild((const uchar*)pattern, (const uchar*)text, nomore, =
1) =3D=3D TRUE;
     return ret;
 }
=20
@@ -331,7 +328,7 @@ int wildmatch_array(const char *pattern, const char=
*const *texts, int where)
     if (!text)
 	return FALSE;
=20
-    if ((matched =3D dowild(p, text, a)) !=3D TRUE && where < 0
+    if ((matched =3D dowild(p, text, a, 0)) !=3D TRUE && where < 0
      && matched !=3D ABORT_ALL) {
 	while (1) {
 	    if (*text =3D=3D '\0') {
@@ -339,7 +336,7 @@ int wildmatch_array(const char *pattern, const char=
*const *texts, int where)
 		    return FALSE;
 		continue;
 	    }
-	    if (*text++ =3D=3D '/' && (matched =3D dowild(p, text, a)) !=3D F=
ALSE
+	    if (*text++ =3D=3D '/' && (matched =3D dowild(p, text, a, 0)) !=3D=
 FALSE
 	     && matched !=3D ABORT_TO_STARSTAR)
 		break;
 	}
--=20
1.7.12.1.405.gb727dc9

From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] dir.c: correct "stuck" logging logic
Date: Thu, 17 Mar 2016 19:45:43 +0700
Message-ID: <1458218744-15810-3-git-send-email-pclouds@gmail.com>
References: <56E9F5B3.6030903@fb.com>
 <1458218744-15810-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: durham@fb.com, mitrandir@fb.com,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 17 13:47:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agXKV-0004EQ-Kc
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 13:47:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935221AbcCQMrD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Mar 2016 08:47:03 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33960 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669AbcCQMrC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 08:47:02 -0400
Received: by mail-pf0-f176.google.com with SMTP id x3so119769528pfb.1
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 05:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6kmdUE2pavLUT8FSmPWpKvaqIjY4Qpouyt85UowW7Xs=;
        b=adutnvWmtWiyyTWjTRWMkppIaJ8cZouampcOyQEJIc7x10KryBDBtwH8QKhndETljF
         aMaDLnSKJi15B7fIFLDsxjkZ1WVuId2HqGSP1D76okvB9mXtkRI3WO8ZG2SLkOEaXKpq
         BPbxu2wgV1Nt5sI+1XE6ZCcOaHqQsAiOsGQjogGLT7I1sKESw8L4DPPvv0Mo2bpAjBGq
         8hUiEpIB1+1UqGcEKxfp/An/QS2N72mXUbaDPXgWYx7vQdaIBQ0DiU0dwi+mlz62SrZk
         Xt10uzKVFbSYpSpXOMI5QHYC7ZPIksPtbwbZWRe50JYVe/Y/FRfEaUbZ8y/eXOoUrHf3
         nftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6kmdUE2pavLUT8FSmPWpKvaqIjY4Qpouyt85UowW7Xs=;
        b=DiJlGiqT1A/faGLWMI/9fqddSMGGbbAx8sEdr3blZgjhcsmZqc6uU5d5LMxwdYm/kb
         wheZBVbyxJvJkRk293KE3v7v2IzU9oOPZ1sx++vW6xsMjBklvjyW9TI8CFIMndEPZ5RL
         wBcYwzZzEYMH+f4cHEuR8ADTVH1EnmqEiZg2kHKtkQwCV0tBtnM1Ik0Tc4Xkk6IdPNTQ
         Jxrqj7PsEumUlOqGnG2QZ/f8TTty8OfZONrUfYUz7B37ZnlVBhAZqjRsHBbnjzBGlaNZ
         dDVt9gZuBAa01BcDgOdqhotTMFpYrIDrXq/qh5OYzjVrgyWkgDul70ol1pOA1EQR9jXY
         rCIw==
X-Gm-Message-State: AD7BkJKtG5BdLAdXuEAQP2RA7p2wzs8tinW59/gjctbxFe59USxNPMfuwCuW/oBrlGW3vw==
X-Received: by 10.66.119.237 with SMTP id kx13mr14323904pab.111.1458218808772;
        Thu, 17 Mar 2016 05:46:48 -0700 (PDT)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id q72sm13271985pfa.70.2016.03.17.05.46.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Mar 2016 05:46:47 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 17 Mar 2016 19:46:49 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1458218744-15810-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289103>

Before the last patch, the loop in last_exclude_matching_from_list()
looks like this (greatly simplified of course)

   exc =3D NULL;
   for (...) {
      if (sticky_paths.nr) {
         if (matched) {
            exc =3D non-NULL;
            break;
         }
         continue;
      }
      ...
   }

With this loop, if sticky_paths.nr is non-zero and exc is not NULL, we
know we have found a sticky path and can log " (stuck)".

With the last patch, the "continue;" line is removed and that won't wor=
k
anymore. So explicitly keep track of when to print " (stuck)".

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c                                | 4 +++-
 t/t1011-read-tree-sparse-checkout.sh | 8 ++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index 77f38a5..2028094 100644
--- a/dir.c
+++ b/dir.c
@@ -1005,6 +1005,7 @@ static struct exclude *last_exclude_matching_from=
_list(const char *pathname,
 {
 	struct exclude *exc =3D NULL; /* undecided */
 	int i, maybe_descend =3D 0;
+	const char *stuck =3D "";
=20
 	if (!el->nr)
 		return NULL;	/* undefined */
@@ -1024,6 +1025,7 @@ static struct exclude *last_exclude_matching_from=
_list(const char *pathname,
 			if (*dtype =3D=3D DT_UNKNOWN)
 				*dtype =3D get_dtype(NULL, pathname, pathlen);
 			if (match_sticky(x, pathname, pathlen, *dtype)) {
+				stuck =3D " (stuck)";
 				exc =3D x;
 				break;
 			}
@@ -1093,7 +1095,7 @@ static struct exclude *last_exclude_matching_from=
_list(const char *pathname,
 	trace_printf_key(&trace_exclude, "exclude: %.*s vs %s at line %d =3D>=
 %s%s\n",
 			 pathlen, pathname, exc->pattern, exc->srcpos,
 			 exc->flags & EXC_FLAG_NEGATIVE ? "no" : "yes",
-			 exc->sticky_paths.nr ? " (stuck)" : "");
+			 stuck);
 	return exc;
 }
=20
diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-s=
parse-checkout.sh
index ecc5e93..f0b856f 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -287,10 +287,14 @@ test_expect_success 'sparse checkout and dir.c st=
icky bits' '
 		!one/hideme
 		EOF
 		git config core.sparsecheckout true &&
-		git checkout &&
+		GIT_TRACE_EXCLUDE=3D2 git checkout 2>&1 | grep stuck >stuck-list &&
 		test_path_is_missing one/hideme &&
 		test_path_is_file    one/showme &&
-		test_path_is_file    two/showme
+		test_path_is_file    two/showme &&
+		cat >expected <<-\EOF &&
+		exclude: one/showme vs /* at line 1 =3D> yes (stuck)
+		EOF
+		test_cmp expected stuck-list
 	)
 '
=20
--=20
2.8.0.rc0.210.gd302cd2

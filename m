From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] dir.c: correct "stuck" logging logic
Date: Thu, 17 Mar 2016 19:45:44 +0700
Message-ID: <1458218744-15810-4-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Thu Mar 17 13:47:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agXKf-0004H9-Sx
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 13:47:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030270AbcCQMrH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Mar 2016 08:47:07 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35145 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030207AbcCQMrG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 08:47:06 -0400
Received: by mail-pf0-f176.google.com with SMTP id n5so119835853pfn.2
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 05:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FUEpqT5+vLRiOSAbc2Oye38nXOcCTzQq2ZJ/7xiIEhU=;
        b=HPWdlqFXsqLcBV3DJUPG1PMrZAdpT3mrPKxNd+Ishp6oDDGpnR4AuY+q25qQDEPYKm
         UbiMAGPTQdV1fW2JD3CcK+VdbvBdTKuUeY1bUmiKPUyQeiv2QA/NPKFbtu4pYxsUYve3
         B64DjvPfkRsWBjKcH5p8GkDLLcnClJwMowkE/i6sZba7Jh+QRuY7EZ3KL4YOLYvdF3PO
         mHxYYUvg7umtnWGEFpWtbQGcuP+WrWbBSw5mGO2AZtHGHwaKiyks2aQUafME4pX/xPto
         tgNJCAAzRRZFXUdOm2tYjl4thW/eaL7LsU/ODHNNxvbObcehj/BFUj2RQigjCo103TnL
         k+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FUEpqT5+vLRiOSAbc2Oye38nXOcCTzQq2ZJ/7xiIEhU=;
        b=ATXINpvr7TRr3P4ffHQGrS19s8Y04XcGqywiccp3XjIPavTaY2GBsvwY1dRJIQewoJ
         22IZ18mU3FCOxYQvs+cJBUlLZsuGvGycgHV2mGtjQ7RahgqTY584rHgwA5oOSIXmd10M
         aR086NmMhuLZ7GbwN24yfpoTKl3mzSTmeQDzifFBzxzwi271WO63JHoVHNY7K7/UWjg/
         7ZUdD+FEkI2+3mvSwoRdB+FwbpPePluLkstx203MkP90jYYxp9v44NXbHEq4M8hsd0PX
         T7yQsHU1m81JVud8K7ELrJzDjHQpkBIqtqGTO+oqMHW1cdtqu5J1NLWwY/po4oHLGMGM
         inqQ==
X-Gm-Message-State: AD7BkJIRcKmAV+zqybtQDsbYqxCeBHiLW4EWkuXEgzQLLcqiK/X+gt+tLfkw5H5djujCTg==
X-Received: by 10.66.171.169 with SMTP id av9mr14697609pac.36.1458218814885;
        Thu, 17 Mar 2016 05:46:54 -0700 (PDT)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id q85sm13270658pfq.81.2016.03.17.05.46.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Mar 2016 05:46:53 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 17 Mar 2016 19:47:00 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1458218744-15810-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289104>

Before the last patch, the loop in last_exclude_matching_from_list()
looks like this (greatly simplified of course)

   exc =3D NULL;
   for (...) {
      if (sticky_paths.nr) {
         if (matched) {
            exc =3D something;
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

From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] exclude: fix a bug in prefix comparison optimization
Date: Sun, 14 Oct 2012 18:35:22 +0700
Message-ID: <1350214522-3242-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 13:36:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNMU8-0002Nw-HM
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 13:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752627Ab2JNLfj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Oct 2012 07:35:39 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:48670 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575Ab2JNLfi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 07:35:38 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so4045717pad.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 04:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=Jd09VXnfNBJ2Z4FYd5tcJnFl9nKLXs0vXG1dwFLAvEE=;
        b=vWjA9P1bnZ0jBRHRR9FdHKjOm8ZpvO7f2cNGt5QQj3vIlH2FdfWs0OG5QrZR/3nDd5
         AXZv8P4qyFmNmmQMDaDvutwFcCHIuRSFzM/zXy5+b4Geah2c44FzwvZEXl+rmBOK5xzx
         nH99FQcEfdaKV9Zm+vKt76rKi5RLTyObTxSK085mlnHhS0LrtaQfAlicf/IAkY1sF7lR
         A3HgHI67VhLNMEeaVq7YJuo0OoQaBX/XNdDGkgCw9sMFySXkcFVvT4WP4dBHEOU1X0qP
         qtrN1T8Zf6iyX8Kv+GCEQmRv3ENohjoQarPkYDHuk8VxXVCMFKvW2ADgW/QyyucAv9gI
         lhkA==
Received: by 10.68.212.74 with SMTP id ni10mr28581598pbc.20.1350214538147;
        Sun, 14 Oct 2012 04:35:38 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.44.221])
        by mx.google.com with ESMTPS id vf8sm7378083pbc.27.2012.10.14.04.35.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 04:35:37 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 14 Oct 2012 18:35:23 +0700
X-Mailer: git-send-email 1.8.0.rc2.11.g2b79d01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207652>

When "namelen" becomes zero at this stage, we have matched the fixed
part, but whether it actually matches the pattern still depends on the
pattern in "exclude". As demonstrated in t3001, path "three/a.3"
exists and it matches the "three/a.3" part in pattern "three/a.3[abc]",
but that does not mean a true match.

Don't be too optimistic and let fnmatch() do the job.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c                              | 2 +-
 t/t3001-ls-files-others-exclude.sh | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 4868339..90bf3a4 100644
--- a/dir.c
+++ b/dir.c
@@ -575,7 +575,7 @@ int excluded_from_list(const char *pathname,
 			namelen -=3D prefix;
 		}
=20
-		if (!namelen || !fnmatch_icase(exclude, name, FNM_PATHNAME))
+		if (!fnmatch_icase(exclude, name, FNM_PATHNAME))
 			return to_exclude;
 	}
 	return -1; /* undecided */
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-othe=
rs-exclude.sh
index c8fe978..dc2f045 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -214,4 +214,10 @@ test_expect_success 'subdirectory ignore (l1)' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'pattern matches prefix completely' '
+	: >expect &&
+	git ls-files -i -o --exclude "/three/a.3[abc]" >actual &&
+	test_cmp expect actual
+'
+
 test_done
--=20
1.8.0.rc2.11.g2b79d01

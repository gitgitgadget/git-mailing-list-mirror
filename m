From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/4] exclude: fix a bug in prefix compare optimization
Date: Sun, 14 Oct 2012 18:55:40 +0700
Message-ID: <1350215742-20761-3-git-send-email-pclouds@gmail.com>
References: <1350215742-20761-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 13:56:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNMny-0004hG-78
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 13:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752808Ab2JNL4Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Oct 2012 07:56:16 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:53136 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935Ab2JNL4P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 07:56:15 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so4052432pad.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 04:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=vxn8UT5h/DSXVwHNLnoWYZvCS51rlcLX3r4fPIVFfBM=;
        b=Zs6Kh9m3V6Ht5EcWB5lZjssLdP0Ih59cyJQ1hF0sPQkRbHYl7kcxElm6HYaRaYDm4W
         ggBaumANwPeZXrCAYldu+rIx+WN/VuhoGE38guNyVc8EAKfSNqzPGSz8MPBaqjkGhohg
         7FQbEVA4mKZDxk3T/vlyyJ/nhtNpxgOfIabldSoJA87Wlj2gYuZh6yYfmzSZrQtd6Wu5
         LHj2AuDx4EgfAOZ5ifMB8k5MRa8kEb/BHwnpuigad/KvEWfESvzaBgFWZJznQ3zm1Xqd
         rw9HBq2ExXByenSEq8wSyip6UrUmXL3WoUzwX8DpHwrhK+zjOyJbqRekAEQ+Uc/pPFdP
         vP+w==
Received: by 10.68.125.229 with SMTP id mt5mr3402029pbb.51.1350215775527;
        Sun, 14 Oct 2012 04:56:15 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.44.221])
        by mx.google.com with ESMTPS id it5sm7400520pbc.10.2012.10.14.04.56.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 04:56:15 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 14 Oct 2012 18:55:59 +0700
X-Mailer: git-send-email 1.8.0.rc2.11.g2b79d01
In-Reply-To: <1350215742-20761-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207657>

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
index d81498e..0f4aea6 100644
--- a/dir.c
+++ b/dir.c
@@ -601,7 +601,7 @@ int excluded_from_list(const char *pathname,
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

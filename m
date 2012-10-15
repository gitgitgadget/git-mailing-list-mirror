From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/6] exclude: fix a bug in prefix compare optimization
Date: Mon, 15 Oct 2012 13:24:36 +0700
Message-ID: <1350282279-4377-3-git-send-email-pclouds@gmail.com>
References: <1350282212-4270-1-git-send-email-pclouds@gmail.com>
 <1350282279-4377-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 08:25:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNe75-0006DF-SY
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 08:25:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753713Ab2JOGZH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2012 02:25:07 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:51858 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753358Ab2JOGZG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 02:25:06 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so2429486dak.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 23:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=nFCGAKJFZFK7q9UN+lefyu082qeo4e2Pz52fJpC+HFI=;
        b=XItxf0GPZeDMqVczvHK8jAc1OkRaz5QgUUUuGofuQ9JaCCRN5LfHC4CVOieFSoqSry
         fuv8C0hlSilzYn+kFv+Yo2IzRd/QMTrCQtYTiqGX6lucvejZCT6DjKUMOOKUl83JWOuB
         KwQH2wXhRKvFSsncsf361UIsUJPSemteMgCAd0cPEmW6YITqne1hZ8xEQqBBlEZ+NDkB
         o/BgUgsua5ToLsKM8S2k0SzoE9LYuVGpJxLncaogducDKNwHRU++qae0FrIldZkwrSx8
         8ePfqBHgVeGRjIOTnA/SuFDhaIvKnz2697Lin4a4pg1bYAaF72dHtUY++imR28SG1NbV
         QBBg==
Received: by 10.66.81.199 with SMTP id c7mr30397833pay.19.1350282306482;
        Sun, 14 Oct 2012 23:25:06 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id pj10sm8572064pbb.46.2012.10.14.23.25.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 23:25:05 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Oct 2012 13:24:56 +0700
X-Mailer: git-send-email 1.8.0.rc0.29.g1fdd78f
In-Reply-To: <1350282279-4377-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207695>

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
index d9b5561..22d0b7b 100644
--- a/dir.c
+++ b/dir.c
@@ -585,7 +585,7 @@ int excluded_from_list(const char *pathname,
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
1.8.0.rc0.29.g1fdd78f

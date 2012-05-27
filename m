From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v6 9/9] submodule: fix normalization to handle repeated ./
Date: Sun, 27 May 2012 23:43:30 +1000
Message-ID: <1338126210-11517-10-git-send-email-jon.seymour@gmail.com>
References: <1338126210-11517-1-git-send-email-jon.seymour@gmail.com>
Cc: Jens.Lehmann@web.de, gitster@pobox.com, phil.hord@gmail.com,
	ramsay@ramsay1.demon.co.uk, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 27 15:44:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYdlh-0006ZR-8s
	for gcvg-git-2@plane.gmane.org; Sun, 27 May 2012 15:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752667Ab2E0NoU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 May 2012 09:44:20 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38301 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590Ab2E0NoO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2012 09:44:14 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so3101250dad.19
        for <git@vger.kernel.org>; Sun, 27 May 2012 06:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=eIzig1Gzi1dT6FMLTx1ypB6e9kqNPqNFsqeEB/taO94=;
        b=E+2NSqe+2kvOPzcC6UdA5/rraTSYx9zbsRA0CvFtBmvLA4f7JHXfJQtGu54aX2tMVB
         7uVkyjFrzOP6jAGv0w6BBoa+2FtO0KlN0pv6Ak4hISj7KoQKJnfDMkiv6TbZ5PFj5+ky
         L8XVHpZ7fKG6qfFjDt/BOw3Rer1+NlcyLc9Lzxcr8vkCvDTDQ1ugNLptCBqcNCPbF152
         Wryb8O1uOQCVcQsIfmF8UQ09ubkZCcoc3x+dLRM8oSLWU1on99SJ1tXDox/hzEjusZWH
         a3uGHOTBA/jplfaA1/uNx7xj+yT0H/muCBhNsNuYu/WeW/w77SUpYKrPwDA0DHH0BMDc
         pMiA==
Received: by 10.68.130.197 with SMTP id og5mr17283377pbb.56.1338126253980;
        Sun, 27 May 2012 06:44:13 -0700 (PDT)
Received: from ubuntu.ubuntu-domain (124-170-214-58.dyn.iinet.net.au. [124.170.214.58])
        by mx.google.com with ESMTPS id ru4sm15870005pbc.66.2012.05.27.06.44.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 May 2012 06:44:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.656.gb5a46db
In-Reply-To: <1338126210-11517-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198600>

Currently path/./foo/./bar is denormalized correctly, but path/foo/././bar
is not.

We fix the normalization script to allow repeated application of the
./ -> / normalization in the same way that foo/.. is handled - by
moving it inside a sed loop.

The existing sed label, start, is renamed to fooslashdotdotslash to
indicate which of the two loops is being refered to by the second
branch directive.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-submodule.sh           | 8 +++++---
 t/t7400-submodule-basic.sh | 6 +++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 1f0983c..8f3bc71 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -229,10 +229,12 @@ normalize_path()
 		sed -e '
 			s|//*|/|g
 			s|^\(\./\)*||
-			s|/\./|/|g
-			:start
+			:slashdotslash
+			s|/\./|/|
+			tslashdotslash
+			:fooslashdotdotslash
 			s|\([^/]*\)/\.\./||
-			tstart
+			tfooslashdotdotslash
 			s|/*$||
 		'
 }
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index b01f479..61887b2 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -499,7 +499,7 @@ test_expect_success '../subrepo works with URL - ssh://hostname/repo' '
 	)
 '
 
-test_expect_failure 'relative path works with URL - ssh://hostname/path/././repo' '
+test_expect_success 'relative path works with URL - ssh://hostname/path/././repo' '
 	(
 		cd reltest &&
 		cp pristine-.git-config .git/config &&
@@ -510,7 +510,7 @@ test_expect_failure 'relative path works with URL - ssh://hostname/path/././repo
 	)
 '
 
-test_expect_failure 'relative path works with URL - ssh://hostname/path/detour/././../repo' '
+test_expect_success 'relative path works with URL - ssh://hostname/path/detour/././../repo' '
 	(
 		cd reltest &&
 		cp pristine-.git-config .git/config &&
@@ -685,7 +685,7 @@ test_expect_success 'relative path works with user@host:path/to/./repo' '
 	)
 '
 
-test_expect_failure 'relative path works with user@host:path/to/././repo' '
+test_expect_success 'relative path works with user@host:path/to/././repo' '
 	(
 		cd reltest &&
 		cp pristine-.git-config .git/config &&
-- 
1.7.10.2.656.gb5a46db

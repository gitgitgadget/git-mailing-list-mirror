From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v7 9/9] submodule: fix normalization to handle repeated ./
Date: Mon, 28 May 2012 01:34:11 +1000
Message-ID: <1338132851-23497-10-git-send-email-jon.seymour@gmail.com>
References: <1338132851-23497-1-git-send-email-jon.seymour@gmail.com>
Cc: Jens.Lehmann@web.de, gitster@pobox.com, phil.hord@gmail.com,
	ramsay@ramsay1.demon.co.uk, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 27 17:36:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYfVt-0006Ww-Gq
	for gcvg-git-2@plane.gmane.org; Sun, 27 May 2012 17:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752962Ab2E0PfS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 May 2012 11:35:18 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:59885 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752751Ab2E0Pe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2012 11:34:56 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so3669135pbb.19
        for <git@vger.kernel.org>; Sun, 27 May 2012 08:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Cjzod+SXCbEsVntB7Wx+0JBXxcQCSjlQ2dnFbbaFtJw=;
        b=bg6sEuAfP1XNr/X/s8OUKWXZ39tFMreI/88CkBCqDE9TflzjC+G4Xsl41G/aQ7lgF6
         SR3Mq13K3Md1HEMP44hukWvo0qnyfY73RLrVOLC2d067PIEnjzX/1RAV1Ok53OiIdZpg
         W97Gq58baLxFbB80G0RTZx4PdAxrSZTzdiPHUSPo4Gito0bPrdzJQNpcCkbebmiLwydY
         GHYnlSRGE9H9UUxZ7Vs0pbd76rgDQYDhJIdcBszbriIRUA+L0Wr+bD7Z+TilGE9zFduv
         zy7z8KqW8pKacm4vs//pbHOtGXfD5UAe9PDvlHvZbTjQSbXfK0FkFQ88N7Dg22g+6jgN
         UbVw==
Received: by 10.68.212.67 with SMTP id ni3mr3967268pbc.136.1338132895841;
        Sun, 27 May 2012 08:34:55 -0700 (PDT)
Received: from ubuntu.ubuntu-domain (124-170-214-58.dyn.iinet.net.au. [124.170.214.58])
        by mx.google.com with ESMTPS id rk4sm16128261pbc.48.2012.05.27.08.34.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 May 2012 08:34:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.656.g24a6219
In-Reply-To: <1338132851-23497-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198613>

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
1.7.10.2.656.g24a6219

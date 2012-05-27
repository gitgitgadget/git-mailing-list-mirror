From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v6 5/9] submodule: extract normalize_path into standalone function
Date: Sun, 27 May 2012 23:43:26 +1000
Message-ID: <1338126210-11517-6-git-send-email-jon.seymour@gmail.com>
References: <1338126210-11517-1-git-send-email-jon.seymour@gmail.com>
Cc: Jens.Lehmann@web.de, gitster@pobox.com, phil.hord@gmail.com,
	ramsay@ramsay1.demon.co.uk, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 27 15:44:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYdlQ-00063X-1z
	for gcvg-git-2@plane.gmane.org; Sun, 27 May 2012 15:44:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752585Ab2E0NoD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 May 2012 09:44:03 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38301 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490Ab2E0Nn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2012 09:43:59 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so3101250dad.19
        for <git@vger.kernel.org>; Sun, 27 May 2012 06:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=L0itF3o+I2nsUHcsUKn1KG3SoQn26JEz+ommSEHgI7Q=;
        b=Kj624dyGd5NSf5++IGNrY1bZjOCAZQNGjLa0Rca2BxxHWSQ9A+sogY6UKpAFNhJiAW
         rgKua4SXz7Ye5eVOTGdv05FTRSJMu/oZVOBn0AF9k5BkrW+ZynbfKLo6SFtkyk2ulTM3
         Jo7Z8s+EqXn3fkAJXxqnkhXYC+LACfeE2Eo2/LOoBMffvqJ2FcD19IfeiMjmWZBFGrY2
         /6aTr4/R98Y9GuMR9vHJXtWD37R2BesVbwUnwMW0eVDtQlnznVDqUio5QMk5DDClwPwQ
         j15m35MhF5EedySRSYaKQVHp/iBOFio6zXilD/lDRixOCZ2uXxRV8kDVBEqSecPBkSUY
         mC2Q==
Received: by 10.68.200.9 with SMTP id jo9mr16988066pbc.122.1338126239730;
        Sun, 27 May 2012 06:43:59 -0700 (PDT)
Received: from ubuntu.ubuntu-domain (124-170-214-58.dyn.iinet.net.au. [124.170.214.58])
        by mx.google.com with ESMTPS id ru4sm15870005pbc.66.2012.05.27.06.43.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 May 2012 06:43:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.656.gb5a46db
In-Reply-To: <1338126210-11517-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198596>

Extract the normalize_path function so that it can be re-used elsewhere.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-submodule.sh | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 64a70d6..dbbc905 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -176,6 +176,21 @@ module_clone()
 	(clear_local_git_env; cd "$sm_path" && GIT_WORK_TREE=. git config core.worktree "$rel/$b")
 }
 
+normalize_path()
+{
+	# normalize path:
+	# multiple //; leading ./; /./; /../; trailing /
+	printf '%s/\n' "$1" |
+		sed -e '
+			s|//*|/|g
+			s|^\(\./\)*||
+			s|/\./|/|g
+			:start
+			s|\([^/]*\)/\.\./||
+			tstart
+			s|/*$||
+		'
+}
 #
 # Add a new submodule to the working tree, .gitmodules and the index
 #
@@ -250,18 +265,7 @@ cmd_add()
 	;;
 	esac
 
-	# normalize path:
-	# multiple //; leading ./; /./; /../; trailing /
-	sm_path=$(printf '%s/\n' "$sm_path" |
-		sed -e '
-			s|//*|/|g
-			s|^\(\./\)*||
-			s|/\./|/|g
-			:start
-			s|\([^/]*\)/\.\./||
-			tstart
-			s|/*$||
-		')
+	sm_path="$(normalize_path "$sm_path")"
 	git ls-files --error-unmatch "$sm_path" > /dev/null 2>&1 &&
 	die "$(eval_gettext "'\$sm_path' already exists in the index")"
 
-- 
1.7.10.2.656.gb5a46db

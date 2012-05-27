From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v7 5/9] submodule: extract normalize_path into standalone function
Date: Mon, 28 May 2012 01:34:07 +1000
Message-ID: <1338132851-23497-6-git-send-email-jon.seymour@gmail.com>
References: <1338132851-23497-1-git-send-email-jon.seymour@gmail.com>
Cc: Jens.Lehmann@web.de, gitster@pobox.com, phil.hord@gmail.com,
	ramsay@ramsay1.demon.co.uk, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 27 17:36:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYfVr-0006Ww-HH
	for gcvg-git-2@plane.gmane.org; Sun, 27 May 2012 17:36:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752899Ab2E0PfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 May 2012 11:35:09 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:59885 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752727Ab2E0Pel (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2012 11:34:41 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so3669135pbb.19
        for <git@vger.kernel.org>; Sun, 27 May 2012 08:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=zhFPqce9DgO+VDDdlZCya+3248dSKXDI2P0DecKuaSE=;
        b=0rjkY6eFl+F7tZCSp0DVLTcJXoazViat3fMPj+dz+pY/IEbXyjz6j1iFo7AjOfTKDY
         14JHtc7PCC94cpadTGrga/xQ5ifo82CrOZXgWPirgmGvVVUu7M4yB1oZw7483PdguQ7Q
         caHvWCFhA+dFBALyAYR87804mOnQX93alz3WD9R1ECJzuqNrQYJ9Pl++8vGkxzBOH8y/
         7QDbr4BaP2OJYpZLM9fHiIEiuZXTh2qdPeUyqkFKtHW9L56f54OQia6Ny4X8DkVAyKM2
         p7Tch3hyevHQLFVpLQVTiyaaD9PCAgj5YIwEnNDzcF4Horm8RMkmnk+GS1C4Qou8oYEn
         3mKw==
Received: by 10.68.238.134 with SMTP id vk6mr17841527pbc.128.1338132880952;
        Sun, 27 May 2012 08:34:40 -0700 (PDT)
Received: from ubuntu.ubuntu-domain (124-170-214-58.dyn.iinet.net.au. [124.170.214.58])
        by mx.google.com with ESMTPS id rk4sm16128261pbc.48.2012.05.27.08.34.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 May 2012 08:34:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.656.g24a6219
In-Reply-To: <1338132851-23497-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198608>

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
1.7.10.2.656.g24a6219

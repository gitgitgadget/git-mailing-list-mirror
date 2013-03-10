From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH v2 02/23] contrib/subtree: Add command from-submodule
Date: Sun, 10 Mar 2013 23:41:10 +0000
Message-ID: <1362958891-26941-3-git-send-email-pcampbell@kemitix.net>
References: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
Cc: David Greene <greened@obbligato.org>,
	Peter Jaros <pjaros@pivotallabs.com>,
	Paul Campbell <pcampbell@kemitix.net>,
	"Avery Pennarun" <apenwarr@gmail.com>,
	"Wayne Walter" <wayne@tickzoom.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 11 00:44:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEpuK-0003X9-2m
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 00:44:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753331Ab3CJXnS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 19:43:18 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:60755 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262Ab3CJXnP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 19:43:15 -0400
Received: by mail-wi0-f176.google.com with SMTP id hm14so606799wib.9
        for <git@vger.kernel.org>; Sun, 10 Mar 2013 16:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=C2wVBzrS36S1NxPbeZ+TxWpKJWk9083Cdl4V4kno76w=;
        b=Cb92PUb26/t7Zq4/cIToSNzwNdbKOyrDpFcNJ8mJUAM2wtN56+VYub/bBGZxDGXrdD
         aF2TSnrFzLJc04nnlxKN1ZtfEYRG2cpVruEME/KQPZlgIdZTmj/6CAo/clWZiCIyao4a
         f4DIHsZc/SN56q8jXpOBbABZ6B6W5zip2vb/rbNE46hDP15oZLFbltzPAdAnvz3c9r0f
         DInsuY15h/PmW9Y2v1FGBIrgKNrjY5W/ho9Afw2GM9LT2qgpiGkBH/J/Xyn2LLi9sRcF
         SnVddMihZRUUa8XVe4BP5iNgt+3S8zO3hyScIyE5LR8FAXQ830BvPC+NYS6T/+AYEhhw
         dJtg==
X-Received: by 10.194.83.105 with SMTP id p9mr15575712wjy.56.1362958993995;
        Sun, 10 Mar 2013 16:43:13 -0700 (PDT)
Received: from coyote.home (host-2-102-87-75.as13285.net. [2.102.87.75])
        by mx.google.com with ESMTPS id r7sm13757148wiz.2.2013.03.10.16.43.08
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 10 Mar 2013 16:43:13 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.rc1
In-Reply-To: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
X-Gm-Message-State: ALoCoQnJLksh9XOVtS5B7BBnQjJPWqx1v2xoz/YZ0DIJOyzSYenB5vS04qNnE9sn3uzwPfsRSte2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217822>

From: Peter Jaros <pjaros@pivotallabs.com>

Converts a git-submodule into a git-subtree.

Signed-off-by: Paul Campbell <pcampbell@kemitix.net>

Conflicts:
	.gitignore
	contrib/subtree/git-subtree.sh
	test.sh
---
 contrib/subtree/git-subtree.sh | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 8a23f58..caf4988 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -14,6 +14,7 @@ git subtree merge --prefix=<prefix> <commit>
 git subtree pull  --prefix=<prefix> <repository> <refspec...>
 git subtree push  --prefix=<prefix> <repository> <refspec...>
 git subtree split --prefix=<prefix> <commit...>
+git subtree from-submodule --prefix=<prefix>
 --
 h,help        show the help
 q             quiet
@@ -101,7 +102,7 @@ done
 command="$1"
 shift
 case "$command" in
-	add|merge|pull) default= ;;
+	add|merge|pull|from-submodule) default= ;;
 	split|push) default="--default HEAD" ;;
 	*) die "Unknown command '$command'" ;;
 esac
@@ -721,4 +722,31 @@ cmd_push()
 	fi
 }
 
+cmd_from-submodule()
+{
+	ensure_clean
+
+	local submodule_sha=$(git submodule status $prefix | cut -d ' ' -f 2)
+
+	# Remove references to submodule.
+	git config --remove-section submodule.$prefix
+	git config --file .gitmodules --remove-section submodule.$prefix
+	git add .gitmodules
+
+	# Move submodule aside.
+	local tmp_repo="$(mktemp -d /tmp/git-subtree.XXXXX)"
+	rm -r $tmp_repo
+	mv $prefix $tmp_repo
+	git rm $prefix
+
+	# Commit changes.
+	git commit -m "Remove '$prefix/' submodule"
+
+	# subtree add from submodule repo.
+	cmd_add_repository $tmp_repo HEAD
+
+	# Remove submodule repo.
+	rm -rf $tmp_repo
+}
+
 "cmd_$command" "$@"
-- 
1.8.2.rc1

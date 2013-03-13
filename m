From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH 2/4] contrib/subtree: Teach push to use --force option
Date: Wed, 13 Mar 2013 22:32:41 +0000
Message-ID: <1363213963-4065-3-git-send-email-pcampbell@kemitix.net>
References: <1363213963-4065-1-git-send-email-pcampbell@kemitix.net>
Cc: David Greene <greened@obbligato.org>, James Roper <jroper@vz.net>,
	Paul Campbell <pcampbell@kemitix.net>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 13 23:34:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFuFN-0005XP-TU
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 23:34:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934337Ab3CMWdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 18:33:37 -0400
Received: from mail-we0-f175.google.com ([74.125.82.175]:37308 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934325Ab3CMWdg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 18:33:36 -0400
Received: by mail-we0-f175.google.com with SMTP id x8so1564595wey.34
        for <git@vger.kernel.org>; Wed, 13 Mar 2013 15:33:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=42+2gW4RZimRYMlRj8LGX0wGLa9MxToGFPm8xHgjb8g=;
        b=d9GNB51gwmDsNRphSND8+gSP++1MJLL4Dm0GMqW5CKPBCIlNUG+0J5aIDrOHiTSKTZ
         lRE/YhYYgxz56nCEabGKEhgw8RexqwKMuZnuZ1Azc6w+TiB2w7eWCVvhGnWh8CQtNptY
         1Z4o3H0vO3B1udV8dFZ2TyuWxcjHh1IXd36cC3ijSZ1pVeRDTsU6PLNl+Z0fQJtmbPl3
         FDS8Pgq2YTygNyEgQrAQNnSS2Ar+nsn8WasUiOeq+5x8pwoiowkObcHyYJI60bLW/vA8
         GGoUvt3iHCbH0KiaNVfvW8xcFW9gYl9nJXRnLs12u1c9hgUbr8NqTq42QtgLB0d9Gsy7
         pqfw==
X-Received: by 10.180.75.177 with SMTP id d17mr143982wiw.16.1363214015259;
        Wed, 13 Mar 2013 15:33:35 -0700 (PDT)
Received: from coyote.home (host-2-102-86-203.as13285.net. [2.102.86.203])
        by mx.google.com with ESMTPS id c15sm330641wiw.3.2013.03.13.15.33.33
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 13 Mar 2013 15:33:34 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1363213963-4065-1-git-send-email-pcampbell@kemitix.net>
X-Gm-Message-State: ALoCoQnSlhMA5zy6dd8Dk8v7evWO0cBFWvkWA9/v4zsQNyeEZHA0olRro8tsE2H0pRnTYglMM7zD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218100>

From: James Roper <jroper@vz.net>

Allow the --force option to be passed to the child push command.

Signed-off-by: Paul Campbell <pcampbell@kemitix.net>
---
 contrib/subtree/git-subtree.sh  | 9 ++++++++-
 contrib/subtree/git-subtree.txt | 5 +++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index c68cc6f..2d9b071 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -26,6 +26,8 @@ b,branch=     create a new branch from the split subtree
 ignore-joins  ignore prior --rejoin commits
 onto=         try connecting new tree to an existing one
 rejoin        merge the new branch back into HEAD
+ options for 'push'
+f,force       use force push
  options for 'add', 'merge', 'pull' and 'push'
 squash        merge subtree changes as a single commit
 "
@@ -84,6 +86,7 @@ while [ $# -gt 0 ]; do
 		-b) branch="$1"; shift ;;
 		-P) prefix="$1"; shift ;;
 		-m) message="$1"; shift ;;
+		-f|--force) force=1 ;;
 		--no-prefix) prefix= ;;
 		--onto) onto="$1"; shift ;;
 		--no-onto) onto= ;;
@@ -712,12 +715,16 @@ cmd_push()
 	    die "You must provide <repository> <refspec>"
 	fi
 	if [ -e "$dir" ]; then
+	    push_opts=
+	    if [ "$force" == "1" ]; then
+		push_opts="$push_opts --force"
+	    fi
 	    repository=$1
 	    refspec=$2
 	    echo "git push using: " $repository $refspec
 	    rev=$(git subtree split --prefix=$prefix)
 	    if [ -n "$rev" ]; then
-		git push $repository $rev:refs/heads/$refspec
+		git push $push_opts $repository $rev:refs/heads/$refspec
 	    else
 		die "Couldn't push, 'git subtree split' failed."
 	    fi
diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index 7ba853e..97dd3c9 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -255,6 +255,11 @@ OPTIONS FOR split
 	'--rejoin' when you split, because you don't want the
 	subproject's history to be part of your project anyway.
 
+OPTIONS FOR push
+----------------
+-f::
+--force::
+    Uses 'git push --force'.
 
 EXAMPLE 1. Add command
 ----------------------
-- 
1.8.2

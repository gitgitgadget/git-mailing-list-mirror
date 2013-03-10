From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH v2 07/23] contrib/subtree: Teach push and pull to use .gittrees if needed
Date: Sun, 10 Mar 2013 23:41:15 +0000
Message-ID: <1362958891-26941-8-git-send-email-pcampbell@kemitix.net>
References: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
Cc: David Greene <greened@obbligato.org>,
	Matt Hoffman <matt.hoffman@quantumretail.com>,
	Paul Campbell <pcampbell@kemitix.net>,
	"Avery Pennarun" <apenwarr@gmail.com>, "bibendi" <bibendi@bk.ru>,
	"Wayne Walter" <wayne@tickzoom.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 11 00:44:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEpv3-0004DI-W9
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 00:44:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421Ab3CJXoP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 19:44:15 -0400
Received: from mail-wg0-f53.google.com ([74.125.82.53]:53053 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801Ab3CJXoM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 19:44:12 -0400
Received: by mail-wg0-f53.google.com with SMTP id fn15so4451860wgb.20
        for <git@vger.kernel.org>; Sun, 10 Mar 2013 16:44:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=D+N9nYt3whlJgvmkQte4u8yqm+ioTYkHsCJrGwspQyI=;
        b=e84nnJPkQ3Jgdz1Wwp+vaVwsoX+oHmH2zdy0xiQIH55VdZpzTIYVqiuSBr4aWwCr6F
         anEuYetX0vjUGEkuW7dh3NT2YXRXpH4T/T6ICmT4FoLPc8b7gU050IXC/YGl0tbkjgCb
         igbllcwDoOMmdKmqgzd474oyMBocypirbp9Fj0PVckJqzwTui6q82cfMp+uasl4haZTK
         9jVatPQYzawRE9LIkOzdUlq/s7FLU1jdcVRC9ADceVazCOncSRK1quTmCT4yvAEUBecT
         SJvVihsvnuzbh2swNbGLNUoqD6ehufG5IAs5jphkUZFj7XNuauIvKU/8I+yKLRXjU84i
         MwgA==
X-Received: by 10.180.8.4 with SMTP id n4mr9094662wia.13.1362959051484;
        Sun, 10 Mar 2013 16:44:11 -0700 (PDT)
Received: from coyote.home (host-2-102-87-75.as13285.net. [2.102.87.75])
        by mx.google.com with ESMTPS id r7sm13757148wiz.2.2013.03.10.16.44.06
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 10 Mar 2013 16:44:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.rc1
In-Reply-To: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
X-Gm-Message-State: ALoCoQlRsHyQcby/WtV6fmjL09ZGGrHDcoeyQOE9XR3OXSynUm0qQMSRkoLbVXr0wjjYT+/QhN7e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217827>

From: Matt Hoffman <matt.hoffman@quantumretail.com>

Only when a repository and/or branch are not supplied on the command
line will push and pull look for them in the .gittrees file.

Signed-off-by: Paul Campbell <pcampbell@kemitix.net>
---
 contrib/subtree/git-subtree.sh | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 39d764b..98c508b 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -712,13 +712,21 @@ cmd_merge()
 
 cmd_pull()
 {
-    if [ $# -ne 1 ]; then
-	    die "You must provide <branch>"
+  if [ $# -gt 2 ]; then
+	    die "You should provide either <refspec> or <repository> <refspec>"
 	fi
 	if [ -e "$dir" ]; then
 	    ensure_clean
-	    repository=$(git config -f .gittrees subtree.$prefix.url)
-	    refspec=$1
+      if [ $# -eq 1 ]; then 
+	      repository=$(git config -f .gittrees subtree.$prefix.url)
+	      refspec=$1
+      elif [ $# -eq 2 ]; then 
+        repository=$1
+        refspec=$2
+      else 
+	      repository=$(git config -f .gittrees subtree.$prefix.url)
+        refspec=$(git config -f .gittrees subtree.$prefix.branch)
+      fi
 	    git fetch $repository $refspec || exit $?
 	    echo "git fetch using: " $repository $refspec
 	    revs=FETCH_HEAD
@@ -731,12 +739,20 @@ cmd_pull()
 
 cmd_push()
 {
-	if [ $# -ne 1 ]; then
-	    die "You must provide <branch>"
+	if [ $# -gt 2 ]; then
+	    die "You shold provide either <refspec> or <repository> <refspec>"
 	fi
 	if [ -e "$dir" ]; then
-	    repository=$(git config -f .gittrees subtree.$prefix.url)
-	    refspec=$1
+      if [ $# -eq 1 ]; then 
+	      repository=$(git config -f .gittrees subtree.$prefix.url)
+        refspec=$1
+      elif [ $# -eq 2 ]; then 
+        repository=$1
+        refspec=$2
+      else
+	      repository=$(git config -f .gittrees subtree.$prefix.url)
+        refspec=$(git config -f .gittrees subtree.$prefix.branch)
+      fi
 	    echo "git push using: " $repository $refspec
 	    git push $repository $(git subtree split --prefix=$prefix):refs/heads/$refspec
 	else
-- 
1.8.2.rc1

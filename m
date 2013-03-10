From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH v2 04/23] contrib/subtree: Teach push and pull to use .gittrees for defaults
Date: Sun, 10 Mar 2013 23:41:12 +0000
Message-ID: <1362958891-26941-5-git-send-email-pcampbell@kemitix.net>
References: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
Cc: David Greene <greened@obbligato.org>, bibendi <bibendi@bk.ru>,
	Paul Campbell <pcampbell@kemitix.net>,
	"Avery Pennarun" <apenwarr@gmail.com>,
	"Wayne Walter" <wayne@tickzoom.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 11 00:44:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEpuZ-0003nJ-Fe
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 00:44:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753351Ab3CJXns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 19:43:48 -0400
Received: from mail-we0-f175.google.com ([74.125.82.175]:45584 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801Ab3CJXnr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 19:43:47 -0400
Received: by mail-we0-f175.google.com with SMTP id x8so2952427wey.20
        for <git@vger.kernel.org>; Sun, 10 Mar 2013 16:43:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=tQjSFictGa/91BURULQXS4FqvAHqtRcriyIIBkm8n/8=;
        b=Llj4a4VXLlj/ode9mZ70ZzQcTvoJpuwI3YRyMLa6WlD0cAnxgNp/OX3n0OL19/b2lK
         nVQzNRLNhpc9Snw1dT9SmooRTaLcou+INNQG78WK0s4Ehxw4FokFuGba1uPpcGeGI0ei
         gXlwejozX8hoBxae20Bs6CL8IJUTDeJQqZ0NS9ijaw6fJoadCyQpnMXr+eeUGhEnbErI
         +JlcAuDkKpuoKFPWDDdNuDn8gcpbXVwM0qojppM8T3b1dmUOCZ7rZj2+EsPVMPkJYfLL
         CzP8b/h214xZGt4Lgxwyx4ivL5Gh2dJioVvjzWAieMm826B7KcCsBV3YdYBoWeqLEgCt
         xZZw==
X-Received: by 10.194.63.109 with SMTP id f13mr15755621wjs.11.1362959026845;
        Sun, 10 Mar 2013 16:43:46 -0700 (PDT)
Received: from coyote.home (host-2-102-87-75.as13285.net. [2.102.87.75])
        by mx.google.com with ESMTPS id r7sm13757148wiz.2.2013.03.10.16.43.42
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 10 Mar 2013 16:43:45 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.rc1
In-Reply-To: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
X-Gm-Message-State: ALoCoQl4+hZXwE1BzEwI0GVqqyZdB3HL2bYbsP5qyCytchCK+XD11eCh+LI6fC7JvCtPIQVrm19f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217824>

From: bibendi <bibendi@bk.ru>

Look in the config file .gittrees for a default repository and
refspec or commit when they are not provided on the command line.

Uses the .gittrees config file in a similar way to how git-submodule
uses the .gitmodules file.

Signed-off-by: Paul Campbell <pcampbell@kemitix.net>
---
 contrib/subtree/git-subtree.sh | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 7b70251..1aff956 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -708,21 +708,31 @@ cmd_merge()
 
 cmd_pull()
 {
-	ensure_clean
-	git fetch "$@" || exit $?
-	revs=FETCH_HEAD
-	set -- $revs
-	cmd_merge "$@"
+    if [ $# -ne 1 ]; then
+	    die "You must provide <branch>"
+	fi
+	if [ -e "$dir" ]; then
+	    ensure_clean
+	    repository=$(git config -f .gittrees subtree.$prefix.url)
+	    refspec=$1
+	    git fetch $repository $refspec || exit $?
+	    echo "git fetch using: " $repository $refspec
+	    revs=FETCH_HEAD
+	    set -- $revs
+	    cmd_merge "$@"
+	else
+	    die "'$dir' must already exist. Try 'git subtree add'."
+	fi
 }
 
 cmd_push()
 {
-	if [ $# -ne 2 ]; then
-	    die "You must provide <repository> <refspec>"
+	if [ $# -ne 1 ]; then
+	    die "You must provide <branch>"
 	fi
 	if [ -e "$dir" ]; then
-	    repository=$1
-	    refspec=$2
+	    repository=$(git config -f .gittrees subtree.$prefix.url)
+	    refspec=$1
 	    echo "git push using: " $repository $refspec
 	    git push $repository $(git subtree split --prefix=$prefix):refs/heads/$refspec
 	else
-- 
1.8.2.rc1

From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH 1/3] cg-commit: Move author picking to cg-Xlib
Date: Tue, 7 Feb 2006 23:44:19 +0100
Message-ID: <20060207224419.GA24790@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 23:45:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6baA-0003Cw-HS
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 23:45:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030225AbWBGWox (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Feb 2006 17:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030226AbWBGWoa
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Feb 2006 17:44:30 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:22219 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1030222AbWBGWoW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Feb 2006 17:44:22 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 8CA2452D5A3;
	Tue,  7 Feb 2006 23:44:21 +0100 (CET)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 20023-01; Tue,  7 Feb 2006 23:44:19 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id D5E9B52D5A2;
	Tue,  7 Feb 2006 23:44:19 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id D5F716DFBC6; Tue,  7 Feb 2006 23:43:34 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id BE47C61AD6; Tue,  7 Feb 2006 23:44:19 +0100 (CET)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15719>

Adds pick_author utility function to cg-Xlib that uses the author line from
git-cat-file output to print a string that sets the GIT_AUTHOR_* env
variables. This string should then be eval'd by the caller.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
commit 5095aca7013d87ccdb08dad20a9fb93d7465d33d
tree 9ec064a96718b937d373769c52d830b8c3a6daca
parent d3cabc9974357947eac035d613557d4318b85f9f
author Jonas Fonseca <fonseca@diku.dk> Tue, 07 Feb 2006 23:05:19 +0100
committer Jonas Fonseca <fonseca@antimatter.localdomain> Tue, 07 Feb 2006 23:05:19 +0100

 cg-Xlib   |   26 ++++++++++++++++++++++++++
 cg-commit |   28 +---------------------------
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/cg-Xlib b/cg-Xlib
index 308d798..e17c82f 100644
--- a/cg-Xlib
+++ b/cg-Xlib
@@ -236,6 +236,32 @@ list_untracked_files()
 	git-ls-files -z --others $listdirs "${EXCLUDE[@]}"
 }
 
+pick_author()
+{
+	local pick_author_script='
+		/^author /{
+			s/'\''/'\''\\'\'\''/g
+			h
+			s/^author \([^<]*\) <[^>]*> .*$/\1/
+			s/'\''/'\''\'\'\''/g
+			s/.*/export GIT_AUTHOR_NAME='\''&'\''/p
+
+			g
+			s/^author [^<]* <\([^>]*\)> .*$/\1/
+			s/'\''/'\''\'\'\''/g
+			s/.*/export GIT_AUTHOR_EMAIL='\''&'\''/p
+
+			g
+			s/^author [^<]* <[^>]*> \(.*\)$/\1/
+			s/'\''/'\''\'\'\''/g
+			s/.*/export GIT_AUTHOR_DATE='\''&'\''/p
+
+			q
+		}
+	'
+	LANG=C LC_ALL=C sed -ne "$pick_author_script"
+}
+
 # Usage: showdate SECONDS TIMEZONE [FORMAT]
 # Display date nicely based on how GIT stores it.
 # Save the date to $_showdate
diff --git a/cg-commit b/cg-commit
index e5e98b4..06ab0c0 100755
--- a/cg-commit
+++ b/cg-commit
@@ -276,33 +276,7 @@ for msg in "${msgs[@]}"; do
 done
 
 if [ "$copy_commit" ]; then
-	pick_author_script='
-		/^author /{
-			s/'\''/'\''\\'\'\''/g
-			h
-			s/^author \([^<]*\) <[^>]*> .*$/\1/
-			s/'\''/'\''\'\'\''/g
-			s/.*/GIT_AUTHOR_NAME='\''&'\''/p
-
-			g
-			s/^author [^<]* <\([^>]*\)> .*$/\1/
-			s/'\''/'\''\'\'\''/g
-			s/.*/GIT_AUTHOR_EMAIL='\''&'\''/p
-
-			g
-			s/^author [^<]* <[^>]*> \(.*\)$/\1/
-			s/'\''/'\''\'\'\''/g
-			s/.*/GIT_AUTHOR_DATE='\''&'\''/p
-
-			q
-		}
-	'
-	set_author_env="$(git-cat-file commit "$copy_commit" |
-	                  LANG=C LC_ALL=C sed -ne "$pick_author_script")"
-	eval "$set_author_env"
-	export GIT_AUTHOR_NAME
-	export GIT_AUTHOR_EMAIL
-	export GIT_AUTHOR_DATE
+	eval "$(git-cat-file commit "$copy_commit" | pick_author)"
 	git-cat-file commit "$copy_commit" | sed -e '1,/^$/d'
         written=1
 fi >>"$LOGMSG"

-- 
Jonas Fonseca

From: sean <seanlkml@sympatico.ca>
Subject: git-commit: allow From: line to be entered in commit message
Date: Thu, 12 Jan 2006 09:37:00 -0500
Message-ID: <BAYC1-PASMTP117A18814EAAFACFE0F31DAE270@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jan 12 15:41:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ex3dj-0007HY-Ra
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 15:41:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030421AbWALOlV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 09:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030418AbWALOlV
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 09:41:21 -0500
Received: from bayc1-pasmtp11.bayc1.hotmail.com ([65.54.191.171]:46122 "EHLO
	BAYC1-PASMTP11.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1030421AbWALOlU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2006 09:41:20 -0500
X-Originating-IP: [69.156.6.171]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.6.171]) by BAYC1-PASMTP11.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 12 Jan 2006 06:42:50 -0800
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id D8526644C23
	for <git@vger.kernel.org>; Thu, 12 Jan 2006 09:41:18 -0500 (EST)
To: git <git@vger.kernel.org>
Message-Id: <20060112093700.1d3d25db.seanlkml@sympatico.ca>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 12 Jan 2006 14:42:50.0265 (UTC) FILETIME=[76318090:01C61786]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Mostly just for comment to see if there is any support
for this feature....

Sean

---
Use the author name and email information given as the 
first line of the commit message in the form of:

From: name <email>

as the author's name and email address in the resulting
commit object.  This makes committing foreign patches
a little less cumbersome to handle for some workflows.


diff --git a/git-commit.sh b/git-commit.sh
index 193feeb..6004cd4 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -219,7 +219,7 @@ t)
 	fi
 esac
 
-grep -v '^#' < "$GIT_DIR"/COMMIT_EDITMSG |
+grep -v '^#' < "$GIT_DIR"/COMMIT_EDITMSG | sed -e '1s/^[ \t]*from:.*//I' |
 git-stripspace > "$GIT_DIR"/COMMIT_MSG
 
 if cnt=`grep -v -i '^Signed-off-by' "$GIT_DIR"/COMMIT_MSG |
@@ -227,6 +227,13 @@ if cnt=`grep -v -i '^Signed-off-by' "$GI
 	wc -l` &&
    test 0 -lt $cnt
 then
+	FROM=$(grep -v '^#' < "$GIT_DIR"/COMMIT_EDITMSG | sed -ne '1s/from:[ \t]*\(.*\)/\1/Ip;q')
+	NAME=$(echo "$FROM" | sed -e 's/<.*//;s/[ \t]*$//')
+	EMAIL=$(echo "$FROM" | sed -e 's/.*<\(.*\)>.*/\1/')
+	if test -n "$FROM"; then
+		export GIT_AUTHOR_NAME="$NAME"
+		export GIT_AUTHOR_EMAIL="$EMAIL"
+	fi
 	tree=$(git-write-tree) &&
 	commit=$(cat "$GIT_DIR"/COMMIT_MSG | git-commit-tree $tree $PARENTS) &&
 	git-update-ref HEAD $commit $current &&

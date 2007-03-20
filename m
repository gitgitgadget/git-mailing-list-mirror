From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH 4/4] update-hook: allow for the possibility that a tagged object is not a commit
Date: Tue, 20 Mar 2007 10:58:47 +0000
Message-ID: <200703201058.47485.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 20 11:59:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTc3c-0002Za-JF
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 11:59:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753679AbXCTK6w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 06:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753678AbXCTK6w
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 06:58:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:59638 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753676AbXCTK6v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 06:58:51 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1597056uga
        for <git@vger.kernel.org>; Tue, 20 Mar 2007 03:58:50 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=utH8122/ubw2nrjbUDRINnIO4QJDJxmF9Wy92aXvrJd7V3A844bO2cR7VfSEFthaomup3+CQOx9lRuUUwq567P8jio3u9WOCPANkPq/aCKAlDLTUOqCViL/1LBDpJOX64lDuDH3eevpNHXmzeapm2l7k6ThD4WkYxjDZPQMF180=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=DDojx4lhNegCIJbq9qFAXuPcFFurk+7coi9KznYbAbuYcww4082AVO2pbidsyN7E0FZWyI+Bv2OqFQmH1C4jAyBuAmX82d3IFwY75tpfd3fTR2us/Myrfp8/xiawR68UXQt7zGzuQ1UqqCQLTqRdM8VmYuO5mzjkGS1QybGQYZs=
Received: by 10.65.237.15 with SMTP id o15mr10080468qbr.1174388329923;
        Tue, 20 Mar 2007 03:58:49 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id r33sm1565224nfc.2007.03.20.03.58.48;
        Tue, 20 Mar 2007 03:58:49 -0700 (PDT)
X-TUID: 3fb7975b8b28f454
X-UID: 295
X-Length: 2610
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42736>

Tags are normally used to tag commits; however this isn't a requirement
so the update hook shouldn't assume it.

This patch only calculates the replacement tag if it is a commit tag -
non-commit tags don't represent a line of development so it would be
meaningless.  Similarly, the short log is not shown for non-commit tags.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 templates/hooks--update |   30 ++++++++++++++++++++----------
 1 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/templates/hooks--update b/templates/hooks--update
index fd4c081..cf2a31a 100644
--- a/templates/hooks--update
+++ b/templates/hooks--update
@@ -234,16 +234,20 @@ case "$refname_type" in
 			esac
 		done <<< "$(git cat-file tag $newrev | head -q -n 4)"
 
-		# If this tag succeeds another, then show which tag it replaces
-		prevtag=$(git describe --abbrev=0 $newrev^ 2>/dev/null)
-		if [ -n "$prevtag" ]; then
-			echo "  replaces  $prevtag"
-		fi
-
 		# Extract user and time from tagger variable
 		eval $(sed -n 's/\([^>]*>\)[^0-9]*\([0-9]*\).*/tagger="\1" ts="\2"/p' <<< "$tagger")
 		tagged=$(date --date="1970-01-01 00:00:00 +0000 $ts seconds" +"$DATEFORMAT")
 
+		echo "   tagging  $tagobject ($tagtype)"
+		if [ "$tagtype" = "commit" ]; then
+			# If the tagged object is a commit, then we assume this is a
+			# release, and so we calculate which tag this tag is replacing
+			prevtag=$(git describe --abbrev=0 $newrev^ 2>/dev/null)
+
+			if [ -n "$prevtag" ]; then
+				echo "  replaces  $prevtag"
+			fi
+		fi
 		echo " tagged by  $tagger"
 		echo "        on  $tagged"
 
@@ -257,10 +261,16 @@ case "$refname_type" in
 		git cat-file tag $newrev | tail -q -n +5
 
 		echo ""
-		if [ -n "$prevtag" ]; then
-			git rev-list --pretty=short "$prevtag..$newrev" | git shortlog
-		else
-			git rev-list --pretty=short $newrev | git shortlog
+		if [ "$tagtype" = "commit" ]; then
+			# Only commit tags make sense to have rev-list operations performed
+			# on them
+			if [ -n "$prevtag" ]; then
+				# Show changes since the previous release
+				git rev-list --pretty=short "$prevtag..$newrev" | git shortlog
+			else
+				# No previous tag, show all the changes since time began
+				git rev-list --pretty=short $newrev | git shortlog
+			fi
 		fi
 
 		echo $LOGEND
-- 
1.5.0.3.402.g0c48

From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH 3/4] update-hook: parse the tag header in preparation to use the tag type
Date: Tue, 20 Mar 2007 10:58:42 +0000
Message-ID: <200703201058.42753.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 20 11:59:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTc3c-0002Za-2a
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 11:59:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753675AbXCTK6r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 06:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753677AbXCTK6r
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 06:58:47 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:59638 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753676AbXCTK6q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 06:58:46 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1597056uga
        for <git@vger.kernel.org>; Tue, 20 Mar 2007 03:58:45 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=ZNIwXw/QdrnaXlwVJ0/ROQmKo41J+ex7vdgwKOS5Yo9PnEUNlFt7rXIKC6dxkZ3zB0oEMlfJ4Kdhv8DOKWBbgOcA9s3MkrZBZXEvItkIzjCTSfCuk0KG9wHgUFglcvb1CdnK8Kz4omEBY5WQvBlx16TePtVHElQqqlG9SwY/mNY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=F8Ef8FQ7PEzmdhgF0qTRxJjwN/AFqTKtodAkG+Frwio/iOXOuG5hTOep6phDvy9R02IWAow7nYm1b8F1IspEuy8F2c+mIogf1MvxShzPewZnDeHpIK+kptaLQEpy/Yi1L3ZDvfD1OHkXiXwxHD91wFFpEOfHFnBQj6EPaw2MZ74=
Received: by 10.65.152.17 with SMTP id e17mr1188130qbo.1174388324910;
        Tue, 20 Mar 2007 03:58:44 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id l22sm1558274nfc.2007.03.20.03.58.43;
        Tue, 20 Mar 2007 03:58:44 -0700 (PDT)
X-TUID: 6b53396cd629f156
X-UID: 294
X-Length: 2449
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42735>

The tag header is parsed with a while loop and read command.  I'm not
entirely sure how portable it is, as it had to use the following unusual
heredoc format:

  while read field value
  do
    # ..
  done <<< "$(some command)"

This was necessary because piping the output to a while doesn't work
because the pipe is run in a separate process and hence setting
variables inside it has no effect in the main script process.  This
"<<<" heredoc notation works around that problem, but I have no idea how
widely supported it is.  The alternative (should it be necessary) is
to wastefully make multiple "git-cat-file | sed" calls - yuck.

This patch also updates the user/time extraction from the "tagger" field
to use the variable $tagger, rather than the "git-cat-file | sed" call
used previously.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 templates/hooks--update |   24 +++++++++++++++++++++---
 1 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/templates/hooks--update b/templates/hooks--update
index 31e72ca..fd4c081 100644
--- a/templates/hooks--update
+++ b/templates/hooks--update
@@ -215,15 +215,33 @@ case "$refname_type" in
 			echo "      from  $oldrev"
 		fi
 
+		# Read the tag header
+		while read field value
+		do
+			case "$field" in
+			object)
+				tagobject="$value"
+				;;
+			type)
+				tagtype="$value"
+				;;
+			tag)
+				# Confirm that this tag has the right name?  Nah
+				;;
+			tagger)
+				tagger="$value"
+				;;
+			esac
+		done <<< "$(git cat-file tag $newrev | head -q -n 4)"
+
 		# If this tag succeeds another, then show which tag it replaces
 		prevtag=$(git describe --abbrev=0 $newrev^ 2>/dev/null)
 		if [ -n "$prevtag" ]; then
 			echo "  replaces  $prevtag"
 		fi
 
-		# Read the tag details
-		eval $(git cat-file tag $newrev | \
-			sed -n '4s/tagger \([^>]*>\)[^0-9]*\([0-9]*\).*/tagger="\1" ts="\2"/p')
+		# Extract user and time from tagger variable
+		eval $(sed -n 's/\([^>]*>\)[^0-9]*\([0-9]*\).*/tagger="\1" ts="\2"/p' <<< "$tagger")
 		tagged=$(date --date="1970-01-01 00:00:00 +0000 $ts seconds" +"$DATEFORMAT")
 
 		echo " tagged by  $tagger"
-- 
1.5.0.3.402.g0c48

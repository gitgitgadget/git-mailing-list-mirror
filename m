From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/3] hooks/post-receive-email: use plumbing instead of git
 log/show
Date: Fri, 2 Aug 2013 16:22:08 -0700
Message-ID: <20130802232208.GC2963@elie.Belkin>
References: <20130802232118.GB2963@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexey Shumkin <alex.crezoff@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Alexander Gerasiov <gq@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 03 01:22:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5Ofo-00077K-Sh
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 01:22:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753109Ab3HBXWN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Aug 2013 19:22:13 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:60584 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712Ab3HBXWM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Aug 2013 19:22:12 -0400
Received: by mail-pb0-f43.google.com with SMTP id md4so1207450pbc.2
        for <git@vger.kernel.org>; Fri, 02 Aug 2013 16:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=i/Ctq2oihla8Ovd5wdiIw4nKMn1fIPWv63Es6r/aEyY=;
        b=zw8S4B5g8M/KeHY2coaFJ/qLHrhgjxVRKtw9QzNx/QatgshuJdsVbQ9mucVDH4tiOP
         LjHBgCs3YjxHiBjiNhyIqHKPFRC1o0ePM3VpoNOgKtFXCYZsQDxekRvbJHU0hlOqrtmy
         YVr67QR83J7WxPvPtPAmdbl3AnXwjJwnH5C4ixwce/fNrnUIrajfcya5JzFsmcIgxTSA
         LBl3TWuLSXOChB4BiE6M+U8huXVF8wPCHBUGOgkfXlHwYfm7DSfKnCuDLlEt6bDPK0tm
         EC7YYXD9RfshS/riZ89IU6wHtcdiLfyM3wBvKiL5J5Izf+3oNKJc2i10Z2nMnSk7SrfH
         UW4Q==
X-Received: by 10.66.118.163 with SMTP id kn3mr12963140pab.165.1375485732354;
        Fri, 02 Aug 2013 16:22:12 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id pq1sm9942819pbb.26.2013.08.02.16.22.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 02 Aug 2013 16:22:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130802232118.GB2963@elie.Belkin>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231545>

This way the hook doesn't have to keep being tweaked as porcelain
learns new features like color and pagination.

While at it, replace the "git rev-list | git shortlog" idiom with
plain "git shortlog" for simplicity.

Except for depending less on the value of settings like '[log]
abbrevCommit', no change in output intended.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/hooks/post-receive-email | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 15311502..72084511 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -471,7 +471,7 @@ generate_delete_branch_email()
 	echo "       was  $oldrev"
 	echo ""
 	echo $LOGBEGIN
-	git show -s --pretty=oneline $oldrev
+	git diff-tree -s --always --pretty=oneline $oldrev
 	echo $LOGEND
 }
 
@@ -547,11 +547,11 @@ generate_atag_email()
 		# performed on them
 		if [ -n "$prevtag" ]; then
 			# Show changes since the previous release
-			git rev-list --pretty=short "$prevtag..$newrev" | git shortlog
+			git shortlog "$prevtag..$newrev"
 		else
 			# No previous tag, show all the changes since time
 			# began
-			git rev-list --pretty=short $newrev | git shortlog
+			git shortlog $newrev
 		fi
 		;;
 	*)
@@ -571,7 +571,7 @@ generate_delete_atag_email()
 	echo "       was  $oldrev"
 	echo ""
 	echo $LOGBEGIN
-	git show -s --pretty=oneline $oldrev
+	git diff-tree -s --always --pretty=oneline $oldrev
 	echo $LOGEND
 }
 
@@ -617,7 +617,7 @@ generate_general_email()
 	echo ""
 	if [ "$newrev_type" = "commit" ]; then
 		echo $LOGBEGIN
-		git show --no-color --root -s --pretty=medium $newrev
+		git diff-tree -s --always --pretty=medium $newrev
 		echo $LOGEND
 	else
 		# What can we do here?  The tag marks an object that is not
@@ -636,7 +636,7 @@ generate_delete_general_email()
 	echo "       was  $oldrev"
 	echo ""
 	echo $LOGBEGIN
-	git show -s --pretty=oneline $oldrev
+	git diff-tree -s --always --pretty=oneline $oldrev
 	echo $LOGEND
 }
 
-- 
1.8.4.rc1

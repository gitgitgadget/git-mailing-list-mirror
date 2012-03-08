From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] post-receive-email: defend against non UTF-8
 i18n.logoutputencoding setting
Date: Thu, 8 Mar 2012 05:59:57 -0600
Message-ID: <20120308115957.GB2750@burratino>
References: <20120308115119.GA2604@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gerrit Pape <pape@smarden.org>, Alexey Shumkin <zapped@mail.ru>,
	Johannes Sixt <j6t@kdbg.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jon Jensen <jon@endpoint.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 08 13:00:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5c0v-0000C9-3L
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 13:00:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755945Ab2CHMAD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 07:00:03 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:32876 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752663Ab2CHMAC (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 07:00:02 -0500
Received: by obbuo6 with SMTP id uo6so562766obb.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 04:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=7/HgfZ78KjkGRyM1TZOUdlLPlw8nS4n7EN4zXa1wT7k=;
        b=uzuimhBZ+jFBPLPN6xbBpcWTHREfujnmKvM645ahoIXX7FY9l+c/rbSPrw3/Gxn564
         UOI6NxZK2UF+qdV3RhJy9Mz4tDsd4J4mSWUHHw6wFWl7oiOb2Baolh+9nrY5MXksxGF3
         MnsDh4P6KKyU0NCVpxWSUnCA0xLx2Ut41vaaIuKBaB8512C9rKGizEvUuXRHSBLaKl1Q
         DIfh+wKkaSk0xn6AWEWqRCgBI9NLRLyd1YyB+upGCJEm/kGY9I5yTQFRq0flGPl7hs3v
         i/zbIYu5RN0kpdOhYee2skauTo2wYgZwnFzOgSNHCdU5djqOPWCi67/Y045MFciaySPm
         65+w==
Received: by 10.182.44.68 with SMTP id c4mr2323432obm.5.1331208001876;
        Thu, 08 Mar 2012 04:00:01 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id a6sm825342oea.13.2012.03.08.04.00.00
        (version=SSLv3 cipher=OTHER);
        Thu, 08 Mar 2012 04:00:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120308115119.GA2604@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192579>

Johannes Sixt wrote:
> Am 9/20/2011 12:42, schrieb Shumkin Alexey:

>> 1. post-send-mail uses description file of a repo
>> 2. gitweb also uses this file and AFAIK it assumes one to be in UTF-8
>>   (I do not know whether it can be changed there but I tested gitweb once long
>>     time ago)
>> 3. So if i18n.logoutputencoding is not UTF-8 we get a message composed
>> 	with mixed encodings. This fact oblidge us to encode headers
>> 	(as quoted printable at least) and synchronize body message that contain
>> 	repo description (in UTF-8) and diffstat (in i18n.logoutputencoding).
[...]
> In this case, it may make sense to have a separate setting, but you should
> call git like this:
>
>    git -c "i18n.logoutputencoding=$emailcharset" show ...
>    git -c "i18n.logoutputencoding=$emailcharset" rev-list --pretty ...

Something like this, I suppose?

This teaches post-receive-email to use plumbing where possible and to
explicitly declare what encoding it expects output to use.

Based on an advice from Alexey Shumkin and Johannes Sixt, but all bugs
are mine.  Making the email charset configurable is left as an
exercise for the interested reader.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/hooks/post-receive-email |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index dc184d0b..b59e03cd 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -464,7 +464,7 @@ generate_delete_branch_email()
 	echo "       was  $oldrev"
 	echo ""
 	echo $LOGBEGIN
-	git show -s --pretty=oneline $oldrev
+	git diff-tree --encoding=UTF-8 -s --pretty=oneline $oldrev
 	echo $LOGEND
 }
 
@@ -540,11 +540,11 @@ generate_atag_email()
 		# performed on them
 		if [ -n "$prevtag" ]; then
 			# Show changes since the previous release
-			git rev-list --pretty=short "$prevtag..$newrev" | git shortlog
+			git shortlog --encoding=UTF-8 "$prevtag..$newrev"
 		else
 			# No previous tag, show all the changes since time
 			# began
-			git rev-list --pretty=short $newrev | git shortlog
+			git shortlog --encoding=UTF-8 "$newrev"
 		fi
 		;;
 	*)
@@ -564,7 +564,7 @@ generate_delete_atag_email()
 	echo "       was  $oldrev"
 	echo ""
 	echo $LOGBEGIN
-	git show -s --pretty=oneline $oldrev
+	git diff-tree --encoding=UTF-8 -s --pretty=oneline $oldrev
 	echo $LOGEND
 }
 
@@ -610,7 +610,7 @@ generate_general_email()
 	echo ""
 	if [ "$newrev_type" = "commit" ]; then
 		echo $LOGBEGIN
-		git show --no-color --root -s --pretty=medium $newrev
+		git diff-tree --encoding=UTF-8 --root -s --pretty=oneline $newrev
 		echo $LOGEND
 	else
 		# What can we do here?  The tag marks an object that is not
@@ -629,7 +629,7 @@ generate_delete_general_email()
 	echo "       was  $oldrev"
 	echo ""
 	echo $LOGBEGIN
-	git show -s --pretty=oneline $oldrev
+	git diff-tree --encoding=UTF-8 -s --pretty=oneline $oldrev
 	echo $LOGEND
 }
 
-- 
1.7.9.2

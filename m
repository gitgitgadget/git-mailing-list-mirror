From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] post-receive-email: explicitly set Content-Type header
Date: Fri, 7 Oct 2011 04:06:02 -0500
Message-ID: <20111007090601.GA22541@elie.hsd1.il.comcast.net>
References: <1316505154-3904-1-git-send-email-zapped@mail.ru>
 <1316506023-5098-1-git-send-email-zapped@mail.ru>
 <4E785DC6.80105@viscovery.net>
 <20110920104256.GA11656@zapped.homeip.net>
 <4E7874B9.2060909@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: zapped@mail.ru, Fabian Emmes <emmes@informatik.rwth-aachen.de>,
	Alexander Gerasiov <gq@cs.msu.su>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Oct 07 11:06:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RC6Np-0007dh-Bg
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 11:06:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935385Ab1JGJGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 05:06:16 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:54832 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759591Ab1JGJGP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 05:06:15 -0400
Received: by yxl31 with SMTP id 31so3425596yxl.19
        for <git@vger.kernel.org>; Fri, 07 Oct 2011 02:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=4cRh8Zvwoq8JVx+fCRpzkx9fHns1SfTAlrax2tbkZ9s=;
        b=CQPjRLEsQt6dDpIaPNnTAKE4jsFp7MDQa4X3ppZYfHtXqpsznvO+gqeJC/77YYwAYX
         ZsNKQHY9EGTepTpXkCWtGjpufZ0UoG4cbNyEG4hY7SdG3Yfhqmcc+0zWxf9nNe9YE/WB
         kEYuQB1xVx7AL7b2r6RJEIXs0ELiKb6QNNY44=
Received: by 10.43.106.202 with SMTP id dv10mr5720225icc.48.1317978374633;
        Fri, 07 Oct 2011 02:06:14 -0700 (PDT)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id by18sm18469880ibb.1.2011.10.07.02.06.13
        (version=SSLv3 cipher=OTHER);
        Fri, 07 Oct 2011 02:06:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E7874B9.2060909@viscovery.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183070>

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
explicitly declare what encoding it expects output to use.  Completely
untested --- basic sanity checking, testing, and tweaks to allow
overriding the choice of encoding left as an exercise to the reader.

Based on patches by Gerrit Pape and Jeff King and advice from Johannes
Sixt.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
More background:
http://thread.gmane.org/gmane.comp.version-control.git/124350/focus=124355

 contrib/hooks/post-receive-email |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index ba077c13..bc603b02 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -234,6 +234,9 @@ generate_email_header()
 	cat <<-EOF
 	To: $recipients
 	Subject: ${emailprefix}$projectdesc $refname_type $short_refname ${change_type}d. $describe
+	MIME-Version: 1.0
+	Content-Type: text/plain; charset=utf-8
+	Content-Transfer-Encoding: 8bit
 	X-Git-Refname: $refname
 	X-Git-Reftype: $refname_type
 	X-Git-Oldrev: $oldrev
@@ -462,7 +465,7 @@ generate_delete_branch_email()
 	echo "       was  $oldrev"
 	echo ""
 	echo $LOGEND
-	git show -s --pretty=oneline $oldrev
+	git diff-tree --encoding=UTF-8 -s --pretty=oneline $oldrev
 	echo $LOGEND
 }
 
@@ -538,11 +541,11 @@ generate_atag_email()
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
@@ -562,7 +565,7 @@ generate_delete_atag_email()
 	echo "       was  $oldrev"
 	echo ""
 	echo $LOGEND
-	git show -s --pretty=oneline $oldrev
+	git diff-tree --encoding=UTF-8 -s --pretty=oneline $oldrev
 	echo $LOGEND
 }
 
@@ -608,7 +611,7 @@ generate_general_email()
 	echo ""
 	if [ "$newrev_type" = "commit" ]; then
 		echo $LOGBEGIN
-		git show --no-color --root -s --pretty=medium $newrev
+		git diff-tree --encoding=UTF-8 --root -s --pretty=oneline $newrev
 		echo $LOGEND
 	else
 		# What can we do here?  The tag marks an object that is not
@@ -627,7 +630,7 @@ generate_delete_general_email()
 	echo "       was  $oldrev"
 	echo ""
 	echo $LOGEND
-	git show -s --pretty=oneline $oldrev
+	git diff-tree --encoding=UTF-8 -s --pretty=oneline $oldrev
 	echo $LOGEND
 }
 
-- 
1.7.7.rc1

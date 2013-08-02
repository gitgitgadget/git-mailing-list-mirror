From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/3] hooks/post-receive-email: force log messages in UTF-8
Date: Fri, 2 Aug 2013 16:23:38 -0700
Message-ID: <20130802232338.GD2963@elie.Belkin>
References: <20130802232118.GB2963@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexey Shumkin <alex.crezoff@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Alexander Gerasiov <gq@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 03 01:23:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5OhI-0002R6-9x
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 01:23:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754639Ab3HBXXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Aug 2013 19:23:44 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:48695 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754579Ab3HBXXn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Aug 2013 19:23:43 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx1so1181532pab.13
        for <git@vger.kernel.org>; Fri, 02 Aug 2013 16:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=WadEf+ct8OejwhgzAnrUekd2CxMkP0z4i4phPzWghaE=;
        b=Vpjkmb4dM026hBrV77LqHjyozx0oxF2qkWCX+Zb9OUJJR9WrS/iWMMJEZse7iTvWEo
         PxCNdYj0UpkZA0eKbdvroHeZmzB5G/vu/O2WCi4a9hoQmYhBHIivbs9LxuIFu8+iyyyG
         b0N0Tqa3WV7/OC2sUx/dTCsOL/UL58BOZh4Q482BVc1edejAv5lSsetPJeh4N14s5Zdo
         fQss1M/07wvW7JggJt8Br086HF10H8+uSyI/dGC52TspeGTYBc1TdMGZ9OjPjgeFKR55
         Fv/ej71+50YuXiaTjdNmsDOUjfTr2MA7oTkWhiIv8whEKmWi8yLoMwu+kP2Zb36RMT8Q
         WfHA==
X-Received: by 10.66.221.8 with SMTP id qa8mr10309904pac.188.1375485822821;
        Fri, 02 Aug 2013 16:23:42 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id qp10sm10107769pab.13.2013.08.02.16.23.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 02 Aug 2013 16:23:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130802232118.GB2963@elie.Belkin>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231546>

Git commands write commit messages in UTF-8 by default, but that
default can be overridden by the [i18n] commitEncoding and
logOutputEncoding settings.  With such a setting, the emails written
by the post-receive-email hook use a mixture of encodings:

 1. Log messages use the configured log output encoding, which is
    meant to be whatever encoding works best with local terminals
    (and does not have much to do with what encoding should be used
    for email)

 2. Filenames are left as is: on Linux, usually UTF-8, and in the Mingw
    port (which uses Unicode filesystem APIs), always UTF-8

 3. The "This is an automated email" preface uses a project description
    from .git/description, which is typically in UTF-8 to support
    gitweb.

So (1) is configurable, and (2) and (3) are unconfigurable and
typically UTF-8.  Override the log output encoding to always use UTF-8
when writing the email to get the best chance of a comprehensible
single-encoding email.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/hooks/post-receive-email | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 72084511..ba93a0d8 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -471,7 +471,7 @@ generate_delete_branch_email()
 	echo "       was  $oldrev"
 	echo ""
 	echo $LOGBEGIN
-	git diff-tree -s --always --pretty=oneline $oldrev
+	git diff-tree -s --always --encoding=UTF-8 --pretty=oneline $oldrev
 	echo $LOGEND
 }
 
@@ -571,7 +571,7 @@ generate_delete_atag_email()
 	echo "       was  $oldrev"
 	echo ""
 	echo $LOGBEGIN
-	git diff-tree -s --always --pretty=oneline $oldrev
+	git diff-tree -s --always --encoding=UTF-8 --pretty=oneline $oldrev
 	echo $LOGEND
 }
 
@@ -617,7 +617,7 @@ generate_general_email()
 	echo ""
 	if [ "$newrev_type" = "commit" ]; then
 		echo $LOGBEGIN
-		git diff-tree -s --always --pretty=medium $newrev
+		git diff-tree -s --always --encoding=UTF-8 --pretty=medium $newrev
 		echo $LOGEND
 	else
 		# What can we do here?  The tag marks an object that is not
@@ -636,7 +636,7 @@ generate_delete_general_email()
 	echo "       was  $oldrev"
 	echo ""
 	echo $LOGBEGIN
-	git diff-tree -s --always --pretty=oneline $oldrev
+	git diff-tree -s --always --encoding=UTF-8 --pretty=oneline $oldrev
 	echo $LOGEND
 }
 
-- 
1.8.4.rc1

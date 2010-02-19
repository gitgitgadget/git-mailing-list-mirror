From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/7] am: Fix launching of pager
Date: Fri, 19 Feb 2010 01:12:03 -0600
Message-ID: <20100219071203.GE29916@progeny.tock>
References: <20100219065010.GA22258@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Celis <sebastian@sebastiancelis.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 19 08:12:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiN1r-0004VQ-Vk
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 08:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754525Ab0BSHLz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 02:11:55 -0500
Received: from mail-yw0-f197.google.com ([209.85.211.197]:63230 "EHLO
	mail-yw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754505Ab0BSHLy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 02:11:54 -0500
Received: by ywh35 with SMTP id 35so1811628ywh.4
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 23:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=UidY4P9jNo+9K5e1aZ7HwJGtI/vz9ciVGDn2KZ66KbE=;
        b=P/axMtA5qVwB0WIxuDf5o41pr9fhab7HNbfhNoMKyAsj2NtFx7GYCQlUK1vRX9d6rM
         Ea9/Qgqbay30t2i4dCfuV3hdjG50/OJeDKXl+rNCM5465Q7isUx9n1OvaKpQYLVBzrrs
         +7G5y+p98I59m+sQSYm15bigjNFzTt+fv0crY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=LLl8i4P7Gp9JlfmSv5+88yF1vDTqIbYBcvY6cGTDUl+Xov8UjlQO8QEt9ibfHqQllq
         oecfCSMaN2ZXpt8/KF2SyzWzpuSkc7/NzI4pivY0YV2sAPU/IRePJCn78BDuWR6Hvv4b
         0M4hbcxyt8jQwJhhc1W/cjMdEWqAVlM8dySeE=
Received: by 10.101.190.21 with SMTP id s21mr7940427anp.12.1266563513459;
        Thu, 18 Feb 2010 23:11:53 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 14sm1551180gxk.15.2010.02.18.23.11.52
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 18 Feb 2010 23:11:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100219065010.GA22258@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140422>

The pagination functionality in git am has some problems:

 - It does not check if stdout is a tty, so it always paginates.

 - If $GIT_PAGER uses any environment variables, they are being
   ignored, since it does not run $GIT_PAGER through eval.

 - If $GIT_PAGER is set to the empty string, instead of passing
   output through to stdout, it tries to run $dotest/patch.

Fix them.  While at it, move the definition of git_pager() to
git-sh-setup so authors of other commands are not tempted to
reimplement it with the same mistakes.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Same as before, included for reference.

 git-am.sh       |    5 +----
 git-sh-setup.sh |   13 +++++++++++++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 3c08d53..b11af03 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -663,10 +663,7 @@ do
 		[eE]*) git_editor "$dotest/final-commit"
 		       action=again ;;
 		[vV]*) action=again
-		       : ${GIT_PAGER=$(git var GIT_PAGER)}
-		       : ${LESS=-FRSX}
-		       export LESS
-		       $GIT_PAGER "$dotest/patch" ;;
+		       git_pager "$dotest/patch" ;;
 		*)     action=again ;;
 		esac
 	    done
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index d56426d..44fb467 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -107,6 +107,19 @@ git_editor() {
 	eval "$GIT_EDITOR" '"$@"'
 }
 
+git_pager() {
+	if test -t 1
+	then
+		GIT_PAGER=$(git var GIT_PAGER)
+	else
+		GIT_PAGER=cat
+	fi
+	: ${LESS=-FRSX}
+	export LESS
+
+	eval "$GIT_PAGER" '"$@"'
+}
+
 sane_grep () {
 	GREP_OPTIONS= LC_ALL=C grep "$@"
 }
-- 
1.7.0

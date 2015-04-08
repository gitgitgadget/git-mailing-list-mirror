From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [WIP/RFH/PATCH 3/3] t/lib-git-svn: adjust config to apache 2.4
Date: Wed,  8 Apr 2015 17:05:26 +0200
Message-ID: <0631c09d394dedb803a100e81ce4052a57b4e73e.1428505184.git.git@drmicha.warpmail.net>
References: <cover.1428505184.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 08 17:05:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfrY6-0005RB-CI
	for gcvg-git-2@plane.gmane.org; Wed, 08 Apr 2015 17:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753078AbbDHPFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2015 11:05:40 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:50313 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754476AbbDHPFc (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Apr 2015 11:05:32 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id E9898205A0
	for <git@vger.kernel.org>; Wed,  8 Apr 2015 11:05:27 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 08 Apr 2015 11:05:31 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	date:from:in-reply-to:message-id:references:subject:to
	:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=xsgKPjTefqM2mTiNDUIN+Ow7GKQ
	=; b=RDK3fKjszUYnF1B+XXZqcXbYdUpxBDz4hDgmA0DfIQc6fWm5ffTKC40Gvv1
	vWPcldlPGK8lUb5c2BZA83q8RgRAilTsNCHiYFI99hQhlHnu/ELndjgjRtRzmItx
	xM+6bOpDrhjeiZq2g7Pu8DvD4Zgobn8ZprcBK6/Ndi2Mo5U8=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=xsgK
	PjTefqM2mTiNDUIN+Ow7GKQ=; b=eC2am0hlFW7aec4hSw7JJ1M15mYH2gwrN9Qq
	MF2uzvGbH6kYk6xLRgHzKrc422UEwVknYjGixeNdRqOhIF2M0sSBDpTSr08ePUvi
	SM7H2/H10sywwez9U44u+xihlw0f0bhawyLWNQkwlhrxDE41s+pGgOkgUeMw0Om+
	JjJppAg=
X-Sasl-enc: PvOpp3AYoV/JmLuDyFx0IRAFuNH3akdrXhqBSEC1KulQ 1428505531
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 834396801A3;
	Wed,  8 Apr 2015 11:05:31 -0400 (EDT)
X-Mailer: git-send-email 2.4.0.rc1.221.gf7021fb
In-Reply-To: <cover.1428505184.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266964>

The current config is tailored to apache 2.2. Apache 2.4 fails to start
with it.

Adjust the config to apache 2.4.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---

Notes:
    This is WIP and RFH. Apache does not start without mpm, and the lock
    mechanism has changed. It will run with these changes, but svn fails to
    connect.
    
    Again, I'm wondering who is running these tests at all, but also:
    Why do we leverage lib-httpd so little from lib-git-svn?

 t/lib-git-svn.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index 2a0ef07..b0ca893 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -117,10 +117,11 @@ ServerName "git svn test"
 ServerRoot "$GIT_DIR"
 DocumentRoot "$GIT_DIR"
 PidFile "$GIT_DIR/httpd.pid"
-LockFile logs/accept.lock
+Mutex default
 Listen 127.0.0.1:$SVN_HTTPD_PORT
 LoadModule dav_module $SVN_HTTPD_MODULE_PATH/mod_dav.so
 LoadModule dav_svn_module $SVN_HTTPD_MODULE_PATH/mod_dav_svn.so
+LoadModule mpm_prefork_module $SVN_HTTPD_MODULE_PATH/mod_mpm_prefork.so
 <Location /$repo_base_path>
 	DAV svn
 	SVNPath "$rawsvnrepo"
-- 
2.4.0.rc1.221.gf7021fb

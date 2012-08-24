From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/6] Support logging unmarked strings
Date: Fri, 24 Aug 2012 12:43:05 +0700
Message-ID: <1345786986-10826-6-git-send-email-pclouds@gmail.com>
References: <1345786986-10826-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 24 07:44:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4mh1-0000vh-GF
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 07:44:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753373Ab2HXFoV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Aug 2012 01:44:21 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39005 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753275Ab2HXFoT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 01:44:19 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so2795592pbb.19
        for <git@vger.kernel.org>; Thu, 23 Aug 2012 22:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=3ihV6zAk7/S6S9xf0VQusXHviULVZz8mPUKLgjyKBF4=;
        b=p8ji3/oZcgLojixSuQxFBipx9VXbsBpaJvln+2mQGqUzwb7COxykyj/mMbwO3ldY8u
         86Qr+0RjaAIEu9F6xnqIy7PHm+cD2hKgmB+FpmKpQ7NJJQ3Mf1QAtrFJu6eOBQgyYkKN
         KudjHOrnkvHJDHBVSnoG8ahJbphXSqaSZToe5EYXLJvmzpN9es2Hqu4ndkQac0zT5Yt+
         lGjzAvUPxwmVsUPEroV3gA+bAfFs8XT9Fwy4jbH0VB2D5/ENNVUaOFF3Tcri/V549PSe
         Ij+jmzLGt+txMbtj1zKofDIuZ/s5i3Pvj6frF5BdjSEi1/MTlvwfQEJj2zy/kAVBnnP5
         7XwQ==
Received: by 10.68.225.196 with SMTP id rm4mr10001918pbc.131.1345787059425;
        Thu, 23 Aug 2012 22:44:19 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id sr3sm7573431pbc.44.2012.08.23.22.44.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 23 Aug 2012 22:44:18 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 24 Aug 2012 12:44:01 +0700
X-Mailer: git-send-email 1.7.12.rc2
In-Reply-To: <1345786986-10826-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204186>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Hard coding path obviously won't fly..

 .gitignore      | 1 +
 wrap-for-bin.sh | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/.gitignore b/.gitignore
index bb5c91e..f2d0fe5 100644
--- a/.gitignore
+++ b/.gitignore
@@ -195,6 +195,7 @@
 /test-sigchain
 /test-subprocess
 /test-svn-fe
+/untranslated.log
 /common-cmds.h
 *.tar.gz
 *.dsc
diff --git a/wrap-for-bin.sh b/wrap-for-bin.sh
index a2d9aef..4dbae80 100644
--- a/wrap-for-bin.sh
+++ b/wrap-for-bin.sh
@@ -17,6 +17,12 @@ fi
 GITPERLLIB=3D'@@BUILD_DIR@@/perl/blib/lib'
 if test -n "$GIT_GETTEXT_POISON"
 then
+	if test -x /usr/lib/preloadable_libintl.so
+	then
+		GETTEXT_LOG_UNTRANSLATED=3D@@BUILD_DIR@@/untranslated.log
+		LD_PRELOAD=3D"/usr/lib/preloadable_libintl.so $LD_PRELOAD"
+		export LD_PRELOAD GETTEXT_LOG_UNTRANSLATED
+	fi
 	GIT_TEXTDOMAINDIR=3D'@@BUILD_DIR@@/po/build/pseudo-locale'
 	LANG=3D$GIT_GETTEXT_POISON
 	unset LC_ALL
--=20
1.7.12.rc2

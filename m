From: Tarmigan Casebolt <tarmigan+git@gmail.com>
Subject: [PATCH 1/2] t/lib-http.sh: Restructure finding of default httpd location
Date: Thu, 19 Nov 2009 17:22:02 -0800
Message-ID: <1258680123-28684-1-git-send-email-tarmigan+git@gmail.com>
Cc: peff@peff.net, jaysoffian@gmail.com, drizzd@aon.at,
	gitster@pobox.com, spearce@spearce.org,
	Tarmigan Casebolt <tarmigan+git@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 20 02:22:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBICw-0007IU-JA
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 02:22:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757146AbZKTBW3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 20:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757066AbZKTBW3
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 20:22:29 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:59497 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756983AbZKTBW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 20:22:28 -0500
Received: by pwi3 with SMTP id 3so1775891pwi.21
        for <git@vger.kernel.org>; Thu, 19 Nov 2009 17:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=Eo4VxqjHb2XTfMsZhO56IpB2s1WyNNUj/x103cxuGv8=;
        b=O2oORgxf1tPMncDbHgo8qJZPWIpf5c3vju0jiic4WAQbhOsz2hvUpUziB20tuPLCOd
         Lkwl4osdfEcobO83PWp6GBigqvZ3N1cvacVY9MLrUHSLcf2PdiD5BXMCslWO1Pr+MIjW
         ieboPp0zhUWapfyRcF94WANe/rL+k4FzN0U/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=BsxBjYHnXgKD0pmCsFwn10HYPtSi0alzs515XswILgskxwNhXG/5LQEVnmlxuJqO+V
         pw5wap6vn2dO/GWuwbNQS8/ING/XnWV0n76Bk7+vRvYl2ix1iBzXEKHMqfhU1pBHnw/B
         WrMNba1hVdJHq4w2mfdSC2XxhUGcd9hAJu9zU=
Received: by 10.114.242.8 with SMTP id p8mr854937wah.169.1258680150234;
        Thu, 19 Nov 2009 17:22:30 -0800 (PST)
Received: from localhost.localdomain (host-98-127-69-228.bln-mt.client.bresnan.net [98.127.69.228])
        by mx.google.com with ESMTPS id 20sm681601pxi.11.2009.11.19.17.22.28
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 19 Nov 2009 17:22:29 -0800 (PST)
X-Mailer: git-send-email 1.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133275>

On my machine with CentOS, httpd is located at /usr/sbin/httpd, and
the modules are located at /usr/lib64/httpd/modules.  To enable easy
testing of httpd, we would like those locations to be detected
automatically.

uname might not be the best way to determine the default location for
httpd since different Linux distributions apparently put httpd in
different places, so we test a couple different locations for httpd,
and use the first one that we come across.  We do the same for the
modules directory.

Signed-off-by: Tarmigan Casebolt <tarmigan+git@gmail.com>
---

Would any machines have httpd or the modules/ directory in several of
these locations?

Also I don't really know shell scripting, so while this Works For Me,
it may be completely wrong.

 t/lib-httpd.sh |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 6765b08..6b86353 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -12,16 +12,23 @@ fi
 
 HTTPD_PARA=""
 
+for DEFAULT_HTTPD_PATH in '/usr/sbin/httpd' '/usr/sbin/apache2'
+do
+	test -x "$DEFAULT_HTTPD_PATH" && break
+done
+
+for DEFAULT_HTTPD_MODULE_PATH in '/usr/libexec/apache2' \
+                                 '/usr/lib/apache2/modules' \
+                                 '/usr/lib64/httpd/modules' \
+                                 '/usr/lib/httpd/modules'
+do
+	test -d "$DEFAULT_HTTPD_MODULE_PATH" && break
+done
+
 case $(uname) in
 	Darwin)
-		DEFAULT_HTTPD_PATH='/usr/sbin/httpd'
-		DEFAULT_HTTPD_MODULE_PATH='/usr/libexec/apache2'
 		HTTPD_PARA="$HTTPD_PARA -DDarwin"
 	;;
-	*)
-		DEFAULT_HTTPD_PATH='/usr/sbin/apache2'
-		DEFAULT_HTTPD_MODULE_PATH='/usr/lib/apache2/modules'
-	;;
 esac
 
 LIB_HTTPD_PATH=${LIB_HTTPD_PATH-"$DEFAULT_HTTPD_PATH"}
-- 
1.6.5.52.g35487

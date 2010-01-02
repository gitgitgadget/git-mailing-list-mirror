From: Tarmigan Casebolt <tarmigan+git@gmail.com>
Subject: [PATCH v2] t/lib-http.sh: Restructure finding of default httpd location
Date: Sat,  2 Jan 2010 14:04:25 -0800
Message-ID: <1262469865-9443-1-git-send-email-tarmigan+git@gmail.com>
References: <905315640911191930rc33cabdr290b534ffbe85690@mail.gmail.com>
Cc: git@vger.kernel.org, Tarmigan Casebolt <tarmigan+git@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jan 02 23:04:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRC5Y-00015c-MP
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jan 2010 23:04:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908Ab0ABWEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2010 17:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751894Ab0ABWEo
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jan 2010 17:04:44 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:46292 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751657Ab0ABWEn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2010 17:04:43 -0500
Received: by ywh6 with SMTP id 6so14259791ywh.4
        for <git@vger.kernel.org>; Sat, 02 Jan 2010 14:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=s+W70Yu/oQ/i/HiSdl+YhonTE8MYZP2slWdo/T9yoGk=;
        b=mtJveZOlekTwXsYyrq5kvYmTwwANhvbolPkQWrMGNwilwS24ZrgqyxAKxfcL/uz1CC
         D5PIlcvJZRYnerWjUcAkT8lQ4FfukVETb4F1bX8Wge1B18pZaua/s7k/PisRc7xlRLgV
         5VHt3Ea6+uUe3/R69icXfbJJ7DKiyH1nruSMU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=xikJqbwuv6LLN/yaQG1CYVhbWumfRy5Mobzs4NeywhjwEM5A455OvLi12Ec2X9OMfD
         N+H4EWWkw2M/fO8bauKu6RiMzohXH33n61iziKHQ/WEE3KWuTDdCb5jW08mnQYrr9gbk
         vbN1KXNJI6ujE44yL3z0086rkgRCotOEon5YE=
Received: by 10.101.165.26 with SMTP id s26mr13643295ano.99.1262469878032;
        Sat, 02 Jan 2010 14:04:38 -0800 (PST)
Received: from localhost.localdomain (c-69-181-44-199.hsd1.ca.comcast.net [69.181.44.199])
        by mx.google.com with ESMTPS id 35sm6549498yxh.51.2010.01.02.14.04.35
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 02 Jan 2010 14:04:37 -0800 (PST)
X-Mailer: git-send-email 1.6.6.236.gc56f3
In-Reply-To: <905315640911191930rc33cabdr290b534ffbe85690@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136060>

On CentOS 5, httpd is located at /usr/sbin/httpd, and the modules are
located at /usr/lib64/httpd/modules.  To enable easy testing of httpd,
we would like those locations to be detected automatically.

uname might not be the best way to determine the default location for
httpd since different Linux distributions apparently put httpd in
different places, so we test a couple different locations for httpd,
and use the first one that we come across.  We do the same for the
modules directory.

cc: Jay Soffian <jaysoffian@gmail.com>
Signed-off-by: Tarmigan Casebolt <tarmigan+git@gmail.com>
---
Jay was concerned about the final fallthrough cases for testing these
lists.  I have added a test for the modules directory and the existing
tests later in the script already test that the apache executable
exists.  If either cannot be found, we do test_done.

Would any machines have httpd or the modules/ directory in several of
these locations?
---
 t/lib-httpd.sh |   30 ++++++++++++++++++++++++------
 1 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 6765b08..27b466b 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -12,16 +12,29 @@ fi
 
 HTTPD_PARA=""
 
+for DEFAULT_HTTPD_PATH in '/usr/sbin/httpd' '/usr/sbin/apache2'
+do
+	if test -x "$DEFAULT_HTTPD_PATH"
+	then
+	        break
+	fi
+done
+
+for DEFAULT_HTTPD_MODULE_PATH in '/usr/libexec/apache2' \
+                                 '/usr/lib/apache2/modules' \
+                                 '/usr/lib64/httpd/modules' \
+                                 '/usr/lib/httpd/modules'
+do
+        if test -d "$DEFAULT_HTTPD_MODULE_PATH"
+	then
+	        break
+	fi
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
@@ -49,6 +62,11 @@ then
 			say "skipping test, at least Apache version 2 is required"
 			test_done
 		fi
+		if ! test -d "$DEFAULT_HTTPD_MODULE_PATH"
+		then
+			say "Apache module directory not found.  Skipping tests."
+			test_done
+		fi
 
 		LIB_HTTPD_MODULE_PATH="$DEFAULT_HTTPD_MODULE_PATH"
 	fi
-- 
1.6.6.236.gc56f3

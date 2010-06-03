From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: [PATCH 3/3] git-instaweb: Add support for --reuse-config using gitconfig
Date: Thu,  3 Jun 2010 19:25:56 +0530
Message-ID: <1275573356-21466-3-git-send-email-pavan.sss1991@gmail.com>
References: <1275573356-21466-1-git-send-email-pavan.sss1991@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: git@vger.kernel.org, jnareb@gmail.com, chriscool@tuxfamily.org,
	pasky@ucw.cz
X-From: git-owner@vger.kernel.org Thu Jun 03 15:57:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKAuu-0007Fn-If
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 15:57:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753869Ab0FCN46 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 09:56:58 -0400
Received: from mail-pz0-f185.google.com ([209.85.222.185]:56024 "EHLO
	mail-pz0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130Ab0FCN45 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 09:56:57 -0400
Received: by pzk15 with SMTP id 15so55845pzk.15
        for <git@vger.kernel.org>; Thu, 03 Jun 2010 06:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=2vhIf/Vt5xfOy1qPoCyyqnXx+GpxMtIsgddlDaofNdI=;
        b=ACqlxy0JiqmcF/7+ps519AVBLWIE/spnOpuDy76fXwTZXA7Kpt/WiRyQ5wV6q91NEP
         5i1PAssbaY5d+CRUm9HJpcjM1mE2K/1hJ3I8NfxL443WnadK8WyDAcXD8R+GNAHhT+7q
         BAP3sxZs30rGH+oQ7MOKhBBWq1aUvfgNkYOpA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=iIGGGH9BF+FN9HWTHd+ovzxN1KsBiORr/cNDl5jkN6QOV75qI0+iNkytbKAXXedjyY
         LeYQAC/xUju1RLJqbaOzT9xJBADv69H4bRuzGGGfW3b1CF9jrArWn8R7QekwDAIVgfq7
         MVP9b18L8u/9g4VPqZv9E7NuO0uhMYJPk8w48=
Received: by 10.143.21.19 with SMTP id y19mr6627757wfi.259.1275573417333;
        Thu, 03 Jun 2010 06:56:57 -0700 (PDT)
Received: from localhost.localdomain ([202.63.112.23])
        by mx.google.com with ESMTPS id v41sm65474wfh.21.2010.06.03.06.56.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 03 Jun 2010 06:56:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.447.gfddfb
In-Reply-To: <1275573356-21466-1-git-send-email-pavan.sss1991@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148320>

Support instaweb's --reuse-config using instaweb.overwrite
variable in gitconfig.

To use --reuse-config always
	[instaweb]
		overwrite = false

Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
---

This patch is based on branch 'pu' and my previous patch
http://thread.gmane.org/gmane.comp.version-control.git/148161

 Documentation/git-instaweb.txt |    2 ++
 git-instaweb.sh                |    5 ++++-
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-instaweb.txt b/Documentation/git-instaweb.txt
index 0e7e20b..12cbe1d 100644
--- a/Documentation/git-instaweb.txt
+++ b/Documentation/git-instaweb.txt
@@ -77,6 +77,8 @@ You may specify configuration in your .git/config
 	port = 4321
 	browser = konqueror
 	modulepath = /usr/lib/apache2/modules
+	gitwebdir = /usr/share/gitweb
+	overwrite = false
 
 -----------------------------------------------------------------------
 
diff --git a/git-instaweb.sh b/git-instaweb.sh
index 1c704a3..3635974 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -28,7 +28,7 @@ httpd="$(git config --get instaweb.httpd)"
 root="$(git config --get instaweb.gitwebdir)"
 port=$(git config --get instaweb.port)
 module_path="$(git config --get instaweb.modulepath)"
-no_reuse=true
+no_reuse="$(git config --bool --get instaweb.overwrite)"
 
 conf="$GIT_DIR/gitweb/httpd.conf"
 
@@ -43,6 +43,9 @@ test -z "$root" && root='@@GITWEBDIR@@'
 # any untaken local port will do...
 test -z "$port" && port=1234
 
+# Default is true -> overwrite gitweb_config.perl
+test -z "$no_reuse" && no_reuse=true
+
 resolve_full_httpd () {
 	case "$httpd" in
 	*apache2*|*lighttpd*)
-- 
1.7.1.447.gfddfb

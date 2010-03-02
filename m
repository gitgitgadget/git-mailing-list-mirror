From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: [PATCH] gitweb multiple project roots documentation
Date: Tue,  2 Mar 2010 01:04:57 +0100
Message-ID: <1267488297-10415-1-git-send-email-sylvain@abstraction.fr>
References: <201003012318.29548.jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Sylvain Rabot <sylvain@abstraction.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 02 01:05:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmFbr-0007vv-6N
	for gcvg-git-2@lo.gmane.org; Tue, 02 Mar 2010 01:05:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753041Ab0CBAFF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 19:05:05 -0500
Received: from mail-bw0-f212.google.com ([209.85.218.212]:43602 "EHLO
	mail-bw0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753021Ab0CBAFC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 19:05:02 -0500
Received: by bwz4 with SMTP id 4so2353935bwz.28
        for <git@vger.kernel.org>; Mon, 01 Mar 2010 16:05:01 -0800 (PST)
Received: by 10.204.48.198 with SMTP id s6mr2735406bkf.8.1267488300976;
        Mon, 01 Mar 2010 16:05:00 -0800 (PST)
Received: from localhost.localdomain (smj33-1-82-233-66-33.fbx.proxad.net [82.233.66.33])
        by mx.google.com with ESMTPS id 16sm2476537bwz.1.2010.03.01.16.05.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Mar 2010 16:05:00 -0800 (PST)
X-Mailer: git-send-email 1.7.0
In-Reply-To: <201003012318.29548.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141368>

This commit adds in the gitweb/README file a description of how to use gitweb
with several project roots using apache virtualhost rewrite rules.

Signed-off-by: Sylvain Rabot <sylvain@abstraction.fr>
---
 gitweb/README |   67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/gitweb/README b/gitweb/README
index 6c2c8e1..2e55d38 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -312,12 +312,16 @@ If you want to have one URL for both gitweb and your http://
 repositories, you can configure apache like this:
 
 <VirtualHost *:80>
-    ServerName git.example.org
-    DocumentRoot /pub/git
-    SetEnv	GITWEB_CONFIG	/etc/gitweb.conf
+    ServerName		git.example.org
+    DocumentRoot	/pub/git
+    SetEnv			GITWEB_CONFIG	/etc/gitweb.conf
+
+    # turning on mod rewrite
     RewriteEngine on
+
     # make the front page an internal rewrite to the gitweb script
     RewriteRule ^/$  /cgi-bin/gitweb.cgi
+
     # make access for "dumb clients" work
     RewriteRule ^/(.*\.git/(?!/?(HEAD|info|objects|refs)).*)?$ /cgi-bin/gitweb.cgi%{REQUEST_URI}  [L,PT]
 </VirtualHost>
@@ -343,6 +347,63 @@ something like the following in your gitweb.conf (or gitweb_config.perl) file:
   $home_link = "/";
 
 
+Webserver configuration with multiple projects' root
+----------------------------------------------------
+
+If you want to use gitweb with several project roots you can edit your apache
+virtual host and gitweb.conf configuration files like this :
+
+virtual host configuration :
+
+<VirtualHost *:80>
+    ServerName			git.example.org
+    DocumentRoot		/pub/git
+    SetEnv				GITWEB_CONFIG	/etc/gitweb.conf
+
+    # turning on mod rewrite
+    RewriteEngine on
+
+    # make the front page an internal rewrite to the gitweb script
+    RewriteRule ^/$ 		/cgi-bin/gitweb.cgi [QSA,L,PT]
+
+    # look for a public_git folder in unix users' home
+    # http://git.example.org/~<user>/
+    RewriteRule ^/\~([^\/]+)(/|/gitweb.cgi)?$	/cgi-bin/gitweb.cgi [QSA,E=GITWEB_PROJECTROOT:/home/$1/public_git/,L,PT]
+
+    # http://git.example.org/+<user>/
+    #RewriteRule ^/\+([^\/]+)(/|/gitweb.cgi)?$	/cgi-bin/gitweb.cgi [QSA,E=GITWEB_PROJECTROOT:/home/$1/public_git/,L,PT]
+
+    # http://git.example.org/user/<user>/
+    #RewriteRule ^/user/([^\/]+)/(gitweb.cgi)?$	/cgi-bin/gitweb.cgi [QSA,E=GITWEB_PROJECTROOT:/home/$1/public_git/,L,PT]
+
+    # defined list of project roots
+    RewriteRule ^/scm(/|/gitweb.cgi)?$		/cgi-bin/gitweb.cgi [QSA,E=GITWEB_PROJECTROOT:/pub/scm/,L,PT]
+    RewriteRule ^/var(/|/gitweb.cgi)?$		/cgi-bin/gitweb.cgi [QSA,E=GITWEB_PROJECTROOT:/var/git/,L,PT]
+
+    # make access for "dumb clients" work
+    RewriteRule ^/(.*\.git/(?!/?(HEAD|info|objects|refs)).*)?$ /cgi-bin/gitweb.cgi%{REQUEST_URI}  [L,PT]
+</VirtualHost>
+
+gitweb.conf configuration :
+
+$projectroot = $ENV{'GITWEB_PROJECTROOT'} || "/pub/git";
+
+These configurations enable two things. First, each unix user (<user>) of the
+server will be able to browse through gitweb git repositories found in
+~/public_git/ with the following url : http://git.example.org/~<user>/
+
+If you do not want this feature on your server just remove the second rewrite rule.
+
+If you already use mod_userdir in your virtual host or you don't want to use 
+the '~' as first character just comment or remove the second rewrite rule and 
+uncomment one of the following according to what you want.
+
+Second, repositories found in /pub/scm/ and /var/git/ will be accesible
+through http://git.example.org/scm/ and http://git.example.org/var/.
+You can add as many project roots as you want by adding rewrite rules like the
+third and the fourth.
+
+
 PATH_INFO usage
 -----------------------
 If you enable PATH_INFO usage in gitweb by putting
-- 
1.7.0

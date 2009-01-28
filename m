From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv4 2/2] gitweb: webserver config for PATH_INFO
Date: Wed, 28 Jan 2009 11:50:32 +0100
Message-ID: <1233139832-24124-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1233139832-24124-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 28 11:52:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS81b-0003DL-El
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 11:52:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbZA1Kuk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 05:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbZA1Kuk
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 05:50:40 -0500
Received: from ey-out-1920.google.com ([74.125.78.146]:22199 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbZA1Kuj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 05:50:39 -0500
Received: by ey-out-1920.google.com with SMTP id 5so1767412eyb.0
        for <git@vger.kernel.org>; Wed, 28 Jan 2009 02:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=DfTuABzXbQj1ui0S4Qo53jqVOcTjWhxntKJNCKe9wrM=;
        b=YxgBSP9sz6Msnj5wQm8bhRK+AhmftN32tYxA6uLDsmF7r/TjunSl4a4EmAP6lNwcg1
         9Cc2rF1irPbblvPmqo73IwXTZVZ4fpu1GGwXJbgVKLlMQYEh5i07mYNrgphwbiLDnKwV
         8c9ZssYyl1EWbtK8lIh2pDr9gxYWb3oCOtF8o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PDKoJfAzUWCDV1m7xSaOmFH4Zn514dxv5lyH56gTw6sbMWFkFBnRDkVuB3KtxLoToL
         9tZSm13po3dUvQa+OVsHCAz40Oh0uAULjYvxy5s7YkBZFk7/iTFu3PJOEZKAqHgrx03H
         2wVVnKCOXL0cPWk9FwySR4PbDIVUcdGPIZz7Y=
Received: by 10.103.217.5 with SMTP id u5mr278116muq.118.1233139835087;
        Wed, 28 Jan 2009 02:50:35 -0800 (PST)
Received: from localhost ([94.37.14.37])
        by mx.google.com with ESMTPS id i7sm2806114mue.45.2009.01.28.02.50.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Jan 2009 02:50:34 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1233139832-24124-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107525>

Document some possible Apache configurations when the path_info feature
is enabled in gitweb.
---
So I decided to document the best way to set up the web server with the
path_info feature. I particularly like the second trick, although I haven't
found a way to make git-daemon accept both git://git.example.com/project and
git://git.example.com/project.git when the project dirs don't have the .git
extensions (e.g. /pub/git/project instead of /pub/git/project.git)

 gitweb/README |   76 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 76 insertions(+), 0 deletions(-)

diff --git a/gitweb/README b/gitweb/README
index 825162a..52ad88b 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -322,6 +322,82 @@ something like the following in your gitweb.conf (or gitweb_config.perl) file:
   $home_link = "/";
 
 
+PATH_INFO usage
+-----------------------
+If you enable PATH_INFO usage in gitweb by putting
+
+   $feature{'pathinfo'}{'default'} = [1];
+
+in your gitweb.conf, it is possible to set up your server so that it
+consumes and produces URLs in the form
+
+http://git.example.com/project.git/shortlog/sometag
+
+by using a configuration such as the following, that assumes that
+/var/www/gitweb is the DocumentRoot of your webserver, and that it
+contains the gitweb.cgi script and complementary static files
+(stylesheet, favicon):
+
+<VirtualHost *:80>
+	ServerAlias git.example.com
+
+	DocumentRoot /var/www/gitweb
+
+	<Directory /var/www/gitweb>
+		Options ExecCGI
+		AddHandler cgi-script cgi
+
+		DirectoryIndex gitweb.cgi
+
+		RewriteEngine On
+		RewriteCond %{REQUEST_FILENAME} !-f
+		RewriteCond %{REQUEST_FILENAME} !-d
+		RewriteRule ^.* /gitweb.cgi/$0 [L,PT]
+	</Directory>
+</VirtualHost>
+
+The rewrite rule guarantees that existing static files will be properly
+served, whereas any other URL will be passed to gitweb as PATH_INFO
+parameter.
+
+Notice that in this case you don't need special settings for
+@stylesheets, $my_uri and $home_link, but you lose "dumb client" access
+to your project .git dirs. A possible workaround for the latter is the
+following: in your project root dir (e.g. /pub/git) have the projects
+named without a .git extension (e.g. /pub/git/project instead of
+/pub/git/project.git) and configure Apache as follows:
+
+<VirtualHost *:80>
+	ServerAlias git.example.com
+
+	DocumentRoot /var/www/gitweb
+
+	AliasMatch ^(/.*?)(\.git)(/.*)? /pub/git$1$3
+	<Directory /var/www/gitweb>
+		Options ExecCGI
+		AddHandler cgi-script cgi
+
+		DirectoryIndex gitweb.cgi
+
+		RewriteEngine On
+		RewriteCond %{REQUEST_FILENAME} !-f
+		RewriteCond %{REQUEST_FILENAME} !-d
+		RewriteRule ^.* /gitweb.cgi/$0 [L,PT]
+	</Directory>
+</VirtualHost>
+
+The additional AliasMatch makes it so that
+
+http://git.example.com/project.git
+
+will give raw access to the project's git dir (so that the project can
+be cloned), while
+
+http://git.example.com/project
+
+will provide human-friendly gitweb access.
+
+
 Originally written by:
   Kay Sievers <kay.sievers@vrfy.org>
 
-- 
1.5.6.5

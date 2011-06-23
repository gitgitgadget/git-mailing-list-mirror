From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 4/4] git-instaweb: Check that correct config file exists for
	(re)start
Date: Thu, 23 Jun 2011 23:01:03 +0200
Message-ID: <20110623205942.18265.5903.stgit@localhost.localdomain>
References: <20110623194624.18265.82482.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Gurjeet Singh <singh.gurjeet@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 23 23:01:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZr1s-00028Z-Gf
	for gcvg-git-2@lo.gmane.org; Thu, 23 Jun 2011 23:01:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759864Ab1FWVBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jun 2011 17:01:31 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39612 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759779Ab1FWVBa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2011 17:01:30 -0400
Received: by fxm17 with SMTP id 17so1505164fxm.19
        for <git@vger.kernel.org>; Thu, 23 Jun 2011 14:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:subject:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=rRokKqG21alPUKjrXRFGt7HGhoAl4hY/V/0jZFeQb2k=;
        b=sl4h9MCS4Xc+nj0CguA++2cHeQA4+YRvKBRByJt7S2GQAVDRgBD1fNZXbDYQVh0hbD
         3eL/FpDyFroI5CPu7ORM602S4IMa+1je5DnOyf/bPk1Zi6XTxhThv4kLcll12o/V9t+C
         057PdT75sN6a200WKbwZj4AUFZIabMLXSPahc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=AzdIbGRbQTGM5EjUy7OdM7lmyarD+pjYbSo0JA5kUnpwrkeZOVhyxsmRTBv7QkgdtI
         N6lCQU+v+5krcUQeQuuE35AB2S+fB5XWvgpeD/1GDfMvCAaddjF55faE2avmFO54rhmQ
         Sm3Xvn9sL76RKPaldfx3zqUe02lkbDvqyL2q8=
Received: by 10.223.98.82 with SMTP id p18mr3333171fan.64.1308862889131;
        Thu, 23 Jun 2011 14:01:29 -0700 (PDT)
Received: from localhost.localdomain (abva28.neoplus.adsl.tpnet.pl [83.8.198.28])
        by mx.google.com with ESMTPS id o23sm1225393faa.33.2011.06.23.14.01.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 23 Jun 2011 14:01:28 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p5NL13xc019506;
	Thu, 23 Jun 2011 23:01:14 +0200
In-Reply-To: <20110623194624.18265.82482.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176293>

Currently start/restart does not generate any configuration files for
spawning a new instance.  This means that

  $ git instaweb --http=<server> --start

might pick up stale 'httpd.conf' file for a different web server
(e.g. for default lighttpd when requesting apache2).

This commit changes that, and makes git-instaweb generate web server
config file and/or gitweb config file if don't exists.

This required naming config files after the name of web server
(alternate solution would be to somehow mark for which web server was
config file generated).

Note that web servers that embed configuration in server script file,
namely webrick and plackup, and which delete "$conf" in their *_conf
function, would have their config (server script) always regenerated.


Note: this commit introduces a bit of code repetition (but only a few
lines).

Reported-by: Gurjeet Singh <singh.gurjeet@gmail.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is an actual fix.

Though I haven't checked if git-instaweb behaves sanely if you switch
between web servers with --start...

 Documentation/git-instaweb.txt |    8 ++++----
 git-instaweb.sh                |    7 +++++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-instaweb.txt b/Documentation/git-instaweb.txt
index 08f85ba..ea95c90 100644
--- a/Documentation/git-instaweb.txt
+++ b/Documentation/git-instaweb.txt
@@ -51,8 +51,8 @@ OPTIONS
 
 start::
 --start::
-	Start the httpd instance and exit.  This does not generate
-	any of the configuration files for spawning a new instance.
+	Start the httpd instance and exit.  Regenerate configuration files
+	as necessary for spawning a new instance.
 
 stop::
 --stop::
@@ -62,8 +62,8 @@ stop::
 
 restart::
 --restart::
-	Restart the httpd instance and exit.  This does not generate
-	any of the configuration files for spawning a new instance.
+	Restart the httpd instance and exit.  Regenerate configuration files
+	as necessary for spawning a new instance.
 
 CONFIGURATION
 -------------
diff --git a/git-instaweb.sh b/git-instaweb.sh
index 9a2f20f..01a1b05 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -99,6 +99,12 @@ start_httpd () {
 
 	# here $httpd should have a meaningful value
 	resolve_full_httpd
+	mkdir -p "$fqgitdir/gitweb/$httpd_only"
+	conf="$fqgitdir/gitweb/$httpd_only.conf"
+
+	# generate correct config file if it doesn't exist
+	test -f "$conf" || configure_httpd
+	test -f "$fqgitdir/gitweb/gitweb_config.perl" || gitweb_conf
 
 	# don't quote $full_httpd, there can be arguments to it (-f)
 	case "$httpd" in
@@ -628,6 +634,7 @@ gitweb_conf
 
 resolve_full_httpd
 mkdir -p "$fqgitdir/gitweb/$httpd_only"
+conf="$fqgitdir/gitweb/$httpd_only.conf"
 
 configure_httpd
 

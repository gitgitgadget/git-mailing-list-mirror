From: Christopher Wilson <cwilson@cdwilson.us>
Subject: [PATCH] Enable highlight executable path as a configuration option
Date: Sun, 19 Sep 2010 15:29:05 -0700
Message-ID: <9E70D992-1101-4F5C-B428-CE7F23CFF3E0@cdwilson.us>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 00:29:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxSNo-00076Z-6C
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 00:29:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753633Ab0ISW3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Sep 2010 18:29:11 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:42022 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752241Ab0ISW3K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Sep 2010 18:29:10 -0400
Received: by pvg2 with SMTP id 2so1005838pvg.19
        for <git@vger.kernel.org>; Sun, 19 Sep 2010 15:29:10 -0700 (PDT)
Received: by 10.142.217.17 with SMTP id p17mr6916411wfg.65.1284935349913;
        Sun, 19 Sep 2010 15:29:09 -0700 (PDT)
Received: from [192.168.1.10] (c-67-170-193-75.hsd1.ca.comcast.net [67.170.193.75])
        by mx.google.com with ESMTPS id d10sm5542328wfe.22.2010.09.19.15.29.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Sep 2010 15:29:08 -0700 (PDT)
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156518>

Allow build-time/run-time configuration of the highlight executable. Defaults
to previous behavior which assumes that highlight is available on the server
PATH. However, if this is not the case, the path to the highlight executable
can be configured at build time as a configuration variable

    HIGHLIGHT_BIN = /path/to/highlight

or at runtime by configuring GITWEB_CONFIG

    $highlight_bin = /path/to/highlight

Signed-off-by: Christopher Wilson <cwilson@cdwilson.us>
---
 gitweb/Makefile    |    4 +++-
 gitweb/README      |    7 ++++++-
 gitweb/gitweb.perl |    6 +++++-
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/gitweb/Makefile b/gitweb/Makefile
index 2fb7c2d..e32ee76 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -35,6 +35,7 @@ GITWEB_FAVICON = static/git-favicon.png
 GITWEB_JS = static/gitweb.js
 GITWEB_SITE_HEADER =
 GITWEB_SITE_FOOTER =
+HIGHLIGHT_BIN = highlight
 
 # include user config
 -include ../config.mak.autogen
@@ -129,7 +130,8 @@ GITWEB_REPLACE = \
 	-e 's|++GITWEB_FAVICON++|$(GITWEB_FAVICON)|g' \
 	-e 's|++GITWEB_JS++|$(GITWEB_JS)|g' \
 	-e 's|++GITWEB_SITE_HEADER++|$(GITWEB_SITE_HEADER)|g' \
-	-e 's|++GITWEB_SITE_FOOTER++|$(GITWEB_SITE_FOOTER)|g'
+	-e 's|++GITWEB_SITE_FOOTER++|$(GITWEB_SITE_FOOTER)|g' \
+	-e 's|++HIGHLIGHT_BIN++|$(HIGHLIGHT_BIN)|g'
 
 GITWEB-BUILD-OPTIONS: FORCE
 	@rm -f $@+
diff --git a/gitweb/README b/gitweb/README
index d481198..69f9860 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -114,6 +114,9 @@ You can specify the following configuration variables when building GIT:
    when gitweb.cgi is executed, then the file specified in the environment
    variable will be loaded instead of the file specified when gitweb.cgi was
    created.  [Default: /etc/gitweb.conf]
+ * HIGHLIGHT_BIN
+   Path to the highlight executable to use. Useful if highlight is not
+   installed on your webserver's PATH. [Default: highlight]
 
 
 Runtime gitweb configuration
@@ -236,7 +239,9 @@ not include variables usually directly set during build):
    If server load exceed this value then return "503 Service Unavailable" error.
    Server load is taken to be 0 if gitweb cannot determine its value.  Set it to
    undefined value to turn it off.  The default is 300.
-
+ * $highlight_bin
+   Path to the highlight executable to use. Useful if highlight is not
+   installed on your webserver's PATH. [Default: highlight]
 
 Projects list file format
 ~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a85e2f6..e808485 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -165,6 +165,10 @@ our @diff_opts = ('-M'); # taken from git_commit
 # the gitweb domain.
 our $prevent_xss = 0;
 
+# highlight executable to use
+# defaults to "highlight"
+our $highlight_bin = "++HIGHLIGHT_BIN++";
+
 # information about snapshot formats that gitweb is capable of serving
 our %known_snapshot_formats = (
 	# name => {
@@ -3360,7 +3364,7 @@ sub run_highlighter {
 	close $fd
 		or die_error(404, "Reading blob failed");
 	open $fd, quote_command(git_cmd(), "cat-file", "blob", $hash)." | ".
-	          "highlight --xhtml --fragment --syntax $syntax |"
+	          "$highlight_bin --xhtml --fragment --syntax $syntax |"
 		or die_error(500, "Couldn't open file or run syntax highlighter");
 	return $fd;
 }
-- 
1.7.2.3

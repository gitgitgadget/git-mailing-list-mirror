From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] gitweb: fallback to system-wide config file if default
	config does not exist
Date: Wed, 26 Mar 2008 18:11:19 +0000
Message-ID: <20080326181119.25618.qmail@065038ef0fc11c.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 19:12:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jea6A-0008VL-2L
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 19:11:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754921AbYCZSK7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 14:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754595AbYCZSK7
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 14:10:59 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:59201 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754544AbYCZSK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 14:10:58 -0400
Received: (qmail 25619 invoked by uid 1000); 26 Mar 2008 18:11:19 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78295>

>From a distribution point of view, configuration files for applications
should reside in /etc/.  On the other hand it's convenient for multiple
instances of gitweb (e.g. virtual web servers on a single machine) to have
a per-instance configuration file, just as gitweb currently supports
through the file gitweb_config.perl next to the cgi.

To support both at runtime, this commit introduces GITWEB_CONFIG_SYSTEM as
a system-wide configuration file which will be used as a fallback if the
config file sprecified throug GITWEB_CONFIG does not exist.

See also
 http://bugs.debian.org/450592

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 Makefile           |    1 +
 gitweb/INSTALL     |    6 +++++-
 gitweb/README      |    9 ++++++++-
 gitweb/gitweb.perl |    7 ++++++-
 4 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 7c70b00..a88acf6 100644
--- a/Makefile
+++ b/Makefile
@@ -189,6 +189,7 @@ ETC_GITCONFIG = $(sysconfdir)/gitconfig
 
 # default configuration for gitweb
 GITWEB_CONFIG = gitweb_config.perl
+GITWEB_CONFIG_SYSTEM = /etc/gitweb.conf
 GITWEB_HOME_LINK_STR = projects
 GITWEB_SITENAME =
 GITWEB_PROJECTROOT = /pub/git
diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index 9cd5b0a..743f2d4 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -95,7 +95,11 @@ for gitweb (in gitweb/README).
   by default it is file named gitweb_config.perl in the same place as
   gitweb.cgi script. You can control default place for config file
   using GITWEB_CONFIG build configuration variable, and you can set it
-  using GITWEB_CONFIG environmental variable.
+  using GITWEB_CONFIG environmental variable. If this file does not
+  exist, gitweb looks for a system-wide configuration file, normally
+  /etc/gitweb.conf. You can change the default using the
+  GITWEB_CONFIG_SYSTEM build configuration variable, and override it
+  through GITWEB_CONFIG_SYSTEM environmental variable.
 
 - Gitweb config file is [fragment] of perl code. You can set variables
   using "our $variable = value"; text from "#" character until the end
diff --git a/gitweb/README b/gitweb/README
index 2163071..8dfe335 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -100,13 +100,20 @@ You can specify the following configuration variables when building GIT:
    is set when gitweb.cgi is executed, then the file specified in the
    environment variable will be loaded instead of the file specified
    when gitweb.cgi was created.  [Default: gitweb_config.perl]
+ * GITWEB_CONFIG_SYSTEM
+   This Perl file will be loaded using 'do' as a fallback if GITWEB_CONFIG
+   does not exist.  If the environment variable GITWEB_CONFIG_SYSTEM is set
+   when gitweb.cgi is executed, then the file specified in the environment
+   variable will be loaded instead of the file specified when gitweb.cgi was
+   created.  [Default: /etc/gitweb.conf]
 
 
 Runtime gitweb configuration
 ----------------------------
 
 You can adjust gitweb behaviour using the file specified in `GITWEB_CONFIG`
-(defaults to 'gitweb_config.perl' in the same directory as the CGI).
+(defaults to 'gitweb_config.perl' in the same directory as the CGI), and
+as a fallback `GITWEB_CONFIG_SYSTEM` (defaults to /etc/gitweb.conf).
 The most notable thing that is not configurable at compile time are the
 optional features, stored in the '%features' variable.
 
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ec73cb1..f73cfca 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -369,7 +369,12 @@ sub filter_snapshot_fmts {
 }
 
 our $GITWEB_CONFIG = $ENV{'GITWEB_CONFIG'} || "++GITWEB_CONFIG++";
-do $GITWEB_CONFIG if -e $GITWEB_CONFIG;
+if (-e $GITWEB_CONFIG) {
+	do $GITWEB_CONFIG;
+} else {
+	our $GITWEB_CONFIG_SYSTEM = $ENV{'GITWEB_CONFIG_SYSTEM'} || "++GITWEB_CONFIG_SYSTEM++";
+	do $GITWEB_CONFIG_SYSTEM if -e $GITWEB_CONFIG_SYSTEM;
+}
 
 # version of the core git binary
 our $git_version = qx($GIT --version) =~ m/git version (.*)$/ ? $1 : "unknown";
-- 
1.5.4.4

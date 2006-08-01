From: Matthias Lederhofer <matled@gmx.net>
Subject: [RFC/PATCH] gitweb: include perl files for configuration
Date: Tue, 1 Aug 2006 15:53:42 +0200
Message-ID: <E1G7ugo-0001Ym-7r@moooo.ath.cx>
References: <200607292239.11034.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Aug 01 15:54:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7ugy-0005SV-QU
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 15:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609AbWHANxt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 09:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751611AbWHANxt
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 09:53:49 -0400
Received: from moooo.ath.cx ([85.116.203.178]:35040 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1751607AbWHANxt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Aug 2006 09:53:49 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200607292239.11034.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24598>

gitweb will first include all files after __DATA__ and then
$GITWEB_CONFIG

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
I really hate upgrading gitweb because every time I've to copy the
configuration part from the old script to the new one.  I do some
regexp to find the values for some configuration values so I'd prefer
to include a perl file instead of a normal configuration file.

For example I'd use this with this patch:

$GIT = "/usr/local/bin/git";
$stylesheet = "/gitweb.css";
if ($ENV{'SCRIPT_NAME'} =~ m#^/([a-z0-9-]+)/#) {
    $projectroot = "/home/$1";
    $home_text =   $projectroot."/gitweb.html";
    $projects_list = $projectroot."/gitweb.list";
} else {
    $projectroot = "/home";
    $home_text = "/www/gitweb.html";
    $projects_list = "/www/gitweb.list";
}

In this setup there is one subdirectory per-user which contains a
symlink to ../gitweb.cgi allowing them to maintain their own gitweb.

Later (see gitweb.pl post) the Makefile could also add the path to the
configuration file automatically if a certain variable is set (by
appending the filename to gitweb.cgi).

Using __DATA__ instead of a variable holding the filename allows to
add the configuration file easily without editing the file in an
editor or trying to replace some part (without breaking something)
using sed.

This patch is on top of my last patch (user configuration cleanup).
---
 gitweb/gitweb.cgi |   35 ++++++++++++++++++++++++++++++++---
 1 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index ca2ef70..96f8852 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -23,6 +23,12 @@ ##
 ## BEGIN USER CONFIGURATION
 ##
 
+# You can let gitweb 'do' (perldoc -f do) configuration files after this
+# configuration section to override the values.  The configuration files
+# will be executed in this order:
+# - files after __DATA__ (first file first)
+# - file in the $GITWEB_CONFIG environment variable
+
 # absolute fs-path which will be prepended to the project path
 our $projectroot = "/pub/git";
 
@@ -67,10 +73,31 @@ ##
 ## END USER CONFIGURATION
 ##
 
-# version of the core git binary
-our $git_version = qx($GIT --version) =~ m/git version (.*)$/ ? $1 : "unknown";
-
 our $version = "267";
+# die_error uses this, circumvents some warnings
+our $git_version = 'unknown';
+
+# 'do' configuration files
+for my $file (<DATA>, $ENV{'GITWEB_CONFIG'}) {
+	next if (!defined($file));
+	$file =~ s/\r?\n$//;
+	if (! -e $file) {
+		warn("configuration file '$file' does not exist");
+		die_error('500 Internal Server Error', 'Configuration error');
+	}
+	undef $@;
+	undef $!;
+	next if (defined(do($file)));
+	if ($@) {
+		warn("parse error in configuration file '$file': $@");
+	} else {
+		warn("error in configuration file '$file': $!");
+	}
+	die_error('500 Internal Server Error', 'Configuration error');
+}
+
+# version of the core git binary
+$git_version = qx($GIT --version) =~ m/git version (.*)$/ ? $1 : "unknown";
 
 # create temp directory
 if (! -d $git_temp) {
@@ -2608,3 +2635,5 @@ sub git_opml {
 	      "</body>\n".
 	      "</opml>\n";
 }
+
+__DATA__
-- 
1.4.2.rc2.g4713

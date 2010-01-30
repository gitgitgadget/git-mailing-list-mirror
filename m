From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/8 v6] gitweb: Load checking
Date: Sat, 30 Jan 2010 23:30:39 +0100
Message-ID: <1264890645-28310-3-git-send-email-jnareb@gmail.com>
References: <1264890645-28310-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 30 23:31:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbLqm-0008Ua-57
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 23:31:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754356Ab0A3WbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 17:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754189Ab0A3WbG
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 17:31:06 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:61073 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753886Ab0A3WbE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 17:31:04 -0500
Received: by fxm20 with SMTP id 20so3058017fxm.21
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 14:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=OqWDnlzzJr0LC/BY4xyL8MpB2Ghkby0rmvu5Gt9kc5g=;
        b=avhK9VeINnFyBTEfe1/3IGcO7XVC6KYJhcubkAmbNGRfawWFpmlJyc4f3Y6ibisfIp
         F3UGx633lagiMVu1cJw9rhpZ4+nI5U3d+8jshcCozFPut8KCobVoomwUKzFltX71sabI
         2UJRqMDjGXtm0tgAuJHhM5qhK3aJleNyYPI5g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hw+b2UBlpGQe2tq8jtJNQ0ss4WL61TmgBulx8By4+EgCp7dnAKaCT8LnU0Cnr1VoKB
         WeeUS6LLGj6HuTqj+Ici8z/lzARhhqdapnX7iguwOw1Cm5qbTl3CZIgsVGXWpdLSgyvl
         FG4D1WQVC2yxoCBQ4uJTkQ7fN2zyFNRd4G8k8=
Received: by 10.223.17.70 with SMTP id r6mr359413faa.22.1264890661345;
        Sat, 30 Jan 2010 14:31:01 -0800 (PST)
Received: from localhost.localdomain (abwu191.neoplus.adsl.tpnet.pl [83.8.244.191])
        by mx.google.com with ESMTPS id 15sm1157284fxm.6.2010.01.30.14.30.58
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 30 Jan 2010 14:30:59 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1264890645-28310-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138511>

From: John 'Warthog9' Hawley <warthog9@kernel.org>

This changes slightly the behavior of gitweb, so that it verifies
that the box isn't inundated with before attempting to serve gitweb.
If the box is overloaded, it basically returns a 503 Server Unavailable
until the load falls below the defined threshold.  This helps dramatically
if you have a box that's I/O bound, reaches a certain load and you
don't want gitweb, the I/O hog that it is, increasing the pain the
server is already undergoing.

This behavior is controlled by $maxload configuration variable.
Default is a load of 300, which for most cases should never be hit.
Unset it (set it to undefined value, i.e. undef) to turn off checking.

Currently it requires that '/proc/loadavg' file exists, otherwise the
load check is bypassed (load is taken to be 0).  So platforms that do
not implement '/proc/loadavg' currently cannot use this feature
(provisions are included for additional checks to be added by others).

There is simple test in t/t9501-gitweb-standalone-http-status.sh to
check that it correctly returns "503 Service Unavailable" if load is
too high, and also if there are any Perl warnings or errors.

Signed-off-by: John 'Warthog9' Hawley <warthog9@kernel.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Changes from version from 'Gitweb caching v5' and
  git://git.kernel.org/pub/scm/git/warthog9/gitweb.git gitweb-ml-v5

* Load checking was moved after setting $git_version, as this variable
  is used in git_header_html, which in turn is used in die_error.  
  Otherwise we would get "Use of unitialized value" warning.

* In git_footer_html we check if $action is defined before comparing
  it with 'blame_incremental'.  This is first time that git_footer_html
  can be called (via die_error) with $action undefined; earlier all calls
  to git_footer_html were after dispatch, which set $action to appropriate
  default value if it was not set (actionless gitweb URL, e.g. projects
  list or project summary).  Otherise we would get "Use of unitialized
  value" warning.

* t/gitweb-lib.sh turns off load checking, just in case.

* There was added test for this feature to t9501, for the simplest case
  of $maxload set to 0.


 gitweb/README                            |    7 ++++-
 gitweb/gitweb.perl                       |   48 ++++++++++++++++++++++++++---
 t/gitweb-lib.sh                          |    1 +
 t/t9501-gitweb-standalone-http-status.sh |   22 +++++++++++++
 4 files changed, 72 insertions(+), 6 deletions(-)
 mode change 100644 => 100755 t/gitweb-lib.sh

diff --git a/gitweb/README b/gitweb/README
index e34ee79..6c2c8e1 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -174,7 +174,7 @@ not include variables usually directly set during build):
    Base URL for relative URLs in pages generated by gitweb,
    (e.g. $logo, $favicon, @stylesheets if they are relative URLs),
    needed and used only for URLs with nonempty PATH_INFO via
-   <base href="$base_url>.  Usually gitweb sets its value correctly,
+   <base href="$base_url">.  Usually gitweb sets its value correctly,
    and there is no need to set this variable, e.g. to $my_uri or "/".
  * $home_link
    Target of the home link on top of all pages (the first part of view
@@ -228,6 +228,11 @@ not include variables usually directly set during build):
    repositories from launching cross-site scripting (XSS) attacks.  Set this
    to true if you don't trust the content of your repositories. The default
    is false.
+ * $maxload
+   Used to set the maximum load that we will still respond to gitweb queries.
+   If server load exceed this value then return "503 Service Unavaliable" error.
+   Server load is taken to be 0 if gitweb cannot determine its value.  Set it to
+   undefined value to turn it off.  The default is 300.
 
 
 Projects list file format
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7e477af..e2522cc 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -221,6 +221,12 @@ our %avatar_size = (
 	'double'  => 32
 );
 
+# Used to set the maximum load that we will still respond to gitweb queries.
+# If server load exceed this value then return "503 server busy" error.
+# If gitweb cannot determined server load, it is taken to be 0.
+# Leave it undefined (or set to 'undef') to turn off load checking.
+our $maxload = 300;
+
 # You define site-wide feature defaults here; override them with
 # $GITWEB_CONFIG as necessary.
 our %feature = (
@@ -551,12 +557,38 @@ if (-e $GITWEB_CONFIG) {
 	do $GITWEB_CONFIG_SYSTEM if -e $GITWEB_CONFIG_SYSTEM;
 }
 
+# Get loadavg of system, to compare against $maxload.
+# Currently it requires '/proc/loadavg' present to get loadavg;
+# if it is not present it returns 0, which means no load checking.
+sub get_loadavg {
+	if( -e '/proc/loadavg' ){
+		open my $fd, '<', '/proc/loadavg'
+			or return 0;
+		my @load = split(/\s+/, scalar <$fd>);
+		close $fd;
+
+		# The first three columns measure CPU and IO utilization of the last one,
+		# five, and 10 minute periods.  The fourth column shows the number of
+		# currently running processes and the total number of processes in the m/n
+		# format.  The last column displays the last process ID used.
+		return $load[0] || 0;
+	}
+	# additional checks for load average should go here for things that don't export
+	# /proc/loadavg
+
+	return 0;
+}
+
 # version of the core git binary
 our $git_version = qx("$GIT" --version) =~ m/git version (.*)$/ ? $1 : "unknown";
 $number_of_git_cmds++;
 
 $projects_list ||= $projectroot;
 
+if (defined $maxload && get_loadavg() > $maxload) {
+	die_error(503, "The load average on the server is too high");
+}
+
 # ======================================================================
 # input validation and dispatch
 
@@ -3328,7 +3360,8 @@ sub git_footer_html {
 	}
 
 	print qq!<script type="text/javascript" src="$javascript"></script>\n!;
-	if ($action eq 'blame_incremental') {
+	if (defined $action &&
+	    $action eq 'blame_incremental') {
 		print qq!<script type="text/javascript">\n!.
 		      qq!startBlame("!. href(action=>"blame_data", -replay=>1) .qq!",\n!.
 		      qq!           "!. href() .qq!");\n!.
@@ -3354,14 +3387,19 @@ sub git_footer_html {
 # 500: The server isn't configured properly, or
 #      an internal error occurred (e.g. failed assertions caused by bugs), or
 #      an unknown error occurred (e.g. the git binary died unexpectedly).
+# 503: The server is currently unavailable (because it is overloaded,
+#      or down for maintenance).  Generally, this is a temporary state.
 sub die_error {
 	my $status = shift || 500;
 	my $error = shift || "Internal server error";
 
-	my %http_responses = (400 => '400 Bad Request',
-			      403 => '403 Forbidden',
-			      404 => '404 Not Found',
-			      500 => '500 Internal Server Error');
+	my %http_responses = (
+		400 => '400 Bad Request',
+		403 => '403 Forbidden',
+		404 => '404 Not Found',
+		500 => '500 Internal Server Error',
+		503 => '503 Service Unavailable',
+	);
 	git_header_html($http_responses{$status});
 	print <<EOF;
 <div class="page_body">
diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
old mode 100644
new mode 100755
index 76d8b7b..5a734b1
--- a/t/gitweb-lib.sh
+++ b/t/gitweb-lib.sh
@@ -25,6 +25,7 @@ our \$favicon = 'file:///$TEST_DIRECTORY/../gitweb/git-favicon.png';
 our \$projects_list = '';
 our \$export_ok = '';
 our \$strict_export = '';
+our \$maxload = undef;
 
 EOF
 
diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-standalone-http-status.sh
index 9e8bc01..7590f10 100755
--- a/t/t9501-gitweb-standalone-http-status.sh
+++ b/t/t9501-gitweb-standalone-http-status.sh
@@ -112,4 +112,26 @@ test_expect_success 'snapshots: bad object id' '
 test_debug 'cat gitweb.output'
 
 
+# ----------------------------------------------------------------------
+# load checking
+
+# always hit the load limit
+cat >>gitweb_config.perl <<\EOF
+our $maxload = 0;
+EOF
+
+test_expect_success 'load checking: load too high (default action)' '
+	gitweb_run "p=.git" &&
+	grep "Status: 503 Service Unavailable" gitweb.headers &&
+	grep "503 - The load average on the server is too high" gitweb.body
+'
+test_debug 'cat gitweb.log' # just in case
+test_debug 'cat gitweb.headers'
+
+# turn off load checking
+cat >>gitweb_config.perl <<\EOF
+our $maxload = undef;
+EOF
+
+
 test_done
-- 
1.6.6.1

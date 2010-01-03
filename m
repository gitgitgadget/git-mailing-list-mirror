From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv2 1/4 (resent)] gitweb: Load checking
Date: Sun,  3 Jan 2010 17:07:27 +0100
Message-ID: <1262534850-24572-2-git-send-email-jnareb@gmail.com>
References: <1262534850-24572-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 03 17:08:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRSzy-0008Jq-Ja
	for gcvg-git-2@lo.gmane.org; Sun, 03 Jan 2010 17:08:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752435Ab0ACQHo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jan 2010 11:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752164Ab0ACQHo
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jan 2010 11:07:44 -0500
Received: from mail-fx0-f225.google.com ([209.85.220.225]:49054 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776Ab0ACQHm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jan 2010 11:07:42 -0500
Received: by fxm25 with SMTP id 25so8133196fxm.21
        for <git@vger.kernel.org>; Sun, 03 Jan 2010 08:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=2cEX/AGG5/D7aeQlL8+EwYM1TP+CDf1G1NR5q8cXGhA=;
        b=s6AvaLC7F1lC1/R/KMd0uLH3lU0ZMmyHKNGqh9e9xS8j8lRYT/wAufJVa7BkUUJe1z
         SOHHD6S+RMzVvgdPbRpJ4gF5UYlOATmoYo5HSDkfZjfFjMsu0NovGKQYy0FsRN7SzcBM
         FwiWFSsILsdchgI9mnTGxdwOb/QkoOX8P9GeM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kRb5+pVPYBCJRYZdIdGuw2VLON41NdqfW5GynX24bT9aA8TtONIOE24CKzOH3pSHfv
         lbKfu6dpSYql3UJKvAu9GjdZ2C4pdPzdEOUCvyW6/uY+aTs3mju+pl8qwDulG+682CpE
         xJ3rz/UXAjDz7QZma2UfY0Bd1sr8vZjrSJ9Tw=
Received: by 10.102.169.17 with SMTP id r17mr817626mue.123.1262534860776;
        Sun, 03 Jan 2010 08:07:40 -0800 (PST)
Received: from localhost.localdomain (abvk210.neoplus.adsl.tpnet.pl [83.8.208.210])
        by mx.google.com with ESMTPS id g1sm1607328muf.14.2010.01.03.08.07.38
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Jan 2010 08:07:40 -0800 (PST)
X-Mailer: git-send-email 1.6.5.3
In-Reply-To: <1262534850-24572-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136079>

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
not implement '/proc/loadavg' currently cannot use this feature.

Signed-off-by: John 'Warthog9' Hawley <warthog9@kernel.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Originally appeared in
  http://permalink.gmane.org/gmane.comp.version-control.git/135418

Differences to original version by John 'Warthog9' Hawley (J.H.):
* Slightly improved wording in commit message and in comments
* $maxload is described in "Gitweb config file variables section 
  in gitweb/README 
* You can use '$maxload = undef;' to turn off load checking
* Error page for too high load is generated using die_error, which had
  to be extended to handle 503 Service Unavailable HTTP error code

One complaints that didn't get addressed was describing alternate
approaches to just reading '/proc/loadavg', like using BSD::getloadavg
module from CPAN, either in comments in gitweb.perl or in commit
message.  But I have changed my mind since then about this issue,
and now I think it is not strictly necessary.  I think that
limitations of current approach are described in sufficient detail,
and we have fall back for when used method cannot work.

 gitweb/README      |    7 ++++++-
 gitweb/gitweb.perl |   39 +++++++++++++++++++++++++++++++++++----
 2 files changed, 41 insertions(+), 5 deletions(-)

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
+   If server load exceed this value then return "503 Service Unavailable" error.
+   Server load is taken to be 0 if gitweb cannot determine its value.  Set it to
+   undefined value to turn it off.  The default is 300.
 
 
 Projects list file format
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7e477af..3222131 100755
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
@@ -551,6 +557,26 @@ if (-e $GITWEB_CONFIG) {
 	do $GITWEB_CONFIG_SYSTEM if -e $GITWEB_CONFIG_SYSTEM;
 }
 
+# Get loadavg of system, to compare against $maxload.
+# Currently it requires '/proc/loadavg' present to get loadavg;
+# if it is not present it returns 0, which means no load checking.
+sub get_loadavg {
+	open my $fd, '<', '/proc/loadavg'
+		or return 0;
+	my @load = split(/\s+/, scalar <$fd>);
+	close $fd;
+
+	# The first three columns measure CPU and IO utilization of the last one,
+	# five, and 10 minute periods.  The fourth column shows the number of
+	# currently running processes and the total number of processes in the m/n
+	# format.  The last column displays the last process ID used.
+	return $load[0] || 0;
+}
+
+if (defined $maxload && get_loadavg() > $maxload) {
+	die_error(503, "The load average on the server is too high");
+}
+
 # version of the core git binary
 our $git_version = qx("$GIT" --version) =~ m/git version (.*)$/ ? $1 : "unknown";
 $number_of_git_cmds++;
@@ -3354,14 +3380,19 @@ sub git_footer_html {
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
-- 
1.6.5.3

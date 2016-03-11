From: Jim Klimov <jim@jimklimov.com>
Subject: [PATCH 2/6] gitweb.perl : added ability to debug requests coming
 through gitweb interface by adding an option to request URL (also requires
 server-side envvar "GITWEB_MAY_DEBUG=yes")
Date: Fri, 11 Mar 2016 14:24:45 +0100
Message-ID: <1457702689-9084-2-git-send-email-jim@jimklimov.com>
References: <1457702689-9084-1-git-send-email-jim@jimklimov.com>
Content-Transfer-Encoding: 7BIT
Cc: Jim Klimov <jim@jimklimov.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 11 14:30:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeN9D-0000m4-D2
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 14:30:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753057AbcCKNa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 08:30:28 -0500
Received: from relay-mta.cos.ru ([93.175.31.8]:43370 "EHLO relay-mta.cos.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753038AbcCKNa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 08:30:26 -0500
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Mar 2016 08:30:25 EST
Received: from sunmail.cos.ru (mail.cos.ru [81.5.113.73])
	by relay-mta.cos.ru (8.14.3+Sun/8.14.3) with ESMTP id u2BDOxJl025365
	for <git@vger.kernel.org>; Fri, 11 Mar 2016 16:25:06 +0300 (MSK)
Received: from debian8.roz.lab.etn.com. ([31.7.243.238])
 by sunmail.cos.ru (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26
 2008; 64bit)) with ESMTPA id <0O3V0013IMPRKC00@sunmail.cos.ru> for
 git@vger.kernel.org; Fri, 11 Mar 2016 16:27:34 +0300 (MSK)
X-Mailer: git-send-email 2.8.0.rc1.4.ge2bf47e.dirty
In-reply-to: <1457702689-9084-1-git-send-email-jim@jimklimov.com>
X-Greylist-Inspected: inspected by milter-greylist-4.5.12-COS (relay-mta.cos.ru [93.175.31.8]); Fri, 11 Mar 2016 16:25:06 +0300 (MSK) for IP:'81.5.113.73' DOMAIN:'mail.cos.ru' HELO:'sunmail.cos.ru' FROM:'jim@jimklimov.com'
X-Greylist: Sender IP whitelisted, ACL 386 matched, not delayed by milter-greylist-4.5.12-COS (relay-mta.cos.ru [93.175.31.8]); Fri, 11 Mar 2016 16:25:06 +0300 (MSK)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288679>

---
 gitweb/gitweb.perl | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 030d429..c715472 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -74,6 +74,11 @@ sub evaluate_uri {
 	our $home_link = $my_uri || "/";
 }
 
+# Request parameters
+our ($action, $project, $DEBUG, $file_name, $file_parent, $hash, $hash_parent, $hash_base,
+     $hash_parent_base, @extra_options, $page, $searchtype, $search_use_regexp,
+     $searchtext, $search_regexp, $project_filter);
+
 # core git executable to use
 # this can just be "git" if your webserver has a sensible PATH
 our $GIT = "++GIT_BINDIR++/git";
@@ -803,6 +808,7 @@ our %input_params = ();
 our @cgi_param_mapping = (
 	project => "p",
 	action => "a",
+	debug => "debug",
 	file_name => "f",
 	file_parent => "fp",
 	hash => "h",
@@ -1033,9 +1039,6 @@ sub evaluate_path_info {
 	}
 }
 
-our ($action, $project, $file_name, $file_parent, $hash, $hash_parent, $hash_base,
-     $hash_parent_base, @extra_options, $page, $searchtype, $search_use_regexp,
-     $searchtext, $search_regexp, $project_filter);
 sub evaluate_and_validate_params {
 	our $action = $input_params{'action'};
 	if (defined $action) {
@@ -1053,6 +1056,23 @@ sub evaluate_and_validate_params {
 		}
 	}
 
+	our $DEBUG = $input_params{'debug'};
+	if (defined $DEBUG) {
+		if ( $DEBUG =~ /^([Yy][Ee][Ss]|[Oo][Nn]|1|[Tt][Rr][Uu][Ee])$/ ) {
+			if ( defined($ENV{'GITWEB_MAY_DEBUG'}) && $ENV{'GITWEB_MAY_DEBUG'} eq "yes" ) {
+				$DEBUG = 1; #true
+			} else {
+				printf STDERR "Invalid action parameter: DEBUG=$DEBUG was requested but server-side GITWEB_MAY_DEBUG=yes is not set\n";
+				die_error(403, "Invalid action parameter: DEBUG was requested but server-side GITWEB_MAY_DEBUG=yes is not set");
+				$DEBUG = 0; #false
+			}
+		} else {
+			$DEBUG = 0; #false
+		}
+	} else {
+		$DEBUG = 0;	# false
+	}
+
 	our $project_filter = $input_params{'project_filter'};
 	if (defined $project_filter) {
 		if (!is_valid_pathname($project_filter)) {
-- 
2.1.4

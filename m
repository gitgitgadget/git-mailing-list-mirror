From: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
Subject: [PATCH 02/18] gitweb: add output buffering and associated functions
Date: Thu,  9 Dec 2010 13:57:08 -0800
Message-ID: <1291931844-28454-3-git-send-email-warthog9@eaglescrag.net>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 09 22:57:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQoUZ-0007o9-Sc
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 22:57:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184Ab0LIV46 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 16:56:58 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:51846 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757395Ab0LIVzs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 16:55:48 -0500
Received: from voot-cruiser.middle.earth (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id oB9LtePm027765
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 9 Dec 2010 13:55:47 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Thu, 09 Dec 2010 13:55:47 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163349>

This adds output buffering for gitweb, mainly in preparation for
caching support.  This is a dramatic change to how caching was being
done, mainly in passing around the variable manually and such.

This centrally flips the entire STDOUT to a variable, which after the
completion of the run, flips it back and does a print on the resulting
data.

This should save on the previous 10K line patch (or so) that adds more
explicit output passing.

[jn: modified reset_output to silence 'gitweb.perl: Name "main::STDOUT_REAL"
 used only once: possible typo at ../gitweb/gitweb.perl line 1130.' warning]

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 gitweb/gitweb.perl |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index cfa511c..cae0e34 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -39,6 +39,9 @@ BEGIN {
 
 our $version = "++GIT_VERSION++";
 
+# Output buffer variable
+our $output = "";
+
 our ($my_url, $my_uri, $base_url, $path_info, $home_link);
 sub evaluate_uri {
 	our $cgi;
@@ -1134,6 +1137,25 @@ sub evaluate_argv {
 	);
 }
 
+sub change_output {
+	our $output;
+
+	# Trap the 'proper' STDOUT to STDOUT_REAL for things like error messages and such
+	open(STDOUT_REAL,">&STDOUT") or die "Unable to capture STDOUT $!\n";
+
+	# Close STDOUT, so that it isn't being used anymore.
+	close STDOUT;
+
+	# Trap STDOUT to the $output variable, which is what I was using in the original
+	# patch anyway.
+	open(STDOUT,">", \$output) || die "Unable to open STDOUT: $!"; #open STDOUT handle to use $var
+}
+
+sub reset_output {
+	# This basically takes STDOUT_REAL and puts it back as STDOUT
+	open STDOUT, ">&", \*STDOUT_REAL;
+}
+
 sub run {
 	evaluate_argv();
 
@@ -1145,7 +1167,10 @@ sub run {
 		$pre_dispatch_hook->()
 			if $pre_dispatch_hook;
 
+		change_output();
 		run_request();
+		reset_output();
+		print $output;
 
 		$post_dispatch_hook->()
 			if $post_dispatch_hook;
@@ -3655,6 +3680,10 @@ sub die_error {
 		500 => '500 Internal Server Error',
 		503 => '503 Service Unavailable',
 	);
+	# Reset the output so that we are actually going to STDOUT as opposed
+	# to buffering the output.
+	reset_output();
+
 	git_header_html($http_responses{$status}, undef, %opts);
 	print <<EOF;
 <div class="page_body">
-- 
1.7.2.3

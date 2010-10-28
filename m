From: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
Subject: [PATCH 2/3] gitweb: add output buffering and associated functions
Date: Wed, 27 Oct 2010 17:42:53 -0700
Message-ID: <1288226574-19068-3-git-send-email-warthog9@eaglescrag.net>
References: <1288226574-19068-1-git-send-email-warthog9@eaglescrag.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.2.3"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 28 03:35:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBHOn-000372-Jl
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 03:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415Ab0J1BfS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 21:35:18 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:48194 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758062Ab0J1BfP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 21:35:15 -0400
X-Greylist: delayed 3133 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Oct 2010 21:35:15 EDT
Received: from voot-cruiser.middle.earth (173-27-0-103.client.mchsi.com [173.27.0.103])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id o9S0gucN008331
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 27 Oct 2010 17:43:04 -0700
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1288226574-19068-1-git-send-email-warthog9@eaglescrag.net>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Wed, 27 Oct 2010 17:43:05 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160148>

This is a multi-part message in MIME format.
--------------1.7.2.3
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


This adds output buffering for gitweb, mainly in preparation for
caching support.  This is a dramatic change to how caching was being
done, mainly in passing around the variable manually and such.

This centrally flips the entire STDOUT to a variable, which after the
completion of the run, flips it back and does a print on the resulting
data.

This should save on the previous 10K line patch (or so) that adds more
explicit output passing.
---
 gitweb/gitweb.perl |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)


--------------1.7.2.3
Content-Type: text/x-patch; name="0002-gitweb-add-output-buffering-and-associated-functions.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline; filename="0002-gitweb-add-output-buffering-and-associated-functions.patch"

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 215a4e9..757ef46 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -30,6 +30,9 @@ BEGIN {
 
 our $version = "++GIT_VERSION++";
 
+# Output buffer variable
+$output = "";
+
 our ($my_url, $my_uri, $base_url, $path_info, $home_link);
 sub evaluate_uri {
 	our $cgi;
@@ -1151,6 +1154,25 @@ sub evaluate_argv {
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
+	# This basically takes STDOUT_REAL and puts it back as STDOUTl
+	open(STDOUT,">&STDOUT_REAL");
+}
+
 sub run {
 	evaluate_argv();
 	evaluate_git_version();
@@ -1163,7 +1185,10 @@ sub run {
 		$pre_dispatch_hook->()
 			if $pre_dispatch_hook;
 
+		change_output();
 		run_request();
+		reset_output();
+		print $output;
 
 		$post_dispatch_hook->()
 			if $post_dispatch_hook;
@@ -3673,6 +3698,10 @@ sub die_error {
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

--------------1.7.2.3--

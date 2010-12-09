From: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
Subject: [PATCH 16/18] gitweb: When changing output (STDOUT) change STDERR as well
Date: Thu,  9 Dec 2010 13:57:22 -0800
Message-ID: <1291931844-28454-17-git-send-email-warthog9@eaglescrag.net>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 09 22:56:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQoTh-0007Gf-CJ
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 22:56:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757487Ab0LIV4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 16:56:13 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:51869 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757196Ab0LIV4F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 16:56:05 -0500
Received: from voot-cruiser.middle.earth (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id oB9LteQ2027765
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 9 Dec 2010 13:56:03 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Thu, 09 Dec 2010 13:56:04 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163340>

This sets up a trap for STDERR as well as STDOUT.  This should
prevent any transient error messages from git itself percolating
up to gitweb and outputting errant information before the HTTP
header has been sent.

Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
---
 gitweb/gitweb.perl  |   22 +++++++++++++++++++++-
 gitweb/lib/cache.pl |   22 ----------------------
 2 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7f8292e..d39982a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1214,6 +1214,10 @@ sub evaluate_argv {
 sub change_output {
 	our $output;
 
+	#
+	# STDOUT
+	#
+
 	# Trap the 'proper' STDOUT to STDOUT_REAL for things like error messages and such
 	open(STDOUT_REAL,">&STDOUT") or die "Unable to capture STDOUT $!\n";
 	print STDOUT_REAL "";
@@ -1223,12 +1227,28 @@ sub change_output {
 
 	# Trap STDOUT to the $output variable, which is what I was using in the original
 	# patch anyway.
-	open(STDOUT,">", \$output) || die "Unable to open STDOUT: $!"; #open STDOUT handle to use $var
+	open(STDOUT,">", \$output) || die "Unable to open STDOUT: $!"; #open STDOUT handle to use $output
+
+	#
+	# STDERR
+	#
+
+	# Trap the 'proper' STDOUT to STDOUT_REAL for things like error messages and such
+	open(STDERR_REAL,">&STDERR") or die "Unable to capture STDERR $!\n";
+	print STDERR_REAL "";
+
+	# Close STDOUT, so that it isn't being used anymore.
+	close STDERR;
+
+	# Trap STDOUT to the $output variable, which is what I was using in the original
+	# patch anyway.
+	open(STDERR,">", \$output_err) || die "Unable to open STDERR: $!"; #open STDERR handle to use $output_err
 }
 
 sub reset_output {
 	# This basically takes STDOUT_REAL and puts it back as STDOUT
 	open(STDOUT,">&STDOUT_REAL");
+	open(STDERR,">&STDERR_REAL");
 }
 
 sub run {
diff --git a/gitweb/lib/cache.pl b/gitweb/lib/cache.pl
index 28e4240..a8c902d 100644
--- a/gitweb/lib/cache.pl
+++ b/gitweb/lib/cache.pl
@@ -380,28 +380,6 @@ EOF
 	return;
 }
 
-sub cacheDisplayErr {
-
-	return if ( ! -e "$fullhashpath.err" );
-
-	open($cacheFileErr, '<:utf8', "$fullhashpath.err");
-	$lockStatus = flock($cacheFileErr,LOCK_SH|LOCK_NB);
-
-	if (! $lockStatus ){
-		show_warning(
-				"<p>".
-				"<strong>*** Warning ***:</strong> Locking error when trying to lock error cache page, file $fullhashpath.err<br/>/\n".
-				"This is about as screwed up as it gets folks - see your systems administrator for more help with this.".
-				"<p>"
-				);
-	}
-
-	while( <$cacheFileErr> ){
-		print $_;
-	}
-	exit(0);
-}
-
 sub cacheDisplay {
 	local $/ = undef;
 	$|++;
-- 
1.7.2.3

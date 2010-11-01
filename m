From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv7.1 2/4] gitweb: add output buffering and associated functions
Date: Mon,  1 Nov 2010 11:24:50 +0100
Message-ID: <1288607092-31458-3-git-send-email-jnareb@gmail.com>
References: <201010311021.55917.jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 01 11:25:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCrZx-0005lL-Uf
	for gcvg-git-2@lo.gmane.org; Mon, 01 Nov 2010 11:25:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752582Ab0KAKZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Nov 2010 06:25:25 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:46286 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757123Ab0KAKZS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Nov 2010 06:25:18 -0400
Received: by eye27 with SMTP id 27so3018422eye.19
        for <git@vger.kernel.org>; Mon, 01 Nov 2010 03:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=UXcca5nqHDYUNscXk3OdbvprlV4lD/fHxGNk6VQgqx8=;
        b=JLXRBK6UXGCImku0uojcmd+9WjwbiH0JLDES4sh9dOVYrbGycq1jmRDyseJOy0ytKa
         V1rp/dEE/otn+G+YJK2hX7M5FMSWmbUgvF6Fv+3fkU73juCLIU2yckcNdQI2zlFGxui5
         A2TegNDIL2aYRS/EcDzw7+hGFiR4HzRJW8tAk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tYbHC6CY2ymculdlNUv1XiVWr7gbv11jOGWPyWS+X3KegLrZr2GJrZ9ZpNLB0wp4yd
         67pBuS33GoMD9BGOcpBCQXtnBPK7XxtQUshItgs5eMqnJKJcsuF6gA3C0NNquNDDVLFF
         itCqf3MqJ932GJ2n9rkIUziG1EFUjxFYqXSMU=
Received: by 10.14.48.74 with SMTP id u50mr5453169eeb.49.1288607117220;
        Mon, 01 Nov 2010 03:25:17 -0700 (PDT)
Received: from roke.localdomain (abvk31.neoplus.adsl.tpnet.pl [83.8.208.31])
        by mx.google.com with ESMTPS id x54sm4069255eeh.11.2010.11.01.03.25.15
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 01 Nov 2010 03:25:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <201010311021.55917.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160475>

From: John 'Warthog9' Hawley <warthog9@eaglescrag.net>

This adds output buffering for gitweb, mainly in preparation for
caching support.  This is a dramatic change to how caching was being
done, mainly in passing around the variable manually and such.

This centrally flips the entire STDOUT to a variable, which after the
completion of the run, flips it back and does a print on the resulting
data.

This should save on the previous 10K line patch (or so) that adds more
explicit output passing.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Commit message unchanged.

I have modified reset_output to silence the following warning from t9500:

  gitweb.perl: Name "main::STDOUT_REAL" used only once: possible typo
  at ../gitweb/gitweb.perl line 1130.

Here is the interdiff for gitweb.perl from 2e5c355 (J.H. patch in 'pu'):

  diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
  index b2b0a23..91e274f 100755
  --- a/gitweb/gitweb.perl
  +++ b/gitweb/gitweb.perl
  @@ -32,7 +39,7 @@ BEGIN {
   our $version = "++GIT_VERSION++";
   
   # Output buffer variable
  -$output = "";
  +our $output = "";
   
   our ($my_url, $my_uri, $base_url, $path_info, $home_link);
   sub evaluate_uri {
  @@ -1143,13 +1138,12 @@ sub change_output {
   }
   
   sub reset_output {
  -	# This basically takes STDOUT_REAL and puts it back as STDOUTl
  -	open(STDOUT,">&STDOUT_REAL");
  +	# This basically takes STDOUT_REAL and puts it back as STDOUT
  +	open STDOUT, ">&", \*STDOUT_REAL;
   }
   

 gitweb/gitweb.perl |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e4c08ba..91e274f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -38,6 +38,9 @@ BEGIN {
 
 our $version = "++GIT_VERSION++";
 
+# Output buffer variable
+our $output = "";
+
 our ($my_url, $my_uri, $base_url, $path_info, $home_link);
 sub evaluate_uri {
 	our $cgi;
@@ -1120,6 +1123,25 @@ sub evaluate_argv {
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
 
@@ -1131,7 +1153,10 @@ sub run {
 		$pre_dispatch_hook->()
 			if $pre_dispatch_hook;
 
+		change_output();
 		run_request();
+		reset_output();
+		print $output;
 
 		$post_dispatch_hook->()
 			if $post_dispatch_hook;
@@ -3640,6 +3665,10 @@ sub die_error {
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
1.7.3

From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv7.4 2/4] gitweb: add output buffering and associated functions
Date: Fri,  3 Dec 2010 20:25:33 +0100
Message-ID: <1291404335-25541-3-git-send-email-jnareb@gmail.com>
References: <1291404335-25541-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 03 20:26:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PObH4-0002Rm-D6
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 20:26:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752178Ab0LCT0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 14:26:07 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59210 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689Ab0LCT0E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 14:26:04 -0500
Received: by mail-bw0-f46.google.com with SMTP id 15so8656191bwz.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 11:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=5E5uSOl+xNOfaH6ZbW5J0YZX1Wqj9KG1j8JGN6yfYTo=;
        b=tpQfeOJFTc7T0tj8LAjGPUA1UvP1Khn/kY1ZKMRU7hJLMCMVpKwMWRr6K74WdN1rgV
         cDoz0MWJBrT5IIU3UuieuuYtCV7zLHptGhV0/lQTGsiwcde1xhPtl0a1+Q1ZLdhk+5Q7
         7Dh89oySh/OMaKj2XBugNf7U36AwGjdViEFcc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pVzAisHBRO+8I1HQaFUh8IsuF9B+3Dp1Mmo47Rbb1HIsgRHZNalrywgJyOokATPHxi
         CRwBehMZiNN7x4UzzEyrNZ/EhqZGde8mDG2y4im/mIkAFIxLt2Q7jgJ1VQ0pBbIbYkW9
         0F1RMuwMZ6+zIp6w6IYWRv8QYsxsCVGd82XeI=
Received: by 10.204.114.77 with SMTP id d13mr3033627bkq.150.1291404361249;
        Fri, 03 Dec 2010 11:26:01 -0800 (PST)
Received: from localhost.localdomain (abrz239.neoplus.adsl.tpnet.pl [83.8.119.239])
        by mx.google.com with ESMTPS id b17sm1064634bku.8.2010.12.03.11.25.59
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 03 Dec 2010 11:26:00 -0800 (PST)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1291404335-25541-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162831>

From: John 'Warthog9' Hawley <warthog9@eaglescrag.net>

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
Reminder: it uses

  open STDOUT, ">&", \*STDOUT_REAL;

rather than

  open(STDOUT,">&STDOUT_REAL");

to silence spurious (invalid) warning

  gitweb.perl: Name "main::STDOUT_REAL" used only once: possible typo
  at ../gitweb/gitweb.perl line 1130.


This version is identical to 
  [PATCHv7.1 2/4] gitweb: add output buffering and associated functions
  Message-Id: <1288607092-31458-3-git-send-email-jnareb@gmail.com>
  http://article.gmane.org/gmane.comp.version-control.git/160475

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
1.7.3

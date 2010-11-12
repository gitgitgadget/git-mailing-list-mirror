From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv7.1 2/4] gitweb: add output buffering and associated functions
Date: Sat, 13 Nov 2010 00:44:48 +0100
Message-ID: <201011130044.49142.jnareb@gmail.com>
References: <201010311021.55917.jnareb@gmail.com> <1288607092-31458-1-git-send-email-jnareb@gmail.com> <201011130035.50229.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 13 00:45:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PH3Ij-0006G8-S8
	for gcvg-git-2@lo.gmane.org; Sat, 13 Nov 2010 00:45:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933210Ab0KLXo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 18:44:57 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43687 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932073Ab0KLXo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 18:44:56 -0500
Received: by fxm6 with SMTP id 6so596351fxm.19
        for <git@vger.kernel.org>; Fri, 12 Nov 2010 15:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=14BpibyFKBVQzFueTKP+CqQPKQ4gzThnaxuN5gYECPo=;
        b=BmHAlh50fAELleMUTYQ1NGiY5m2noVrAJE0sh466TiYNhDpJ91+Qf6wZOlc0TFp4rY
         xM0YkwWZkqGJulvwCluFuWAHEaAnJBtIecMqchPad8zdR6LR764HgsiMP/jn1FqMt6pB
         MpUx1anNnnpNt/FaXoncFeMSi2Z90qmbWGjaw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=G/tLoGKBDG5OflFFpjln/3nUxaFnWrPVGkrpROstVh5lZpoIL67MDQUXhyRemJoy2m
         Wv8qhD1ZHBiYamap6vIOoBYoXaFTr/C3vnVT3SuhX6UDEzQYnAVd9oZJ5V1sATeXakwz
         CsY78Z2xUmYfG338ea46duAJ9MmsbxUP2dusg=
Received: by 10.223.74.143 with SMTP id u15mr2056899faj.27.1289605494929;
        Fri, 12 Nov 2010 15:44:54 -0800 (PST)
Received: from [192.168.1.13] (abwe118.neoplus.adsl.tpnet.pl [83.8.228.118])
        by mx.google.com with ESMTPS id b20sm202452fab.35.2010.11.12.15.44.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Nov 2010 15:44:53 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <201011130035.50229.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161370>

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
This is unchanged from previous version.


Reminder: it uses

  open STDOUT, ">&", \*STDOUT_REAL;

rather than

  open(STDOUT,">&STDOUT_REAL");

to silence spurious (invalid) warning

  gitweb.perl: Name "main::STDOUT_REAL" used only once: possible typo
  at ../gitweb/gitweb.perl line 1130.


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

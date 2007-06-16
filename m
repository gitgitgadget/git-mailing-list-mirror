From: Alex Unleashed <unledev@gmail.com>
Subject: [PATCH] Add --skip-from-cc option to git-send-email to prevent mailing to From: and Cc: addresses in patch headers
Date: Sat, 16 Jun 2007 16:00:25 +0200
Message-ID: <11820024254060-git-send-email-unledev@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 16 15:52:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzYhE-0004DX-UW
	for gcvg-git@gmane.org; Sat, 16 Jun 2007 15:52:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531AbXFPNv7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jun 2007 09:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753205AbXFPNv7
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jun 2007 09:51:59 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:59874 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752283AbXFPNv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2007 09:51:58 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1064066ugf
        for <git@vger.kernel.org>; Sat, 16 Jun 2007 06:51:57 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:from:to:subject:date:message-id:x-mailer:from;
        b=F5gcU+0f1ajRjhq+UTkPqk0+kPekNN6XqWcIS0MjgqGiBxu2idxdwIoLUzOVXIaVgUbRqOExTnvb481gMlKUW0sDDjAzC4vA25k4Qnjz+Xh2mPyuDG73+DiTL6NT/xguu5VGIYOhMzpSNkjY2fR8s0d1/ZXH5UH3WrogsIvfFOs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:message-id:x-mailer;
        b=qC5U+ckM0rt8xKCv/T07qnKVQ3kaEmgkNFiJGQFz534J/zyF70ybYOmZmIlqFQVau1t5LbdhWIhb0n6brDVXlEDws5CyRrodNmGZmds0GwKkrEA/HpNLXa2txYxLOF7kFPgIyV6CjpcpJuRt8ktevzoihoa2pcsqkdOoWUKtLVo=
Received: by 10.66.249.16 with SMTP id w16mr3515207ugh.1182001917070;
        Sat, 16 Jun 2007 06:51:57 -0700 (PDT)
Received: from unleashed.kicks-ass.org ( [89.129.157.209])
        by mx.google.com with ESMTP id 28sm1010614ugc.2007.06.16.06.51.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Jun 2007 06:51:56 -0700 (PDT)
Received: by unleashed.kicks-ass.org (nbSMTP-1.00) for uid 1000
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	alex@unleashed.kicks-ass.org; Sat, 16 Jun 2007 16:00:26 +0200 (CEST)
X-Mailer: git-send-email 1.5.2.1
From: Alex Unleashed <unledev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50289>

This applies only to From: and Cc: lines in headers, not the body, so
that --no-signed-off-by-cc still applies for those.

Signed-off-by: Alex Unleashed <unledev@gmail.com>

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 946bd76..7c9fded 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -67,6 +67,10 @@ The --cc option must be repeated for each user you want on the cc list.
 	Make git-send-email less verbose.  One line per email should be
 	all that is output.
 
+--skip-from-cc::
+	Do not add emails found in From: or Cc: headers in patches.
+	Note that this does not apply to addresses in patch bodies.
+
 --smtp-server::
 	If set, specifies the outgoing SMTP server to use (e.g.
 	`smtp.example.com` or a raw IP address).  Alternatively it can
diff --git a/git-send-email.perl b/git-send-email.perl
index 7c0c90b..35a0e6c 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -68,6 +68,9 @@ Options:
                  that appear in Signed-off-by: or Cc: lines to the cc:
                  list.  Note: Using this option is not recommended.
 
+   --skip-from-cc Do not send email to From: and Cc: addresses from headers
+                  in patches.
+
    --smtp-server  If set, specifies the outgoing SMTP server to use.
                   Defaults to localhost.
 
@@ -139,7 +142,7 @@ my (@to,@cc,@initial_cc,@bcclist,@xh,
 
 # Behavior modification variables
 my ($chain_reply_to, $quiet, $suppress_from, $no_signed_off_cc,
-	$dry_run) = (1, 0, 0, 0, 0);
+	$skip_from_cc, $dry_run) = (1, 0, 0, 0, 0, 0);
 my $smtp_server;
 my $envelope_sender;
 
@@ -179,6 +182,7 @@ my $rc = GetOptions("from=s" => \$from,
 		    "quiet" => \$quiet,
 		    "suppress-from" => \$suppress_from,
 		    "no-signed-off-cc|no-signed-off-by-cc" => \$no_signed_off_cc,
+		    "skip-from-cc" => \$skip_from_cc,
 		    "dry-run" => \$dry_run,
 		    "envelope-sender=s" => \$envelope_sender,
 	 );
@@ -560,7 +564,7 @@ foreach my $t (@files) {
 				if (/^Subject:\s+(.*)$/) {
 					$subject = $1;
 
-				} elsif (/^(Cc|From):\s+(.*)$/) {
+				} elsif (!$skip_from_cc && /^(Cc|From):\s+(.*)$/) {
 					if (unquote_rfc2047($2) eq $from) {
 						$from = $2;
 						next if ($suppress_from);
@@ -583,7 +587,7 @@ foreach my $t (@files) {
 				# line 2 = subject
 				# So let's support that, too.
 				$input_format = 'lots';
-				if (@cc == 0) {
+				if (!$skip_from_cc && @cc == 0) {
 					printf("(non-mbox) Adding cc: %s from line '%s'\n",
 						$_, $_) unless $quiet;
 
-- 
1.5.2.1

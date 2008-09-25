From: Michael Witten <mfwitten@MIT.EDU>
Subject: [PATCH RFC 5/6] Docs: send-email: change --no-validate to boolean --[no-]validate
Date: Thu, 25 Sep 2008 15:44:35 -0500
Message-ID: <1222375476-32911-5-git-send-email-mfwitten@mit.edu>
References: <1222099095-50360-1-git-send-email-mfwitten@mit.edu>
 <1222375476-32911-1-git-send-email-mfwitten@mit.edu>
 <1222375476-32911-2-git-send-email-mfwitten@mit.edu>
 <1222375476-32911-3-git-send-email-mfwitten@mit.edu>
 <1222375476-32911-4-git-send-email-mfwitten@mit.edu>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 25 22:46:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KixjE-0007Oy-Bm
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 22:46:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753956AbYIYUpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 16:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753838AbYIYUpH
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 16:45:07 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:61353 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753164AbYIYUpF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Sep 2008 16:45:05 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m8PKirhO003931;
	Thu, 25 Sep 2008 16:44:53 -0400 (EDT)
Received: from localhost.localdomain (97-116-112-224.mpls.qwest.net [97.116.112.224])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m8PKibJc008003
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 25 Sep 2008 16:44:52 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.2.302.ge6cbd1
In-Reply-To: <1222375476-32911-4-git-send-email-mfwitten@mit.edu>
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96798>

There is also now a configuration variable:

    sendemail[.<identity>].validate

Signed-off-by: Michael Witten <mfwitten@mit.edu>
---
 Documentation/git-send-email.txt |    9 +++++++--
 git-send-email.perl              |   10 ++++++----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 6031eb7..fe53e9b 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -189,14 +189,16 @@ user is prompted for a password while the input is masked for privacy.
 	variable; if that is unspecified, choosing the envelope sender is left
 	to your MTA.
 
---no-validate::
-	Don't perform any sanity checks on patches.
+--[no-]validate::
+	Perform sanity checks on patches.
 	Currently, validation means the following:
 +
 --
 		*	Warn of patches that contain lines longer than 998 characters; this
 			is due to SMTP limits as described by http://www.ietf.org/rfc/rfc2821.txt.
 --
++
+This option can be set with sendemail[.<identity>].validate; default to --validate
 
 
 CONFIGURATION
@@ -249,6 +251,9 @@ sendemail.smtpencryption::
 sendemail.smtpssl::
 	Legacy boolean that sets 'smtpencryption=ssl' if enabled.
 
+sendemail.validate::
+    Boolean override for --[no-]validate.
+
 Author
 ------
 Written by Ryan Anderson <ryan@michonline.com>
diff --git a/git-send-email.perl b/git-send-email.perl
index b86a3f3..8bc204f 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -113,7 +113,8 @@ Options:
    --envelope-sender       Specify the envelope sender used to send the
                            emails.
 
-   --no-validate           Don't perform any sanity checks on patches.
+   --[no-]validate         Perform any sanity checks on patches.
+                           Default to on.
 
 EOT
 	exit(1);
@@ -195,7 +196,7 @@ my ($quiet, $dry_run) = (0, 0);
 my ($thread, $chain_reply_to, $suppress_from, $signed_off_cc, $cc_cmd);
 my ($smtp_server, $smtp_server_port, $smtp_authuser, $smtp_encryption);
 my ($identity, $aliasfiletype, @alias_files, @smtp_host_parts);
-my ($no_validate);
+my ($validate);
 my (@suppress_cc);
 
 my %config_bool_settings = (
@@ -203,6 +204,7 @@ my %config_bool_settings = (
     "chainreplyto" => [\$chain_reply_to, 1],
     "suppressfrom" => [\$suppress_from, undef],
     "signedoffcc" => [\$signed_off_cc, undef],
+    "validate" => [\$validate, 1],
 );
 
 my %config_settings = (
@@ -269,7 +271,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "dry-run" => \$dry_run,
 		    "envelope-sender=s" => \$envelope_sender,
 		    "thread!" => \$thread,
-		    "no-validate" => \$no_validate,
+		    "validate!" => \$validate,
 	 );
 
 unless ($rc) {
@@ -422,7 +424,7 @@ for my $f (@ARGV) {
 	}
 }
 
-if (!$no_validate) {
+if ($validate) {
 	foreach my $f (@files) {
 		unless (-p $f) {
 			my $error = validate_patch($f);
-- 
1.6.0.2.302.ge6cbd1

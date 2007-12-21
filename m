From: David Brown <git@davidb.org>
Subject: [PATCH] git-send-email: Add --suppress-all-from option.
Date: Thu, 20 Dec 2007 22:01:00 -0800
Message-ID: <1198216860-487-1-git-send-email-git@davidb.org>
Cc: David Brown <git@davidb.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 21 07:33:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5bRL-00015J-8R
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 07:32:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbXLUGcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 01:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbXLUGcf
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 01:32:35 -0500
Received: from mail.davidb.org ([66.93.32.219]:32895 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751160AbXLUGce (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 01:32:34 -0500
X-Greylist: delayed 1890 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Dec 2007 01:32:34 EST
Received: from davidb by mail.davidb.org with local (Exim 4.68 #1 (Debian))
	id 1J5awO-000085-BG; Thu, 20 Dec 2007 22:01:00 -0800
X-Mailer: git-send-email 1.5.3.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69043>

Sometimes, it is useful to be able to send a patch to a third party
without the author of the patch being copied on the message.  An
common example would be an internal discussion at a company to ask if
a particular patch should be applied.  Some environments may even have
policy against such mail being sent outside of the company.

Add the --suppress-all-from/--no-suppress-all-from options to avoid
sending patches to the patch author, even if different from the
sender.  Add the sendemail.suppressallfrom config option to allow this
to have a different default.

Signed-off-by: David Brown <git@davidb.org>
---
 Documentation/git-send-email.txt |    7 +++++++
 git-send-email.perl              |    9 ++++++++-
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index f0bd285..5d06264 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -117,6 +117,13 @@ The --cc option must be repeated for each user you want on the cc list.
         Default is the value of 'sendemail.suppressfrom' configuration value;
         if that is unspecified, default to --no-suppress-from.
 
+--suppress-all-from, --no-suppress-all-from::
+        If this is set, do not add the From: address to the cc: list,
+        even if it is different than the person sending the email.
+        Default is the value of the 'sendemail.suppressallfrom'
+        configuration value; if that is unspecified, default to
+        -no-suppress-all-from.
+
 --thread, --no-thread::
 	If this is set, the In-Reply-To header will be set on each email sent.
 	If disabled with "--no-thread", no emails will have the In-Reply-To
diff --git a/git-send-email.perl b/git-send-email.perl
index 248d035..80265b5 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -90,6 +90,9 @@ Options:
 
    --suppress-from Suppress sending emails to yourself. Defaults to off.
 
+   --suppress-all-from Never automatically send to a patch author.
+                  Defaults to off.
+
    --thread       Specify that the "In-Reply-To:" header should be set on all
                   emails. Defaults to on.
 
@@ -174,7 +177,8 @@ if ($@) {
 my ($quiet, $dry_run) = (0, 0);
 
 # Variables with corresponding config settings
-my ($thread, $chain_reply_to, $suppress_from, $signed_off_cc, $cc_cmd);
+my ($thread, $chain_reply_to, $suppress_from, $suppress_all_from);
+my ($signed_off_cc, $cc_cmd);
 my ($smtp_server, $smtp_server_port, $smtp_authuser, $smtp_authpass, $smtp_ssl);
 my ($identity, $aliasfiletype, @alias_files, @smtp_host_parts);
 
@@ -182,6 +186,7 @@ my %config_bool_settings = (
     "thread" => [\$thread, 1],
     "chainreplyto" => [\$chain_reply_to, 1],
     "suppressfrom" => [\$suppress_from, 0],
+    "suppressallfrom" => [\$suppress_all_from, 0],
     "signedoffcc" => [\$signed_off_cc, 1],
     "smtpssl" => [\$smtp_ssl, 0],
 );
@@ -218,6 +223,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "quiet" => \$quiet,
 		    "cc-cmd=s" => \$cc_cmd,
 		    "suppress-from!" => \$suppress_from,
+		    "suppress-all-from!" => \$suppress_all_from,
 		    "signed-off-cc|signed-off-by-cc!" => \$signed_off_cc,
 		    "dry-run" => \$dry_run,
 		    "envelope-sender=s" => \$envelope_sender,
@@ -700,6 +706,7 @@ foreach my $t (@files) {
 					$subject = $1;
 
 				} elsif (/^(Cc|From):\s+(.*)$/) {
+					next if ($suppress_all_from);
 					if (unquote_rfc2047($2) eq $sender) {
 						next if ($suppress_from);
 					}
-- 
1.5.3.7

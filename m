From: Michael Witten <mfwitten@MIT.EDU>
Subject: [PATCH 4/9] send-email: change --no-validate to boolean --[no-]validate
Date: Tue, 30 Sep 2008 07:58:27 -0500
Message-ID: <1222779512-58936-4-git-send-email-mfwitten@mit.edu>
References: <20080929174445.GA6015@coredump.intra.peff.net>
 <1222779512-58936-1-git-send-email-mfwitten@mit.edu>
 <1222779512-58936-2-git-send-email-mfwitten@mit.edu>
 <1222779512-58936-3-git-send-email-mfwitten@mit.edu>
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Tue Sep 30 15:00:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkeqG-0005SS-JS
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 15:00:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752789AbYI3M7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 08:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752699AbYI3M7T
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 08:59:19 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:52378 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752446AbYI3M7S (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Sep 2008 08:59:18 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m8UCweGQ010288;
	Tue, 30 Sep 2008 08:58:40 -0400 (EDT)
Received: from localhost.localdomain (97-116-104-2.mpls.qwest.net [97.116.104.2])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m8UCwWON010491
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 30 Sep 2008 08:58:39 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.2.304.gdcf23.dirty
In-Reply-To: <1222779512-58936-3-git-send-email-mfwitten@mit.edu>
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97113>

There is also now a configuration variable:

    sendemail[.<identity>].validate

Signed-off-by: Michael Witten <mfwitten@mit.edu>
---
 Documentation/git-send-email.txt |    9 +++++++--
 git-send-email.perl              |    9 +++++----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 0c6dbf6..81970f3 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -182,14 +182,16 @@ configuration variable), then authentication is not attempted.
 +
 The --to option must be repeated for each user you want on the to list.
 
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
@@ -242,6 +244,9 @@ sendemail.smtpencryption::
 sendemail.smtpssl::
 	Legacy boolean that sets 'smtpencryption=ssl' if enabled.
 
+sendemail.validate::
+    Boolean override for --[no-]validate.
+
 Author
 ------
 Written by Ryan Anderson <ryan@michonline.com>
diff --git a/git-send-email.perl b/git-send-email.perl
index 2c31a25..3467cf1 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -65,7 +65,7 @@ Options:
    --smtp-ssl                     * Deprecated. Use '--smtp-encryption ssl'.
    --quiet                        * Output one line of info per email.
    --dry-run                      * Don't actually send the emails.
-   --no-validate                  * Don't perform sanity checks on patches.
+   --[no-]validate                * Perform patch sanity checks. Default on.
 
 EOT
 	exit(1);
@@ -147,7 +147,7 @@ my ($quiet, $dry_run) = (0, 0);
 my ($thread, $chain_reply_to, $suppress_from, $signed_off_cc, $cc_cmd);
 my ($smtp_server, $smtp_server_port, $smtp_authuser, $smtp_encryption);
 my ($identity, $aliasfiletype, @alias_files, @smtp_host_parts);
-my ($no_validate);
+my ($validate);
 my (@suppress_cc);
 
 my %config_bool_settings = (
@@ -155,6 +155,7 @@ my %config_bool_settings = (
     "chainreplyto" => [\$chain_reply_to, 1],
     "suppressfrom" => [\$suppress_from, undef],
     "signedoffcc" => [\$signed_off_cc, undef],
+    "validate" => [\$validate, 1],
 );
 
 my %config_settings = (
@@ -221,7 +222,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "dry-run" => \$dry_run,
 		    "envelope-sender=s" => \$envelope_sender,
 		    "thread!" => \$thread,
-		    "no-validate" => \$no_validate,
+		    "validate!" => \$validate,
 	 );
 
 unless ($rc) {
@@ -374,7 +375,7 @@ for my $f (@ARGV) {
 	}
 }
 
-if (!$no_validate) {
+if ($validate) {
 	foreach my $f (@files) {
 		unless (-p $f) {
 			my $error = validate_patch($f);
-- 
1.6.0.2.304.gdcf23.dirty

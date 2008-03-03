From: drafnel@gmail.com
Subject: [PATCH] git-send-email: add option to force a From: line within the message body
Date: Mon,  3 Mar 2008 00:00:43 -0600
Message-ID: <8870673.1204524015315.JavaMail.teamon@b301.teamon.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 07:11:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW3tK-0005Pq-Nx
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 07:11:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbYCCGKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 01:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbYCCGKg
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 01:10:36 -0500
Received: from mailproxy01.teamon.com ([64.85.68.137]:56135 "EHLO
	b301.teamon.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751288AbYCCGKf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 01:10:35 -0500
X-Greylist: delayed 619 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Mar 2008 01:10:35 EST
Received: from b301.teamon.com (localhost [127.0.0.1])
	by b301.teamon.com (8.11.7 DSN_MOD/8.11.7) with ESMTP id m2360FZ27596;
	Mon, 3 Mar 2008 06:00:15 GMT
X-Mailer: git-send-email 1.5.4.3.473.g74d8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75886>

From: Brandon Casey <drafnel@gmail.com>

Add a new command line option --add-author-from and a config option
sendemail.addauthorfrom which will ensure that a From: line is added
to the message body regardless of whether the sender email matches the
From: line parsed from the supplied patch (i.e. the patch author).

This provides a work-around for mail gateways which override the From:
line of submitted messages.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---

I don't know if anyone else has the same problem, but I sometimes use a
mail gateway which forces a certain From: line overriding what is
supplied in the email. So, for me, the solution this patch provides could
be achieved by just typing in some bogus string when git-send-email prompts
for the From address, but this patch is more convenient and more general.

-brandon


 Documentation/git-send-email.txt |    9 +++++++++
 git-send-email.perl              |   12 ++++++++++++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 336d797..e3267de 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -157,6 +157,11 @@ user is prompted for a password while the input is masked for privacy.
 	if that is unspecified, default to 'self' if --suppress-from is
 	specified, as well as 'sob' if --no-signed-off-cc is specified.
 
+--add-author-from::
+	Add a "From:" line within the message body describing the patch
+	author even if the author is equal to the sender. Usually, a "From:"
+	line is added only when the author differs from the sender.
+
 --thread, --no-thread::
 	If this is set, the In-Reply-To header will be set on each email sent.
 	If disabled with "--no-thread", no emails will have the In-Reply-To
@@ -225,6 +230,10 @@ sendemail.smtppass::
 sendemail.smtpssl::
 	Boolean value specifying the default to the '--smtp-ssl' parameter.
 
+sendemail.addauthorfrom::
+	Boolean value specifying the default to the '--add-author-from'
+	parameter.
+
 Author
 ------
 Written by Ryan Anderson <ryan@michonline.com>
diff --git a/git-send-email.perl b/git-send-email.perl
index 29b1105..4d0aaac 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -94,6 +94,9 @@ Options:
 
    --suppress-from Suppress sending emails to yourself. Defaults to off.
 
+   --add-author-from Add "From:" line within message body for patch author
+                  even when author is equal to sender.
+
    --thread       Specify that the "In-Reply-To:" header should be set on all
                   emails. Defaults to on.
 
@@ -187,6 +190,7 @@ my ($smtp_server, $smtp_server_port, $smtp_authuser, $smtp_ssl);
 my ($identity, $aliasfiletype, @alias_files, @smtp_host_parts);
 my ($no_validate);
 my (@suppress_cc);
+my ($force_author_from);
 
 my %config_bool_settings = (
     "thread" => [\$thread, 1],
@@ -194,6 +198,7 @@ my %config_bool_settings = (
     "suppressfrom" => [\$suppress_from, undef],
     "signedoffcc" => [\$signed_off_cc, undef],
     "smtpssl" => [\$smtp_ssl, 0],
+    "addauthorfrom" => [\$force_author_from, 0],
 );
 
 my %config_settings = (
@@ -252,6 +257,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "quiet" => \$quiet,
 		    "cc-cmd=s" => \$cc_cmd,
 		    "suppress-from!" => \$suppress_from,
+		    "add-author-from!" => \$force_author_from,
 		    "suppress-cc=s" => \@suppress_cc,
 		    "signed-off-cc|signed-off-by-cc!" => \$signed_off_cc,
 		    "dry-run" => \$dry_run,
@@ -802,6 +808,12 @@ foreach my $t (@files) {
 
 				} elsif (/^(Cc|From):\s+(.*)$/) {
 					if (unquote_rfc2047($2) eq $sender) {
+						if ($force_author_from &&
+						    $1 eq 'From') {
+							($author,
+							 $author_encoding) =
+							unquote_rfc2047($2)
+						}
 						next if ($suppress_cc{'self'});
 					}
 					elsif ($1 eq 'From') {
-- 
1.5.4.3.472.gdf7d.dirty


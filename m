From: Joe Perches <joe@perches.com>
Subject: [PATCH] git-send-email.perl: Add --suppress-to
Date: Sat, 05 Feb 2011 15:40:08 -0800
Message-ID: <1296949208.4133.66.camel@Joe-Laptop>
References: <1290272809.27951.30.camel@Joe-Laptop>
	 <m2mxp3zr88.fsf@igel.home> <1290286877.31117.15.camel@Joe-Laptop>
	 <4CE84FF3.2070906@pcharlan.com> <1290294365.31117.40.camel@Joe-Laptop>
	 <7vmxowq6gz.fsf@alter.siamese.dyndns.org>
	 <1290807268.11971.310.camel@Joe-Laptop>
	 <7vk4jzpq8h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 06 00:40:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Plrjm-0003AR-Q2
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 00:40:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753946Ab1BEXkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Feb 2011 18:40:13 -0500
Received: from mail.perches.com ([173.55.12.10]:3608 "EHLO mail.perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753936Ab1BEXkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Feb 2011 18:40:09 -0500
Received: from [192.168.1.162] (unknown [192.168.1.162])
	by mail.perches.com (Postfix) with ESMTP id D888A24368;
	Sat,  5 Feb 2011 15:40:05 -0800 (PST)
In-Reply-To: <7vk4jzpq8h.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166130>

Add an equivalent command line option to suppress-cc.

Signed-off-by: Joe Perches <joe@perches.com>
---
 Documentation/git-send-email.txt |   17 +++++++++++++++++
 git-send-email.perl              |   33 +++++++++++++++++++++++++++++++--
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 7ec9dab..69e03e8 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -232,6 +232,23 @@ Automating
 	cc list. Default is the value of 'sendemail.signedoffbycc' configuration
 	value; if that is unspecified, default to --signed-off-by-cc.
 
+--suppress-to=<category>::
+	Specify an additional category of recipients to suppress the
+	auto-to of:
++
+--
+- 'author' will avoid including the patch author
+- 'self' will avoid including the sender
+- 'tocmd' will avoid running the --to-cmd
+- 'bodyto' will avoid including anyone mentioned in To lines in the
+   patch body (commit message) except for self (use 'self' for that)
+- 'all' will suppress all auto to values.
+--
++
+Default is the value of 'sendemail.suppressto' configuration value; if
+that is unspecified, default to 'self' if --suppress-from is
+specified.
+
 --suppress-cc=<category>::
 	Specify an additional category of recipients to suppress the
 	auto-cc of:
diff --git a/git-send-email.perl b/git-send-email.perl
index 76565de..0365c29 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -74,6 +74,7 @@ git send-email [options] <file | directory | rev-list options >
   Automating:
     --identity              <str>  * Use the sendemail.<id> options.
     --to-cmd                <str>  * Email To: via `<str> \$patch_path`
+    --suppress-to           <str>  * author, self, tocmd, bodyto, all.
     --cc-cmd                <str>  * Email Cc: via `<str> \$patch_path`
     --suppress-cc           <str>  * author, self, sob, cc, cccmd, body, bodycc, all.
     --[no-]signed-off-by-cc        * Send to Signed-off-by: addresses. Default on.
@@ -196,6 +197,7 @@ my ($smtp_server, $smtp_server_port, @smtp_server_options);
 my ($smtp_authuser, $smtp_encryption);
 my ($identity, $aliasfiletype, @alias_files, $smtp_domain);
 my ($validate, $confirm);
+my (@suppress_to);
 my (@suppress_cc);
 my ($auto_8bit_encoding);
 
@@ -226,6 +228,7 @@ my %config_settings = (
     "aliasfiletype" => \$aliasfiletype,
     "bcc" => \@bcclist,
     "aliasesfile" => \@alias_files,
+    "suppressto" => \@suppress_to,
     "suppresscc" => \@suppress_cc,
     "envelopesender" => \$envelope_sender,
     "multiedit" => \$multiedit,
@@ -301,6 +304,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "quiet" => \$quiet,
 		    "cc-cmd=s" => \$cc_cmd,
 		    "suppress-from!" => \$suppress_from,
+		    "suppress-to=s" => \@suppress_to,
 		    "suppress-cc=s" => \@suppress_cc,
 		    "signed-off-cc|signed-off-by-cc!" => \$signed_off_by_cc,
 		    "confirm=s" => \$confirm,
@@ -369,6 +373,24 @@ foreach my $setting (values %config_bool_settings) {
 # 'default' encryption is none -- this only prevents a warning
 $smtp_encryption = '' unless (defined $smtp_encryption);
 
+# Set TO suppressions
+my(%suppress_to);
+if (@suppress_to) {
+	foreach my $entry (@suppress_to) {
+		die "Unknown --suppress-to field: '$entry'\n"
+			unless $entry =~ /^(?:all|author|self|tocmd|bodyto)$/;
+		$suppress_to{$entry} = 1;
+	}
+}
+
+if ($suppress_to{'all'}) {
+	foreach my $entry (qw (author self tocmd bodyto)) {
+		$suppress_to{$entry} = 1;
+	}
+	delete $suppress_to{'all'};
+}
+$suppress_to{'self'} = $suppress_from if defined $suppress_from;
+
 # Set CC suppressions
 my(%suppress_cc);
 if (@suppress_cc) {
@@ -407,7 +429,11 @@ die "Unknown --confirm setting: '$confirm'\n"
 
 # Debugging, print out the suppressions.
 if (0) {
-	print "suppressions:\n";
+	print "To suppressions:\n";
+	foreach my $entry (keys %suppress_to) {
+		printf "  %-5s -> $suppress_to{$entry}\n", $entry;
+	}
+	print "Cc suppressions:\n";
 	foreach my $entry (keys %suppress_cc) {
 		printf "  %-5s -> $suppress_cc{$entry}\n", $entry;
 	}
@@ -1201,6 +1227,9 @@ foreach my $t (@files) {
 			}
 			elsif (/^To:\s+(.*)$/) {
 				foreach my $addr (parse_address_line($1)) {
+
+				    next if $suppress_to{'author'};
+				    next if $suppress_to{'self'} and $author eq $sender;
 					printf("(mbox) Adding to: %s from line '%s'\n",
 						$addr, $_) unless $quiet;
 					push @to, sanitize_address($addr);
@@ -1269,7 +1298,7 @@ foreach my $t (@files) {
 	close $fh;
 
 	push @to, recipients_cmd("to-cmd", "to", $to_cmd, $t)
-		if defined $to_cmd;
+		if defined $to_cmd && !$suppress_to{'tocmd'};
 	push @cc, recipients_cmd("cc-cmd", "cc", $cc_cmd, $t)
 		if defined $cc_cmd && !$suppress_cc{'cccmd'};
 

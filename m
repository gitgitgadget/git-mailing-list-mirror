From: David Brown <git@davidb.org>
Subject: [PATCH] git-send-email: Generalize auto-cc recipient mechanism.
Date: Mon, 24 Dec 2007 11:01:42 -0800
Message-ID: <1198522902-12117-1-git-send-email-git@davidb.org>
References: <1198216860-487-1-git-send-email-git@davidb.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 24 20:02:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6sZ1-0000sZ-Te
	for gcvg-git-2@gmane.org; Mon, 24 Dec 2007 20:02:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbXLXTBo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Dec 2007 14:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbXLXTBo
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Dec 2007 14:01:44 -0500
Received: from mail.davidb.org ([66.93.32.219]:53145 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750874AbXLXTBn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Dec 2007 14:01:43 -0500
Received: from davidb by mail.davidb.org with local (Exim 4.68 #1 (Debian))
	id 1J6sYY-00039l-V9
	for <git@vger.kernel.org>; Mon, 24 Dec 2007 11:01:42 -0800
X-Mailer: git-send-email 1.5.4.rc1.22.gaab91
In-Reply-To: <1198216860-487-1-git-send-email-git@davidb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69220>

There are a few options to git-send-email to suppress the automatic
generation of 'Cc' fields: --suppress-from, and --signed-off-cc.  However,
there are other times that git-send-email automatically includes Cc'd
recipients.  This is not desirable for all development environments.

Add a new option --suppress-cc, which can be specified one or more times to
list the categories of auto-cc fields that should be suppressed.  If not
specified, it defaults to values to give the same behavior as specified
by --suppress-from, and --signed-off-cc.  The categories are:

  self   - patch sender.  Same as --suppress-from.
  author - patch author.
  cc     - cc lines mentioned in the patch.
  cccmd  - avoid running the cccmd.
  sob    - signed off by lines.

Signed-off-by: David Brown <git@davidb.org>
---
I tried to generalize as suggested in Junio's email, but it just didn't fit
well with the decision tree in the code.

What bothers me most about this change is that --signed-of-cc
and --suppress-from are silently ignored if --suppress-cc is given, either
on the command line, or in the config.

 Documentation/git-send-email.txt |   13 +++++++++++++
 git-send-email.perl              |   34 ++++++++++++++++++++++++++++++----
 2 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index f0bd285..432f336 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -70,6 +70,7 @@ The --cc option must be repeated for each user you want on the cc list.
         cc list.
         Default is the value of 'sendemail.signedoffcc' configuration value;
         if that is unspecified, default to --signed-off-by-cc.
+        Note that this has no effect if --suppress-cc is given.
 
 --quiet::
 	Make git-send-email less verbose.  One line per email should be
@@ -116,6 +117,18 @@ The --cc option must be repeated for each user you want on the cc list.
         If this is set, do not add the From: address to the cc: list.
         Default is the value of 'sendemail.suppressfrom' configuration value;
         if that is unspecified, default to --no-suppress-from.
+        Note that this has no effect if --suppress-cc is given.
+
+--suppress-cc::
+	Specify an additional category of recipients to suppress the
+	auto-cc of.  'self' will avoid including the sender, 'author' will
+	avoid including the patch author, 'cc' will avoid including anyone
+	mentioned in Cc lines in the patch, 'sob' will avoid including
+	anyone mentioned in Signed-off-by lines, and 'cccmd' will avoid
+	running the --cc-cmd.
+	Default is the value of 'sendemail.suppresscc' configuration value;
+	if that is unspecified, default to 'self' if --suppress-from is
+	specified, as well as 'sob' if --no-signed-off-cc is specified.
 
 --thread, --no-thread::
 	If this is set, the In-Reply-To header will be set on each email sent.
diff --git a/git-send-email.perl b/git-send-email.perl
index e47994a..cb9adf2 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -88,6 +88,11 @@ Options:
 
    --smtp-ssl     If set, connects to the SMTP server using SSL.
 
+   --suppress-cc  Suppress the specified category of auto-CC.  The category
+                  can be one of 'author' for the patch author, 'self' to
+                  avoid copying yourself, 'sob' for Signed-off-by lines,
+                  and 'cccmd' for the output of the cccmd.
+
    --suppress-from Suppress sending emails to yourself. Defaults to off.
 
    --thread       Specify that the "In-Reply-To:" header should be set on all
@@ -177,6 +182,7 @@ my ($quiet, $dry_run) = (0, 0);
 my ($thread, $chain_reply_to, $suppress_from, $signed_off_cc, $cc_cmd);
 my ($smtp_server, $smtp_server_port, $smtp_authuser, $smtp_authpass, $smtp_ssl);
 my ($identity, $aliasfiletype, @alias_files, @smtp_host_parts);
+my (@suppress_cc);
 
 my %config_bool_settings = (
     "thread" => [\$thread, 1],
@@ -196,6 +202,7 @@ my %config_settings = (
     "aliasfiletype" => \$aliasfiletype,
     "bcc" => \@bcclist,
     "aliasesfile" => \@alias_files,
+    "suppresscc" => \@suppress_cc,
 );
 
 # Begin by accumulating all the variables (defined above), that we will end up
@@ -218,6 +225,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "quiet" => \$quiet,
 		    "cc-cmd=s" => \$cc_cmd,
 		    "suppress-from!" => \$suppress_from,
+		    "suppress-cc=s" => \@suppress_cc,
 		    "signed-off-cc|signed-off-by-cc!" => \$signed_off_cc,
 		    "dry-run" => \$dry_run,
 		    "envelope-sender=s" => \$envelope_sender,
@@ -262,6 +270,20 @@ foreach my $setting (values %config_bool_settings) {
 	${$setting->[0]} = $setting->[1] unless (defined (${$setting->[0]}));
 }
 
+# Set CC suppressions
+my(%suppress_cc);
+if (@suppress_cc) {
+	foreach my $entry (@suppress_cc) {
+		die "Unknown --suppress-cc field: '$entry'\n"
+			unless $entry =~ /^(cccmd|cc|author|self|sob)$/;
+		$suppress_cc{$entry} = 1;
+	}
+} else {
+	# Convert the old-style options.
+	$suppress_cc{'self'} = 1 if $suppress_from;
+	$suppress_cc{'sob'} = 1 unless $signed_off_cc;
+}
+
 my ($repoauthor) = $repo->ident_person('author');
 my ($repocommitter) = $repo->ident_person('committer');
 
@@ -701,11 +723,14 @@ foreach my $t (@files) {
 
 				} elsif (/^(Cc|From):\s+(.*)$/) {
 					if (unquote_rfc2047($2) eq $sender) {
-						next if ($suppress_from);
+						next if ($suppress_cc{'self'});
 					}
 					elsif ($1 eq 'From') {
 						($author, $author_encoding)
 						  = unquote_rfc2047($2);
+						next if ($suppress_cc{'author'});
+					} else {
+						next if ($suppress_cc{'cc'});
 					}
 					printf("(mbox) Adding cc: %s from line '%s'\n",
 						$2, $_) unless $quiet;
@@ -732,7 +757,7 @@ foreach my $t (@files) {
 				# line 2 = subject
 				# So let's support that, too.
 				$input_format = 'lots';
-				if (@cc == 0) {
+				if (@cc == 0 && !$suppress_cc{'cc'}) {
 					printf("(non-mbox) Adding cc: %s from line '%s'\n",
 						$_, $_) unless $quiet;
 
@@ -750,9 +775,10 @@ foreach my $t (@files) {
 		} else {
 			$message .=  $_;
 			if (/^(Signed-off-by|Cc): (.*)$/i && $signed_off_cc) {
+				next if ($suppress_cc{'sob'});
 				my $c = $2;
 				chomp $c;
-				next if ($c eq $sender and $suppress_from);
+				next if ($c eq $sender and $suppress_cc{'self'});
 				push @cc, $c;
 				printf("(sob) Adding cc: %s from line '%s'\n",
 					$c, $_) unless $quiet;
@@ -761,7 +787,7 @@ foreach my $t (@files) {
 	}
 	close F;
 
-	if (defined $cc_cmd) {
+	if (defined $cc_cmd && !$suppress_cc{'cccmd'}) {
 		open(F, "$cc_cmd $t |")
 			or die "(cc-cmd) Could not execute '$cc_cmd'";
 		while(<F>) {
-- 
1.5.3.7

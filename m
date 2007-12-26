From: David Brown <git@davidb.org>
Subject: [PATCH] git-send-email: Generalize auto-cc recipient mechanism.
Date: Tue, 25 Dec 2007 19:56:29 -0800
Message-ID: <1198641389-959-1-git-send-email-git@davidb.org>
References: <7vk5n2o58p.fsf@gitster.siamese.dyndns.org>
Cc: Joel Becker <Joel.Becker@oracle.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 26 04:56:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J7NO5-0007Up-MJ
	for gcvg-git-2@gmane.org; Wed, 26 Dec 2007 04:56:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbXLZD4c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Dec 2007 22:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbXLZD4c
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Dec 2007 22:56:32 -0500
Received: from mail.davidb.org ([66.93.32.219]:58009 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751401AbXLZD4b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Dec 2007 22:56:31 -0500
Received: from davidb by mail.davidb.org with local (Exim 4.68 #1 (Debian))
	id 1J7NNd-0000Fm-Rw; Tue, 25 Dec 2007 19:56:29 -0800
X-Mailer: git-send-email 1.5.4.rc1.22.g983a2
In-Reply-To: <7vk5n2o58p.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69240>

There are a few options to git-send-email to suppress the automatic
generation of 'Cc' fields: --suppress-from, and --signed-off-cc.
However, there are other times that git-send-email automatically
includes Cc'd recipients.  This is not desirable for all development
environments.

Add a new option --suppress-cc, which can be specified one or more
times to list the categories of auto-cc fields that should be
suppressed.  If not specified, it defaults to values to give the same
behavior as specified by --suppress-from, and --signed-off-cc.  The
categories are:

  self   - patch sender.  Same as --suppress-from.
  author - patch author.
  cc     - cc lines mentioned in the patch.
  cccmd  - avoid running the cccmd.
  sob    - signed off by lines.
  all    - all non-explicit recipients

Signed-off-by: David Brown <git@davidb.org>
---
I've now added changes similar to those suggested by Junio Hamano so
that signed-off-cc and suppress-from override values set by
signed-off-by.

Dave

 Documentation/git-send-email.txt |   11 +++++++
 git-send-email.perl              |   56 +++++++++++++++++++++++++++++++++-----
 2 files changed, 60 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index f0bd285..3dcea86 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -117,6 +117,17 @@ The --cc option must be repeated for each user you want on the cc list.
         Default is the value of 'sendemail.suppressfrom' configuration value;
         if that is unspecified, default to --no-suppress-from.
 
+--suppress-cc::
+	Specify an additional category of recipients to suppress the
+	auto-cc of.  'self' will avoid including the sender, 'author' will
+	avoid including the patch author, 'cc' will avoid including anyone
+	mentioned in Cc lines in the patch, 'sob' will avoid including
+	anyone mentioned in Signed-off-by lines, and 'cccmd' will avoid
+	running the --cc-cmd.  'all' will suppress all auto cc values.
+	Default is the value of 'sendemail.suppresscc' configuration value;
+	if that is unspecified, default to 'self' if --suppress-from is
+	specified, as well as 'sob' if --no-signed-off-cc is specified.
+
 --thread, --no-thread::
 	If this is set, the In-Reply-To header will be set on each email sent.
 	If disabled with "--no-thread", no emails will have the In-Reply-To
diff --git a/git-send-email.perl b/git-send-email.perl
index e47994a..a4cf4a9 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -88,6 +88,12 @@ Options:
 
    --smtp-ssl     If set, connects to the SMTP server using SSL.
 
+   --suppress-cc  Suppress the specified category of auto-CC.  The category
+                  can be one of 'author' for the patch author, 'self' to
+                  avoid copying yourself, 'sob' for Signed-off-by lines,
+                  'cccmd' for the output of the cccmd, or 'all' to suppress
+                  all of these.
+
    --suppress-from Suppress sending emails to yourself. Defaults to off.
 
    --thread       Specify that the "In-Reply-To:" header should be set on all
@@ -177,12 +183,13 @@ my ($quiet, $dry_run) = (0, 0);
 my ($thread, $chain_reply_to, $suppress_from, $signed_off_cc, $cc_cmd);
 my ($smtp_server, $smtp_server_port, $smtp_authuser, $smtp_authpass, $smtp_ssl);
 my ($identity, $aliasfiletype, @alias_files, @smtp_host_parts);
+my (@suppress_cc);
 
 my %config_bool_settings = (
     "thread" => [\$thread, 1],
     "chainreplyto" => [\$chain_reply_to, 1],
-    "suppressfrom" => [\$suppress_from, 0],
-    "signedoffcc" => [\$signed_off_cc, 1],
+    "suppressfrom" => [\$suppress_from, undef],
+    "signedoffcc" => [\$signed_off_cc, undef],
     "smtpssl" => [\$smtp_ssl, 0],
 );
 
@@ -196,6 +203,7 @@ my %config_settings = (
     "aliasfiletype" => \$aliasfiletype,
     "bcc" => \@bcclist,
     "aliasesfile" => \@alias_files,
+    "suppresscc" => \@suppress_cc,
 );
 
 # Begin by accumulating all the variables (defined above), that we will end up
@@ -218,6 +226,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "quiet" => \$quiet,
 		    "cc-cmd=s" => \$cc_cmd,
 		    "suppress-from!" => \$suppress_from,
+		    "suppress-cc=s" => \@suppress_cc,
 		    "signed-off-cc|signed-off-by-cc!" => \$signed_off_cc,
 		    "dry-run" => \$dry_run,
 		    "envelope-sender=s" => \$envelope_sender,
@@ -262,6 +271,35 @@ foreach my $setting (values %config_bool_settings) {
 	${$setting->[0]} = $setting->[1] unless (defined (${$setting->[0]}));
 }
 
+# Set CC suppressions
+my(%suppress_cc);
+if (@suppress_cc) {
+	foreach my $entry (@suppress_cc) {
+		die "Unknown --suppress-cc field: '$entry'\n"
+			unless $entry =~ /^(all|cccmd|cc|author|self|sob)$/;
+		$suppress_cc{$entry} = 1;
+	}
+}
+
+if ($suppress_cc{'all'}) {
+	foreach my $entry (qw (ccmd cc author self sob)) {
+		$suppress_cc{$entry} = 1;
+	}
+	delete $suppress_cc{'all'};
+}
+
+# If explicit old-style ones are specified, they trump --suppress-cc.
+$suppress_cc{'self'} = $suppress_from if defined $suppress_from;
+$suppress_cc{'sob'} = $signed_off_cc if defined $signed_off_cc;
+
+# Debugging, print out the suppressions.
+if (0) {
+	print "suppressions:\n";
+	foreach my $entry (keys %suppress_cc) {
+		printf "  %-5s -> $suppress_cc{$entry}\n", $entry;
+	}
+}
+
 my ($repoauthor) = $repo->ident_person('author');
 my ($repocommitter) = $repo->ident_person('committer');
 
@@ -701,11 +739,14 @@ foreach my $t (@files) {
 
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
@@ -732,7 +773,7 @@ foreach my $t (@files) {
 				# line 2 = subject
 				# So let's support that, too.
 				$input_format = 'lots';
-				if (@cc == 0) {
+				if (@cc == 0 && !$suppress_cc{'cc'}) {
 					printf("(non-mbox) Adding cc: %s from line '%s'\n",
 						$_, $_) unless $quiet;
 
@@ -749,10 +790,11 @@ foreach my $t (@files) {
 			}
 		} else {
 			$message .=  $_;
-			if (/^(Signed-off-by|Cc): (.*)$/i && $signed_off_cc) {
+			if (/^(Signed-off-by|Cc): (.*)$/i) {
+				next if ($suppress_cc{'sob'});
 				my $c = $2;
 				chomp $c;
-				next if ($c eq $sender and $suppress_from);
+				next if ($c eq $sender and $suppress_cc{'self'});
 				push @cc, $c;
 				printf("(sob) Adding cc: %s from line '%s'\n",
 					$c, $_) unless $quiet;
@@ -761,7 +803,7 @@ foreach my $t (@files) {
 	}
 	close F;
 
-	if (defined $cc_cmd) {
+	if (defined $cc_cmd && !$suppress_cc{'cccmd'}) {
 		open(F, "$cc_cmd $t |")
 			or die "(cc-cmd) Could not execute '$cc_cmd'";
 		while(<F>) {
-- 
1.5.3.7

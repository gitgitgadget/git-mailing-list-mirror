From: Douglas Stockwell <doug@11011.net>
Subject: [PATCH] send-email: Add support for SSL and SMTP-AUTH
Date: Mon,  3 Sep 2007 03:06:25 +0900
Message-ID: <11887563853329-git-send-email-doug@11011.net>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Sep 03 02:54:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IS0DA-0006pg-BX
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 02:54:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752642AbXICAyg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 20:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbXICAyg
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 20:54:36 -0400
Received: from vsmtp02.dti.ne.jp ([202.216.231.137]:52957 "EHLO
	vsmtp02.dti.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbXICAyf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 20:54:35 -0400
X-Greylist: delayed 990 seconds by postgrey-1.27 at vger.kernel.org; Sun, 02 Sep 2007 20:54:35 EDT
Received: from localhost.localdomain (fw21.opt2.point.ne.jp [210.235.203.21]) by vsmtp02.dti.ne.jp (3.11v) with ESMTP AUTH id l830aBe5015923;Mon, 3 Sep 2007 09:36:11 +0900 (JST)
X-Mailer: git-send-email 1.5.3.1.gad66
In-Reply-To: 7vveatpklg.fsf@gitster.siamese.dyndns.org
References: 7vveatpklg.fsf@gitster.siamese.dyndns.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57420>

Allows username and password to be given using --smtp-user
and --smtp-pass. SSL use is flagged by --smtp-ssl. These are
backed by corresponding defaults in the git configuration file.

This implements Junio's 'mail identity' suggestion in a slightly
more generalised manner. --identity=$identity, backed by
sendemail.identity indicates that the configuration subsection
[sendemail "$identity"] should take priority over the [sendemail]
section for all configuration values.

Signed-off-by: Douglas Stockwell <doug@11011.net>
---
 Documentation/git-send-email.txt |   35 +++++++++++++-
 git-send-email.perl              |  101 ++++++++++++++++++++++++++++----------
 2 files changed, 109 insertions(+), 27 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 16bfd7b..1ec61af 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -75,6 +75,12 @@ The --cc option must be repeated for each user you want on the cc list.
 	Make git-send-email less verbose.  One line per email should be
 	all that is output.
 
+--identity::
+	A configuration identity. When given, causes values in the
+	'sendemail.<identity>' subsection to take precedence over
+	values in the 'sendemail' section. The default identity is
+	the value of 'sendemail.identity'.
+
 --smtp-server::
 	If set, specifies the outgoing SMTP server to use (e.g.
 	`smtp.example.com` or a raw IP address).  Alternatively it can
@@ -85,6 +91,17 @@ The --cc option must be repeated for each user you want on the cc list.
 	`/usr/lib/sendmail` if such program is available, or
 	`localhost` otherwise.
 
+--smtp-user, --smtp-pass::
+	Username and password for SMTP-AUTH. Defaults are the values of
+	the configuration values 'sendemail.smtpuser' and
+	'sendemail.smtppass', but see also 'sendemail.identity'.
+	If not set, authentication is not attempted.
+
+--smtp-ssl::
+	If set, connects to the SMTP server using SSL.
+	Default is the value of the 'sendemail.smtpssl' configuration value;
+	if that is unspecified, does not use SSL.
+
 --subject::
 	Specify the initial subject of the email thread.
 	Only necessary if --compose is also set.  If --compose
@@ -122,6 +139,13 @@ The --to option must be repeated for each user you want on the to list.
 
 CONFIGURATION
 -------------
+sendemail.identity::
+	The default configuration identity. When specified,
+	'sendemail.<identity>.<item>' will have higher precedence than
+	'sendemail.<item>'. This is useful to declare multiple SMTP
+	identities and to hoist sensitive authentication information
+	out of the repository and into the global configuation file.
+
 sendemail.aliasesfile::
 	To avoid typing long email addresses, point this to one or more
 	email aliases files.  You must also supply 'sendemail.aliasfiletype'.
@@ -141,7 +165,16 @@ sendemail.chainreplyto::
 	parameter.
 
 sendemail.smtpserver::
-	Default smtp server to use.
+	Default SMTP server to use.
+
+sendemail.smtpuser::
+	Default SMTP-AUTH username.
+
+sendemail.smtppass::
+	Default SMTP-AUTH password.
+
+sendemail.smtpssl::
+	Boolean value specifying the default to the '--smtp-ssl' parameter.
 
 Author
 ------
diff --git a/git-send-email.perl b/git-send-email.perl
index e0b7d12..dd7560b 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -73,9 +73,18 @@ Options:
    --signed-off-cc Automatically add email addresses that appear in
                  Signed-off-by: or Cc: lines to the cc: list. Defaults to on.
 
+   --identity     The configuration identity, a subsection to prioritise over
+                  the default section.
+
    --smtp-server  If set, specifies the outgoing SMTP server to use.
                   Defaults to localhost.
 
+   --smtp-user    The username for SMTP-AUTH.
+
+   --smtp-pass    The password for SMTP-AUTH.
+
+   --smtp-ssl     If set, connects to the SMTP server using SSL.
+
    --suppress-from Suppress sending emails to yourself if your address
                   appears in a From: line. Defaults to off.
 
@@ -145,7 +154,6 @@ my $compose_filename = ".msg.$$";
 my (@to,@cc,@initial_cc,@bcclist,@xh,
 	$initial_reply_to,$initial_subject,@files,$author,$sender,$compose,$time);
 
-my $smtp_server;
 my $envelope_sender;
 
 # Example reply to:
@@ -164,24 +172,26 @@ my ($quiet, $dry_run) = (0, 0);
 
 # Variables with corresponding config settings
 my ($thread, $chain_reply_to, $suppress_from, $signed_off_cc, $cc_cmd);
+my ($smtp_server, $smtp_authuser, $smtp_authpass, $smtp_ssl);
+my ($identity, $aliasfiletype, @alias_files);
 
-my %config_settings = (
+my %config_bool_settings = (
     "thread" => [\$thread, 1],
     "chainreplyto" => [\$chain_reply_to, 1],
     "suppressfrom" => [\$suppress_from, 0],
     "signedoffcc" => [\$signed_off_cc, 1],
-    "cccmd" => [\$cc_cmd, ""],
+    "smtpssl" => [\$smtp_ssl, 0],
 );
 
-foreach my $setting (keys %config_settings) {
-    my $config = $repo->config_bool("sendemail.$setting");
-    ${$config_settings{$setting}->[0]} = (defined $config) ? $config : $config_settings{$setting}->[1];
-}
-
-@bcclist = $repo->config('sendemail.bcc');
-if (!@bcclist or !$bcclist[0]) {
-    @bcclist = ();
-}
+my %config_settings = (
+    "smtpserver" => \$smtp_server,
+    "smtpuser" => \$smtp_authuser,
+    "smtppass" => \$smtp_authpass,
+    "cccmd" => \$cc_cmd,
+    "aliasfiletype" => \$aliasfiletype,
+    "bcc" => \@bcclist,
+    "aliasesfile" => \@alias_files,
+);
 
 # Begin by accumulating all the variables (defined above), that we will end up
 # needing, first, from the command line:
@@ -194,6 +204,10 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "bcc=s" => \@bcclist,
 		    "chain-reply-to!" => \$chain_reply_to,
 		    "smtp-server=s" => \$smtp_server,
+		    "smtp-user=s" => \$smtp_authuser,
+		    "smtp-pass=s" => \$smtp_authpass,
+		    "smtp-ssl!" => \$smtp_ssl,
+		    "identity=s" => \$identity,
 		    "compose" => \$compose,
 		    "quiet" => \$quiet,
 		    "cc-cmd=s" => \$cc_cmd,
@@ -208,6 +222,43 @@ unless ($rc) {
     usage();
 }
 
+# Now, let's fill any that aren't set in with defaults:
+
+sub read_config {
+	my ($prefix) = @_;
+
+	foreach my $setting (keys %config_bool_settings) {
+		my $target = $config_bool_settings{$setting}->[0];
+		$$target = $repo->config_bool("$prefix.$setting") unless (defined $$target);
+	}
+
+	foreach my $setting (keys %config_settings) {
+		my $target = $config_settings{$setting};
+		if (ref($target) eq "ARRAY") {
+			unless (@$target) {
+				my @values = $repo->config("$prefix.$setting");
+				@$target = @values if (@values && defined $values[0]);
+			}
+		}
+		else {
+			$$target = $repo->config("$prefix.$setting") unless (defined $$target);
+		}
+	}
+}
+
+# read configuration from [sendemail "$identity"], fall back on [sendemail]
+$identity = $repo->config("sendemail.identity") unless (defined $identity);
+read_config("sendemail.$identity") if (defined $identity);
+read_config("sendemail");
+
+# fall back on builtin bool defaults
+foreach my $setting (values %config_bool_settings) {
+	${$setting->[0]} = $setting->[1] unless (defined (${$setting->[0]}));
+}
+
+my ($repoauthor) = $repo->ident_person('author');
+my ($repocommitter) = $repo->ident_person('committer');
+
 # Verify the user input
 
 foreach my $entry (@to) {
@@ -222,14 +273,7 @@ foreach my $entry (@bcclist) {
 	die "Comma in --bcclist entry: $entry'\n" unless $entry !~ m/,/;
 }
 
-# Now, let's fill any that aren't set in with defaults:
-
-my ($repoauthor) = $repo->ident_person('author');
-my ($repocommitter) = $repo->ident_person('committer');
-
 my %aliases;
-my @alias_files = $repo->config('sendemail.aliasesfile');
-my $aliasfiletype = $repo->config('sendemail.aliasfiletype');
 my %parse_alias = (
 	# multiline formats can be supported in the future
 	mutt => sub { my $fh = shift; while (<$fh>) {
@@ -320,10 +364,7 @@ if ($thread && !defined $initial_reply_to && $prompting) {
 	$initial_reply_to =~ s/(^\s+|\s+$)//g;
 }
 
-if (!$smtp_server) {
-	$smtp_server = $repo->config('sendemail.smtpserver');
-}
-if (!$smtp_server) {
+if (!defined $smtp_server) {
 	foreach (qw( /usr/sbin/sendmail /usr/lib/sendmail )) {
 		if (-x $_) {
 			$smtp_server = $_;
@@ -553,8 +594,16 @@ X-Mailer: git-send-email $gitversion
 		print $sm "$header\n$message";
 		close $sm or die $?;
 	} else {
-		require Net::SMTP;
-		$smtp ||= Net::SMTP->new( $smtp_server );
+		if ($smtp_ssl) {
+			require Net::SMTP::SSL;
+			$smtp ||= Net::SMTP::SSL->new( $smtp_server, Port => 465 );
+		}
+		else {
+			require Net::SMTP;
+			$smtp ||= Net::SMTP->new( $smtp_server );
+		}
+		$smtp->auth( $smtp_authuser, $smtp_authpass )
+			or die $smtp->message if (defined $smtp_authuser);
 		$smtp->mail( $raw_from ) or die $smtp->message;
 		$smtp->to( @recipients ) or die $smtp->message;
 		$smtp->data or die $smtp->message;
@@ -661,7 +710,7 @@ foreach my $t (@files) {
 	}
 	close F;
 
-	if ($cc_cmd ne "") {
+	if (defined $cc_cmd) {
 		open(F, "$cc_cmd $t |")
 			or die "(cc-cmd) Could not execute '$cc_cmd'";
 		while(<F>) {
-- 
1.5.3.1.gc752

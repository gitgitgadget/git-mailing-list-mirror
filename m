From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH RFC3 10/13] send-email: Add --sleep for email throttling
Date: Mon, 13 Apr 2009 13:23:54 -0500
Message-ID: <1239647037-15381-11-git-send-email-mfwitten@gmail.com>
References: <1239647037-15381-1-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-2-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-3-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-4-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-5-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-6-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-7-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-8-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-9-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-10-git-send-email-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 13 20:38:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtR0q-0003it-A8
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 20:36:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011AbZDMSef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 14:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbZDMSef
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 14:34:35 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:38252 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011AbZDMSee (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 14:34:34 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1132551wah.21
        for <git@vger.kernel.org>; Mon, 13 Apr 2009 11:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=oPhBskgJdOJ1UW28JWKobBHBsBA62hFn33WSLcZRdkQ=;
        b=tH8rnPWNOeR0X7ac2TRUPt/n3+/ChDy0jV6cAdkBL+GNYbgt3he7fuhzdQhNe6+w0r
         UE/Bm3qecO72w1RT20+EdhbMJE6mMX33eHBckMzy07heaDGGsuial5WwyRVoc98oDuDO
         uHx4J2H6DRWouRrYCDqBrFhMph2Z1c9uK6yAc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Jc33bcO+K5xAqSABZzXfbnrkZgjtT/GKtRV5FM3HViz6LNMsQbRTQ9fr8qtkUhLLyK
         BdrrNkDKiDws5swchrIYXRJK3y29u9Nf8h+phhKVpVpQp97nTDJBk2HXNBpodGzKmytY
         AlT6K/OKfHUuj36yGoIghaYPQqZzCozJF8nDE=
Received: by 10.114.73.6 with SMTP id v6mr3295463waa.48.1239647672418;
        Mon, 13 Apr 2009 11:34:32 -0700 (PDT)
Received: from localhost.localdomain (97-116-116-167.mpls.qwest.net [97.116.116.167])
        by mx.google.com with ESMTPS id m30sm5963707wag.12.2009.04.13.11.34.30
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Apr 2009 11:34:31 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.479.g2aec
In-Reply-To: <1239647037-15381-10-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The --sleep option provides a means for specifying that there
should be a certain number of seconds of delay after sending
a certain number of emails; see Documentation/git-send-email.txt

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/git-send-email.txt |   30 +++++++++++++++
 git-send-email.perl              |   74 +++++++++++++++++++++++++++++++++++---
 2 files changed, 99 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 5f7d640..236e578 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -178,6 +178,36 @@ Automating
 	cc list. Default is the value of 'sendemail.signedoffbycc' configuration
 	value; if that is unspecified, default to --signed-off-by-cc.
 
+--sleep=<seconds>[,<burst>]::
+	This option specfies that send-email should sleep for <seconds>
+	after sending <burst> messages as quickly as possible; <seconds>
+	should be an integer >= 0 and <burst> should be an integer >= 1.
+	This mode of operation attacks 2 problems: email throttling and
+	arrival disorder. Default is the value of the 'sendemail.sleep'
+	configuration variable, or '0' if that does not exist.
++
+By default, send-email tries to send one patch per email as quickly as
+possible. Unfortunately, some email services restrict a user by refusing
+to send more than some maximum number of email messages, M, in a given
+period of seconds, S. This can be troublesome if the patch series has
+more than M patches, because the server will ultimately refuse to send
+some of them. In this case, simply pass '--sleep=S,M' or '--sleep S,M'
+or set sendemail.sleep to 'S,M'.
++
+Moreover, the emails often arrive at the final destination out of order;
+though send-email manipulates the date fields and usually chains subsequent
+emails via the In-Reply-To headers, some mail viewers nevertheless insist
+on presenting them by order of arrival. This may be mitigated by using
+something like '--sleep 60' (the equivalent of '--sleep 60,1'), so that
+there is a 60 second delay between sending any two messages.
++
+*Note*: Because of varying routes and batching schemes, there is no delay
+that can guarantee the correct arrival order. Obviously, one solution is to
+choose an obscenely large number, so be prepared to run send-email in the
+background. Of course, spreading emails across time makes it more likely
+that unrelated email messages arrive between patches. Therefore, send-email
+warns you if both --sleep and --no-chain-reply-to are used.
+
 --suppress-cc=<category>::
 	Specify an additional category of recipients to suppress the
 	auto-cc of:
diff --git a/git-send-email.perl b/git-send-email.perl
index 0ff72f6..a394663 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -72,6 +72,7 @@ git send-email [options] <file | directory | rev-list options >
     --smtp-ssl                     * Deprecated. Use '--smtp-encryption ssl'.
 
   Automating:
+    --sleep      <secs>[,<burst>]  * Delay <secs> every <burst> email(s).
     --identity               <id>  * Use the sendemail.<id> options.
     --cc-cmd            <command>  * Email Cc: via `<command> $patch_path`
     --suppress-cc      <category>  * author, self, sob, cc, cccmd, body,
@@ -189,7 +190,7 @@ sub do_edit {
 }
 
 # Variables with corresponding config settings
-my ($thread, $chain_reply_to, $suppress_from, $signed_off_by_cc, $cc_cmd);
+my ($sleep, $thread, $chain_reply_to, $suppress_from, $signed_off_by_cc, $cc_cmd);
 my ($smtp_server, $smtp_server_port, $smtp_authuser, $smtp_encryption);
 my ($identity, $aliasfiletype, @alias_files, @smtp_host_parts);
 my ($validate, $confirm);
@@ -205,6 +206,7 @@ my %config_bool_settings = (
 );
 
 my %config_settings = (
+	"sleep" => \$sleep,
 	"smtpserver" => \$smtp_server,
 	"smtpserverport" => \$smtp_server_port,
 	"smtpuser" => \$smtp_authuser,
@@ -257,6 +259,7 @@ my $rc = GetOptions(
 	"cc=s" => \@initial_cc,
 	"bcc=s" => \@bcclist,
 	"chain-reply-to!" => \$chain_reply_to,
+	"sleep=s" => \$sleep,
 	"smtp-server=s" => \$smtp_server,
 	"smtp-server-port=s" => \$smtp_server_port,
 	"smtp-user=s" => \$smtp_authuser,
@@ -329,6 +332,43 @@ foreach my $setting (values %config_bool_settings) {
 	${$setting->[0]} = $setting->[1] unless (defined (${$setting->[0]}));
 }
 
+#### Parse input
+
+my ($sleep_seconds, $sleep_burst);
+
+if (defined $sleep) {{
+
+	unless ($chain_reply_to) {
+
+		print "Both --sleep and --no-chain-reply-to are in effect.\n";
+		print "Therefore, it is much more likely that unrelated\n";
+		print "email messages will appear between any 2 of your\n";
+		print "patches.\n\n";
+
+		$_ = ask(
+			"How to proceed? ([q]uit | --[s]leep | --no-[c]hain | [n]either | [b]oth): ",
+			valid_re => qr/^(?:b|s|c|n|q)/i,
+			default => 'b'
+		);
+
+		/^b/                                               or
+		/^s/ and $chain_reply_to = 1                       or
+		/^c/ and $sleep = undef, last                      or
+		/^n/ and $chain_reply_to = 1, $sleep = undef, last or
+		/^q/ and exit;
+	}
+
+	$sleep =~ /^(\d+)(?:,(\d+))?$/
+		or  print "Should be '--sleep=<seconds>[,<burst>]', but got '--sleep=\"$sleep\"'\n"
+		and exit;
+
+	# Explicitly convert to integers to avoid repeated conversion:
+	# (<burst> = 0 is not defined, but let's be nice and absorb it)
+
+	$sleep_seconds = 0+$1;
+	$sleep_burst   = $2 ? 0+$2 : 1;
+}}
+
 # 'default' encryption is none -- this only prevents a warning
 $smtp_encryption = '' unless (defined $smtp_encryption);
 
@@ -1033,8 +1073,12 @@ $references = $initial_reply_to || '';
 $subject = $initial_subject;
 $message_num = 0;
 
-foreach my $t (@files) {
-	open(F,"<",$t) or die "can't open file $t";
+my $burst_count = $sleep_burst;
+my $time_of_last_message;
+
+for (my $index = 0; $index < @files; $index++) {
+	my $file = $files[$index];
+	open(F,"<",$file) or die "can't open file $file";
 
 	my $author = undef;
 	my $author_encoding;
@@ -1143,7 +1187,7 @@ foreach my $t (@files) {
 	close F;
 
 	if (defined $cc_cmd && !$suppress_cc{'cccmd'}) {
-		open(F, "$cc_cmd $t |")
+		open(F, "$cc_cmd $file |")
 			or die "(cc-cmd) Could not execute '$cc_cmd'";
 		while(<F>) {
 			my $c = $_;
@@ -1190,7 +1234,27 @@ foreach my $t (@files) {
 
 	my $message_was_sent = send_message();
 
-	# set up for the next message
+	# Throttle the outgoing rate:
+
+	if ($sleep_seconds && $message_was_sent) {
+
+		$time_of_last_message = time;
+
+		unless (--$burst_count) {  # unless we can send more
+
+			$burst_count = $sleep_burst;
+
+			my $already_elapsed = time - $time_of_last_message;
+
+			if ($already_elapsed < $sleep_seconds && $index < $#files) {
+				my $this_long = $sleep_seconds - $already_elapsed;
+				while (($this_long -= sleep $this_long) > 0) {}
+			}
+		}
+	}
+
+	# set up for the next message:
+
 	if ($message_was_sent and $chain_reply_to || not defined $reply_to || length($reply_to) == 0) {
 		$reply_to = $message_id;
 		if (length $references > 0) {
-- 
1.6.2.2.479.g2aec

From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH RFC 08/10] send-email: Add --sleep for email throttling
Date: Sat, 11 Apr 2009 14:08:26 -0500
Message-ID: <1239476908-25944-8-git-send-email-mfwitten@gmail.com>
References: <1239476908-25944-1-git-send-email-mfwitten@gmail.com>
 <1239476908-25944-2-git-send-email-mfwitten@gmail.com>
 <1239476908-25944-3-git-send-email-mfwitten@gmail.com>
 <1239476908-25944-4-git-send-email-mfwitten@gmail.com>
 <1239476908-25944-5-git-send-email-mfwitten@gmail.com>
 <1239476908-25944-6-git-send-email-mfwitten@gmail.com>
 <1239476908-25944-7-git-send-email-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 11 21:17:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lsii9-0003G2-6i
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 21:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757787AbZDKTQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2009 15:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755533AbZDKTQQ
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 15:16:16 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:62534 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754087AbZDKTQP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 15:16:15 -0400
Received: by yx-out-2324.google.com with SMTP id 31so1618069yxl.1
        for <git@vger.kernel.org>; Sat, 11 Apr 2009 12:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=xAat3d55tIdEwJlFigu7DVngjv3ARtuKOqVT/PWKa78=;
        b=tcd96v1BcpLIWFp24Cvit2okbeRALkPrTHS+BHbWA8QHzgu99IPyXos/NPveuMvtDp
         Tgilf/R+gyx/AxWSsJ1brjZQ3jMUPbuFB/0G5sD/RR9oyHxpQ3u4kPbb8W83PgVN8Y9v
         Pljs4Ls3Mk3I2Xxd/RJj9atxtRRHI88vkAvYA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=D6lXWneZbZf46w8vwq1SP2EbNn1vIdKu6YvdrYS1Mt9Bv61cWooE3h2dhv9sClhkkb
         3OLAHeWPDu21bfWx/NYyt+GFqG0LxsYgZDcglGDWNuCHLzc/PkboJxOzgY9PQSX+txZG
         0KLjfrzlbQo/uE4/vylpSh7O1sGYUT78X5Piw=
Received: by 10.100.166.10 with SMTP id o10mr708860ane.155.1239477355987;
        Sat, 11 Apr 2009 12:15:55 -0700 (PDT)
Received: from localhost.localdomain (97-116-109-29.mpls.qwest.net [97.116.109.29])
        by mx.google.com with ESMTPS id 9sm5461438ywf.6.2009.04.11.12.15.55
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 11 Apr 2009 12:15:55 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.479.g2aec
In-Reply-To: <1239476908-25944-7-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116317>

The --sleep option provides a means for specifying that there
should be a certain number of seconds of delay after sending
a certain number of emails; see Documentation/git-send-email.txt

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/git-send-email.txt |   30 +++++++++++++++
 git-send-email.perl              |   74 +++++++++++++++++++++++++++++++++++---
 2 files changed, 99 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 12845d6..f0c2e7b 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -168,6 +168,36 @@ Automating
 	entire patch series. Default is the value of the 'sendemail.chainreplyto'
 	configuration value; if that is unspecified, default to --chain-reply-to.
 
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
+there is a 60 second delay between sending each patch.
++
+*Note*: Because of varying routes and batching schemes, there is no delay
+that can guarantee the correct arrival order. Obviously, one solution is to
+choose an obscenely large number, so be prepared to run send-email in the
+background. Of course, spreading emails across time makes it more likely
+that unrelated email messages arrive between patches. Therefore, send-email
+warns you if both --sleep and --no-chain-reply-to are used.
+
 --identity=<id>::
 	A configuration identity. When given, causes values in the
 	'sendemail.<id>' subsection to take precedence over
diff --git a/git-send-email.perl b/git-send-email.perl
index 4f0462f..c26a1b5 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -77,6 +77,7 @@ git send-email [options] <file | directory | rev-list options >
     --smtp-ssl                     * Deprecated. Use '--smtp-encryption ssl'.
 
   Automating:
+    --sleep      <secs>[,<burst>]  * Delay <secs> every <burst> email(s).
     --identity               <id>  * Use the sendemail.<id> options.
     --cc-cmd            <command>  * Email Cc: via `<command> \$patch_path`
     --suppress-cc      <category>  * author, self, sob, cc, cccmd, body,
@@ -194,7 +195,7 @@ sub do_edit {
 }
 
 # Variables with corresponding config settings
-my ($thread, $chain_reply_to, $suppress_from, $signed_off_by_cc, $cc_cmd);
+my ($sleep, $thread, $chain_reply_to, $suppress_from, $signed_off_by_cc, $cc_cmd);
 my ($smtp_server, $smtp_server_port, $smtp_authuser, $smtp_encryption);
 my ($identity, $aliasfiletype, @alias_files, @smtp_host_parts);
 my ($validate, $confirm);
@@ -210,6 +211,7 @@ my %config_bool_settings = (
 );
 
 my %config_settings = (
+	"sleep" => \$sleep,
 	"smtpserver" => \$smtp_server,
 	"smtpserverport" => \$smtp_server_port,
 	"smtpuser" => \$smtp_authuser,
@@ -262,6 +264,7 @@ my $rc = GetOptions(
 	"cc=s" => \@initial_cc,
 	"bcc=s" => \@bcclist,
 	"chain-reply-to!" => \$chain_reply_to,
+	"sleep=s" => \$sleep,
 	"smtp-server=s" => \$smtp_server,
 	"smtp-server-port=i" => \$smtp_server_port,
 	"smtp-user=s" => \$smtp_authuser,
@@ -334,6 +337,43 @@ foreach my $setting (values %config_bool_settings) {
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
 
@@ -1041,8 +1081,12 @@ $references = $initial_reply_to || '';
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
@@ -1151,7 +1195,7 @@ foreach my $t (@files) {
 	close F;
 
 	if (defined $cc_cmd && !$suppress_cc{'cccmd'}) {
-		open(F, "$cc_cmd $t |")
+		open(F, "$cc_cmd $file |")
 			or die "(cc-cmd) Could not execute '$cc_cmd'";
 		while(<F>) {
 			my $c = $_;
@@ -1198,7 +1242,27 @@ foreach my $t (@files) {
 
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

From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH] git-send-email: Remember sources of Cc addresses
Date: Wed,  4 May 2011 18:12:08 +0200
Message-ID: <1304525528-24757-1-git-send-email-jnareb@gmail.com>
References: <20110415034251.GC19621@sigill.intra.peff.net> <4DA754A4.3090709@windriver.com> <20110414210913.GC6525@sigill.intra.peff.net> <4DA791A2.3010901@windriver.com>
Cc: Jeff King <peff@peff.net>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 18:12:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHegr-0002el-FW
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 18:12:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106Ab1EDQMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 12:12:34 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41907 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970Ab1EDQMd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 12:12:33 -0400
Received: by wwa36 with SMTP id 36so1403953wwa.1
        for <git@vger.kernel.org>; Wed, 04 May 2011 09:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=OoM6JAlDeAdQ9ebWHHl4S1xE7a3mfDe11R0v4CwQRFo=;
        b=Spmb4TXcjCZGa9TgaRcJx8+9FlOWniViol883VwoZgDXD7B2AYF4sXKAIfwQ0ls3ph
         Bjqs+72I3rSRRnd0C0qth0DcUKK+OC9CxX2Jlq59W71q6NSem34/YHEQzCLv/uVhIqba
         SUy7TpfHDejo4m1Xk1PyP8HzYAsjwpUk5FsxY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=e5EBmuCEQKnSLA/oBV8cZn1D5+c5WgN6lKi0CaCxtbkOV69QkzxkzCbgGPLo2bLhNJ
         wXIs0xTTtj7KdY09KPfQ8Hy3kSMaM/XQBiYc7jHcsR8wDY7sRSeuuXHXUO5CCPs3Ljux
         BHW0ENYTaflP7ZsVPQtZnmXeZpJns+kQguL8A=
Received: by 10.227.11.146 with SMTP id t18mr1344392wbt.104.1304525551740;
        Wed, 04 May 2011 09:12:31 -0700 (PDT)
Received: from localhost.localdomain (abvb15.neoplus.adsl.tpnet.pl [83.8.199.15])
        by mx.google.com with ESMTPS id h11sm795220wbc.26.2011.05.04.09.12.28
        (version=SSLv3 cipher=OTHER);
        Wed, 04 May 2011 09:12:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.186.g3966e.dirty
In-Reply-To: <20110415034251.GC19621@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172750>

Instead of using @initial_cc to remember --cc=<address> command line
options, and @cc to remember Cc addresses derived from message body
and --cc-cmd=<command> and ultimately gather all Cc addresses,
use %cc hash to remember from where Cc addresses came from:
 * command line --cc=<address> ('initial'),
 * "From:" email header in patch ('from'),
 * "Cc:"   email header in patch ('cc'),
 * signoff lines and Cc lines in message body ('body'),
 * result of running <command> from --cc-cmd=<command> ('cc-cmd').

This is pure refactoring: we don't use this information, but gather
together all of those in @cc variable local to send_message()
subroutine.  No changes in behavior.

While at it make assignment to $to variable in send_message()
up, to make it more clear that @recipients is just @to then.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
On Fri, 15 Apr 2011, Jeff King wrote:
> On Thu, Apr 14, 2011 at 08:30:26PM -0400, Paul Gortmaker wrote:

>> True.  I wonder if there is some flexibility in what we do, depending
>> on whether the setting is a local binary like /usr/bin/sendmail, vs.
>> a hostname of a server, like it was in my case...
> 
> Sure. Since you are actually doing SMTP, you have much more flexibility
> in knowing what errors happen. Look in git-send-email.perl's
> send_message, around line 1118. We use the Mail::SMTP module, but we
> just feed it the whole recipient list and barf if any of them is
> rejected. You could probably remember which recipients are "important"
> (i.e., given on the command line) and which were pulled automatically
> from the commit information, and then feed each recipient individually.
> If important ones fail, abort the message. If an unimportant one fails,
> send the message anyway, but remember the bad address and report the
> error at the end.
> 
> That wouldn't help people using a sendmail binary, but there's nothing
> we can do. That transport simply doesn't supply as much information, so
> it can't take advantage of the new feature. But it will be no worse off
> for you adding the feature for SMTP users.

This is an RFC patch preparing the way, so to speak, by remembering
where each Cc address came from.  We could in the future treat
$cc{'body'} / all_cc('body') differently from the rest of all_cc().

Is the approach taken here sane?

 git-send-email.perl |   52 ++++++++++++++++++++++++++++++--------------------
 1 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 1c6b1a8..7d75a1e 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -140,10 +140,18 @@ my $smtp;
 my $auth;
 
 # Variables we fill in automatically, or via prompting:
-my (@to,$no_to,@initial_to,@cc,$no_cc,@initial_cc,@bcclist,$no_bcc,@xh,
+my (@to,$no_to,@initial_to,%cc,$no_cc,@bcclist,$no_bcc,@xh,
 	$initial_reply_to,$initial_subject,@files,
 	$author,$sender,$smtp_authpass,$annotate,$compose,$time);
 
+sub all_cc {
+	my @keys = @_;
+	@keys = qw(initial from cc body cc-cmd) unless @keys;
+	return map { ref($_) ? @$_ : () } @cc{@keys};
+
+	#return map { ref($_) ? @$_ : () } values %cc;
+}
+
 my $envelope_sender;
 
 # Example reply to:
@@ -221,7 +229,7 @@ my %config_settings = (
     "smtpdomain" => \$smtp_domain,
     "to" => \@initial_to,
     "tocmd" => \$to_cmd,
-    "cc" => \@initial_cc,
+    "cc" => \@{$cc{'initial'}},
     "cccmd" => \$cc_cmd,
     "aliasfiletype" => \$aliasfiletype,
     "bcc" => \@bcclist,
@@ -281,7 +289,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "to=s" => \@initial_to,
 		    "to-cmd=s" => \$to_cmd,
 		    "no-to" => \$no_to,
-		    "cc=s" => \@initial_cc,
+		    "cc=s" => \@{$cc{'initial'}},
 		    "no-cc" => \$no_cc,
 		    "bcc=s" => \@bcclist,
 		    "no-bcc" => \$no_bcc,
@@ -423,7 +431,7 @@ foreach my $entry (@initial_to) {
 	die "Comma in --to entry: $entry'\n" unless $entry !~ m/,/;
 }
 
-foreach my $entry (@initial_cc) {
+foreach my $entry (@{$cc{'initial'}}) {
 	die "Comma in --cc entry: $entry'\n" unless $entry !~ m/,/;
 }
 
@@ -753,7 +761,7 @@ sub expand_one_alias {
 
 @initial_to = expand_aliases(@initial_to);
 @initial_to = (map { sanitize_address($_) } @initial_to);
-@initial_cc = expand_aliases(@initial_cc);
+@{$cc{'initial'}} = expand_aliases(@{$cc{'initial'}});
 @bcclist = expand_aliases(@bcclist);
 
 if ($thread && !defined $initial_reply_to && $prompting) {
@@ -959,12 +967,14 @@ sub maildomain {
 
 sub send_message {
 	my @recipients = unique_email_list(@to);
-	@cc = (grep { my $cc = extract_valid_address($_);
-		      not grep { $cc eq $_ || $_ =~ /<\Q${cc}\E>$/ } @recipients
-		    }
-	       map { sanitize_address($_) }
-	       @cc);
-	my $to = join (",\n\t", @recipients);
+	my $to = join(",\n\t", @recipients);
+	my @cc =
+		grep {
+			my $cc = extract_valid_address($_);
+			not grep { $cc eq $_ || $_ =~ /<\Q${cc}\E>$/ } @recipients
+		}
+		map { sanitize_address($_) }
+		all_cc();
 	@recipients = unique_email_list(@recipients,@cc,@bcclist);
 	@recipients = (map { extract_valid_address($_) } @recipients);
 	my $date = format_2822_time($time++);
@@ -1159,7 +1169,7 @@ foreach my $t (@files) {
 	my $has_content_type;
 	my $body_encoding;
 	@to = ();
-	@cc = ();
+	$cc{$_} = [] foreach (qw(from cc body));
 	@xh = ();
 	my $input_format = undef;
 	my @header = ();
@@ -1197,7 +1207,7 @@ foreach my $t (@files) {
 				next if $suppress_cc{'self'} and $author eq $sender;
 				printf("(mbox) Adding cc: %s from line '%s'\n",
 					$1, $_) unless $quiet;
-				push @cc, $1;
+				push @{$cc{'from'}}, $1;
 			}
 			elsif (/^To:\s+(.*)$/) {
 				foreach my $addr (parse_address_line($1)) {
@@ -1215,7 +1225,7 @@ foreach my $t (@files) {
 					}
 					printf("(mbox) Adding cc: %s from line '%s'\n",
 						$addr, $_) unless $quiet;
-					push @cc, $addr;
+					push @{$cc{'cc'}}, $addr;
 				}
 			}
 			elsif (/^Content-type:/i) {
@@ -1239,10 +1249,10 @@ foreach my $t (@files) {
 			# line 2 = subject
 			# So let's support that, too.
 			$input_format = 'lots';
-			if (@cc == 0 && !$suppress_cc{'cc'}) {
+			if (all_cc() == 0 && !$suppress_cc{'cc'}) {
 				printf("(non-mbox) Adding cc: %s from line '%s'\n",
 					$_, $_) unless $quiet;
-				push @cc, $_;
+				push @{$cc{'cc'}}, $_;
 			} elsif (!defined $subject) {
 				$subject = $_;
 			}
@@ -1261,7 +1271,7 @@ foreach my $t (@files) {
 				next if $suppress_cc{'sob'} and $what =~ /Signed-off-by/i;
 				next if $suppress_cc{'bodycc'} and $what =~ /Cc/i;
 			}
-			push @cc, $c;
+			push @{$cc{'body'}}, $c;
 			printf("(body) Adding cc: %s from line '%s'\n",
 				$c, $_) unless $quiet;
 		}
@@ -1270,7 +1280,7 @@ foreach my $t (@files) {
 
 	push @to, recipients_cmd("to-cmd", "to", $to_cmd, $t)
 		if defined $to_cmd;
-	push @cc, recipients_cmd("cc-cmd", "cc", $cc_cmd, $t)
+	push @{$cc{'cc-cmd'}}, recipients_cmd("cc-cmd", "cc", $cc_cmd, $t)
 		if defined $cc_cmd && !$suppress_cc{'cccmd'};
 
 	if ($broken_encoding{$t} && !$has_content_type) {
@@ -1308,14 +1318,14 @@ foreach my $t (@files) {
 		}
 	}
 
+	my $has_cc = all_cc();
 	$needs_confirm = (
 		$confirm eq "always" or
-		($confirm =~ /^(?:auto|cc)$/ && @cc) or
+		($confirm =~ /^(?:auto|cc)$/ && $has_cc) or
 		($confirm =~ /^(?:auto|compose)$/ && $compose && $message_num == 1));
-	$needs_confirm = "inform" if ($needs_confirm && $confirm_unconfigured && @cc);
+	$needs_confirm = "inform" if ($needs_confirm && $confirm_unconfigured && $has_cc);
 
 	@to = (@initial_to, @to);
-	@cc = (@initial_cc, @cc);
 
 	my $message_was_sent = send_message();
 
-- 
1.7.5

From: Joe Perches <joe@perches.com>
Subject: [PATCH V2] git-send-email.perl: Add --to-cmd
Date: Thu, 23 Sep 2010 11:45:20 -0700
Message-ID: <1285267520.31572.34.camel@Joe-Laptop>
References: <AANLkTinsM5jdU194FR8L3hTvBXk0Tr_oV2E5752NOUpq@mail.gmail.com>
	 <AANLkTikkJNwF4LS9rx5=bHM2R0Pm751Y1u9V8iAt0w1A@mail.gmail.com>
	 <1285227413.7286.47.camel@Joe-Laptop>
	 <Pine.LNX.4.64.1009231054230.15528@ask.diku.dk>
	 <20100923090931.GA29789@albatros> <20100923120024.GA26715@albatros>
	 <1285253867.31572.13.camel@Joe-Laptop>
	 <Pine.LNX.4.64.1009231757090.11585@ask.diku.dk>
	 <1285262237.31572.18.camel@Joe-Laptop>
	 <AANLkTin_Y8w4ujNGTqGJPNDNfYz7hcjBVLcOG0emBjYn@mail.gmail.com>
	 <1285263993.31572.25.camel@Joe-Laptop>
	 <AANLkTinCx=+n6bMZw4tQqrQ7WC1o_aeGG_n_PxywTyb8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Julia Lawall <julia@diku.dk>, git <git@vger.kernel.org>,
	Vasiliy Kulikov <segooon@gmail.com>,
	matt mooney <mfmooney@gmail.com>,
	kernel-janitors@vger.kernel.org, Dan Carpenter <error27@gmail.com>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 23 20:45:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyqnP-0004nI-Tn
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 20:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754824Ab0IWSpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Sep 2010 14:45:22 -0400
Received: from mail.perches.com ([173.55.12.10]:2291 "EHLO mail.perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754380Ab0IWSpV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Sep 2010 14:45:21 -0400
Received: from [192.168.1.156] (unknown [192.168.1.156])
	by mail.perches.com (Postfix) with ESMTP id 5F4CB24368;
	Thu, 23 Sep 2010 11:45:09 -0700 (PDT)
In-Reply-To: <AANLkTinCx=+n6bMZw4tQqrQ7WC1o_aeGG_n_PxywTyb8@mail.gmail.com>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156895>

Add the ability to use a command line --to-cmd=cmd
to create the list of "To:" addresses.

Signed-off-by: Joe Perches <joe@perches.com>
---
 Documentation/git-send-email.txt |    8 +++++++-
 git-send-email.perl              |   25 +++++++++++++++++++++++--
 t/t9001-send-email.sh            |   18 ++++++++++++++++++
 3 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index c283084..fff97a3 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -97,7 +97,7 @@ See the CONFIGURATION section for 'sendemail.multiedit'.
 	Specify the primary recipient of the emails generated. Generally, this
 	will be the upstream maintainer of the project involved. Default is the
 	value of the 'sendemail.to' configuration value; if that is unspecified,
-	this will be prompted for.
+	and --to-cmd is not specified, this will be prompted for.
 +
 The --to option must be repeated for each user you want on the to list.
 
@@ -177,6 +177,12 @@ user is prompted for a password while the input is masked for privacy.
 Automating
 ~~~~~~~~~~
 
+--to-cmd=<command>::
+	Specify a command to execute once per patch file which
+	should generate patch file specific "To:" entries.
+	Output of this command must be single email address per line.
+	Default is the value of 'sendemail.tocmd' configuration value.
+
 --cc-cmd=<command>::
 	Specify a command to execute once per patch file which
 	should generate patch file specific "Cc:" entries.
diff --git a/git-send-email.perl b/git-send-email.perl
index 6dab3bf..fa8da8b 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -70,6 +70,7 @@ git send-email [options] <file | directory | rev-list options >
 
   Automating:
     --identity              <str>  * Use the sendemail.<id> options.
+    --to-cmd                <str>  * Email To: via `<str> \$patch_path`
     --cc-cmd                <str>  * Email Cc: via `<str> \$patch_path`
     --suppress-cc           <str>  * author, self, sob, cc, cccmd, body, bodycc, all.
     --[no-]signed-off-by-cc        * Send to Signed-off-by: addresses. Default on.
@@ -187,7 +188,8 @@ sub do_edit {
 }
 
 # Variables with corresponding config settings
-my ($thread, $chain_reply_to, $suppress_from, $signed_off_by_cc, $cc_cmd);
+my ($thread, $chain_reply_to, $suppress_from, $signed_off_by_cc);
+my ($to_cmd, $cc_cmd);
 my ($smtp_server, $smtp_server_port, $smtp_authuser, $smtp_encryption);
 my ($identity, $aliasfiletype, @alias_files, @smtp_host_parts, $smtp_domain);
 my ($validate, $confirm);
@@ -214,6 +216,7 @@ my %config_settings = (
     "smtppass" => \$smtp_authpass,
 	"smtpdomain" => \$smtp_domain,
     "to" => \@to,
+    "tocmd" => \$to_cmd,
     "cc" => \@initial_cc,
     "cccmd" => \$cc_cmd,
     "aliasfiletype" => \$aliasfiletype,
@@ -272,6 +275,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
                     "in-reply-to=s" => \$initial_reply_to,
 		    "subject=s" => \$initial_subject,
 		    "to=s" => \@to,
+		    "to-cmd=s" => \$to_cmd,
 		    "no-to" => \$no_to,
 		    "cc=s" => \@initial_cc,
 		    "no-cc" => \$no_cc,
@@ -711,7 +715,7 @@ if (!defined $sender) {
 	$prompting++;
 }
 
-if (!@to) {
+if (!@to && !defined $to_cmd) {
 	my $to = ask("Who should the emails be sent to? ");
 	push @to, parse_address_line($to) if defined $to; # sanitized/validated later
 	$prompting++;
@@ -1238,6 +1242,23 @@ foreach my $t (@files) {
 	}
 	close F;
 
+	if (defined $to_cmd) {
+		open(F, "$to_cmd \Q$t\E |")
+			or die "(to-cmd) Could not execute '$to_cmd'";
+		while(<F>) {
+			my $t = $_;
+			$t =~ s/^\s*//g;
+			$t =~ s/\n$//g;
+			next if ($t eq $sender and $suppress_from);
+			push @to, parse_address_line($t)
+			    if defined $t; # sanitized/validated later
+			printf("(to-cmd) Adding To: %s from: '%s'\n",
+				$t, $to_cmd) unless $quiet;
+		}
+		close F
+			or die "(to-cmd) failed to close pipe to '$to_cmd'";
+	}
+
 	if (defined $cc_cmd && !$suppress_cc{'cccmd'}) {
 		open(F, "$cc_cmd \Q$t\E |")
 			or die "(cc-cmd) Could not execute '$cc_cmd'";
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 71b3df9..36cf421 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -201,6 +201,24 @@ test_expect_success $PREREQ 'Prompting works' '
 		grep "^To: to@example.com\$" msgtxt1
 '
 
+test_expect_success $PREREQ 'tocmd works' '
+	clean_fake_sendmail &&
+	cp $patches tocmd.patch &&
+	echo tocmd--tocmd@example.com >>tocmd.patch &&
+	{
+	  echo "#!$SHELL_PATH"
+	  echo sed -n -e s/^tocmd--//p \"\$1\"
+	} > tocmd-sed &&
+	chmod +x tocmd-sed &&
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--to-cmd=./tocmd-sed \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		tocmd.patch \
+		&&
+	grep "^To: tocmd@example.com" msgtxt1
+'
+
 test_expect_success $PREREQ 'cccmd works' '
 	clean_fake_sendmail &&
 	cp $patches cccmd.patch &&

From: Joe Perches <joe@perches.com>
Subject: [RFC PATCH] sit-send-email.pl: Add --to-cmd
Date: Thu, 23 Sep 2010 10:17:17 -0700
Message-ID: <1285262237.31572.18.camel@Joe-Laptop>
References: <AANLkTinsM5jdU194FR8L3hTvBXk0Tr_oV2E5752NOUpq@mail.gmail.com>
	 <AANLkTikkJNwF4LS9rx5=bHM2R0Pm751Y1u9V8iAt0w1A@mail.gmail.com>
	 <1285227413.7286.47.camel@Joe-Laptop>
	 <Pine.LNX.4.64.1009231054230.15528@ask.diku.dk>
	 <20100923090931.GA29789@albatros>  <20100923120024.GA26715@albatros>
	 <1285253867.31572.13.camel@Joe-Laptop>
	 <Pine.LNX.4.64.1009231757090.11585@ask.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Vasiliy Kulikov <segooon@gmail.com>,
	matt mooney <mfmooney@gmail.com>,
	kernel-janitors@vger.kernel.org, Dan Carpenter <error27@gmail.com>
To: Julia Lawall <julia@diku.dk>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 23 19:17:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OypQF-0004hL-KS
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 19:17:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755427Ab0IWRRU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Sep 2010 13:17:20 -0400
Received: from mail.perches.com ([173.55.12.10]:2281 "EHLO mail.perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754484Ab0IWRRT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Sep 2010 13:17:19 -0400
Received: from [192.168.1.162] (unknown [192.168.1.162])
	by mail.perches.com (Postfix) with ESMTP id 778B424368;
	Thu, 23 Sep 2010 10:17:08 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1009231757090.11585@ask.diku.dk>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156885>

On Thu, 2010-09-23 at 17:58 +0200, Julia Lawall wrote:
> On Thu, 23 Sep 2010, Joe Perches wrote:
> > On Thu, 2010-09-23 at 16:00 +0400, Vasiliy Kulikov wrote:
> > > On Thu, Sep 23, 2010 at 13:09 +0400, Vasiliy Kulikov wrote:
> > > > On Thu, Sep 23, 2010 at 10:55 +0200, Julia Lawall wrote:
> > > > > I made some changes to git-send-email to get it to send mail to different 
> > > > > people, ie a different set of addresses for each patch.  Is that now 
> > > > > possible with the standard version?  If not I can submit a patch with my 
> > > > > changes at some point.
> > > > I use git-send-email --cc-cmd=script_to_form_cc_list.
> > I believe that Julia means some mechanism to vary the
> > "to" addresses for each patch, ie: some "--to-cmd=cmd".
> Yes, sort of.  I took the strategy of precomputing the To addresses, so I 
> just have a collection of files that have different To and Cc addresses.  
> But a --to-cmd option seems like a good idea too.

Perhaps something like this?

Lightly tested only.

I know there's a test harness in git, but
I don't know how to wire up the new options.

Signed-off-by: Joe Perches <joe@perches.com>
---
 git-send-email.perl |   25 +++++++++++++++++++++++--
 1 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 6dab3bf..8e8e4c4 100755
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
+if (!@to && $to_cmd eq "") {
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

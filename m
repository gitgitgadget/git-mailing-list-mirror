From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] - git-send-email.perl
Date: Fri, 17 Aug 2007 18:51:12 -0700
Message-ID: <1187401873.822.146.camel@localhost>
References: <1186984174.10249.7.camel@localhost>
	 <200708131933.10125.m.kozlowski@tuxland.pl>
	 <1187026955.2688.4.camel@laptopd505.fenrus.org>
	 <1187037445.6628.98.camel@heimdal.trondhjem.org>
	 <1187054366.2757.0.camel@laptopd505.fenrus.org>
	 <46C10AA8.3090505@gmail.com> <20070814102033.604c8695@the-village.bc.nu>
	 <46C1CFFE.4000001@gmail.com> <1187110824.32555.76.camel@localhost>
	 <7vwsvx8twx.fsf@assigned-by-dhcp.cox.net>
	 <1187316783.822.19.camel@localhost> <1187317826.822.23.camel@localhost>
	 <1187373278.822.100.camel@localhost>
	 <7vy7g9enqd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Rene Herman <rene.herman@gmail.com>, git@vger.kernel.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Arjan van de Ven <arjan@infradead.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 18 03:52:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMDUd-0005g0-SK
	for gcvg-git@gmane.org; Sat, 18 Aug 2007 03:52:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbXHRBwo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 21:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbXHRBwo
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 21:52:44 -0400
Received: from DSL022.labridge.com ([206.117.136.22]:4438 "EHLO perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751009AbXHRBwm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2007 21:52:42 -0400
Received: from [192.168.1.128] ([192.168.1.128])
	by perches.com (8.9.3/8.9.3) with ESMTP id TAA07188;
	Fri, 17 Aug 2007 19:12:20 -0700
In-Reply-To: <7vy7g9enqd.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.10.2-2.1mdv2007.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56101>

On Fri, 2007-08-17 at 16:38 -0700, Junio C Hamano wrote:
> Joe Perches <joe@perches.com> writes:
> ... Signed-off-by: ...
> I do not see a patch to "Documentation/git-send-email.txt" here...
> Something like this, with appropriate error checking, perhaps?
> 
> 	open my $cc, "${cc_cmd} $t |";
>         while (my $c = <$cc>) {
>         	...
> 	}
>         close $cc;

Add --cc-cmd, the ability to execute an arbitrary "cmd" to
generate per patch file specific "Cc:"s to git-send-email.perl

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index d243ed1..9a48847 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -34,6 +34,12 @@ The --bcc option must be repeated for each user you want on the bcc list.
 +
 The --cc option must be repeated for each user you want on the cc list.
 
+--cc-cmd::
+	Specify a command to execute once per patch file which
+	should generate patch file specific "Cc:" entries.
+	Output of this command must be single email address per line.
+	Default is the value of 'sendemail.cccmd' configuration value.
+	
 --chain-reply-to, --no-chain-reply-to::
 	If this is set, each email will be sent as a reply to the previous
 	email sent.  If disabled with "--no-chain-reply-to", all emails after
@@ -124,6 +130,9 @@ sendemail.aliasfiletype::
 	Format of the file(s) specified in sendemail.aliasesfile. Must be
 	one of 'mutt', 'mailrc', 'pine', or 'gnus'.
 
+sendemail.cccmd::
+	Command to execute to generate per patch file specific "Cc:"s.
+
 sendemail.bcc::
 	Email address (or alias) to always bcc.
 
diff --git a/git-send-email.perl b/git-send-email.perl
index 69559b2..d49947c 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -46,6 +46,9 @@ Options:
    --cc           Specify an initial "Cc:" list for the entire series
                   of emails.
 
+   --cc-cmd       Specify a command to execute per file which adds
+                  per file specific cc address entries
+
    --bcc          Specify a list of email addresses that should be Bcc:
 		  on all the emails.
 
@@ -157,13 +160,14 @@ if ($@) {
 my ($quiet, $dry_run) = (0, 0);
 
 # Variables with corresponding config settings
-my ($thread, $chain_reply_to, $suppress_from, $signed_off_cc);
+my ($thread, $chain_reply_to, $suppress_from, $signed_off_cc, $cc_cmd);
 
 my %config_settings = (
     "thread" => [\$thread, 1],
     "chainreplyto" => [\$chain_reply_to, 1],
     "suppressfrom" => [\$suppress_from, 0],
     "signedoffcc" => [\$signed_off_cc, 1],
+    "cccmd" => [\$cc_cmd, ""],
 );
 
 foreach my $setting (keys %config_settings) {
@@ -189,6 +193,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "smtp-server=s" => \$smtp_server,
 		    "compose" => \$compose,
 		    "quiet" => \$quiet,
+		    "cc-cmd=s" => \$cc_cmd,
 		    "suppress-from!" => \$suppress_from,
 		    "signed-off-cc|signed-off-by-cc!" => \$signed_off_cc,
 		    "dry-run" => \$dry_run,
@@ -652,11 +657,25 @@ foreach my $t (@files) {
 		}
 	}
 	close F;
+
+	if (${cc_cmd} ne "") {
+	    open(F, "${cc_cmd} $t |")
+		or die "(cc-cmd) Could not execute '${cc_cmd}'\n";
+	    while(<F>) {
+		my $c = $_;
+		$c =~ s/^\s*//g;
+		$c =~ s/\n$//g;
+		push @cc, $c;
+		printf("(cc-cmd) Adding cc: %s from: '%s'\n", $c, $cc_cmd)
+		    unless $quiet;
+	    }
+	    close F;
+	}
+
 	if (defined $author) {
 		$message = "From: $author\n\n$message";
 	}
 
-
 	send_message();
 
 	# set up for the next message

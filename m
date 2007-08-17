From: Joe Perches <joe@perches.com>
Subject: [PATCH] - git-send-email.perl
Date: Fri, 17 Aug 2007 10:54:38 -0700
Message-ID: <1187373278.822.100.camel@localhost>
References: <1186984174.10249.7.camel@localhost>
	 <200708131933.10125.m.kozlowski@tuxland.pl>
	 <1187026955.2688.4.camel@laptopd505.fenrus.org>
	 <1187037445.6628.98.camel@heimdal.trondhjem.org>
	 <1187054366.2757.0.camel@laptopd505.fenrus.org>
	 <46C10AA8.3090505@gmail.com> <20070814102033.604c8695@the-village.bc.nu>
	 <46C1CFFE.4000001@gmail.com> <1187110824.32555.76.camel@localhost>
	 <7vwsvx8twx.fsf@assigned-by-dhcp.cox.net>
	 <1187316783.822.19.camel@localhost>  <1187317826.822.23.camel@localhost>
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
X-From: git-owner@vger.kernel.org Fri Aug 17 19:55:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IM62h-0003BC-7p
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 19:55:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758543AbXHQRzW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 13:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757675AbXHQRzW
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 13:55:22 -0400
Received: from DSL022.labridge.com ([206.117.136.22]:4064 "EHLO perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756941AbXHQRzU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2007 13:55:20 -0400
Received: from [192.168.1.128] ([192.168.1.128])
	by perches.com (8.9.3/8.9.3) with ESMTP id LAA05002;
	Fri, 17 Aug 2007 11:15:53 -0700
In-Reply-To: <1187317826.822.23.camel@localhost>
X-Mailer: Evolution 2.10.2-2.1mdv2007.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56077>

Here's a path to enable a command line option
that takes a string argument

	cc-cmd

This modifies the @cc array to include whatever
output is produced by cc_cmd $patchfile

cccmd can be stored in a config settings file

previous versions of this patch were submitted
against an older version of git-send-email.perl

diff --git a/git-send-email.perl b/git-send-email.perl
index 69559b2..828a77a 100755
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
@@ -652,11 +657,21 @@ foreach my $t (@files) {
 		}
 	}
 	close F;
+
+	if (${cc_cmd} ne "") {
+	    my $output = `${cc_cmd} $t`;
+	    my @lines = split("\n", $output);
+	    foreach my $c (@lines) {
+		push @cc, $c;
+		printf("(cc-cmd) Adding cc: %s from: '%s'\n", $c, $cc_cmd)
+		    unless $quiet;
+	    }
+	}
+
 	if (defined $author) {
 		$message = "From: $author\n\n$message";
 	}
 
-
 	send_message();
 
 	# set up for the next message

From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] [1/2many] - FInd the maintainer(s) for a patch -
	scripts/get_maintainer.pl
Date: Thu, 16 Aug 2007 19:30:26 -0700
Message-ID: <1187317826.822.23.camel@localhost>
References: <1186984174.10249.7.camel@localhost>
	 <200708131933.10125.m.kozlowski@tuxland.pl>
	 <1187026955.2688.4.camel@laptopd505.fenrus.org>
	 <1187037445.6628.98.camel@heimdal.trondhjem.org>
	 <1187054366.2757.0.camel@laptopd505.fenrus.org>
	 <46C10AA8.3090505@gmail.com> <20070814102033.604c8695@the-village.bc.nu>
	 <46C1CFFE.4000001@gmail.com> <1187110824.32555.76.camel@localhost>
	 <7vwsvx8twx.fsf@assigned-by-dhcp.cox.net>
	 <1187316783.822.19.camel@localhost>
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
X-From: git-owner@vger.kernel.org Fri Aug 17 04:31:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILrcW-0007ah-Sp
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 04:31:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757604AbXHQCbA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 22:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752592AbXHQCbA
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 22:31:00 -0400
Received: from DSL022.labridge.com ([206.117.136.22]:3400 "EHLO perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751501AbXHQCa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 22:30:59 -0400
Received: from [192.168.1.128] ([192.168.1.128])
	by perches.com (8.9.3/8.9.3) with ESMTP id TAA02437;
	Thu, 16 Aug 2007 19:51:57 -0700
In-Reply-To: <1187316783.822.19.camel@localhost>
X-Mailer: Evolution 2.10.2-2.1mdv2007.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56041>

On Thu, 2007-08-16 at 19:13 -0700, Joe Perches wrote:
> Sorry, not a git developer, so the paths are wrong.
> This seems to work:

Sorry.  Patch reversed too.

--- /usr/local/bin/git-send-email	2007-05-01 11:59:14.000000000 -0700
+++ /home/joe/bin/git-send-email.pl	2007-08-16 19:25:53.000000000 -0700
@@ -47,6 +47,9 @@ Options:
    --cc           Specify an initial "Cc:" list for the entire series
                   of emails.
 
+   --cc-cmd       Specify a command to execute per file which adds
+                  per file specific cc address entries
+
    --bcc          Specify a list of email addresses that should be Bcc:
 		  on all the emails.
 
@@ -140,7 +143,7 @@ my (@to,@cc,@initial_cc,@bcclist,@xh,
 
 # Behavior modification variables
 my ($chain_reply_to, $quiet, $suppress_from, $no_signed_off_cc,
-	$dry_run) = (1, 0, 0, 0, 0);
+	$dry_run, $cc_cmd) = (1, 0, 0, 0, 0, "");
 my $smtp_server;
 my $envelope_sender;
 
@@ -173,6 +176,7 @@ my $rc = GetOptions("from=s" => \$from,
 		    "subject=s" => \$initial_subject,
 		    "to=s" => \@to,
 		    "cc=s" => \@initial_cc,
+		    "cc-cmd=s" => \$cc_cmd,
 		    "bcc=s" => \@bcclist,
 		    "chain-reply-to!" => \$chain_reply_to,
 		    "smtp-server=s" => \$smtp_server,
@@ -607,6 +611,16 @@ foreach my $t (@files) {
 		}
 	}
 	close F;
+
+	if (${cc_cmd} ne "") {
+	    my $output = `${cc_cmd} $t`;
+	    my @lines = split("\n", $output);
+	    foreach my $c (@lines) {
+		push @cc, $c;
+		printf("(sob) Adding cc: %s from cc-cmd: '%s'\n", $c, $t) unless $quiet;
+	    }
+	}
+
 	if (defined $author_not_sender) {
 		$author_not_sender = unquote_rfc2047($author_not_sender);
 		$message = "From: $author_not_sender\n\n$message";

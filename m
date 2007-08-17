From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] [1/2many] - FInd the maintainer(s) for a patch -
	scripts/get_maintainer.pl
Date: Thu, 16 Aug 2007 19:13:03 -0700
Message-ID: <1187316783.822.19.camel@localhost>
References: <1186984174.10249.7.camel@localhost>
	 <200708131933.10125.m.kozlowski@tuxland.pl>
	 <1187026955.2688.4.camel@laptopd505.fenrus.org>
	 <1187037445.6628.98.camel@heimdal.trondhjem.org>
	 <1187054366.2757.0.camel@laptopd505.fenrus.org>
	 <46C10AA8.3090505@gmail.com> <20070814102033.604c8695@the-village.bc.nu>
	 <46C1CFFE.4000001@gmail.com> <1187110824.32555.76.camel@localhost>
	 <7vwsvx8twx.fsf@assigned-by-dhcp.cox.net>
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
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1765568AbXHQCNa@vger.kernel.org Fri Aug 17 04:13:46 2007
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1765568AbXHQCNa@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILrLK-0003j7-Ae
	for glk-linux-kernel-3@gmane.org; Fri, 17 Aug 2007 04:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765568AbXHQCNa (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 16 Aug 2007 22:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757494AbXHQCNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Aug 2007 22:13:16 -0400
Received: from DSL022.labridge.com ([206.117.136.22]:3373 "EHLO perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750897AbXHQCNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Aug 2007 22:13:14 -0400
Received: from [192.168.1.128] ([192.168.1.128])
	by perches.com (8.9.3/8.9.3) with ESMTP id TAA02379;
	Thu, 16 Aug 2007 19:34:34 -0700
In-Reply-To: <7vwsvx8twx.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.10.2-2.1mdv2007.1 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56038>

On Tue, 2007-08-14 at 18:31 -0700, Junio C Hamano wrote:
>    On the other hand, git-send-email _is_ all about sending it
>    out, and it needs to know who your patch should reach.  I
>    think it makes sense to have one script that, given a set of
>    paths that are affected, gives a list of potentially
>    interested people (that is "Finding" part -- and I see there
>    are 600+ patches to implement this on the list), and a new
>    option to git-send-email to (1) inspect the patch to see what
>    paths are affected, and (2) call that "Find" script to figure
>    out whom to send it to, and probably asking for confirmation.

Sorry, not a git developer, so the paths are wrong.
This seems to work:

Example:

git-send-email \
   --cc-cmd "perl scripts/get_maintainers.pl -non -multiline" foo.diff

--- git-send-email.pl	2007-08-16 19:06:07.000000000 -0700
+++ /usr/local/bin/git-send-email	2007-05-01 11:59:14.000000000 -0700
@@ -47,9 +47,6 @@ Options:
    --cc           Specify an initial "Cc:" list for the entire series
                   of emails.
 
-   --cc-cmd       Specify a command to execute per file which adds
-                  per file specific cc address entries
-
    --bcc          Specify a list of email addresses that should be Bcc:
 		  on all the emails.
 
@@ -143,7 +140,7 @@ my (@to,@cc,@initial_cc,@bcclist,@xh,
 
 # Behavior modification variables
 my ($chain_reply_to, $quiet, $suppress_from, $no_signed_off_cc,
-	$dry_run, $cc_cmd) = (1, 0, 0, 0, 0, 0);
+	$dry_run) = (1, 0, 0, 0, 0);
 my $smtp_server;
 my $envelope_sender;
 
@@ -176,7 +173,6 @@ my $rc = GetOptions("from=s" => \$from,
 		    "subject=s" => \$initial_subject,
 		    "to=s" => \@to,
 		    "cc=s" => \@initial_cc,
-		    "cc-cmd=s" => \$cc_cmd,
 		    "bcc=s" => \@bcclist,
 		    "chain-reply-to!" => \$chain_reply_to,
 		    "smtp-server=s" => \$smtp_server,
@@ -611,16 +607,6 @@ foreach my $t (@files) {
 		}
 	}
 	close F;
-
-	if (${cc_cmd} ne "") {
-	    my $output = `${cc_cmd} $t`;
-	    my @lines = split("\n", $output);
-	    foreach my $c (@lines) {
-		push @cc, $c;
-		printf("(sob) Adding cc: %s from cc-cmd: '%s'\n", $c, $t) unless $quiet;
-	    }
-	}
-
 	if (defined $author_not_sender) {
 		$author_not_sender = unquote_rfc2047($author_not_sender);
 		$message = "From: $author_not_sender\n\n$message";

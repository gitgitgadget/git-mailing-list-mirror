From: Junio C Hamano <junkio@cox.net>
Subject: Re: Make git-send-email detect mbox-style patches more readily
Date: Sat, 07 Oct 2006 03:09:05 -0700
Message-ID: <7vy7rssaim.fsf@assigned-by-dhcp.cox.net>
References: <20061006202414.GR2563@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 07 12:09:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GW97J-0000Oa-2O
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 12:09:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWJGKJH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 06:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbWJGKJH
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 06:09:07 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:37269 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750775AbWJGKJG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Oct 2006 06:09:06 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061007100906.OPOM12909.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Sat, 7 Oct 2006 06:09:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id XN981V0101kojtg0000000
	Sat, 07 Oct 2006 06:09:09 -0400
To: Matthew Wilcox <matthew@wil.cx>
In-Reply-To: <20061006202414.GR2563@parisc-linux.org> (Matthew Wilcox's
	message of "Fri, 6 Oct 2006 14:24:14 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28469>

Matthew Wilcox <matthew@wil.cx> writes:

> Earlier today, I embarrassed myself by trying to construct a patch that
> git-send-email would send, and I missed out the putting
>
> From garbage
>
> line on the front, which led it to send the patches with a
> Subject: From: Matthew Wilcox <matthew@wil.cx>
> line.  Bad.

I do not mind this patch per-se, but what do you prepare your
patch with?  Straight "diff -pu" between two directories?
quilt?

Since the command deals with two formats (mbox and "send lots of
email"), I am wondering if it would be bettern to loosen the
regexp you used further to catch something like this:

	/^[-A-Za-z]+:\s/

The reason why I suspect it would be better to do this loosening
is because I've queued the patch I did yesterday for Len to
allow the prepared patch file to contain custom header fields,
not just the set of headers hardcoded in the send-email script.

The second line in the "send lots of email" format is e-mail
subject, and it is conceivable that would match the above
pattern, so this may not be workable, though.

Maybe something like this?

diff --git a/git-send-email.perl b/git-send-email.perl
index 3f50aba..ed8652c 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -472,15 +472,21 @@ foreach my $t (@files) {
 
 	my $author_not_sender = undef;
 	@cc = @initial_cc;
-	my $found_mbox = 0;
+	my $input_format = undef;
 	my $header_done = 0;
 	$message = "";
 	while(<F>) {
 		if (!$header_done) {
-			$found_mbox = 1, next if (/^From /);
+			if (/^From /) {
+				$input_format = 'mbox';
+				next;
+			}
 			chomp;
+			if (!defined $input_format && /^[-A-Za-z]+:\s/) {
+				$input_format = 'mbox';
+			}
 
-			if ($found_mbox) {
+			if (defined $input_format && $input_format eq 'mbox') {
 				if (/^Subject:\s+(.*)$/) {
 					$subject = $1;
 
@@ -502,6 +508,7 @@ foreach my $t (@files) {
 				# line 1 = cc
 				# line 2 = subject
 				# So let's support that, too.
+				$input_format = 'lots';
 				if (@cc == 0) {
 					printf("(non-mbox) Adding cc: %s from line '%s'\n",
 						$_, $_) unless $quiet;

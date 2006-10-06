From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-send-email w/ headers
Date: Thu, 05 Oct 2006 23:09:18 -0700
Message-ID: <7v1wpm2cxd.fsf@assigned-by-dhcp.cox.net>
References: <200610041250.50272.len.brown@intel.com>
	<7viriy9w1q.fsf@assigned-by-dhcp.cox.net>
	<200610060041.56807.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 06 08:09:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVitj-0003CJ-HQ
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 08:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932616AbWJFGJU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 02:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932617AbWJFGJU
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 02:09:20 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:16305 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932616AbWJFGJT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Oct 2006 02:09:19 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061006060919.DYAV22977.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>;
          Fri, 6 Oct 2006 02:09:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Wu9M1V00d1kojtg0000000
	Fri, 06 Oct 2006 02:09:22 -0400
To: Len Brown <lenb@kernel.org>
In-Reply-To: <200610060041.56807.len.brown@intel.com> (Len Brown's message of
	"Fri, 6 Oct 2006 00:41:56 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28386>

Len Brown <len.brown@intel.com> writes:

> But the Signed-off-by: line from the original message body has
> now been swallowed up into the message header -- so my mailer
> doesn't display it.

Sorry, what I sent out has worse breakage than not having your
custom header.  It would eat the first paragraph of your message
X-<.

A replacement patch is attached.  If you have already applied
the previous patch, you can hand edit the line that says:

	$header .= join("\n", @xh);

to

	$header .= join("\n", @xh) . "\n";

It forgets to end the last line of the headers with LF.

---

diff --git a/git-send-email.perl b/git-send-email.perl
index 3f50aba..2fd5e87 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -83,7 +83,7 @@ # Constants (essentially)
 my $compose_filename = ".msg.$$";
 
 # Variables we fill in automatically, or via prompting:
-my (@to,@cc,@initial_cc,@bcclist,
+my (@to,@cc,@initial_cc,@bcclist,@xh,
 	$initial_reply_to,$initial_subject,@files,$from,$compose,$time);
 
 # Behavior modification variables
@@ -422,6 +422,9 @@ X-Mailer: git-send-email $gitversion
 		$header .= "In-Reply-To: $reply_to\n";
 		$header .= "References: $references\n";
 	}
+	if (@xh) {
+		$header .= join("\n", @xh) . "\n";
+	}
 
 	if ($smtp_server =~ m#^/#) {
 		my $pid = open my $sm, '|-';
@@ -472,6 +475,7 @@ foreach my $t (@files) {
 
 	my $author_not_sender = undef;
 	@cc = @initial_cc;
+	@xh = ();
 	my $found_mbox = 0;
 	my $header_done = 0;
 	$message = "";
@@ -495,6 +499,9 @@ foreach my $t (@files) {
 						$2, $_) unless $quiet;
 					push @cc, $2;
 				}
+				elsif (/^[-A-Za-z]+:\s+\S/) {
+					push @xh, $_;
+				}
 
 			} else {
 				# In the traditional

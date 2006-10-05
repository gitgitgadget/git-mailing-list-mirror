From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-send-email w/ headers
Date: Thu, 05 Oct 2006 16:34:25 -0700
Message-ID: <7viriy9w1q.fsf@assigned-by-dhcp.cox.net>
References: <200610041250.50272.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 06 01:34:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVcjc-0003rE-3X
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 01:34:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbWJEXe1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Oct 2006 19:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbWJEXe1
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Oct 2006 19:34:27 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:48570 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932429AbWJEXe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Oct 2006 19:34:26 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061005233426.ZDQE21457.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Thu, 5 Oct 2006 19:34:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WnaU1V00e1kojtg0000000
	Thu, 05 Oct 2006 19:34:29 -0400
To: Len Brown <lenb@kernel.org>
In-Reply-To: <200610041250.50272.len.brown@intel.com> (Len Brown's message of
	"Wed, 4 Oct 2006 12:50:50 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28376>

Len Brown <len.brown@intel.com> writes:

> git-send-email seems to strip out my custom headers.

It seems to not care about anything but a selected few.

Could you give this a try, please?

-- >8 --
git-send-email: do not drop custom headers the user prepared

The command picked up only Subject, CC, and From headers in the
incoming mbox text.  Sending out patches prepared by
git-format-patch with user's custom headers was impossible with
that.

Just keep the ones it does not need to look at and add them to
the header of the message when sending it out.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff --git a/git-send-email.perl b/git-send-email.perl
index 4a20310..77e4557 100755
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
+		$header .= join("\n", @xh);
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

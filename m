From: Junio C Hamano <junkio@cox.net>
Subject: Re: Fw: [PATCH 31/49] PCI: PCI/Cardbus cards hidden, needs pci=assign-busses to fix
Date: Thu, 23 Mar 2006 18:27:15 -0800
Message-ID: <7v3bh837cs.fsf@assigned-by-dhcp.cox.net>
References: <20060323161521.28a874e6.akpm@osdl.org>
	<20060324002930.GA21184@kroah.com>
	<20060323163844.5fda7589.akpm@osdl.org>
	<20060324004654.GA19763@kroah.com>
	<7vbqvw3a62.fsf@assigned-by-dhcp.cox.net>
	<20060323175126.7ff71032.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andrew Morton <akpm@osdl.org>
X-From: git-owner@vger.kernel.org Fri Mar 24 03:27:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMc1f-00022U-U0
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 03:27:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWCXC1W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Mar 2006 21:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932637AbWCXC1W
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Mar 2006 21:27:22 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:46219 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932145AbWCXC1W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Mar 2006 21:27:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060324022717.WUJP17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 23 Mar 2006 21:27:17 -0500
To: greg@kroah.com
In-Reply-To: <20060323175126.7ff71032.akpm@osdl.org> (Andrew Morton's message
	of "Thu, 23 Mar 2006 17:51:26 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17897>

Andrew Morton <akpm@osdl.org> writes:

> We wouldn't want to attempt to mix this concept up with email envelopes or
> email headers or anything like that.  The authorship is an attribute of the
> patch, and has nothing to do with how it was transported, stored or
> anything like that.

Fair enough.  This is the approach I called "the second best" in
my message but I am inclined to agree with you.

This was tested once by sending myself two patches.

-- >8 --
[PATCH] send-email: Identify author at the top when sending e-mail

git-send-email was not checking if the sender is the same as the
patch author.  Follow the "From: at the beginning" convention to
propagate the patch author correctly.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/git-send-email.perl b/git-send-email.perl
index 7c8d512..b220d11 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -307,6 +307,7 @@ $subject = $initial_subject;
 foreach my $t (@files) {
 	open(F,"<",$t) or die "can't open file $t";
 
+	my $author_not_sender = undef;
 	@cc = @initial_cc;
 	my $found_mbox = 0;
 	my $header_done = 0;
@@ -321,7 +322,12 @@ foreach my $t (@files) {
 					$subject = $1;
 
 				} elsif (/^(Cc|From):\s+(.*)$/) {
-					next if ($2 eq $from && $suppress_from);
+					if ($2 eq $from) {
+						next if ($suppress_from);
+					}
+					else {
+						$author_not_sender = $2;
+					}
 					printf("(mbox) Adding cc: %s from line '%s'\n",
 						$2, $_) unless $quiet;
 					push @cc, $2;
@@ -360,6 +366,9 @@ foreach my $t (@files) {
 		}
 	}
 	close F;
+	if (defined $author_not_sender) {
+		$message = "From: $author_not_sender\n\n$message";
+	}
 
 	$cc = join(", ", unique_email_list(@cc));
 

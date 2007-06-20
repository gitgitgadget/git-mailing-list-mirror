From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email: RFC2822 compliant Message-ID
Date: Wed, 20 Jun 2007 13:47:34 -0700
Message-ID: <7v7ipytkt5.fsf@assigned-by-dhcp.pobox.com>
References: <11823459011323-git-send-email-michael@ndrix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Hendricks <michael@ndrix.org>
X-From: git-owner@vger.kernel.org Wed Jun 20 22:47:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I175W-00029m-7D
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 22:47:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbXFTUrh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 16:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbXFTUrg
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 16:47:36 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:35503 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396AbXFTUrg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 16:47:36 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070620204733.LVGR3993.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Wed, 20 Jun 2007 16:47:33 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Dwna1X00N1kojtg0000000; Wed, 20 Jun 2007 16:47:35 -0400
In-Reply-To: <11823459011323-git-send-email-michael@ndrix.org> (Michael
	Hendricks's message of "Wed, 20 Jun 2007 07:25:01 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50569>

How about doing this instead?

 * Move call to make_message_id() to where it matters, namely,
   before the $message_id is needed to be placed in the
   generated e-mail header; this has an important side effect of
   making it clear that $from is already available.

 * Throw in Sys::Hostname::hostname() just for fun, although I
   suspect that the code would never trigger due to the modified
   call sequence that makes sure $from is always available.

---

diff --git a/git-send-email.perl b/git-send-email.perl
index 7c0c90b..9f75551 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -412,13 +412,21 @@ sub extract_valid_address {
 # 1 second since the last time we were called.
 
 # We'll setup a template for the message id, using the "from" address:
-my $message_id_from = extract_valid_address($from);
-my $message_id_template = "<%s-git-send-email-$message_id_from>";
 
 sub make_message_id
 {
 	my $date = time;
 	my $pseudo_rand = int (rand(4200));
+	my $du_part;
+	for ($from, $committer, $author) {
+		$du_part = extract_valid_address($_);
+		last if ($du_part ne '');
+	}
+	if ($du_part eq '') {
+		use Sys::Hostname qw();
+		$du_part = 'user@' . Sys::Hostname::hostname();
+	}
+	my $message_id_template = "<%s-git-send-email-$du_part>";
 	$message_id = sprintf $message_id_template, "$date$pseudo_rand";
 	#print "new message id = $message_id\n"; # Was useful for debugging
 }
@@ -467,6 +475,8 @@ sub send_message
 		$ccline = "\nCc: $cc";
 	}
 	$from = sanitize_address_rfc822($from);
+	make_message_id();
+
 	my $header = "From: $from
 To: $to${ccline}
 Subject: $subject
@@ -533,7 +543,6 @@ X-Mailer: git-send-email $gitversion
 
 $reply_to = $initial_reply_to;
 $references = $initial_reply_to || '';
-make_message_id();
 $subject = $initial_subject;
 
 foreach my $t (@files) {
@@ -627,7 +636,6 @@ foreach my $t (@files) {
 			$references = "$message_id";
 		}
 	}
-	make_message_id();
 }
 
 if ($compose) {

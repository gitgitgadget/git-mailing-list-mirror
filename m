From: Junio C Hamano <junio@pobox.com>
Subject: [PATCH 2/6] send-email: fix non-threaded mails
Date: Wed, 10 Jun 2009 00:16:13 -0700
Message-ID: <7vr5xstv7m.fsf@alter.siamese.dyndns.org>
References: <1244410857-920-1-git-send-email-markus.heidelberg@web.de>
	<1244410857-920-4-git-send-email-markus.heidelberg@web.de>
	<7vhbyo1vr7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Witten <mfwitten@gmail.com>
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Wed Jun 10 09:16:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEI2q-0007la-LD
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 09:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753307AbZFJHQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 03:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753232AbZFJHQM
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 03:16:12 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:52598 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753192AbZFJHQL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 03:16:11 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090610071614.NSRZ17670.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 10 Jun 2009 03:16:14 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 27GD1c00E4aMwMQ047GDDw; Wed, 10 Jun 2009 03:16:13 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=-Lt4Nlr--RwA:10 a=qJrc7L8M5mcA:10
 a=ybZZDoGAAAAA:8 a=A1X0JdhQAAAA:8 a=8ve4Z51ExzC_PcuFcuUA:9
 a=ArxvGoQZcb7XjuE5wFfXPwHYdaEA:4 a=MCAouRVjatsA:10 a=5N_Nib3jKbIA:10
 a=XTUYKXyG0EEA:10 a=5KVauyKsRKMA:10 a=qIVjreYYsbEA:10 a=Y6qChIQXU1wA:10
 a=c-BNxvpMH2kzHS1M:21 a=fYHhARZh7WdSJmmR:21
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121255>

From: Markus Heidelberg <markus.heidelberg@web.de>
Date: Mon, 8 Jun 2009 08:43:56 +0200

After commit 3e0c4ff (send-email: respect in-reply-to regardless of
threading, 2009-03-01) the variable $thread was only used for prompting
for an "In-Reply-To", but not for controlling whether the "In-Reply-To"
and "References" fields should be written into the email.

Thus these fields were always used beginning with the second mail and it
was not possible to produce non-threaded mails anymore until commit
15da108 ("send-email: 'References:' should only reference what is sent",
2009-04-13), which introduced a regression with the side effect to make
it possible again when --no-chain-reply-to was set.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Applies on top of [1/6]

 git-send-email.perl   |    3 ++-
 t/t9001-send-email.sh |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index cccbf45..5d51697 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1137,7 +1137,8 @@ foreach my $t (@files) {
 	send_message();
 
 	# set up for the next message
-	if ($chain_reply_to || !defined $reply_to || length($reply_to) == 0) {
+	if ($thread &&
+		($chain_reply_to || !defined $reply_to || length($reply_to) == 0)) {
 		$reply_to = $message_id;
 		if (length $references > 0) {
 			$references .= "\n $message_id";
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 5bfa36e..8518aca 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -621,7 +621,7 @@ test_expect_success 'in-reply-to but no threading' '
 	grep "In-Reply-To: <in-reply-id@example.com>"
 '
 
-test_expect_failure 'no in-reply-to and no threading' '
+test_expect_success 'no in-reply-to and no threading' '
 	git send-email \
 		--dry-run \
 		--from="Example <nobody@example.com>" \
-- 
1.6.3.2.214.gf4f78e

From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH 5/6] send-email: fix non-threaded mails
Date: Sun,  7 Jun 2009 23:40:56 +0200
Message-ID: <1244410857-920-6-git-send-email-markus.heidelberg@web.de>
References: <1244410857-920-1-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>,
	Thomas Rast <trast@student.ethz.ch>,
	Michael Witten <mfwitten@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 07 23:41:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDQ7b-0004bz-0H
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 23:41:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756191AbZFGVlW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 17:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756147AbZFGVlQ
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 17:41:16 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:36562 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752947AbZFGVlE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 17:41:04 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id A68A9FF04610;
	Sun,  7 Jun 2009 23:41:06 +0200 (CEST)
Received: from [89.59.87.118] (helo=localhost.localdomain)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MDQ70-0007ZM-01; Sun, 07 Jun 2009 23:41:06 +0200
X-Mailer: git-send-email 1.6.3.2.221.g0ff2f
In-Reply-To: <1244410857-920-1-git-send-email-markus.heidelberg@web.de>
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18AQDpb9InQl0GOk0GWRGvPQ6hUnAmdJwni2x4r
	m32cAWF6DzCFu6HSDtN43fqe7oSZ04Q2cCFi8Q4CG8WeohuBTl
	zaI0wfXTAaB0At9Ku2Tg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121009>

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
---
 git-send-email.perl   |    5 ++++-
 t/t9001-send-email.sh |    2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index c11a245..be63ea7 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1142,7 +1142,10 @@ foreach my $t (@files) {
 	my $message_was_sent = send_message();
 
 	# set up for the next message
-	if ($message_was_sent and $chain_reply_to || !defined $reply_to || length($reply_to) == 0) {
+	if ($message_was_sent and $thread and
+			$chain_reply_to || !defined $reply_to || length($reply_to) == 0) {
+		# with --chain-reply-to every time
+		# else only after the first mail (and only if --in-reply-to was not specified)
 		$reply_to = $message_id;
 		if (length $references > 0) {
 			$references .= "\n $message_id";
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 9cddd5f..12433a7 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -621,7 +621,7 @@ test_expect_success 'in-reply-to but no threading' '
 	grep "In-Reply-To: <in-reply-id@example.com>"
 '
 
-test_expect_failure 'no in-reply-to and no threading' '
+test_expect_success 'no in-reply-to and no threading' '
 	! git send-email \
 		--dry-run \
 		--from="Example <nobody@example.com>" \
-- 
1.6.3.2.221.g0ff2f

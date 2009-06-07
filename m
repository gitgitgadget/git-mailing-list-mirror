From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH 3/6] send-email: fix threaded mails without chain-reply-to
Date: Sun,  7 Jun 2009 23:40:54 +0200
Message-ID: <1244410857-920-4-git-send-email-markus.heidelberg@web.de>
References: <1244410857-920-1-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>,
	Michael Witten <mfwitten@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 07 23:41:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDQ7a-0004bz-9r
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 23:41:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756155AbZFGVlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 17:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756144AbZFGVlP
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 17:41:15 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:36551 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754388AbZFGVlE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 17:41:04 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id A628CFF0452F;
	Sun,  7 Jun 2009 23:41:05 +0200 (CEST)
Received: from [89.59.87.118] (helo=localhost.localdomain)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MDQ6z-0007ZM-01; Sun, 07 Jun 2009 23:41:05 +0200
X-Mailer: git-send-email 1.6.3.2.221.g0ff2f
In-Reply-To: <1244410857-920-1-git-send-email-markus.heidelberg@web.de>
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+Rt8X8SJ7cdUjokCTXyvRFGbkqr6/M5HvG21cU
	wOnUYvjSEBAR4z8JBj83V3q4h0S9OFjLmhSTDmlGZSD3lOFMkV
	6uhpLI1NKHv+g7I8LcKg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121010>

These commands didn't send threaded mails anymore:

    $ git format-patch <revision range>
    $ git send-email --thread --no-chain-reply-to <files>

This regression was introduced in commit 15da108 ("send-email:
'References:' should only reference what is sent", 2009-04-13) by a
hidden code style change:

    ! defined $reply_to || length($reply_to) == 0
was changed to
    not defined $reply_to || length($reply_to) == 0
which is
    not (defined $reply_to || length($reply_to) == 0)
instead of
    (not defined $reply_to) || (length($reply_to) == 0)

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 git-send-email.perl   |    2 +-
 t/t9001-send-email.sh |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 5b7ab4e..c11a245 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1142,7 +1142,7 @@ foreach my $t (@files) {
 	my $message_was_sent = send_message();
 
 	# set up for the next message
-	if ($message_was_sent and $chain_reply_to || not defined $reply_to || length($reply_to) == 0) {
+	if ($message_was_sent and $chain_reply_to || !defined $reply_to || length($reply_to) == 0) {
 		$reply_to = $message_id;
 		if (length $references > 0) {
 			$references .= "\n $message_id";
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 4ccca44..41af35a 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -621,7 +621,7 @@ test_expect_success 'in-reply-to but no threading' '
 	grep "In-Reply-To: <in-reply-id@example.com>"
 '
 
-test_expect_failure 'threading but no chain-reply-to' '
+test_expect_success 'threading but no chain-reply-to' '
 	git send-email \
 		--dry-run \
 		--from="Example <nobody@example.com>" \
-- 
1.6.3.2.221.g0ff2f

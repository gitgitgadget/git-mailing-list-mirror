From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH 2/2] send-email: fix non-threaded mails
Date: Tue,  9 Jun 2009 09:11:31 +0200
Message-ID: <1244531491-21312-2-git-send-email-markus.heidelberg@web.de>
References: <200906090905.58446.markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 09:12:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDvV5-0006i9-Pd
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 09:12:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758115AbZFIHLm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 03:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758187AbZFIHLk
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 03:11:40 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:33952 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758228AbZFIHLj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 03:11:39 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id 9DFE7FF213ED;
	Tue,  9 Jun 2009 09:11:40 +0200 (CEST)
Received: from [89.59.118.0] (helo=localhost.localdomain)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MDvUi-00040F-01; Tue, 09 Jun 2009 09:11:40 +0200
X-Mailer: git-send-email 1.6.3.2.8.g055bf
In-Reply-To: <200906090905.58446.markus.heidelberg@web.de>
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19CeKTaad/W949rJ8R0E6KGKxoII3XTA9vvRdj7
	7P/PVVUfExTQOmD98Pwr+K6DMBpAF/Q5fgs+Y8cru+4GhVdmAg
	2QRWvdzT+ncGYWx4AZ8Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121145>

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
index cccbf45..3f31b7b 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1137,7 +1137,10 @@ foreach my $t (@files) {
 	send_message();
 
 	# set up for the next message
-	if ($chain_reply_to || !defined $reply_to || length($reply_to) == 0) {
+	if ($thread and
+			$chain_reply_to || !defined $reply_to || length($reply_to) == 0) {
+		# with --chain-reply-to every time
+		# else only after the first mail (and only if --in-reply-to was not specified)
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
1.6.3.2.8.g055bf

From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH 2/2] send-email: fix threaded mails without chain-reply-to
Date: Sun,  7 Jun 2009 17:20:19 +0200
Message-ID: <1244388019-12763-2-git-send-email-markus.heidelberg@web.de>
References: <200906061414.27371.markus.heidelberg@web.de>
 <1244388019-12763-1-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Michael Witten <mfwitten@gmail.com>,
	Markus Heidelberg <markus.heidelberg@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 07 17:20:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDKAs-0003iV-Ql
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 17:20:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755268AbZFGPUc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 11:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754932AbZFGPUa
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 11:20:30 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:57066 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754748AbZFGPUa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 11:20:30 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id E03BF104B03DA;
	Sun,  7 Jun 2009 17:20:31 +0200 (CEST)
Received: from [89.59.87.118] (helo=localhost.localdomain)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MDKAh-0001nD-01; Sun, 07 Jun 2009 17:20:31 +0200
X-Mailer: git-send-email 1.6.3.2.216.g24c61
In-Reply-To: <1244388019-12763-1-git-send-email-markus.heidelberg@web.de>
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/uzncT4NQ6PnNcANNgoOkVTFhsbLGyCna0Bhv1
	0CpIaS3ckmquGXDq1WBoTHCI9I8wkkUHXGrk1rA0dZslkkI6di
	PHXBnm7i+bUXQh5CVDRA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120978>

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
index 3d6a982..c914bff 100755
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
index 576bbd3..bb03aa4 100755
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
1.6.3.2.216.g24c61

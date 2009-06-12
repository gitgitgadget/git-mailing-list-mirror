From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH 2/6] send-email: fix non-threaded mails
Date: Fri, 12 Jun 2009 12:51:38 +0200
Message-ID: <1244803902-8068-2-git-send-email-markus.heidelberg@web.de>
References: <1244803766-7785-1-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Michael Witten <mfwitten@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 12:52:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MF4N1-0002Bm-OT
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 12:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933564AbZFLKvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 06:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760305AbZFLKvs
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 06:51:48 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:32873 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933557AbZFLKvp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 06:51:45 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id 48579FFA03EA;
	Fri, 12 Jun 2009 12:51:47 +0200 (CEST)
Received: from [89.59.124.123] (helo=localhost.localdomain)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MF4MN-00044V-00; Fri, 12 Jun 2009 12:51:47 +0200
X-Mailer: git-send-email 1.6.3.2.236.ge505d
In-Reply-To: <1244803766-7785-1-git-send-email-markus.heidelberg@web.de>
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18S4nc0lnPHdwKi1aMDVJRledCZyOteuSbt/P0C
	nldcdCzsoN6IZHMYB3mFAKWL4YAj1vhEuD3oG3ujL26b0Vmz/g
	pgEAAWJq3+tqixb2UwaA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121402>

After commit 3e0c4ff (send-email: respect in-reply-to regardless of
threading, 2009-03-01) the variable $thread was only used for prompting
for an "In-Reply-To", but not for controlling whether the "In-Reply-To"
and "References" fields should be written into the email.

Thus these fields were always used beginning with the second mail and it
was not possible to produce non-threaded mails anymore.

However, a later commit 15da108 ("send-email: 'References:' should only
reference what is sent", 2009-04-13) introduced a regression with the
side effect to make non-threaded mails possible again, but only when
--no-chain-reply-to was used.

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
1.6.3.2.236.ge505d

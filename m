From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH v3] git-send-email.perl: make initial In-Reply-To apply only to first email
Date: Fri,  5 Nov 2010 21:59:29 +0100
Message-ID: <1288990769-13307-1-git-send-email-ospite@studenti.unina.it>
References: <20101020004533.b64d446c.ospite@studenti.unina.it>
Cc: Antonio Ospite <ospite@studenti.unina.it>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Brandon Casey <drafnel@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 05 21:59:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PETNv-0002l7-9h
	for gcvg-git-2@lo.gmane.org; Fri, 05 Nov 2010 21:59:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754770Ab0KEU7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Nov 2010 16:59:38 -0400
Received: from smtp206.alice.it ([82.57.200.102]:37090 "EHLO smtp206.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752956Ab0KEU7g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Nov 2010 16:59:36 -0400
Received: from jcn (87.1.14.101) by smtp206.alice.it (8.5.124.08)
        id 4C1A268C094DBFF8; Fri, 5 Nov 2010 21:59:34 +0100
Received: from ao2 by jcn with local (Exim 4.72)
	(envelope-from <ospite@studenti.unina.it>)
	id 1PETNk-0003T8-Qg; Fri, 05 Nov 2010 21:59:32 +0100
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <20101020004533.b64d446c.ospite@studenti.unina.it>
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160822>

When an initial In-Reply-To is supplied it should apply only to the
first email, second and subsequent messages should behave just according
to the --[no-]chain-reply-to setting; this is the typical behaviour we
want when we send a series with cover letter in reply to some
discussion, this is what the man page says about the
--[no-]chain-reply-to option and this is also how the --in-reply-to
option behaves in git-format-patch.

Moreover, when $initial_reply_to is asked to the user interactively it
is asked as the "Message-ID to be used as In-Reply-To for the _first_
email", this makes the user think that the second and subsequent patches
are not using it but are considered as replies to the first message or
chained according to the --[no-]chain-reply setting.

Adjust also the documentation about --in-reply-to to avoid ambiguities.

NOTE: This patch changes the current behaviour and brings it to be what
I think was the intentions stated in the documentation, also aligning it
to how git-format-patch behaves; in order to achieve the old behaviour
of a flat structure in reply to something the user can always use
"--no-thread --in-reply-to <...>".

Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
---

Changes since v2:
 - Make the purpose of the patch more explicit
 - Adjust the documentation
 - Make the test narrower and more explicit as well

I am CCing some of the latest contributors to git-send-email.perl

Juno, there are still some unanswered questions (one about the
and-chains in tests) in one of previous mails in this thread.

With Best Regards,
   Antonio

 Documentation/git-send-email.txt |    8 +++++---
 git-send-email.perl              |    3 ++-
 t/t9001-send-email.sh            |   14 ++++++++++++++
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 05904e0..acbff9b 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -82,9 +82,11 @@ See the CONFIGURATION section for 'sendemail.multiedit'.
 	set, as returned by "git var -l".
 
 --in-reply-to=<identifier>::
-	Specify the contents of the first In-Reply-To header.
-	Subsequent emails will refer to the previous email
-	instead of this if --chain-reply-to is set.
+	Make the first mail (or all the mails with `--no-thread`) appear as a
+	reply to the given Message-Id, which avoids breaking threads to
+	provide a new patch series.
+	The second and subsequent emails will be sent as replies according to
+	the --[no]-chain-reply-to setting.
 	Only necessary if --compose is also set.  If --compose
 	is not set, this will be prompted for.
 
diff --git a/git-send-email.perl b/git-send-email.perl
index f68ed5a..fe6b848 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1319,7 +1319,8 @@ foreach my $t (@files) {
 
 	# set up for the next message
 	if ($thread && $message_was_sent &&
-		(chain_reply_to() || !defined $reply_to || length($reply_to) == 0)) {
+		(chain_reply_to() || !defined $reply_to || length($reply_to) == 0 ||
+		$message_num == 1)) {
 		$reply_to = $message_id;
 		if (length $references > 0) {
 			$references .= "\n $message_id";
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index d1ba252..c85be0f 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -313,6 +313,20 @@ test_expect_success $PREREQ 'Valid In-Reply-To when prompting' '
 	! grep "^In-Reply-To: < *>" msgtxt1
 '
 
+test_expect_success $PREREQ 'Apply initial In-Reply-To only to first patch with --thread' '
+	clean_fake_sendmail &&
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--thread \
+		--in-reply-to="<unique-message-id@example.com>" \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		$patches $patches \
+		2>errors
+        # The second message should not have the initial In-Reply-To
+        test $(sed -n -e "s/^In-Reply-To: \(.*\)/\1/p" msgtxt2) != "<unique-message-id@example.com>"
+'
+
 test_expect_success $PREREQ 'setup fake editor' '
 	(echo "#!$SHELL_PATH" &&
 	 echo "echo fake edit >>\"\$1\""
-- 
1.7.2.3

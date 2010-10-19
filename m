From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH v2] git-send-email.perl: fix In-Reply-To for second and subsequent patches
Date: Tue, 19 Oct 2010 11:52:44 +0200
Message-ID: <1287481964-8883-1-git-send-email-ospite@studenti.unina.it>
References: <20101015095651.b75c4b54.ospite@studenti.unina.it>
Cc: Antonio Ospite <ospite@studenti.unina.it>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 19 11:53:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P88ss-0006Sl-Ss
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 11:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758166Ab0JSJxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 05:53:24 -0400
Received: from smtp207.alice.it ([82.57.200.103]:39231 "EHLO smtp207.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756596Ab0JSJxX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 05:53:23 -0400
Received: from jcn (82.57.81.162) by smtp207.alice.it (8.5.124.08)
        id 4C9E16C901B8D77A; Tue, 19 Oct 2010 11:53:22 +0200
Received: from ao2 by jcn with local (Exim 4.72)
	(envelope-from <ospite@studenti.unina.it>)
	id 1P88sa-0002Jy-6Z; Tue, 19 Oct 2010 11:53:12 +0200
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <20101015095651.b75c4b54.ospite@studenti.unina.it>
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159318>

Make second and subsequent patches appear as replies to the first patch,
even when an initial In-Reply-To is supplied; this is the typical
behaviour we want when we send a series with cover letter in reply to
some discussion, and this is also what the man page says about
the --in-reply-to option.

When $initial_reply_to is asked to the user interactively it is asked as
the "Message-ID to be used as In-Reply-To for the _first_ email", this
makes the user think that the second and subsequent patches are not
using it but are considered as replies to the first message or chained
according to the --[no-]chain-reply setting.

In order to achieve the old behaviour of a flat structure in reply to
something the user can always use "--no-thread --in-reply-to <...>".

Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
---

Changes since v1:
 - add more details about the interactive case in the commit message
 - split long line as requested by Jonathan Nieder
 - add a test case in t/t9001-send-email.sh, please check that, I am not
   comparing the strings inside '<>' is it necessary to be so strict?
   Note to self: remember to run 'make' before running t9001-send-email.sh :)

Thanks,
   Antonio Ospite
   http://ao2.it

 git-send-email.perl   |    3 ++-
 t/t9001-send-email.sh |   14 ++++++++++++++
 2 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 8cc4161..bc4e318 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1313,7 +1313,8 @@ foreach my $t (@files) {
 
 	# set up for the next message
 	if ($thread && $message_was_sent &&
-		(chain_reply_to() || !defined $reply_to || length($reply_to) == 0)) {
+		(chain_reply_to() || !defined $reply_to || length($reply_to) == 0 ||
+		$message_num == 1)) {
 		$reply_to = $message_id;
 		if (length $references > 0) {
 			$references .= "\n $message_id";
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index a298eb0..410b85f 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -295,6 +295,20 @@ test_expect_success $PREREQ 'Valid In-Reply-To when prompting' '
 	! grep "^In-Reply-To: < *>" msgtxt1
 '
 
+test_expect_success $PREREQ 'In-Reply-To in second patch with --thread' '
+	clean_fake_sendmail &&
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--thread \
+		--in-reply-to="<unique-message-id@example.com>" \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		$patches $patches \
+		2>errors
+        # The second patch should be seen as reply to the first one
+        test $(sed -n -e "s/^In-Reply-To:\(.*\)/\1/p" msgtxt2) = $(sed -n -e "s/^Message-Id:\(.*\)/\1/p" msgtxt1)
+'
+
 test_expect_success $PREREQ 'setup fake editor' '
 	(echo "#!$SHELL_PATH" &&
 	 echo "echo fake edit >>\"\$1\""
-- 
1.7.2.3

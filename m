From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCHi v4] git-send-email.perl: make initial In-Reply-To apply only to first email
Date: Fri, 12 Nov 2010 15:55:08 +0100
Message-ID: <1289573708-18573-1-git-send-email-ospite@studenti.unina.it>
References: <7v62w5hsd4.fsf@alter.siamese.dyndns.org>
Cc: Antonio Ospite <ospite@studenti.unina.it>,
	Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Brandon Casey <drafnel@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 12 15:55:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGv2D-0006YD-La
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 15:55:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757440Ab0KLOzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 09:55:20 -0500
Received: from smtp205.alice.it ([82.57.200.101]:39344 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757359Ab0KLOzT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 09:55:19 -0500
Received: from jcn (79.2.146.76) by smtp205.alice.it (8.5.124.08)
        id 4C1A26450A367FC7; Fri, 12 Nov 2010 15:55:17 +0100
Received: from ao2 by jcn with local (Exim 4.72)
	(envelope-from <ospite@studenti.unina.it>)
	id 1PGv23-0004q5-9K; Fri, 12 Nov 2010 15:55:15 +0100
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7v62w5hsd4.fsf@alter.siamese.dyndns.org>
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161345>

When an initial In-Reply-To is supplied it should apply only to the
first email, second and subsequent messages should behave just according
to the --[no-]chain-reply-to setting; this is also what the man page
says about the --[no-]chain-reply-to option and this is also how the
correspondent git-format-patch option behaves.

This is the typical behaviour we    |
want when we send a series with     | [PATCH 0/2] Here is what I did...
cover letter in reply to some       |   [PATCH 1/2] Clean up and tests
discussion, the new patch series    |   [PATCH 2/2] Implementation
should appear as a separate subtree |   [PATCH v2 0/3] Here is a reroll
in the discussion, look at the v2   |     [PATCH v2 1/3] Clean up
series in the illustration on the   |     [PATCH v2 2/3] New tests
right to see what the new behaviour |     [PATCH v2 3/3] Implementation
ensures.                            |

Moreover, when $initial_reply_to is asked to the user interactively it
is asked as the "Message-ID to be used as In-Reply-To for the _first_
email", this makes the user think that the second and subsequent patches
are not using it but are considered as replies to the first message or
chained according to the --[no-]chain-reply setting.

Fix also the documentation about --in-reply-to to avoid ambiguities.

NOTE: This patch changes the current behaviour and brings it to be what
I think were the intentions stated in the documentation, also aligning it
to how git-format-patch behaves; in order to achieve the old behaviour
of a flat structure in reply to something the user can always use
"--no-thread --in-reply-to <...>".

Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
---

Hoping we are there. Patch is on top of origin/next.

Changes since v3:
 - Change the test about 'In-Reply-To without --chain-reply-to' instead of
   providing  a new one.
 - Illustrate an actual use case when describing the new behaviour, both in
   the commit message and in the documentation.

It is cool to see how such a small change in the code requires quite some
"communication overhead", not a big surprise in general but in this case I
wonder if I've been overly verbose.

Junio, if you feel that the documentation and the commit message can be slimmed
down feel free to do it when committing the patch.

Matthieu, maybe we can have a Tested-by: you, can't we?

Thanks a lot,
   Antonio

 Documentation/git-send-email.txt |   25 ++++++++++++++++++++-----
 git-send-email.perl              |    3 ++-
 t/t9001-send-email.sh            |    4 +++-
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 05904e0..ebc024a 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -82,11 +82,26 @@ See the CONFIGURATION section for 'sendemail.multiedit'.
 	set, as returned by "git var -l".
 
 --in-reply-to=<identifier>::
-	Specify the contents of the first In-Reply-To header.
-	Subsequent emails will refer to the previous email
-	instead of this if --chain-reply-to is set.
-	Only necessary if --compose is also set.  If --compose
-	is not set, this will be prompted for.
+	Make the first mail (or all the mails with `--no-thread`) appear as a
+	reply to the given Message-Id, which avoids breaking threads to
+	provide a new patch series.
+	The second and subsequent emails will be sent as replies according to
+	the `--[no]-chain-reply-to` setting.
++
+So for example when `--thread` and `--no-chain-reply-to` are specified, the
+second and subsequent patches will be replies to the first one like in the
+illustration below where `[PATCH v2 0/3]` is in reply to `[PATCH 0/2]`:
++
+  [PATCH 0/2] Here is what I did...
+    [PATCH 1/2] Clean up and tests
+    [PATCH 2/2] Implementation
+    [PATCH v2 0/3] Here is a reroll
+      [PATCH v2 1/3] Clean up
+      [PATCH v2 2/3] New tests
+      [PATCH v2 3/3] Implementation
++
+Only necessary if --compose is also set.  If --compose
+is not set, this will be prompted for.
 
 --subject=<string>::
 	Specify the initial subject of the email thread.
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
index 26c2e93..5e48318 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -324,9 +324,11 @@ test_expect_success $PREREQ 'In-Reply-To without --chain-reply-to' '
 		--smtp-server="$(pwd)/fake.sendmail" \
 		$patches $patches $patches \
 		2>errors &&
-	# All the messages are replies to --in-reply-to
+	# The first message is a reply to --in-reply-to
 	sed -n -e "s/^In-Reply-To: *\(.*\)/\1/p" msgtxt1 >actual &&
 	test_cmp expect actual &&
+	# Second and subsequent messages are replies to the first one
+	sed -n -e "s/^Message-Id: *\(.*\)/\1/p" msgtxt1 >expect &&
 	sed -n -e "s/^In-Reply-To: *\(.*\)/\1/p" msgtxt2 >actual &&
 	test_cmp expect actual &&
 	sed -n -e "s/^In-Reply-To: *\(.*\)/\1/p" msgtxt3 >actual &&
-- 
1.7.2.3

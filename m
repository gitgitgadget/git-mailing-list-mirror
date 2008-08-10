From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: use $TEST_DIRECTORY to refer to the t/ directory
Date: Sun, 10 Aug 2008 00:33:18 -0700
Message-ID: <7vvdy92ukh.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0808080752210.9611@pacific.mpi-cbg.de.mpi-cbg.de>
 <alpine.DEB.1.00.0808080754230.9611@pacific.mpi-cbg.de.mpi-cbg.de>
 <489BF95F.1070000@lsrfire.ath.cx> <7vprojgbbu.fsf@gitster.siamese.dyndns.org>
 <7vod43etuw.fsf_-_@gitster.siamese.dyndns.org> <489E1FDB.5070700@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Sun Aug 10 09:34:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KS5Ro-0002Ow-KN
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 09:34:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165AbYHJHdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 03:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752157AbYHJHdh
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 03:33:37 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58110 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062AbYHJHdg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 03:33:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 81CC253435;
	Sun, 10 Aug 2008 03:33:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5228253433; Sun, 10 Aug 2008 03:33:23 -0400 (EDT)
In-Reply-To: <489E1FDB.5070700@free.fr> (Olivier Marin's message of "Sun, 10
 Aug 2008 00:53:15 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A08D9E08-66AE-11DD-B1E6-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91805>

> OK, I read the diff and found some trivial quoting issues that will break the
> following tests if $TEST_DIRECTORY contain a space:

Thanks.  I think this should catch all of them.  I've run the tests in a
clone that has SP in it.

 t/t4101-apply-nonl.sh |    7 ++++---
 t/t5100-mailinfo.sh   |   17 +++++++++--------
 t/t7500-commit.sh     |   39 +++++++++++++++++++++++++++++----------
 3 files changed, 42 insertions(+), 21 deletions(-)

diff --git a/t/t4101-apply-nonl.sh b/t/t4101-apply-nonl.sh
index 1391d20..e3443d0 100755
--- a/t/t4101-apply-nonl.sh
+++ b/t/t4101-apply-nonl.sh
@@ -21,9 +21,10 @@ do
   do
     test $i -eq $j && continue
     cat frotz.$i >frotz
-    test_expect_success \
-        "apply diff between $i and $j" \
-	"git apply <"$TEST_DIRECTORY"/t4101/diff.$i-$j && diff frotz.$j frotz"
+    test_expect_success "apply diff between $i and $j" '
+	git apply <"$TEST_DIRECTORY"/t4101/diff.$i-$j &&
+	test_cmp frotz.$j frotz
+    '
   done
 done
 
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index a40d48b..c3ab881 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -15,20 +15,21 @@ test_expect_success 'split sample box' \
 
 for mail in `echo 00*`
 do
-	test_expect_success "mailinfo $mail" \
-		"git mailinfo -u msg$mail patch$mail <$mail >info$mail &&
+	test_expect_success "mailinfo $mail" '
+		git mailinfo -u msg$mail patch$mail <$mail >info$mail &&
 		echo msg &&
-		diff "$TEST_DIRECTORY"/t5100/msg$mail msg$mail &&
+		test_cmp "$TEST_DIRECTORY"/t5100/msg$mail msg$mail &&
 		echo patch &&
-		diff "$TEST_DIRECTORY"/t5100/patch$mail patch$mail &&
+		test_cmp "$TEST_DIRECTORY"/t5100/patch$mail patch$mail &&
 		echo info &&
-		diff "$TEST_DIRECTORY"/t5100/info$mail info$mail"
+		test_cmp "$TEST_DIRECTORY"/t5100/info$mail info$mail
+	'
 done
 
 test_expect_success 'respect NULs' '
 
 	git mailsplit -d3 -o. "$TEST_DIRECTORY"/t5100/nul-plain &&
-	cmp "$TEST_DIRECTORY"/t5100/nul-plain 001 &&
+	test_cmp "$TEST_DIRECTORY"/t5100/nul-plain 001 &&
 	(cat 001 | git mailinfo msg patch) &&
 	test 4 = $(wc -l < patch)
 
@@ -37,9 +38,9 @@ test_expect_success 'respect NULs' '
 test_expect_success 'Preserve NULs out of MIME encoded message' '
 
 	git mailsplit -d5 -o. "$TEST_DIRECTORY"/t5100/nul-b64.in &&
-	cmp "$TEST_DIRECTORY"/t5100/nul-b64.in 00001 &&
+	test_cmp "$TEST_DIRECTORY"/t5100/nul-b64.in 00001 &&
 	git mailinfo msg patch <00001 &&
-	cmp "$TEST_DIRECTORY"/t5100/nul-b64.expect patch
+	test_cmp "$TEST_DIRECTORY"/t5100/nul-b64.expect patch
 
 '
 
diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
index 86c1647..7ae0bd0 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -46,15 +46,24 @@ test_expect_success 'unedited template with comments should not commit' '
 '
 
 test_expect_success 'a Signed-off-by line by itself should not commit' '
-	! GIT_EDITOR="$TEST_DIRECTORY"/t7500/add-signed-off git commit --template "$TEMPLATE"
+	(
+		test_set_editor "$TEST_DIRECTORY"/t7500/add-signed-off &&
+		test_must_fail git commit --template "$TEMPLATE"
+	)
 '
 
 test_expect_success 'adding comments to a template should not commit' '
-	! GIT_EDITOR="$TEST_DIRECTORY"/t7500/add-comments git commit --template "$TEMPLATE"
+	(
+		test_set_editor "$TEST_DIRECTORY"/t7500/add-comments &&
+		test_must_fail git commit --template "$TEMPLATE"
+	)
 '
 
 test_expect_success 'adding real content to a template should commit' '
-	GIT_EDITOR="$TEST_DIRECTORY"/t7500/add-content git commit --template "$TEMPLATE" &&
+	(
+		test_set_editor "$TEST_DIRECTORY"/t7500/add-content &&
+		git commit --template "$TEMPLATE"
+	) &&
 	commit_msg_is "template linecommit message"
 '
 
@@ -62,7 +71,10 @@ test_expect_success '-t option should be short for --template' '
 	echo "short template" > "$TEMPLATE" &&
 	echo "new content" >> foo &&
 	git add foo &&
-	GIT_EDITOR="$TEST_DIRECTORY"/t7500/add-content git commit -t "$TEMPLATE" &&
+	(
+		test_set_editor "$TEST_DIRECTORY"/t7500/add-content &&
+		git commit -t "$TEMPLATE"
+	) &&
 	commit_msg_is "short templatecommit message"
 '
 
@@ -71,7 +83,10 @@ test_expect_success 'config-specified template should commit' '
 	git config commit.template "$TEMPLATE" &&
 	echo "more content" >> foo &&
 	git add foo &&
-	GIT_EDITOR="$TEST_DIRECTORY"/t7500/add-content git commit &&
+	(
+		test_set_editor "$TEST_DIRECTORY"/t7500/add-content &&
+		git commit
+	) &&
 	git config --unset commit.template &&
 	commit_msg_is "new templatecommit message"
 '
@@ -88,8 +103,10 @@ test_expect_success 'commit message from file should override template' '
 	echo "content galore" >> foo &&
 	git add foo &&
 	echo "standard input msg" |
-		GIT_EDITOR="$TEST_DIRECTORY"/t7500/add-content git commit \
-			--template "$TEMPLATE" --file - &&
+	(
+		test_set_editor "$TEST_DIRECTORY"/t7500/add-content &&
+		git commit --template "$TEMPLATE" --file -
+	) &&
 	commit_msg_is "standard input msg"
 '
 
@@ -132,10 +149,12 @@ EOF
 
 test_expect_success '--signoff' '
 	echo "yet another content *narf*" >> foo &&
-	echo "zort" |
-		GIT_EDITOR="$TEST_DIRECTORY"/t7500/add-content git commit -s -F - foo &&
+	echo "zort" | (
+		test_set_editor "$TEST_DIRECTORY"/t7500/add-content &&
+		git commit -s -F - foo
+	) &&
 	git cat-file commit HEAD | sed "1,/^$/d" > output &&
-	diff expect output
+	test_cmp expect output
 '
 
 test_expect_success 'commit message from file (1)' '
-- 
1.6.0.rc2.22.g71b99

From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] sequencer: preserve commit messages
Date: Mon, 23 Feb 2015 14:23:41 +0100
Message-ID: <f58ae048d7fd468cfdd7f7d369b3b4fc0a564641.1424697676.git.git@drmicha.warpmail.net>
References: <1424540906.15539.22.camel@scientia.net>
Cc: Christoph Anton Mitterer <calestyo@scientia.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 14:23:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPszF-0005Rh-2d
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 14:23:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032AbbBWNXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 08:23:44 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:43943 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751661AbbBWNXn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Feb 2015 08:23:43 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 7D5AB2038C
	for <git@vger.kernel.org>; Mon, 23 Feb 2015 08:23:42 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 23 Feb 2015 08:23:43 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id:in-reply-to:references; s=smtpout; bh=YHzHK+9tQuzV20
	tVbybBjAN6Lyo=; b=ROKenblUsOgErR4rkI9wx7NqZ8J+dlPtJhnfrT9V2a1UoT
	oBIGPeqo9eYf8xu1PLdYVI1SpARptC9SpuqeYzF7U/rNeMewLzX0Bs+l9jBdPSrF
	ulw0Mj4rI1tJcr/I5y8rtgbASofLd5+cmDOz8sZZIe5iuvHBEKF7qUXQZCJ9I=
X-Sasl-enc: UVFXJSbiqlXasSFxC8c2aGZKNvMvTn6kJEGfg2E3Vx4u 1424697822
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id C2EF26800F4;
	Mon, 23 Feb 2015 08:23:42 -0500 (EST)
X-Mailer: git-send-email 2.3.0.296.g32c87e1
In-Reply-To: <1424540906.15539.22.camel@scientia.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264255>

sequencer calls "commit" with default options, which implies
"--cleanup=default" unless the user specified something else in their
config. This leads to cherry-picked commits getting a cleaned up commit
message, which is usually not an intended side-effect.

Make the sequencer use "--cleanup=verbatim" so that it preserves commit
messages independent of the defaults and user config for "commit".

Reported-by: Christoph Anton Mitterer <calestyo@scientia.net>
Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---

Notes:
    All tests run fine with this changed behavior. I don't know
    whether this may have any side-effects on other (untested)
    uses of the sequencer.

 sequencer.c              |  1 +
 t/t3511-cherry-pick-x.sh | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 77a1266..35fe9d9 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -377,6 +377,7 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 	argv_array_init(&array);
 	argv_array_push(&array, "commit");
 	argv_array_push(&array, "-n");
+	argv_array_push(&array, "--cleanup=verbatim");
 
 	if (opts->gpg_sign)
 		argv_array_pushf(&array, "-S%s", opts->gpg_sign);
diff --git a/t/t3511-cherry-pick-x.sh b/t/t3511-cherry-pick-x.sh
index f977279..b7dff09 100755
--- a/t/t3511-cherry-pick-x.sh
+++ b/t/t3511-cherry-pick-x.sh
@@ -36,6 +36,20 @@ mesg_with_cherry_footer="$mesg_with_footer_sob
 (cherry picked from commit da39a3ee5e6b4b0d3255bfef95601890afd80709)
 Tested-by: C.U. Thor <cuthor@example.com>"
 
+mesg_unclean="$mesg_one_line
+
+
+leading empty lines
+
+
+consecutive empty lines
+
+# hash tag comment
+
+trailing empty lines
+
+
+"
 
 test_expect_success setup '
 	git config advice.detachedhead false &&
@@ -53,6 +67,10 @@ test_expect_success setup '
 	test_commit "$mesg_with_footer_sob" foo b mesg-with-footer-sob &&
 	git reset --hard initial &&
 	test_commit "$mesg_with_cherry_footer" foo b mesg-with-cherry-footer &&
+	git reset --hard initial &&
+	test_config commit.cleanup verbatim &&
+	test_commit "$mesg_unclean" foo b mesg-unclean &&
+	test_unconfig commit.cleanup &&
 	pristine_detach initial &&
 	test_commit conflicting unrelated
 '
@@ -216,4 +234,14 @@ test_expect_success 'cherry-pick -x -s treats "(cherry picked from..." line as p
 	test_cmp expect actual
 '
 
+test_expect_success 'cherry-pick preserves commit message' '
+	pristine_detach initial &&
+	printf "$mesg_unclean" >expect &&
+	git log -1 --pretty=format:%B mesg-unclean >actual &&
+	test_cmp expect actual &&
+	git cherry-pick mesg-unclean &&
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.3.0.296.g32c87e1

From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2] sequencer: preserve commit messages
Date: Fri,  6 Mar 2015 14:55:32 +0100
Message-ID: <3e771e1bf45d972c9192441b7dfe6374f5a72bb5.1425649130.git.git@drmicha.warpmail.net>
References: <xmqqd24vjjf0.fsf@gitster.dls.corp.google.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 06 14:55:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTsjA-00086q-EK
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 14:55:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753552AbbCFNzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 08:55:35 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:51382 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753473AbbCFNze (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Mar 2015 08:55:34 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 717C62098A
	for <git@vger.kernel.org>; Fri,  6 Mar 2015 08:55:32 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Fri, 06 Mar 2015 08:55:33 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id:in-reply-to:references; s=smtpout; bh=GIM5vC9+L/6oJl
	oaAiPpnZGJGh8=; b=p9tRxSVy8wJde7Xi2VW9d7xdshISai9Z0/Lok+hg4Moz0h
	9JlBSHyBYSHU7nR4eAQl6N4Mai34BPgv4VEF7pzFVAXN2cX/HZVRMkjZ5PzDcoe+
	qodxBcb/Zfsz/AMuV3V+DTcR5ektDCX6HTpMdT/dDwmDbo+06UWMWjeAKSpNs=
X-Sasl-enc: KAzgYuxC4gzNw1YEqqUUiSt4293ZZ6SQGfCdo2MilWRS 1425650133
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 57A9C6801A1;
	Fri,  6 Mar 2015 08:55:33 -0500 (EST)
X-Mailer: git-send-email 2.3.1.303.g5174db1
In-Reply-To: <xmqqd24vjjf0.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264924>

sequencer calls "commit" with default options, which implies
"--cleanup=default" unless the user specified something else in their
config. This leads to cherry-picked commits getting a cleaned up commit
message, which is usually not an intended side-effect.

Make the sequencer use "--cleanup=verbatim" so that it preserves commit
messages independent of the default, unless the user has set config for "commit"
or the message is amended with -s or -x.

Reported-by: Christoph Anton Mitterer <calestyo@scientia.net>
Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 sequencer.c              |  5 +++++
 t/t3511-cherry-pick-x.sh | 28 ++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 77a1266..8cf575c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -373,6 +373,7 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 {
 	struct argv_array array;
 	int rc;
+	const char *value;
 
 	argv_array_init(&array);
 	argv_array_push(&array, "commit");
@@ -385,6 +386,10 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 	if (!opts->edit) {
 		argv_array_push(&array, "-F");
 		argv_array_push(&array, defmsg);
+		if (!opts->signoff &&
+		    !opts->record_origin &&
+		    git_config_get_value("commit.cleanup", &value))
+			argv_array_push(&array, "--cleanup=verbatim");
 	}
 
 	if (allow_empty)
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
2.3.1.303.g5174db1

From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 03/15] branch: die on config error when unsetting upstream
Date: Tue, 16 Feb 2016 13:56:30 +0100
Message-ID: <1455627402-752-4-git-send-email-ps@pks.im>
References: <1455627402-752-1-git-send-email-ps@pks.im>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	ps@pks.im, Eric Sunshine <sunshine@sunshineco.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 13:57:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfBp-0001g8-0Q
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 13:57:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbcBPM46 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 07:56:58 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:33915 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932067AbcBPM4z (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2016 07:56:55 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id A87FB20A98
	for <git@vger.kernel.org>; Tue, 16 Feb 2016 07:56:54 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Tue, 16 Feb 2016 07:56:54 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=/vQP
	4TLihGgA4Q+gM3qSMufmhSw=; b=RCtzP4ltmkNlvxEta69H87nsiTIewQ4eCLjU
	YPk0mTwJKMk3FgjrDIGnVnEX6r3chuMv/QxPP+J6zRsArGMgazgPEtqhxcY/Fu2D
	N8zfqgg/41SYZikQgJI1TjxqOCpFC6SJ7fKc3M0xnrebFG3fmMICGIhbpraTYFB5
	Gp03BsU=
X-Sasl-enc: zvY2pnL6i7WQGZRcXxbBS+3CB1xeSt0cayyd0ubwg6+/ 1455627414
Received: from localhost (unknown [46.189.27.162])
	by mail.messagingengine.com (Postfix) with ESMTPA id 2CE5A680130;
	Tue, 16 Feb 2016 07:56:54 -0500 (EST)
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1455627402-752-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286342>

When we try to unset upstream configurations we do not check
return codes for the `git_config_set` functions. As those may
indicate that we were unable to unset the respective
configuration we may exit successfully without any error message
while in fact the upstream configuration was not unset.

Fix this by dying with an error message when we cannot unset the
configuration.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/branch.c  | 4 ++--
 t/t3200-branch.sh | 7 +++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 3f6c825..0978287 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -791,10 +791,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			die(_("Branch '%s' has no upstream information"), branch->name);
 
 		strbuf_addf(&buf, "branch.%s.remote", branch->name);
-		git_config_set_multivar(buf.buf, NULL, NULL, 1);
+		git_config_set_multivar_or_die(buf.buf, NULL, NULL, 1);
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "branch.%s.merge", branch->name);
-		git_config_set_multivar(buf.buf, NULL, NULL, 1);
+		git_config_set_multivar_or_die(buf.buf, NULL, NULL, 1);
 		strbuf_release(&buf);
 	} else if (argc > 0 && argc <= 2) {
 		struct branch *branch = branch_get(argv[0]);
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index dd776b3..a897248 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -473,6 +473,13 @@ test_expect_success '--unset-upstream should fail if given a non-existent branch
 	test_must_fail git branch --unset-upstream i-dont-exist
 '
 
+test_expect_success '--unset-upstream should fail if config is locked' '
+	test_when_finished "rm -f .git/config.lock" &&
+	git branch --set-upstream-to locked &&
+	>.git/config.lock &&
+	test_must_fail git branch --unset-upstream
+'
+
 test_expect_success 'test --unset-upstream on HEAD' '
 	git branch my14 &&
 	test_config branch.master.remote foo &&
-- 
2.7.1

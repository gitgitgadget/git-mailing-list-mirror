From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 03/15] branch: die on config error when unsetting upstream
Date: Tue,  2 Feb 2016 12:51:44 +0100
Message-ID: <1454413916-31984-4-git-send-email-ps@pks.im>
References: <1454413916-31984-1-git-send-email-ps@pks.im>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 12:52:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQZVV-000650-4K
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 12:52:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754828AbcBBLwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 06:52:16 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38431 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754719AbcBBLwO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Feb 2016 06:52:14 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id C9D8F2132B
	for <git@vger.kernel.org>; Tue,  2 Feb 2016 06:52:13 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Tue, 02 Feb 2016 06:52:13 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=OHgc
	YhdmBv3lRF6fILFnM6YPzx0=; b=ac9yIv1KbWu9f2AqcHDnLQuf4anr+k8idiHh
	Yl0qmQP7YS+4mV/wxEXVNXe+wDUAUYYeOMJ32SmSTgTUr9ckTWVecyYqJpKNGfJa
	Fa8b+z+sLCNaq/CB9KVHA2iEOVWld/QSmv1omPeiD77zqES2v53hnhOgxzfy/Yaq
	TgoGIJ0=
X-Sasl-enc: DMaPTdfrrQqjSo1XIaJwQ5tSQIlj9vYj8z0wzwAae2c0 1454413933
Received: from localhost (f052008117.adsl.alicedsl.de [78.52.8.117])
	by mail.messagingengine.com (Postfix) with ESMTPA id 5DC6B680195;
	Tue,  2 Feb 2016 06:52:13 -0500 (EST)
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454413916-31984-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285256>

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
2.7.0

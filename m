From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 5/9] branch: handle config errors when unsetting upstream
Date: Thu, 28 Jan 2016 10:00:33 +0100
Message-ID: <1453971637-22273-6-git-send-email-ps@pks.im>
References: <1453971637-22273-1-git-send-email-ps@pks.im>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 28 10:00:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOiRh-0006rD-So
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 10:00:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933805AbcA1JAu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 04:00:50 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:43262 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755221AbcA1JAr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jan 2016 04:00:47 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 297ED21EFD
	for <git@vger.kernel.org>; Thu, 28 Jan 2016 04:00:47 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 28 Jan 2016 04:00:47 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=OHgc
	YhdmBv3lRF6fILFnM6YPzx0=; b=izoR2tv5drKwx9CVj+dXXWiL9CpHYPGhv/sT
	67XMG9LKGWkb6j4RZDjjsHGOGOrFLEjV8/1PZlEtsYN/WFuaLj1dpZD0UDXNI2CM
	PaXwTmW3Nx53GsE7gB4EYq9nqOt8e+zX382tE0YZy1RZrzDnSovvWJS7ADajvPXz
	j80ftBo=
X-Sasl-enc: yqvLGgfk87ZmEyZ/L2xAFkWLJvfsFnSysj1b2Z7qpvy+ 1453971646
Received: from localhost (f052174253.adsl.alicedsl.de [78.52.174.253])
	by mail.messagingengine.com (Postfix) with ESMTPA id B393DC00012;
	Thu, 28 Jan 2016 04:00:46 -0500 (EST)
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1453971637-22273-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284993>

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

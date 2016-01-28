From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 8/9] submodule--helper: handle config errors
Date: Thu, 28 Jan 2016 10:00:36 +0100
Message-ID: <1453971637-22273-9-git-send-email-ps@pks.im>
References: <1453971637-22273-1-git-send-email-ps@pks.im>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 28 10:01:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOiRp-0006xG-Je
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 10:01:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933932AbcA1JA4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 04:00:56 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:50620 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755221AbcA1JAw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jan 2016 04:00:52 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 8FF3621F19
	for <git@vger.kernel.org>; Thu, 28 Jan 2016 04:00:51 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Thu, 28 Jan 2016 04:00:51 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=2WqW
	NyHLtw1EFiSjaruyWsRzpzE=; b=J27OBAlEvN0q1N1GByQ2kahx0f6kQbQVvf36
	+TnjBasDYgdVovFd3w1D0ehD9a8g18cqYI3MsClDcin25X1YflphtDvPyepcbSE3
	ah+XB34ryL61MwNPNM12lukYgQrZwRX5UCpc/vwHWMyj1RjXQ1nTatDypPhlBAmr
	s+2HTjs=
X-Sasl-enc: GZFjW4gUyaXjyPqCmjll+EEfdm/A1qXuiiZGGqoqVe2N 1453971651
Received: from localhost (f052174253.adsl.alicedsl.de [78.52.174.253])
	by mail.messagingengine.com (Postfix) with ESMTPA id 253626800FD;
	Thu, 28 Jan 2016 04:00:51 -0500 (EST)
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1453971637-22273-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284997>

When setting the 'core.worktree' option for a newly cloned
submodule we ignore the return value of `git_config_set_in_file`.
Instead, we want to inform the user that something has gone wrong
by printing an error message and aborting the program.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/submodule--helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f4c3eff..c7e1ea2 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -245,8 +245,8 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	p = git_pathdup_submodule(path, "config");
 	if (!p)
 		die(_("could not get submodule directory for '%s'"), path);
-	git_config_set_in_file(p, "core.worktree",
-			       relative_path(sb.buf, sm_gitdir, &rel_path));
+	git_config_set_in_file_or_die(p, "core.worktree",
+				      relative_path(sb.buf, sm_gitdir, &rel_path));
 	strbuf_release(&sb);
 	strbuf_release(&rel_path);
 	free(sm_gitdir);
-- 
2.7.0

From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 06/15] submodule--helper: die on config error when cloning module
Date: Tue,  2 Feb 2016 12:51:47 +0100
Message-ID: <1454413916-31984-7-git-send-email-ps@pks.im>
References: <1454413916-31984-1-git-send-email-ps@pks.im>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 12:52:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQZVS-000650-Ov
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 12:52:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754896AbcBBLwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 06:52:19 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:35727 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754702AbcBBLwS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Feb 2016 06:52:18 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id BFE9E20DEB
	for <git@vger.kernel.org>; Tue,  2 Feb 2016 06:52:17 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 02 Feb 2016 06:52:17 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=AfzS
	5/I7BNlWVv/kjX1UEPmPaRU=; b=UHNa0hB57znwIqMF6oUMC8cqj/abFOBOXIjC
	ZzUsl9CsBQdiTDgbRsyRn7NsAfF4jjetmUdf6rwU2mbx1PIuSlG58ztN4eS5Xbhe
	XOfOk2iw+LWilRpzSxh8dA7FtmmKuhgG3LpTxY1Ls+O4821YcAAxSnQvgnrqCrqu
	R8nn+1U=
X-Sasl-enc: bjqmtwBtx3FqWOSIeQ4aFXrB/DhMt/m0Mg73PQVoij6A 1454413937
Received: from localhost (f052008117.adsl.alicedsl.de [78.52.8.117])
	by mail.messagingengine.com (Postfix) with ESMTPA id 5424AC00012;
	Tue,  2 Feb 2016 06:52:17 -0500 (EST)
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454413916-31984-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285255>

When setting the 'core.worktree' option for a newly cloned
submodule we ignore the return value of `git_config_set_in_file`.
As this leaves the submodule in an inconsistent state, we instaed
we want to inform the user that something has gone wrong by
printing an error and aborting the program.

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

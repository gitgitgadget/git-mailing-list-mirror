From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 06/15] submodule--helper: die on config error when cloning module
Date: Tue, 16 Feb 2016 13:56:33 +0100
Message-ID: <1455627402-752-7-git-send-email-ps@pks.im>
References: <1455627402-752-1-git-send-email-ps@pks.im>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	ps@pks.im, Eric Sunshine <sunshine@sunshineco.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 13:57:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfBq-0001g8-7L
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 13:57:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbcBPM5D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 07:57:03 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36966 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932067AbcBPM47 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2016 07:56:59 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 8595420A9D
	for <git@vger.kernel.org>; Tue, 16 Feb 2016 07:56:58 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Tue, 16 Feb 2016 07:56:58 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=F5eH
	47CqNrKPrI985hi+r5GNRjM=; b=pV2mZODYx2UFRwe7XHyXyB30MRlVDER4Fb6e
	1++gqZBPKXfBjv02UmfFtmONoNTUuBQlc8dRqhxSDDlw8lMQH2ZEm5s67MH8LC+a
	URGt4rPA5xVOsCqeGlSWtQCWgMuw95XcF4fzqXjO/XUTyWm4JLeTLvvNbyopwkxJ
	UDenqAM=
X-Sasl-enc: I7lXIKBqV58HWx9TT519H07tWq84CyIfGClVSYKiLbbu 1455627418
Received: from localhost (unknown [46.189.27.162])
	by mail.messagingengine.com (Postfix) with ESMTPA id 1E802C0001A;
	Tue, 16 Feb 2016 07:56:58 -0500 (EST)
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1455627402-752-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286343>

When setting the 'core.worktree' option for a newly cloned
submodule we ignore the return value of `git_config_set_in_file`.
As this leaves the submodule in an inconsistent state, we instead
want to inform the user that something has gone wrong by printing
an error and aborting the program.

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
2.7.1

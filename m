From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 05/15] submodule: die on config error when linking modules
Date: Tue,  2 Feb 2016 12:51:46 +0100
Message-ID: <1454413916-31984-6-git-send-email-ps@pks.im>
References: <1454413916-31984-1-git-send-email-ps@pks.im>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 12:52:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQZVU-000650-BR
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 12:52:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754907AbcBBLwY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 06:52:24 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:44242 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754719AbcBBLwQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Feb 2016 06:52:16 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 6C02121222
	for <git@vger.kernel.org>; Tue,  2 Feb 2016 06:52:16 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Tue, 02 Feb 2016 06:52:16 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=GLXO
	pLmD6rLCMvWcVl8iOp1PBjs=; b=b6Zby5UerbwGv8P+f6W1rjakfmmpgiysp6jF
	IewByybvogwUBlywGPZs3uJnad9B7mbJ92rlDJbcagF2/EIinq0RIKyrJcR7nI6K
	RVQot4OGxOps2SKG8t3Q+koaV9qmWg3JH/nYJhexDpdKE1Dr6wQ1vXt9F7pz3bLB
	st+GdjY=
X-Sasl-enc: +1szl48rcj47HgTqCCBwaWTZPkRcsQ+5uhQduiVdCRyU 1454413936
Received: from localhost (f052008117.adsl.alicedsl.de [78.52.8.117])
	by mail.messagingengine.com (Postfix) with ESMTPA id 037F468010F;
	Tue,  2 Feb 2016 06:52:15 -0500 (EST)
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454413916-31984-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285253>

When trying to connect a submodule with its corresponding
repository in '.git/modules' we try to set the core.worktree
setting in the submodule, which may fail due to an error
encountered in `git_config_set_in_file`.

The function is used in the git-mv command when trying to move a
submodule to another location. We already die when renaming a
file fails but do not pay attention to the case where updating
the connection between submodule and its repository fails. As
this leaves the repository in an inconsistent state, as well,
abort the program by dying early and presenting the failure to
the user.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 submodule.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/submodule.c b/submodule.c
index b83939c..589a82c 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1087,11 +1087,9 @@ void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
 	/* Update core.worktree setting */
 	strbuf_reset(&file_name);
 	strbuf_addf(&file_name, "%s/config", git_dir);
-	if (git_config_set_in_file(file_name.buf, "core.worktree",
-				   relative_path(real_work_tree, git_dir,
-						 &rel_path)))
-		die(_("Could not set core.worktree in %s"),
-		    file_name.buf);
+	git_config_set_in_file_or_die(file_name.buf, "core.worktree",
+				      relative_path(real_work_tree, git_dir,
+						    &rel_path));
 
 	strbuf_release(&file_name);
 	strbuf_release(&rel_path);
-- 
2.7.0

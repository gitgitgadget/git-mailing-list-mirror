From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v6 05/15] submodule: die on config error when linking modules
Date: Mon, 22 Feb 2016 12:23:26 +0100
Message-ID: <1456140216-24169-6-git-send-email-ps@pks.im>
References: <1456140216-24169-1-git-send-email-ps@pks.im>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	ps@pks.im, Eric Sunshine <sunshine@sunshineco.com>,
	Stefan Beller <sbeller@google.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Michael Blume <blume.mike@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 12:24:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXobe-0000Yy-2M
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 12:24:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754658AbcBVLYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 06:24:43 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:37661 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754492AbcBVLYl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Feb 2016 06:24:41 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 9FEAD20C37
	for <git@vger.kernel.org>; Mon, 22 Feb 2016 06:24:40 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Mon, 22 Feb 2016 06:24:40 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=UgLB
	hqsbkjz6Q//gkCSjkbi9InE=; b=XEKfCfu6eTcSGCwKJW30i7tLs4nKM6s3/aPP
	FWHtUlU6fwkOy1K8DbGeGrzI36HsChpsbqg8OOdBRdPInN3mAGWCZ/l9Y8OSWkrm
	OyiNlwoEOzeHspZ9v/FpjgIaPPSLCXFl6i/T3wdRIPycVKRbgb1CcWWxD8jd6EWx
	u2THYBo=
X-Sasl-enc: GBD4v1U5eTvNGrWIkqt5lykSr9L6pOHbvoFJOUND8fHh 1456140280
Received: from localhost (unknown [46.189.27.162])
	by mail.messagingengine.com (Postfix) with ESMTPA id 31857C00014;
	Mon, 22 Feb 2016 06:24:40 -0500 (EST)
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1456140216-24169-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286911>

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
2.7.1

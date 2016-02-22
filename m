From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v6 06/15] submodule--helper: die on config error when cloning module
Date: Mon, 22 Feb 2016 12:23:27 +0100
Message-ID: <1456140216-24169-7-git-send-email-ps@pks.im>
References: <1456140216-24169-1-git-send-email-ps@pks.im>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	ps@pks.im, Eric Sunshine <sunshine@sunshineco.com>,
	Stefan Beller <sbeller@google.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Michael Blume <blume.mike@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 12:24:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXobl-0000f0-6z
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 12:24:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754661AbcBVLYp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 06:24:45 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:59228 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754215AbcBVLYm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Feb 2016 06:24:42 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id ED2B420711
	for <git@vger.kernel.org>; Mon, 22 Feb 2016 06:24:41 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 22 Feb 2016 06:24:41 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=F5eH
	47CqNrKPrI985hi+r5GNRjM=; b=kHunHbJaUzLw1E0kEZ37W4RbuE6cJvUy/McS
	R5wo3JyFpaxOyOixE8jA9xaO3mVMzRcj08PNmy8XHxVL6YqeBaM2LbR5pdneTtu2
	i36jDaWNh8fhQ9Kd04USkLuNQhVcig0eULJhyvIazVh4Nti40id342rGF3Q4RM91
	4gGRIzo=
X-Sasl-enc: F7IybQMqcKaIXc+ruZjRaXCRe5WB6sheeC9bVuhu8/+s 1456140281
Received: from localhost (unknown [46.189.27.162])
	by mail.messagingengine.com (Postfix) with ESMTPA id 76B426800FE;
	Mon, 22 Feb 2016 06:24:41 -0500 (EST)
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1456140216-24169-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286913>

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

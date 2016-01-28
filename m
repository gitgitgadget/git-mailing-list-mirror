From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 7/9] sequencer: handle config errors when saving opts
Date: Thu, 28 Jan 2016 10:00:35 +0100
Message-ID: <1453971637-22273-8-git-send-email-ps@pks.im>
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
	id 1aOiRq-0006xG-7t
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 10:01:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934059AbcA1JA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 04:00:57 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:52828 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755177AbcA1JAv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jan 2016 04:00:51 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 3D5A121F00
	for <git@vger.kernel.org>; Thu, 28 Jan 2016 04:00:50 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute6.internal (MEProxy); Thu, 28 Jan 2016 04:00:50 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=SOOE
	4+bKxxCjw5HeWVcliiEHRg8=; b=PosAiGZW2Oa7fTy8xqAnhnQ9ZcCUprY4h01A
	qx1K2lMDioqW2ziibKKyOoVJcYiOXnKnPyDx2fHTYzaFzrXCYxKtTAD4ZW0zXaTm
	Oos+xFG8k8OUJ4hmnUyMLLNGXKZmC5H/aqGEMBHLloQO3X6Xf29tPutMC1E4O6xp
	eHQuK58=
X-Sasl-enc: sZAf9XMrXESg0SkhktkBGFMCiVxCp/Ntw0lNIEhIy7u0 1453971649
Received: from localhost (f052174253.adsl.alicedsl.de [78.52.174.253])
	by mail.messagingengine.com (Postfix) with ESMTPA id 9511AC0001E;
	Thu, 28 Jan 2016 04:00:49 -0500 (EST)
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1453971637-22273-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284995>

When we start picking a range of revisions we save the replay
options that are required to restore state when interrupting and
later continuing picking the revisions. However, we do not check
the return values of the `git_config_set` functions, which may
lead us to store incomplete information. As this may lead us to
fail when trying to continue the sequence this error can be
fatal.

Fix this by dying immediately when we are unable to write back
any replay option.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 sequencer.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 8c58fa2..3c109b6 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -933,31 +933,31 @@ static void save_opts(struct replay_opts *opts)
 	const char *opts_file = git_path_opts_file();
 
 	if (opts->no_commit)
-		git_config_set_in_file(opts_file, "options.no-commit", "true");
+		git_config_set_in_file_or_die(opts_file, "options.no-commit", "true");
 	if (opts->edit)
-		git_config_set_in_file(opts_file, "options.edit", "true");
+		git_config_set_in_file_or_die(opts_file, "options.edit", "true");
 	if (opts->signoff)
-		git_config_set_in_file(opts_file, "options.signoff", "true");
+		git_config_set_in_file_or_die(opts_file, "options.signoff", "true");
 	if (opts->record_origin)
-		git_config_set_in_file(opts_file, "options.record-origin", "true");
+		git_config_set_in_file_or_die(opts_file, "options.record-origin", "true");
 	if (opts->allow_ff)
-		git_config_set_in_file(opts_file, "options.allow-ff", "true");
+		git_config_set_in_file_or_die(opts_file, "options.allow-ff", "true");
 	if (opts->mainline) {
 		struct strbuf buf = STRBUF_INIT;
 		strbuf_addf(&buf, "%d", opts->mainline);
-		git_config_set_in_file(opts_file, "options.mainline", buf.buf);
+		git_config_set_in_file_or_die(opts_file, "options.mainline", buf.buf);
 		strbuf_release(&buf);
 	}
 	if (opts->strategy)
-		git_config_set_in_file(opts_file, "options.strategy", opts->strategy);
+		git_config_set_in_file_or_die(opts_file, "options.strategy", opts->strategy);
 	if (opts->gpg_sign)
-		git_config_set_in_file(opts_file, "options.gpg-sign", opts->gpg_sign);
+		git_config_set_in_file_or_die(opts_file, "options.gpg-sign", opts->gpg_sign);
 	if (opts->xopts) {
 		int i;
 		for (i = 0; i < opts->xopts_nr; i++)
-			git_config_set_multivar_in_file(opts_file,
-							"options.strategy-option",
-							opts->xopts[i], "^$", 0);
+			git_config_set_multivar_in_file_or_die(opts_file,
+							       "options.strategy-option",
+							       opts->xopts[i], "^$", 0);
 	}
 }
 
-- 
2.7.0

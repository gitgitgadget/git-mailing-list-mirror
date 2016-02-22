From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v6 12/15] sequencer: die on config error when saving replay opts
Date: Mon, 22 Feb 2016 12:23:33 +0100
Message-ID: <1456140216-24169-13-git-send-email-ps@pks.im>
References: <1456140216-24169-1-git-send-email-ps@pks.im>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	ps@pks.im, Eric Sunshine <sunshine@sunshineco.com>,
	Stefan Beller <sbeller@google.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Michael Blume <blume.mike@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 12:25:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXoc5-0000ln-UR
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 12:25:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754705AbcBVLY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 06:24:57 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:40291 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754021AbcBVLYu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Feb 2016 06:24:50 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id C4DA020C70
	for <git@vger.kernel.org>; Mon, 22 Feb 2016 06:24:49 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 22 Feb 2016 06:24:49 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=ROs3
	PmroNDbQepaC/jKD2IBGg3M=; b=CC2YEos+ZLWV6hVXo8Ft0W78cI+eutEZSPJD
	BWYdSraFkroohXL/MKTzSqpqoqnAf/CnEXX3poXFV/mvSZVCc8vU5uv4BU0pNwuJ
	6oUREdpNMxornUb+I7WBbp3z5PqXyOJg6jpKBcu/4nvNvVhKJ2LM1/ESCKX5m+92
	etElKrA=
X-Sasl-enc: 68L4rrCpp+Yc/xT/R+J/i513fD2fsrcLdNB53dXv6su2 1456140289
Received: from localhost (unknown [46.189.27.162])
	by mail.messagingengine.com (Postfix) with ESMTPA id 4EE156800FE;
	Mon, 22 Feb 2016 06:24:49 -0500 (EST)
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1456140216-24169-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286917>

When we start picking a range of revisions we save the replay
options that are required to restore state when interrupting and
later continuing picking the revisions. However, we do not check
the return values of the `git_config_set` functions, which may
lead us to store incomplete information. As this may lead us to
fail when trying to continue the sequence the error can be fatal.

Fix this by dying immediately when we are unable to write back
any replay option.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 sequencer.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 8048786..3590248 100644
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
2.7.1

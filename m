From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 12/15] sequencer: die on config error when saving replay opts
Date: Tue, 16 Feb 2016 13:56:39 +0100
Message-ID: <1455627402-752-13-git-send-email-ps@pks.im>
References: <1455627402-752-1-git-send-email-ps@pks.im>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	ps@pks.im, Eric Sunshine <sunshine@sunshineco.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 14:00:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfEW-000418-QK
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:00:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbcBPM7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 07:59:24 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:59729 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932117AbcBPM5H (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2016 07:57:07 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 7EE5620B34
	for <git@vger.kernel.org>; Tue, 16 Feb 2016 07:57:06 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute6.internal (MEProxy); Tue, 16 Feb 2016 07:57:06 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=ROs3
	PmroNDbQepaC/jKD2IBGg3M=; b=nlDdOujEyUr0A2EJuZ1apRGL+7+BDHK/3E7X
	/OXItcuGs4fYZstNQFzqoxt+OOnsMmxyvHdof0gVxrQg/v3MGMYigL6iCCNLnlGC
	eqCGs+vnx2vreb0x3DBMn688loWS/909JHzXPJjXxxwPFfiyzVa9h/5GndbgMQkh
	C8W1ksw=
X-Sasl-enc: Sg4o1WzJ5TkMxbjZZntTQsdNn1zBxiM4F1GM64mqFIo7 1455627426
Received: from localhost (unknown [46.189.27.162])
	by mail.messagingengine.com (Postfix) with ESMTPA id 1AAB5C0001D;
	Tue, 16 Feb 2016 07:57:06 -0500 (EST)
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1455627402-752-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286351>

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

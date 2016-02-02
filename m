From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 12/15] sequencer: die on config error when saving replay opts
Date: Tue,  2 Feb 2016 12:51:53 +0100
Message-ID: <1454413916-31984-13-git-send-email-ps@pks.im>
References: <1454413916-31984-1-git-send-email-ps@pks.im>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 12:53:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQZWP-0007Yq-Sj
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 12:53:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755006AbcBBLxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 06:53:22 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38525 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754854AbcBBLxV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Feb 2016 06:53:21 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 320CC20364
	for <git@vger.kernel.org>; Tue,  2 Feb 2016 06:53:21 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 02 Feb 2016 06:53:21 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=mDjP
	Mguz9K1eEEjtHRaYFDVtWF4=; b=pvvJgAMfVXenLsF1h03mFSvuT7lnkbvaR/38
	6ZVGt+ib6WmTBIWqTMwDY/1Zdfj3j+dIAf9OyB43IeLhNAmXwNNCFhdpc8kqQDVC
	Rk7XoVuTTJaM9TeeXkzCDPfnte4BclxnrTLvZ9ZhpX7o3y9+f+Btiy2aAAhJZ82G
	SPpYAvE=
X-Sasl-enc: 3T39VL7Sopqn8gB7akgb1wVL7BGEvD67nHV+UUz6Pndz 1454414000
Received: from localhost (f052008117.adsl.alicedsl.de [78.52.8.117])
	by mail.messagingengine.com (Postfix) with ESMTPA id B8910C0001D;
	Tue,  2 Feb 2016 06:53:20 -0500 (EST)
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454413916-31984-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285260>

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
2.7.0

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0F591F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 14:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752632AbcIIOiD (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 10:38:03 -0400
Received: from mout.gmx.net ([212.227.17.22]:51884 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750882AbcIIOh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 10:37:58 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LsD9n-1b3Dp83Dmp-013th9; Fri, 09 Sep 2016 16:37:53
 +0200
Date:   Fri, 9 Sep 2016 16:37:53 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 14/17] sequencer: lib'ify save_opts()
In-Reply-To: <cover.1473431645.git.johannes.schindelin@gmx.de>
Message-ID: <15198727511147562a86610ae8894284a13b652c.1473431645.git.johannes.schindelin@gmx.de>
References: <cover.1472219214.git.johannes.schindelin@gmx.de> <cover.1473431645.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:M9BPz7wv9LJ0JIrNe1bAYGUtVAOGvnIpGuw4TDhLhgL790xGTuB
 VmyuEeMTG+KWOF6GlfwbgYG8zFwC3QH3cI120nFd4805UTMqAFrw7r90HPnnHN4mq5n2uk2
 c9NjIhGNpFtHAJipW8su6LF6/npwMd/NQOvUX4nzbJMY4xFbPSJUvcd9EGg8s4+bgeJtZcL
 YUIVH8Bdl9/UHZKxdqC3w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:S6jDQz7dNRc=:ZPS4x9wrvUGuOQgr31Xq5v
 IfMJWAzaurdO8bfGtJ/i9t3//3hSZcukFrhhfVEea3G+rgmrn10i+w5OUs2yCg+NIUw35T95S
 Yj1FyNfJ+zFomETqmRmOGcg4PQJ+cxocGNle74DUZfYEu6g+QZjPDwT6XCqIPDkQV4PYyGsLl
 V145JiFxk87L9pN9i8Sk6QyCe4ECq7oirVjLgUlqvEjD5Pdv3OtpWvq3goB0NMCSRFei/ZyIE
 TpiifMnOl7fH4e6bRoJ7PTPWUyt9uWd64W5Ui+EY0cBvI3L/XxDBR9r1W6rWAgKk/9jEqMnxD
 WD/ntZuFagxD/RuKSzT4by+mnmigZVG3LPW5fb91CmPnNrXi/B1d7Zu7o8F8CSd6JVe/7+1Ib
 VZBX6fBl8f29/xrk/uKjsNB9qmjs3AKMJF5KnPRSeb0X8V+f4Hy/pag1c54NEYDfiKZjOa/IF
 aPesNvYmCh+9fdzhXINF3GOgKsMGbO4PzIsUfTwj1ntaW7aVA96/mDENPy0LQ+/JcqOrYwAbf
 EBqS/X0ObvVr1FO4p/gr9W3psBI0PUPoGXGEP7BTrkObPhaDwHDc+6MBpriHbAMsXxjBNYhkP
 ztO8RsFSc9SAQKgghIH6pVR0XOD5nNdqXsDzYKvbUJXwEVPSyTqzMdfKG2w5ooa5Nso2LEp9M
 Kv1WeL2elRKwr8yuy6XXopuNb4WKrU0TI6cwNEb/IqIK7klE9Qq7I2Uo1qrAn9oxzfd/0Y+wE
 hOtDNGFEXtY4WSXPwMgeNlobjmBDYxP+nwjt+qMQpOB3juZovSPiA/ZJKlq4vTCccrMopl25s
 cEUnKZe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of dying there, let the caller high up in the callchain notice
the error and handle it (by dying, still).

The only caller of save_opts(), sequencer_pick_revisions() can already
return errors, so its caller must be already prepared to handle error
returns, and with this step, we make it notice an error return from
this function.

So this is a safe conversion to make save_opts() callable from new
callers that want it not to die, without changing the external
behaviour of anything existing.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 32c53bb..021ddf3 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -970,37 +970,39 @@ static int save_todo(struct commit_list *todo_list, struct replay_opts *opts)
 	return 0;
 }
 
-static void save_opts(struct replay_opts *opts)
+static int save_opts(struct replay_opts *opts)
 {
 	const char *opts_file = git_path_opts_file();
+	int res = 0;
 
 	if (opts->no_commit)
-		git_config_set_in_file(opts_file, "options.no-commit", "true");
+		res |= git_config_set_in_file_gently(opts_file, "options.no-commit", "true");
 	if (opts->edit)
-		git_config_set_in_file(opts_file, "options.edit", "true");
+		res |= git_config_set_in_file_gently(opts_file, "options.edit", "true");
 	if (opts->signoff)
-		git_config_set_in_file(opts_file, "options.signoff", "true");
+		res |= git_config_set_in_file_gently(opts_file, "options.signoff", "true");
 	if (opts->record_origin)
-		git_config_set_in_file(opts_file, "options.record-origin", "true");
+		res |= git_config_set_in_file_gently(opts_file, "options.record-origin", "true");
 	if (opts->allow_ff)
-		git_config_set_in_file(opts_file, "options.allow-ff", "true");
+		res |= git_config_set_in_file_gently(opts_file, "options.allow-ff", "true");
 	if (opts->mainline) {
 		struct strbuf buf = STRBUF_INIT;
 		strbuf_addf(&buf, "%d", opts->mainline);
-		git_config_set_in_file(opts_file, "options.mainline", buf.buf);
+		res |= git_config_set_in_file_gently(opts_file, "options.mainline", buf.buf);
 		strbuf_release(&buf);
 	}
 	if (opts->strategy)
-		git_config_set_in_file(opts_file, "options.strategy", opts->strategy);
+		res |= git_config_set_in_file_gently(opts_file, "options.strategy", opts->strategy);
 	if (opts->gpg_sign)
-		git_config_set_in_file(opts_file, "options.gpg-sign", opts->gpg_sign);
+		res |= git_config_set_in_file_gently(opts_file, "options.gpg-sign", opts->gpg_sign);
 	if (opts->xopts) {
 		int i;
 		for (i = 0; i < opts->xopts_nr; i++)
-			git_config_set_multivar_in_file(opts_file,
+			res |= git_config_set_multivar_in_file_gently(opts_file,
 							"options.strategy-option",
 							opts->xopts[i], "^$", 0);
 	}
+	return res;
 }
 
 static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
@@ -1147,7 +1149,8 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 		return error(_("Can't revert as initial commit"));
 	if (save_head(sha1_to_hex(sha1)))
 		return -1;
-	save_opts(opts);
+	if (save_opts(opts))
+		return -1;
 	return pick_commits(todo_list, opts);
 }
 
-- 
2.10.0.windows.1.10.g803177d



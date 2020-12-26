Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62989C433E0
	for <git@archiver.kernel.org>; Sat, 26 Dec 2020 13:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26B1E207D1
	for <git@archiver.kernel.org>; Sat, 26 Dec 2020 13:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgLZNzE convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 26 Dec 2020 08:55:04 -0500
Received: from nibbler.ldn-fai.net ([80.67.188.164]:54308 "EHLO
        nibbler.ldn-fai.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgLZNzD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Dec 2020 08:55:03 -0500
X-Greylist: delayed 543 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Dec 2020 08:55:03 EST
Received: from localhost (localhost [127.0.0.1])
        by nibbler.ldn-fai.net (Postfix) with ESMTP id B30CE8ED5A1;
        Sat, 26 Dec 2020 14:45:19 +0100 (CET)
Received: from nibbler.ldn-fai.net ([127.0.0.1])
        by localhost (nibbler.ldn-fai.net [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id AA49uNd-9KVf; Sat, 26 Dec 2020 14:45:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by nibbler.ldn-fai.net (Postfix) with ESMTP id 2AA948ED59F;
        Sat, 26 Dec 2020 14:45:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at nibbler.ldn-fai.net
Received: from nibbler.ldn-fai.net ([127.0.0.1])
        by localhost (nibbler.ldn-fai.net [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RNq19qR_okuM; Sat, 26 Dec 2020 14:45:19 +0100 (CET)
Received: from pica.home.lan (82-64-239-100.subs.proxad.net [82.64.239.100])
        by nibbler.ldn-fai.net (Postfix) with ESMTPSA id CC8E48ED59E;
        Sat, 26 Dec 2020 14:45:18 +0100 (CET)
From:   =?UTF-8?q?J=C3=A9r=C3=A9mie=20Detrey?= <Jeremie.Detrey@altu.fr>
To:     git@vger.kernel.org
Cc:     Shulhan <m.shulhan@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?J=C3=A9r=C3=A9mie=20Detrey?= <Jeremie.Detrey@altu.fr>
Subject: [PATCH] git-remote: load config whenever create_symref() might be called
Date:   Sat, 26 Dec 2020 14:44:20 +0100
Message-Id: <20201226134420.722643-1-Jeremie.Detrey@altu.fr>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, the calls to `create_symref()` do not honor the
`core.logAllRefUpdates` nor the `user.{name,email}` configuration
settings, and therefore write reflogs even when explicitly asked not
to, and ignore the configured user identity.

This happens on `git remote add --fetch`, `git remote set-head`, and
`git remote rename`: these are the three commands which may create
a symbolic-ref for the remote's HEAD.

A call to `git_config(git_default_config, NULL);` for these three
commands is enough to load the necessary configuration beforehand.

The call to `git_config()` was inserted right after command-line
processing for these three commands. One might also decide to push
it closer to the actual call to `create_symref()`, as it is not
needed elsewhere, but it made more sense not to have it buried into
nested `if` conditions.

Signed-off-by: Jérémie Detrey <Jeremie.Detrey@altu.fr>
---
 builtin/remote.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/builtin/remote.c b/builtin/remote.c
index 64b4b551eb..f797fc3f65 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -190,6 +190,8 @@ static int add(int argc, const char **argv)
 	name = argv[0];
 	url = argv[1];
 
+	git_config(git_default_config, NULL);
+
 	remote = remote_get(name);
 	if (remote_is_configured(remote, 1))
 		die(_("remote %s already exists."), name);
@@ -685,6 +687,8 @@ static int mv(int argc, const char **argv)
 	rename.new_name = argv[2];
 	rename.remote_branches = &remote_branches;
 
+	git_config(git_default_config, NULL);
+
 	oldremote = remote_get(rename.old_name);
 	if (!remote_is_configured(oldremote, 1))
 		die(_("No such remote: '%s'"), rename.old_name);
@@ -1326,6 +1330,8 @@ static int set_head(int argc, const char **argv)
 	if (argc)
 		strbuf_addf(&buf, "refs/remotes/%s/HEAD", argv[0]);
 
+	git_config(git_default_config, NULL);
+
 	if (!opt_a && !opt_d && argc == 2) {
 		head_name = xstrdup(argv[1]);
 	} else if (opt_a && !opt_d && argc == 1) {
-- 
2.29.2


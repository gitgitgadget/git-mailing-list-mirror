Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56D4820966
	for <e@80x24.org>; Fri, 24 Mar 2017 17:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966926AbdCXRR7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 13:17:59 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:59596 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966906AbdCXRR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 13:17:57 -0400
Received: from [IPv6:2001:4b98:beef:a:be5f:f4ff:fe69:f6a] (locke.gandi.net [IPv6:2001:4b98:beef:a:be5f:f4ff:fe69:f6a])
        (Authenticated sender: romuald@chivil.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 3CE251720E7;
        Fri, 24 Mar 2017 18:17:54 +0100 (CET)
Message-ID: <1490375874.745.227.camel@locke.gandi.net>
Subject: [PATCH] push: allow atomic flag via configuration
From:   Romuald Brunet <romuald@chivil.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Matthieu Moy <Matthieu.Moy@imag.fr>,
        Junio C Hamano <gitster@pobox.com>
Date:   Fri, 24 Mar 2017 18:17:54 +0100
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.4.4-3 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Added a "push.atomic" option to git-config to allow site-specific
configuration of the atomic flag of git push

Signed-off-by: Romuald Brunet <romuald@chivil.com>
---
 Documentation/config.txt               |  5 +++++
 builtin/push.c                         |  6 ++++++
 contrib/completion/git-completion.bash |  1 +
 t/t5543-atomic-push.sh                 | 31 +++++++++++++++++++++++++++++++
 4 files changed, 43 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0d8df5a9f..c826c86ae 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2555,6 +2555,11 @@ new default).
 
 --
 
+push.atomic::
+	If set to true enable `--atomic` option by default.  You
+	may override this configuration at time of push by specifying
+	`--no-atomic`.
+
 push.followTags::
 	If set to true enable `--follow-tags` option by default.  You
 	may override this configuration at time of push by specifying
diff --git a/builtin/push.c b/builtin/push.c
index 5c22e9f2e..03066f3f7 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -498,6 +498,12 @@ static int git_push_config(const char *k, const char *v, void *cb)
 		const char *value;
 		if (!git_config_get_value("push.recursesubmodules", &value))
 			recurse_submodules = parse_push_recurse_submodules_arg(k, value);
+	} else if (!strcmp(k, "push.atomic")) {
+		if (git_config_bool(k, v))
+			*flags |= TRANSPORT_PUSH_ATOMIC;
+		else
+			*flags &= ~TRANSPORT_PUSH_ATOMIC;
+		return 0;
 	}
 
 	return git_default_config(k, v, NULL);
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index fc32286a4..8d38f5f8f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2396,6 +2396,7 @@ _git_config ()
 		pull.octopus
 		pull.twohead
 		push.default
+		push.atomic
 		push.followTags
 		rebase.autosquash
 		rebase.stat
diff --git a/t/t5543-atomic-push.sh b/t/t5543-atomic-push.sh
index 3480b3300..7c573b85b 100755
--- a/t/t5543-atomic-push.sh
+++ b/t/t5543-atomic-push.sh
@@ -191,4 +191,35 @@ test_expect_success 'atomic push is not advertised if configured' '
 	test_refs master HEAD@{1}
 '
 
+test_expect_success 'atomic option possible via git-config' '
+	# prepare the repo
+	mk_repo_pair &&
+	(
+		cd workbench &&
+		test_commit one &&
+		git checkout -b second master &&
+		test_commit two &&
+		git push --mirror up
+	) &&
+	# a third party modifies the server side:
+	(
+		cd upstream &&
+		git checkout second &&
+		git tag test_tag second
+	) &&
+	# see if we can now push both branches.
+	(
+		cd workbench &&
+		git config push.atomic true &&
+		git checkout master &&
+		test_commit three &&
+		git checkout second &&
+		test_commit four &&
+		git tag test_tag &&
+		test_must_fail git push --tags up master second
+	) &&
+	test_refs master HEAD@{3} &&
+	test_refs second HEAD@{1}
+'
+
 test_done
-- 
2.12.0.dirty




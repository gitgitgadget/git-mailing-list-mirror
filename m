Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA7FC11F67
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 22:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAEFB61154
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 22:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbhGAWyZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 18:54:25 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33250 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232807AbhGAWyZ (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 1 Jul 2021 18:54:25 -0400
Received: from camp.crustytoothpaste.net (unknown [69.17.174.146])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AB75360424;
        Thu,  1 Jul 2021 22:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1625179883;
        bh=c+nz3wpz+VQQGrI/SVXU4v4jI0tQi/DfLbZTqfUGDbw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=XTKFhYBor8l2LFl3sdnTpk0EYm1G7+rl/iHT1BnAGsoq7EooEQw65auwI7QPXICAS
         T99mgYutegS6iZDlhTKyFQZafCw2pQcUMYzdqDvez+mhM9W+7RDqrzY2gwLzxCQMqY
         /JsCMpFeenymYObF0wYL5K460RXrhws9uA2KPUeYXLaELiFKnZCYVEKxnMt0BV9tPA
         9qqvdLsBvZ8cIOLVbn0A90iA3ZRpXzdwgolHyGz6U+Nfga1fedzJp+5E3HNx5NiAB2
         6jp9vuKpmBPhY4TqKWhJ2bToDgpOI4Ii1jIR0/muniuSkfIdGQZwF05axCHbpznrSd
         8qGS0zL3Mfhkd60Ne9q7b32h9lChdkoN7SWkKnDcf1lsrdlyabEDaIkomQy1pYp8dh
         +SHEdP7dRqQJv8XIUN6IinPldNf7MFC9hIcA/cEfm0zHcAJgVucGMn+/g5lQhDzSvN
         hSSvAW7oF+lQsdRGEYP4nR7qm2PeHu8Km8ZYWjAE4fc4uV9bpwb
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Rose Kunkel <rose@rosekunkel.me>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: [PATCH v2] submodule: mark submodules with update=none as inactive
Date:   Thu,  1 Jul 2021 22:51:17 +0000
Message-Id: <20210701225117.909892-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.32.0.272.g935e593368
In-Reply-To: <YMvgRjwyrwyLz4SC@camp.crustytoothpaste.net>
References: <YMvgRjwyrwyLz4SC@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the user recursively clones a repository with submodules and one or
more of those submodules is marked with the submodule.<name>.update=none
configuration, the submodule will end up being active.  This is a
problem because we will have skipped cloning or checking out the
submodule, and as a result, other commands, such as git reset or git
checkout, will fail if they are invoked with --recurse-submodules (or
when submodule.recurse is true).

This is obviously not the behavior the user wanted, so let's fix this by
specifically setting the submodule as inactive in this case when we're
initializing the repository.  That will make us properly ignore the
submodule when performing recursive operations.

We only do this when initializing a submodule, since git submodule
update can update the submodule with various options despite the setting
of "none" and we want those options to override it as they currently do.

Reported-by: Rose Kunkel <rose@rosekunkel.me>
Helped-by: Philippe Blain <levraiphilippeblain@gmail.com>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/submodule--helper.c |  6 ++++++
 t/t5601-clone.sh            | 24 ++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index ae6174ab05..a3f8c45d97 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -686,6 +686,12 @@ static void init_submodule(const char *path, const char *prefix,
 
 		if (git_config_set_gently(sb.buf, upd))
 			die(_("Failed to register update mode for submodule path '%s'"), displaypath);
+
+		if (sub->update_strategy.type == SM_UPDATE_NONE) {
+			strbuf_reset(&sb);
+			strbuf_addf(&sb, "submodule.%s.active", sub->name);
+			git_config_set_gently(sb.buf, "false");
+		}
 	}
 	strbuf_release(&sb);
 	free(displaypath);
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index c0688467e7..efe6b13be0 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -752,6 +752,30 @@ test_expect_success 'batch missing blob request does not inadvertently try to fe
 	git clone --filter=blob:limit=0 "file://$(pwd)/server" client
 '
 
+test_expect_success 'clone with submodule with update=none is not active' '
+	rm -rf server client &&
+
+	test_create_repo server &&
+	echo a >server/a &&
+	echo b >server/b &&
+	git -C server add a b &&
+	git -C server commit -m x &&
+
+	echo aa >server/a &&
+	echo bb >server/b &&
+	git -C server submodule add --name c "$(pwd)/repo_for_submodule" c &&
+	git -C server config -f .gitmodules submodule.c.update none &&
+	git -C server add a b c .gitmodules &&
+	git -C server commit -m x &&
+
+	git clone --recurse-submodules server client &&
+	git -C client config submodule.c.active >actual &&
+	echo false >expected &&
+	test_cmp actual expected &&
+	# This would fail if the submodule were active, since it is not checked out.
+	git -C client reset --recurse-submodules --hard
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 

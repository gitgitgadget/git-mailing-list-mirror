Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74914C2B9F4
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 21:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47F5C601FE
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 21:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhFSVrO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Jun 2021 17:47:14 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:52912 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229521AbhFSVrN (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 19 Jun 2021 17:47:13 -0400
Received: from camp.crustytoothpaste.net (unknown [69.17.174.146])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9A92060424;
        Sat, 19 Jun 2021 21:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1624139101;
        bh=NGDEhOKSQLzYo3tuRgCKXFJzWZ8ssAaGsltDw1KMLl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=i8wu8phlk8vXnfkgoFK//hYCnY31xViyKH599E7I3hcAYJHv1GHhsR5W2Jc3f9wbl
         aoMEtsvLKGF2jCdEocQKIpl+GlNFrtzZ7mJL81DHvao5fs6lUQNIZEo3GtN+XceP27
         xSukW/8Lk5EErprEwmdjgGjMdPaClkKSu0Wr3dnhD/rOdUTg70/RXN3OGM22CJvoIb
         uv4lJrDJO0MppA7gxqEymrMIBYlMOg4phXnoBa/6gt7VbalvsYGBrwEwwkU0YYlx+/
         uG/1WgJFolcc1k4562DOmQUC1cpbTrVScYqlNnbV1F69V17zfrp/rKreqFRUca3EQl
         +4Xc84EH+aJVtHcHIUQZ1p9Xu6F2ITs0LweJFdXOOEWwnb4r9rZD2tiQNMXvvuDDFz
         Tn5v3ToFoQQcvouNcKm5V9nCMbSBhfOEScgwWLNj/eB7lfMxJGJ8sTl0Ev5/OUM1TV
         u3IkoFSn9PR9lRGqRAjpFDwe5+DNBndlGpz39sBl+ikTgxXJBvd
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Rose Kunkel <rose@rosekunkel.me>
Subject: [PATCH] submodule: mark submodules with update=none as inactive
Date:   Sat, 19 Jun 2021 21:44:49 +0000
Message-Id: <20210619214449.2827705-1-sandals@crustytoothpaste.net>
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
cloning the repository.  That will make us properly ignore the submodule
when performing recursive operations.

Note that we only do this when the --require-init option is passed,
which is only passed during clone.  That's because the update-clone
submodule helper is also invoked during a user-invoked git submodule
update, where we explicitly indicate that we override the configuration
setting, so we don't want to set such a configuration option then.

Reported-by: Rose Kunkel <rose@rosekunkel.me>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/submodule--helper.c |  5 +++++
 t/t5601-clone.sh            | 24 ++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index ae6174ab05..2e14cc7a26 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2102,6 +2102,11 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	if (suc->update.type == SM_UPDATE_NONE
 	    || (suc->update.type == SM_UPDATE_UNSPECIFIED
 		&& update_type == SM_UPDATE_NONE)) {
+		if (suc->require_init) {
+			key = xstrfmt("submodule.%s.active", sub->name);
+			git_config_set(key, "false");
+			free(key);
+		}
 		strbuf_addf(out, _("Skipping submodule '%s'"), displaypath);
 		strbuf_addch(out, '\n');
 		goto cleanup;
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
 

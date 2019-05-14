Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D5AF1F461
	for <e@80x24.org>; Tue, 14 May 2019 00:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfENAYL (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 20:24:11 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36456 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726780AbfENAYL (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 May 2019 20:24:11 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:89af:9dea:d4e0:996c])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 219B060823;
        Tue, 14 May 2019 00:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1557793448;
        bh=dOUWA6YEzh0vTAMKFMBd1HY3+nW1f7nKelNZ14Tw4fQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=PyRY3du/iVhySbIH/1xVAqYuMbQnYcpz0gZ10qLcDwL1zS6sl4Thxn2gvDxDimywe
         g2F8JyD0a2gcbeNL9L+Dm6XbQFxhBga2s44a0jyt3injXW4no6E3t/atTaZvZGbyaL
         kReT9pTlGkzQp6gJ68f+cTXFbkp86UymAftE/xbD45lZsJic3J/1ldKkZOdRleeHqr
         h/vEw8Q8kOZgmxOmZh6nBo0XlnJ8Cyxl0ng53dbMI162YAL1pJGnF2tpJu6vQ8oHqK
         ZYEpiOq12njEDIjmmTmZ9h6NqCR0EIhmIKnD1TI4VOCejhSK0ex/fE6H3YgICiCryP
         qSCMddf/dhbWHGhyw8RCXAqyBPhP5z4mUUPnwJesHY9LPt6okREsHr8dpH1WD3E9hD
         I27TCC8bOweY80WUS3hfBbTcc+/+OkQ7qEcPHspF3011ocf1J6lMupa9x6EVbg6KKR
         PYyEAJ9q3aO1oyRKLCsIL/iRsVBrzahXLuX1Al0bBTLTeQFaRHb
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 5/7] transport: add support for multiple pre-push hooks
Date:   Tue, 14 May 2019 00:23:30 +0000
Message-Id: <20190514002332.121089-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a
In-Reply-To: <20190514002332.121089-1-sandals@crustytoothpaste.net>
References: <20190514002332.121089-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add support for multiple pre-push hooks.

Remove find_hook since there are no longer any callers of it.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 run-command.c            | 12 ------------
 run-command.h            |  6 ------
 t/t5571-pre-push-hook.sh | 19 +++++++++++++++++++
 transport.c              | 29 +++++++++++++++++++----------
 4 files changed, 38 insertions(+), 28 deletions(-)

diff --git a/run-command.c b/run-command.c
index eb075ac86b..191d6f6f7e 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1346,18 +1346,6 @@ static int has_hook(struct strbuf *path, int strip, int check)
 	return 1;
 }
 
-const char *find_hook(const char *name)
-{
-	static struct strbuf path = STRBUF_INIT;
-
-	strbuf_reset(&path);
-	strbuf_git_path(&path, "hooks/%s", name);
-	if (has_hook(&path, 1, X_OK)) {
-		return path.buf;
-	}
-	return NULL;
-}
-
 int find_hooks(const char *name, struct string_list *list)
 {
 	struct strbuf path = STRBUF_INIT;
diff --git a/run-command.h b/run-command.h
index 1b3677fcac..15974e26d4 100644
--- a/run-command.h
+++ b/run-command.h
@@ -63,12 +63,6 @@ int finish_command(struct child_process *);
 int finish_command_in_signal(struct child_process *);
 int run_command(struct child_process *);
 
-/*
- * Returns the path to the hook file, or NULL if the hook is missing
- * or disabled. Note that this points to static storage that will be
- * overwritten by further calls to find_hook and run_hook_*.
- */
-extern const char *find_hook(const char *name);
 /*
  * Returns the paths to all hook files, or NULL if all hooks are missing or
  * disabled.
diff --git a/t/t5571-pre-push-hook.sh b/t/t5571-pre-push-hook.sh
index ac53d63869..754ad8eb93 100755
--- a/t/t5571-pre-push-hook.sh
+++ b/t/t5571-pre-push-hook.sh
@@ -2,6 +2,7 @@
 
 test_description='check pre-push hooks'
 . ./test-lib.sh
+. "$TEST_DIRECTORY/lib-hooks.sh"
 
 # Setup hook that always succeeds
 HOOKDIR="$(git rev-parse --git-dir)/hooks"
@@ -125,4 +126,22 @@ test_expect_success 'sigpipe does not cause pre-push hook failure' '
 	git push parent1 "refs/heads/b/*:refs/heads/b/*"
 '
 
+push_command () {
+	test_commit "$1" &&
+	git push hooks refs/heads/master:refs/heads/master
+}
+
+push_no_verify_command () {
+	test_commit "$1" &&
+	git push --no-verify hooks refs/heads/master:refs/heads/master
+}
+
+test_expect_success 'setup' '
+	git checkout master &&
+	git init --bare hooktest &&
+	git remote add hooks hooktest
+'
+
+test_multiple_hooks pre-push push_command push_no_verify_command
+
 test_done
diff --git a/transport.c b/transport.c
index 365ea574c7..7672f4fb57 100644
--- a/transport.c
+++ b/transport.c
@@ -1042,20 +1042,23 @@ static void die_with_unpushed_submodules(struct string_list *needs_pushing)
 	die(_("Aborting."));
 }
 
-static int run_pre_push_hook(struct transport *transport,
-			     struct ref *remote_refs)
+struct pre_push_hook_data {
+	struct transport *transport;
+	struct ref *remote_refs;
+};
+
+static int do_run_pre_push_hook(const char *name, const char *path, void *p)
 {
+	struct pre_push_hook_data *data = p;
+	struct child_process proc = CHILD_PROCESS_INIT;
 	int ret = 0, x;
 	struct ref *r;
-	struct child_process proc = CHILD_PROCESS_INIT;
 	struct strbuf buf;
 	const char *argv[4];
 
-	if (!(argv[0] = find_hook("pre-push")))
-		return 0;
-
-	argv[1] = transport->remote->name;
-	argv[2] = transport->url;
+	argv[0] = path;
+	argv[1] = data->transport->remote->name;
+	argv[2] = data->transport->url;
 	argv[3] = NULL;
 
 	proc.argv = argv;
@@ -1071,7 +1074,7 @@ static int run_pre_push_hook(struct transport *transport,
 
 	strbuf_init(&buf, 256);
 
-	for (r = remote_refs; r; r = r->next) {
+	for (r = data->remote_refs; r; r = r->next) {
 		if (!r->peer_ref) continue;
 		if (r->status == REF_STATUS_REJECT_NONFASTFORWARD) continue;
 		if (r->status == REF_STATUS_REJECT_STALE) continue;
@@ -1101,10 +1104,16 @@ static int run_pre_push_hook(struct transport *transport,
 	x = finish_command(&proc);
 	if (!ret)
 		ret = x;
-
 	return ret;
 }
 
+static int run_pre_push_hook(struct transport *transport,
+			     struct ref *remote_refs)
+{
+	struct pre_push_hook_data data = { transport, remote_refs };
+	return for_each_hook("pre-push", do_run_pre_push_hook, &data);
+}
+
 int transport_push(struct repository *r,
 		   struct transport *transport,
 		   struct refspec *rs, int flags,

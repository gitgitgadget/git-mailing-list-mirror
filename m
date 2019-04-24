Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1316F1F453
	for <e@80x24.org>; Wed, 24 Apr 2019 00:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbfDXAyf (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 20:54:35 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35632 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729026AbfDXAyd (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 23 Apr 2019 20:54:33 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:ace5:84c6:6a15:3d32])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0692861006;
        Wed, 24 Apr 2019 00:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1556067271;
        bh=Kz5SMFLvSrAik3eWk/P2YZnaNhg2VUDTcHV6484tyso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=yCCrO2CFNSWN04BOIGVh8Wt+mM0nliFszPdHIWokt6LBkzBmc2EnrnUxLD/EYUF2P
         Hm3Br49GgK9yaKtdN3AfWCn9CMrkYCn5VBJ+w3jaMGLONkVPmfhp5YpQUKwWO4IpEq
         bGLTfu5k8czVcYrleLC5dmWVxeeLBwrRa3KsRH0tPMzE6Q3qdMbaTecGMcW4wX0jZa
         PzpPDwocOMcdBCdN/CeD4Du0KJOFJQ+i2LiD6F25zmGIbTld9oF2z2eK7mvC1NROay
         I3IYwANikHqqYG/eeGIhW+JifMRUkd0jaqvSy2mue/2MPJtoZmWWlZUnBs7j0c2X7c
         xE9HcBt1ayL4YeuOHmC3NS9ap/k3nV4ExuOHoLKuo3CXhkbJb3oey2PnVRkxwplhJn
         TAWVD2ArJKYkinkcuVAtm4XjJdCbkEHu728uDPs9lHEJ+xuzfeihCp1uZjWXUB5DOQ
         eYar+k0Z6c4rq9zl1twA/y8R5A6vKCeL578KXMXixOqaj52IAEp
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 5/5] transport: add support for multiple pre-push hooks
Date:   Wed, 24 Apr 2019 00:49:48 +0000
Message-Id: <20190424004948.728326-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18
In-Reply-To: <20190424004948.728326-1-sandals@crustytoothpaste.net>
References: <20190424004948.728326-1-sandals@crustytoothpaste.net>
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
 run-command.c            | 12 -----
 run-command.h            |  6 ---
 t/t5571-pre-push-hook.sh | 19 ++++++++
 transport.c              | 98 ++++++++++++++++++++++------------------
 4 files changed, 74 insertions(+), 61 deletions(-)

diff --git a/run-command.c b/run-command.c
index 669af5ebc7..2c387a7aef 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1340,18 +1340,6 @@ static int has_hook(struct strbuf *path, int strip)
 	return 1;
 }
 
-const char *find_hook(const char *name)
-{
-	static struct strbuf path = STRBUF_INIT;
-
-	strbuf_reset(&path);
-	strbuf_git_path(&path, "hooks/%s", name);
-	if (has_hook(&path, 1)) {
-		return path.buf;
-	}
-	return NULL;
-}
-
 struct string_list *find_hooks(const char *name)
 {
 	struct string_list *list = xmalloc(sizeof(*list));
diff --git a/run-command.h b/run-command.h
index 7266dc2969..a657c09a6c 100644
--- a/run-command.h
+++ b/run-command.h
@@ -62,12 +62,6 @@ int finish_command(struct child_process *);
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
index d0608df5c9..a2a9437c5b 100644
--- a/transport.c
+++ b/transport.c
@@ -1049,61 +1049,73 @@ static int run_pre_push_hook(struct transport *transport,
 {
 	int ret = 0, x;
 	struct ref *r;
-	struct child_process proc = CHILD_PROCESS_INIT;
+	struct child_process proc;
+	struct string_list *hooks;
+	struct string_list_item *p;
 	struct strbuf buf;
 	const char *argv[4];
 
-	if (!(argv[0] = find_hook("pre-push")))
+	hooks = find_hooks("pre-push");
+	if (!hooks)
 		return 0;
 
-	argv[1] = transport->remote->name;
-	argv[2] = transport->url;
-	argv[3] = NULL;
 
-	proc.argv = argv;
-	proc.in = -1;
-	proc.trace2_hook_name = "pre-push";
+	for_each_string_list_item(p, hooks) {
+		child_process_init(&proc);
 
-	if (start_command(&proc)) {
-		finish_command(&proc);
-		return -1;
-	}
+		argv[0] = p->string;
+		argv[1] = transport->remote->name;
+		argv[2] = transport->url;
+		argv[3] = NULL;
 
-	sigchain_push(SIGPIPE, SIG_IGN);
+		proc.argv = argv;
+		proc.in = -1;
+		proc.trace2_hook_name = "pre-push";
 
-	strbuf_init(&buf, 256);
-
-	for (r = remote_refs; r; r = r->next) {
-		if (!r->peer_ref) continue;
-		if (r->status == REF_STATUS_REJECT_NONFASTFORWARD) continue;
-		if (r->status == REF_STATUS_REJECT_STALE) continue;
-		if (r->status == REF_STATUS_UPTODATE) continue;
-
-		strbuf_reset(&buf);
-		strbuf_addf( &buf, "%s %s %s %s\n",
-			 r->peer_ref->name, oid_to_hex(&r->new_oid),
-			 r->name, oid_to_hex(&r->old_oid));
-
-		if (write_in_full(proc.in, buf.buf, buf.len) < 0) {
-			/* We do not mind if a hook does not read all refs. */
-			if (errno != EPIPE)
-				ret = -1;
+		if (start_command(&proc)) {
+			finish_command(&proc);
+			ret = -1;
 			break;
 		}
+
+		sigchain_push(SIGPIPE, SIG_IGN);
+
+		strbuf_init(&buf, 256);
+
+		for (r = remote_refs; r; r = r->next) {
+			if (!r->peer_ref) continue;
+			if (r->status == REF_STATUS_REJECT_NONFASTFORWARD) continue;
+			if (r->status == REF_STATUS_REJECT_STALE) continue;
+			if (r->status == REF_STATUS_UPTODATE) continue;
+
+			strbuf_reset(&buf);
+			strbuf_addf( &buf, "%s %s %s %s\n",
+				 r->peer_ref->name, oid_to_hex(&r->new_oid),
+				 r->name, oid_to_hex(&r->old_oid));
+
+			if (write_in_full(proc.in, buf.buf, buf.len) < 0) {
+				/* We do not mind if a hook does not read all refs. */
+				if (errno != EPIPE)
+					ret = -1;
+				break;
+			}
+		}
+
+		strbuf_release(&buf);
+
+		x = close(proc.in);
+		if (!ret)
+			ret = x;
+
+		sigchain_pop(SIGPIPE);
+
+		x = finish_command(&proc);
+		if (!ret)
+			ret = x;
+		if (ret)
+			break;
 	}
-
-	strbuf_release(&buf);
-
-	x = close(proc.in);
-	if (!ret)
-		ret = x;
-
-	sigchain_pop(SIGPIPE);
-
-	x = finish_command(&proc);
-	if (!ret)
-		ret = x;
-
+	free_hooks(hooks);
 	return ret;
 }
 

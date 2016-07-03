Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D60EF20179
	for <e@80x24.org>; Sun,  3 Jul 2016 08:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330AbcGCIAR (ORCPT <rfc822;e@80x24.org>);
	Sun, 3 Jul 2016 04:00:17 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:55594 "EHLO
	homiemail-a21.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752297AbcGCIAM (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Jul 2016 04:00:12 -0400
Received: from homiemail-a21.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a21.g.dreamhost.com (Postfix) with ESMTP id 60D1130009B;
	Sun,  3 Jul 2016 00:58:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=novalis.org;
	 bh=jtEHu8TSoVtUnzyPtYFTADUODzk=; b=GwfmGAbJXZoNbBPKoh6YtPedIt6h
	iUVtT6fKxtWHOwF2UhvHvUDjqA0tB1N01EaIrfsVS4JMTApMs4vA1exyf8ogTprW
	HsIXdsnuqg4u7DgB63PEwJe1s2Hu/Y4BKSzB7uiwv4XmGb88Gzb1omv8R2+PIpTS
	BqSpyyFPG1UD29c=
Received: from frank.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com [207.38.164.98])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: novalis@novalis.org)
	by homiemail-a21.g.dreamhost.com (Postfix) with ESMTPSA id B495E30007B;
	Sun,  3 Jul 2016 00:58:42 -0700 (PDT)
From:	David Turner <novalis@novalis.org>
To:	git@vger.kernel.org, pclouds@gmail.com, kmaggg@gmail.com
Cc:	David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v14 18/21] index-helper: optionally automatically run
Date:	Sun,  3 Jul 2016 03:58:10 -0400
Message-Id: <1467532693-20017-19-git-send-email-novalis@novalis.org>
X-Mailer: git-send-email 2.8.0.rc4.11.g9232872.dirty
In-Reply-To: <1467532693-20017-1-git-send-email-novalis@novalis.org>
References: <1467532693-20017-1-git-send-email-novalis@novalis.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: David Turner <dturner@twopensource.com>

Introduce a new config option, indexhelper.autorun, to automatically
run git index-helper before starting up a builtin git command.  This
enables users to keep index-helper running without manual
intervention.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt |  4 ++++
 read-cache.c             | 35 +++++++++++++++++++++++++++++++++--
 t/t7900-index-helper.sh  | 20 ++++++++++++++++++++
 3 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 15001ce..385ea66 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1856,6 +1856,10 @@ index.version::
 	Specify the version with which new index files should be
 	initialized.  This does not affect existing repositories.
 
+indexhelper.autorun::
+	Automatically run git index-helper when any builtin git
+	command is run inside a repository.
+
 init.templateDir::
 	Specify the directory from which templates will be copied.
 	(See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)
diff --git a/read-cache.c b/read-cache.c
index 8141559..fde778b 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -22,6 +22,7 @@
 #include "pkt-line.h"
 #include "sigchain.h"
 #include "ewah/ewok.h"
+#include "run-command.h"
 
 static struct cache_entry *refresh_cache_entry(struct cache_entry *ce,
 					       unsigned int options);
@@ -1733,6 +1734,31 @@ static void post_read_index_from(struct index_state *istate)
 	tweak_untracked_cache(istate);
 }
 
+static int want_auto_index_helper(void)
+{
+	int want = -1;
+	const char *value = NULL;
+	const char *key = "indexhelper.autorun";
+
+	if (git_config_key_is_valid(key) &&
+	    !git_config_get_value(key, &value)) {
+		int b = git_config_maybe_bool(key, value);
+		want = b >= 0 ? b : 0;
+	}
+	return want;
+}
+
+static void autorun_index_helper(void)
+{
+	const char *argv[] = {"git-index-helper", "--detach", "--autorun", NULL};
+	if (want_auto_index_helper() <= 0)
+		return;
+
+	if (run_command_v_opt(argv,
+			      RUN_SILENT_EXEC_FAILURE | RUN_CLEAN_ON_EXIT))
+		warning(_("You specified indexhelper.autorun, but running git-index-helper failed."));
+}
+
 /* in ms */
 #define WATCHMAN_TIMEOUT 1000
 
@@ -1804,6 +1830,7 @@ static int poke_daemon(struct index_state *istate,
 	if (fd < 0) {
 		warning("Failed to connect to index-helper socket");
 		unlink(git_path("index-helper.sock"));
+		autorun_index_helper();
 		return -1;
 	}
 	sigchain_push(SIGPIPE, SIG_IGN);
@@ -1843,9 +1870,13 @@ static int try_shm(struct index_state *istate)
 	int fd = -1;
 
 	if (!is_main_index(istate) ||
-	    old_size <= 20 ||
-	    stat(git_path("index-helper.sock"), &st))
+	    old_size <= 20)
 		return -1;
+
+	if (stat(git_path("index-helper.sock"), &st)) {
+		autorun_index_helper();
+		return -1;
+	}
 	if (poke_daemon(istate, &st, 0))
 		return -1;
 	sha1 = (unsigned char *)istate->mmap + old_size - 20;
diff --git a/t/t7900-index-helper.sh b/t/t7900-index-helper.sh
index 7f72e94..15ba612 100755
--- a/t/t7900-index-helper.sh
+++ b/t/t7900-index-helper.sh
@@ -18,6 +18,9 @@ test $? = 129 ||
 }
 
 test_expect_success 'index-helper smoke test' '
+	# We need an existing commit so that the index exists (otherwise,
+	# the index-helper will not be autostarted)
+	test_commit x &&
 	git index-helper --exit-after 1 &&
 	test_path_is_missing .git/index-helper.sock
 '
@@ -48,4 +51,21 @@ test_expect_success 'index-helper is quiet with --autorun' '
 	git index-helper --autorun
 '
 
+test_expect_success 'index-helper autorun works' '
+	test_when_finished "git index-helper --kill" &&
+	rm -f .git/index-helper.sock &&
+	git status &&
+	test_path_is_missing .git/index-helper.sock &&
+	test_config indexhelper.autorun true &&
+	git status &&
+	test -S .git/index-helper.sock &&
+	git status 2>err &&
+	test -S .git/index-helper.sock &&
+	test_must_be_empty err &&
+	git index-helper --kill &&
+	test_config indexhelper.autorun false &&
+	git status &&
+	test_path_is_missing .git/index-helper.sock
+'
+
 test_done
-- 
1.9.1


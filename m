From: Peter Wu <peter@lekensteyn.nl>
Subject: [PATCH v3] remote: add --fetch and --both options to set-url
Date: Tue, 25 Nov 2014 12:48:26 +0100
Message-ID: <1416916106-19892-1-git-send-email-peter@lekensteyn.nl>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 25 12:48:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtEbm-000390-Bn
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 12:48:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755948AbaKYLsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 06:48:33 -0500
Received: from lekensteyn.nl ([178.21.112.251]:49732 "EHLO lekensteyn.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752980AbaKYLsb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 06:48:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lekensteyn.nl; s=s2048-2014-q3;
	h=Message-Id:Date:Subject:Cc:To:From; bh=+bxZovWP8o/AHkO9O/LXLeO3/iAYDYKYSA8U8yf3u0s=;
	b=vKhAEsavIcBBa+7jMtChS4HlcQgwD/nTweK8qnKuSCt6en5w/dHyUDxGVDo6qxrKNKMwwTN025PaHAIbU65i4UiZUVy6UAPJgiAbzOcRBA/szk6cmbytcRTukM6x45wnqV30Dk2Hoeo9HBG85nTZ8qNOAnGL4fHSkXE9sNNKmt+jaaTzxQ80DEierC+J8ByMq4BLaelXH5ZnAHT59EjPquVtX+ELO3KOgfIPaLgBFhp25tGh+Xpv7eOgDarBxl/1SVwmThjS22LFT2CDysrLBeRGPGPedm/RAu3Eo4ixnrFcUXln7hF2A6NWBxWMWH7KtMTHkCSsY//e3ih/QabqVg==;
Received: by lekensteyn.nl with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA256:128)
	(Exim 4.80)
	(envelope-from <peter@lekensteyn.nl>)
	id 1XtEbc-0000Ch-4S; Tue, 25 Nov 2014 12:48:28 +0100
X-Mailer: git-send-email 2.1.3
X-Spam-Score: -0.0 (/)
X-Spam-Status: No, hits=-0.0 required=5.0 tests=NO_RELAYS=-0.001 autolearn=no autolearn_force=no
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260213>

git remote set-url knew about the '--push' option to update just the
pushurl, but it does not have a similar option for "update fetch URL and
leave whatever was in place for the push URL".

This patch adds support for a '--fetch' option which implements that use
case in a backwards compatible way: if no --both, --push or --fetch
options are given, then the push URL is modified too if it was not set
before. This is the case since the push URL is implicitly based on the
fetch URL.

A '--both' option is added to make the command independent of previous
pushurl settings. For the --add and --delete set operations, it will
always set the push and/ or the fetch URLs. For the primary mode of
operation (without --add or --delete), it will drop pushurl as the
implicit push URL is the (fetch) URL.

The documentation has also been updated and a missing '--push' option
is added to the 'git remote -h' command.

Tests are also added to verify the documented behavior.

Signed-off-by: Peter Wu <peter@lekensteyn.nl>
---

 v2: fixed test case
 v3: added --both option, changed --fetch --push behavior, added more tests for
     --add/--delete cases, refactored to reduce duplication (not special-casing
     add_mode without oldurl, just skip initially setting oldurl).

Translators note: the help text gained more translatable strings and some
strings got additional options.
---
 Documentation/git-remote.txt |  17 ++++--
 builtin/remote.c             | 140 +++++++++++++++++++++++++++----------------
 t/t5505-remote.sh            | 125 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 228 insertions(+), 54 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index cb103c8..bdd0305 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -15,9 +15,9 @@ SYNOPSIS
 'git remote remove' <name>
 'git remote set-head' <name> (-a | --auto | -d | --delete | <branch>)
 'git remote set-branches' [--add] <name> <branch>...
-'git remote set-url' [--push] <name> <newurl> [<oldurl>]
-'git remote set-url --add' [--push] <name> <newurl>
-'git remote set-url --delete' [--push] <name> <url>
+'git remote set-url' [--both | --fetch | --push] <name> <newurl> [<oldurl>]
+'git remote set-url' [--both | --fetch | --push] '--add' <name> <newurl>
+'git remote set-url' [--both | --fetch | --push] '--delete' <name> <url>
 'git remote' [-v | --verbose] 'show' [-n] <name>...
 'git remote prune' [-n | --dry-run] <name>...
 'git remote' [-v | --verbose] 'update' [-p | --prune] [(<group> | <remote>)...]
@@ -134,7 +134,16 @@ Changes URL remote points to. Sets first URL remote points to matching
 regex <oldurl> (first URL if no <oldurl> is given) to <newurl>. If
 <oldurl> doesn't match any URL, error occurs and nothing is changed.
 +
-With '--push', push URLs are manipulated instead of fetch URLs.
+With '--both', both the fetch and push URLs are manipulated.
++
+With '--fetch', only fetch URLs are manipulated.
++
+With '--push', only push URLs are manipulated.
++
+If none of the '--both', '--fetch' or --push' options are given, then
+'--both' applies only if no push URL was set before. Otherwise '--fetch'
+is assumed for historical reasons. This default may change in the
+future to '--both' to avoid surprises depending on the configuration.
 +
 With '--add', instead of changing some URL, new URL is added.
 +
diff --git a/builtin/remote.c b/builtin/remote.c
index 7f28f92..a250b23 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -18,9 +18,9 @@ static const char * const builtin_remote_usage[] = {
 	N_("git remote prune [-n | --dry-run] <name>"),
 	N_("git remote [-v | --verbose] update [-p | --prune] [(<group> | <remote>)...]"),
 	N_("git remote set-branches [--add] <name> <branch>..."),
-	N_("git remote set-url [--push] <name> <newurl> [<oldurl>]"),
-	N_("git remote set-url --add <name> <newurl>"),
-	N_("git remote set-url --delete <name> <url>"),
+	N_("git remote set-url [--both | --fetch | --push] <name> <newurl> [<oldurl>]"),
+	N_("git remote set-url [--both | --fetch | --push] --add <name> <newurl>"),
+	N_("git remote set-url [--both | --fetch | --push] --delete <name> <url>"),
 	NULL
 };
 
@@ -66,9 +66,9 @@ static const char * const builtin_remote_update_usage[] = {
 };
 
 static const char * const builtin_remote_seturl_usage[] = {
-	N_("git remote set-url [--push] <name> <newurl> [<oldurl>]"),
-	N_("git remote set-url --add <name> <newurl>"),
-	N_("git remote set-url --delete <name> <url>"),
+	N_("git remote set-url [--both | --fetch | --push] <name> <newurl> [<oldurl>]"),
+	N_("git remote set-url [--both | --fetch | --push] --add <name> <newurl>"),
+	N_("git remote set-url [--both | --fetch | --push] --delete <name> <url>"),
 	NULL
 };
 
@@ -1503,21 +1503,35 @@ static int set_branches(int argc, const char **argv)
 	return set_remote_branches(argv[0], argv + 1, add_mode);
 }
 
+#define MODIFY_TYPE_FETCH       (1 << 0)
+#define MODIFY_TYPE_PUSH        (1 << 1)
+#define MODIFY_TYPE_BOTH        (MODIFY_TYPE_FETCH | MODIFY_TYPE_PUSH)
+#define MODIFY_TYPE_HISTORIC    (MODIFY_TYPE_FETCH | (1 << 2))
+
 static int set_url(int argc, const char **argv)
 {
-	int i, push_mode = 0, add_mode = 0, delete_mode = 0;
+	int i, add_mode = 0, delete_mode = 0;
+	int modify_type = MODIFY_TYPE_HISTORIC;
 	int matches = 0, negative_matches = 0;
 	const char *remotename = NULL;
 	const char *newurl = NULL;
 	const char *oldurl = NULL;
 	struct remote *remote;
 	regex_t old_regex;
-	const char **urlset;
-	int urlset_nr;
-	struct strbuf name_buf = STRBUF_INIT;
+	struct strbuf name_buf_fetch = STRBUF_INIT;
+	struct strbuf name_buf_push = STRBUF_INIT;
 	struct option options[] = {
-		OPT_BOOL('\0', "push", &push_mode,
-			 N_("manipulate push URLs")),
+		OPT_GROUP(""),
+		OPT_SET_INT('\0', "fetch", &modify_type,
+			N_("manipulate just fetch URLs"),
+			MODIFY_TYPE_FETCH),
+		OPT_SET_INT('\0', "push", &modify_type,
+			N_("manipulate just push URLs"),
+			MODIFY_TYPE_PUSH),
+		OPT_SET_INT('\0', "both", &modify_type,
+			N_("manipulate both push and fetch URLs"),
+			MODIFY_TYPE_BOTH),
+		OPT_GROUP(""),
 		OPT_BOOL('\0', "add", &add_mode,
 			 N_("add URL")),
 		OPT_BOOL('\0', "delete", &delete_mode,
@@ -1535,7 +1549,8 @@ static int set_url(int argc, const char **argv)
 
 	remotename = argv[1];
 	newurl = argv[2];
-	if (argc > 3)
+	/* The old URL is only meaningful for the primary non-set operation. */
+	if (argc > 3 && !add_mode && !delete_mode)
 		oldurl = argv[3];
 
 	if (delete_mode)
@@ -1545,47 +1560,72 @@ static int set_url(int argc, const char **argv)
 		die(_("No such remote '%s'"), remotename);
 	remote = remote_get(remotename);
 
-	if (push_mode) {
-		strbuf_addf(&name_buf, "remote.%s.pushurl", remotename);
-		urlset = remote->pushurl;
-		urlset_nr = remote->pushurl_nr;
-	} else {
-		strbuf_addf(&name_buf, "remote.%s.url", remotename);
-		urlset = remote->url;
-		urlset_nr = remote->url_nr;
+	strbuf_addf(&name_buf_fetch, "remote.%s.url", remotename);
+	strbuf_addf(&name_buf_push, "remote.%s.pushurl", remotename);
+
+	if (oldurl && !add_mode) {
+		/* Old URL specified, or deletion. Demand that one matches. */
+		if (regcomp(&old_regex, oldurl, REG_EXTENDED))
+			die(_("Invalid old URL pattern: %s"), oldurl);
+
+		if (modify_type & MODIFY_TYPE_FETCH)
+			for (i = 0; i < remote->url_nr; i++)
+				if (!regexec(&old_regex, remote->url[i], 0, NULL, 0))
+					matches++;
+				else
+					negative_matches++;
+		if (delete_mode && !negative_matches && modify_type & MODIFY_TYPE_FETCH)
+			die(_("Will not delete all non-push URLs"));
+		if (modify_type & MODIFY_TYPE_PUSH)
+			for (i = 0; i < remote->pushurl_nr; i++)
+				if (!regexec(&old_regex, remote->pushurl[i], 0, NULL, 0))
+					matches++;
+				else
+					negative_matches++;
+		if (!delete_mode && !matches)
+			die(_("No such URL found: %s"), oldurl);
+
+		regfree(&old_regex);
 	}
 
-	/* Special cases that add new entry. */
-	if ((!oldurl && !delete_mode) || add_mode) {
-		if (add_mode)
-			git_config_set_multivar(name_buf.buf, newurl,
-				"^$", 0);
-		else
-			git_config_set(name_buf.buf, newurl);
-		strbuf_release(&name_buf);
-		return 0;
+	/* If --fetch was explicitly given, then ensure that the push
+	 * URL does not change by copying the fetch URL to it. */
+	if (modify_type == MODIFY_TYPE_FETCH &&
+			remote->pushurl_nr == 0 && remote->url_nr > 0)
+		for (i = 0; i < remote->url_nr; i++)
+			git_config_set_multivar(name_buf_push.buf,
+				remote->url[i], "^$", 0);
+
+	/* Set the new entry value (not a --add or --delete operation). */
+	if (!add_mode && !delete_mode && !oldurl) {
+		if (modify_type & MODIFY_TYPE_FETCH)
+			git_config_set(name_buf_fetch.buf, newurl);
+		/* URLs will be the same, so remove pushurl. */
+		if (modify_type == MODIFY_TYPE_BOTH)
+			git_config_set(name_buf_push.buf, NULL);
+		else if (modify_type == MODIFY_TYPE_PUSH)
+			git_config_set(name_buf_push.buf, newurl);
+
+		goto cleanup_ok;
 	}
 
-	/* Old URL specified. Demand that one matches. */
-	if (regcomp(&old_regex, oldurl, REG_EXTENDED))
-		die(_("Invalid old URL pattern: %s"), oldurl);
-
-	for (i = 0; i < urlset_nr; i++)
-		if (!regexec(&old_regex, urlset[i], 0, NULL, 0))
-			matches++;
-		else
-			negative_matches++;
-	if (!delete_mode && !matches)
-		die(_("No such URL found: %s"), oldurl);
-	if (delete_mode && !negative_matches && !push_mode)
-		die(_("Will not delete all non-push URLs"));
-
-	regfree(&old_regex);
-
-	if (!delete_mode)
-		git_config_set_multivar(name_buf.buf, newurl, oldurl, 0);
-	else
-		git_config_set_multivar(name_buf.buf, NULL, oldurl, 1);
+	/* Set operations (--add, --delete) or change request (oldurl given). */
+	if (delete_mode) {
+		if (modify_type & MODIFY_TYPE_FETCH)
+			git_config_set_multivar(name_buf_fetch.buf, NULL, oldurl, 1);
+		if (modify_type & MODIFY_TYPE_PUSH)
+			git_config_set_multivar(name_buf_push.buf, NULL, oldurl, 1);
+	} else {
+		if (add_mode) /* Do not replace oldurl, but add a new one. */
+			oldurl = "^$";
+		if (modify_type & MODIFY_TYPE_FETCH)
+			git_config_set_multivar(name_buf_fetch.buf, newurl, oldurl, 0);
+		if (modify_type & MODIFY_TYPE_PUSH)
+			git_config_set_multivar(name_buf_push.buf, newurl, oldurl, 0);
+	}
+cleanup_ok:
+	strbuf_release(&name_buf_fetch);
+	strbuf_release(&name_buf_push);
 	return 0;
 }
 
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index ac79dd9..390281a 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -961,6 +961,59 @@ test_expect_success 'remote set-url --push zot' '
 	cmp expect actual
 '
 
+test_expect_success 'remote set-url --fetch zox' '
+	git remote set-url --fetch someremote zox &&
+	echo zox >expect &&
+	echo "YYY" >>expect &&
+	echo zot >>expect &&
+	git config --get-all remote.someremote.url >actual &&
+	echo "YYY" >>actual &&
+	git config --get-all remote.someremote.pushurl >>actual &&
+	cmp expect actual
+'
+
+test_expect_success 'remote set-url --both foo' '
+	git remote set-url --both someremote foo &&
+	echo "YYY" >expect &&
+	echo foo >>expect &&
+	test_must_fail git config --get-all remote.someremote.pushurl >actual &&
+	echo "YYY" >>actual &&
+	git config --get-all remote.someremote.url >>actual &&
+	cmp expect actual
+'
+
+test_expect_success 'remote set-url --delete --push foo' '
+	git remote set-url --delete --push someremote foo &&
+	echo "YYY" >expect &&
+	echo foo >>expect &&
+	test_must_fail git config --get-all remote.someremote.pushurl >actual &&
+	echo "YYY" >actual &&
+	git config --get-all remote.someremote.url >>actual &&
+	cmp expect actual
+'
+
+test_expect_success 'remote set-url --push zot' '
+	git remote set-url --push someremote zot &&
+	echo zot >expect &&
+	echo "YYY" >>expect &&
+	echo foo >>expect &&
+	git config --get-all remote.someremote.pushurl >actual &&
+	echo "YYY" >>actual &&
+	git config --get-all remote.someremote.url >>actual &&
+	cmp expect actual
+'
+
+test_expect_success 'remote set-url --fetch baz foo' '
+	git remote set-url --fetch someremote baz foo &&
+	echo zot >expect &&
+	echo "YYY" >>expect &&
+	echo baz >>expect &&
+	git config --get-all remote.someremote.pushurl >actual &&
+	echo "YYY" >>actual &&
+	git config --get-all remote.someremote.url >>actual &&
+	cmp expect actual
+'
+
 test_expect_success 'remote set-url --push qux zot' '
 	git remote set-url --push someremote qux zot &&
 	echo qux >expect &&
@@ -1091,6 +1144,78 @@ test_expect_success 'remote set-url --delete baz' '
 	cmp expect actual
 '
 
+test_expect_success 'remote set-url --fetch --add bar' '
+	git remote set-url --fetch --add someremote bar &&
+	echo ccc >expect &&
+	echo "YYY" >>expect &&
+	echo ccc >>expect &&
+	echo bar >>expect &&
+	git config --get-all remote.someremote.pushurl >actual &&
+	echo "YYY" >>actual &&
+	git config --get-all remote.someremote.url >>actual &&
+	cmp expect actual
+'
+
+test_expect_success 'remote set-url --both --add foo' '
+	git remote set-url --both --add someremote foo &&
+	echo ccc >expect &&
+	echo foo >>expect &&
+	echo "YYY" >>expect &&
+	echo ccc >>expect &&
+	echo bar >>expect &&
+	echo foo >>expect &&
+	git config --get-all remote.someremote.pushurl >actual &&
+	echo "YYY" >>actual &&
+	git config --get-all remote.someremote.url >>actual &&
+	cmp expect actual
+'
+
+test_expect_success 'remote set-url --both --delete ccc' '
+	git remote set-url --both --delete someremote ccc &&
+	echo foo >expect &&
+	echo "YYY" >>expect &&
+	echo bar >>expect &&
+	echo foo >>expect &&
+	git config --get-all remote.someremote.pushurl >actual &&
+	echo "YYY" >>actual &&
+	git config --get-all remote.someremote.url >>actual &&
+	cmp expect actual
+'
+
+test_expect_success 'remote set-url --fetch --delete bar' '
+	git remote set-url --fetch --delete someremote bar &&
+	echo foo >expect &&
+	echo "YYY" >>expect &&
+	echo foo >>expect &&
+	git config --get-all remote.someremote.pushurl >actual &&
+	echo "YYY" >>actual &&
+	git config --get-all remote.someremote.url >>actual &&
+	cmp expect actual
+'
+
+test_expect_success 'remote set-url --push --add baz' '
+	git remote set-url --push --add someremote baz &&
+	echo foo >expect &&
+	echo baz >>expect &&
+	echo "YYY" >>expect &&
+	echo foo >>expect &&
+	git config --get-all remote.someremote.pushurl >actual &&
+	echo "YYY" >>actual &&
+	git config --get-all remote.someremote.url >>actual &&
+	cmp expect actual
+'
+
+test_expect_success 'remote set-url --push --delete foo' '
+	git remote set-url --push --delete someremote foo &&
+	echo baz >expect &&
+	echo "YYY" >>expect &&
+	echo foo >>expect &&
+	git config --get-all remote.someremote.pushurl >actual &&
+	echo "YYY" >>actual &&
+	git config --get-all remote.someremote.url >>actual &&
+	cmp expect actual
+'
+
 test_expect_success 'extra args: setup' '
 	# add a dummy origin so that this does not trigger failure
 	git remote add origin .
-- 
2.1.3

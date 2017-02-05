Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DA3A1FAF4
	for <e@80x24.org>; Sun,  5 Feb 2017 21:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752716AbdBEVnZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Feb 2017 16:43:25 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:61764 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752085AbdBEVnY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2017 16:43:24 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 80A921E1872;
        Sun,  5 Feb 2017 22:43:20 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ZdOtvEMuiZPP; Sun,  5 Feb 2017 22:43:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 24F7F1E18B5;
        Sun,  5 Feb 2017 22:43:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mzMWFioQFMxn; Sun,  5 Feb 2017 22:43:19 +0100 (CET)
Received: from localhost.localdomain (aftr-185-17-204-255.dynamic.mnet-online.de [185.17.204.255])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id A32751E1872;
        Sun,  5 Feb 2017 22:43:18 +0100 (CET)
From:   cornelius.weig@tngtech.com
To:     git@vger.kernel.org
Cc:     bitte.keine.werbung.einwerfen@googlemail.com,
        Cornelius Weig <cornelius.weig@tngtech.com>,
        karthik.188@gmail.com, peff@peff.net
Subject: [PATCH] tag: generate useful reflog message
Date:   Sun,  5 Feb 2017 22:42:54 +0100
Message-Id: <20170205214254.24560-1-cornelius.weig@tngtech.com>
X-Mailer: git-send-email 2.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Cornelius Weig <cornelius.weig@tngtech.com>

When tags are created with `--create-reflog` or with the option
`core.logAllRefUpdates` set to 'always', a reflog is created for them.
So far, the description of reflog entries for tags was empty, making the
reflog hard to understand. For example:
"6e3a7b3 refs/tags/tag_with_reflog@{0}:"

Now, a reflog message is generated when creating a tag. The message
follows the pattern "commit: <subject>" where the subject is taken from
the commit the tag points to. For example:
"6e3a7b3 refs/tags/tag_with_reflog@{0}: commit: Git 2.12-rc0"
If the tag points to a tree/blob/tag object, the following static
messages are used instead:

 - "tree object"
 - "blob object"
 - "other tag object"

Signed-off-by: Cornelius Weig <cornelius.weig@tngtech.com>
---

Notes:
    While playing around with tag reflogs I also found a bug that was present
    before this patch. It manifests itself when the sha1-ref in the reflog does not
    point to a commit object but something else.
    
    For example,
    
     - when the referenced sha1 is a tag object:
    	$ git tag --create-reflog -f -m'annotated tag' tag_with_reflog
     - when the referenced sha1 is a blob object:
    	$ git tag --create-reflog -f tag_with_reflog HEAD:<filename>
     - when the referenced sha1 is a tree object:
    	$ git tag --create-reflog -f tag_with_reflog HEAD^{tree}
    
    In each case, a proper reflog entry is generated, but
    	$ git reflog tag_with_reflog
    will sometimes segfault (if it does, it does so consistently), or only show the
    first few entries. The tree/blob cases are IMHO not so important, but the
    broken reflog for annotated tags I find quite severe.
    
    I guess it's because the reflog is funneled through the log.c code, where every
    reflog-entry is assumed to be a commit object? If this is the case, a fix would
    probably be quite involved.

 builtin/tag.c  | 43 ++++++++++++++++++++++++++++++++++++++++++-
 t/t7004-tag.sh | 14 +++++++++++++-
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index e40c4a9..c0d9478 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -302,6 +302,43 @@ static void create_tag(const unsigned char *object, const char *tag,
 	}
 }
 
+static void create_reflog_msg(const unsigned char *object, struct strbuf *sb)
+{
+	enum object_type type;
+	char *buf;
+	unsigned long size;
+	int subject_len = 0;
+	const char *subject_start;
+
+	type = sha1_object_info(object, NULL);
+	switch (type) {
+	default:
+		strbuf_addstr(sb, "internal object");
+		break;
+	case OBJ_COMMIT:
+		strbuf_addstr(sb, "commit: ");
+		buf = read_sha1_file(object, &type, &size);
+		if (buf) {
+			subject_len = find_commit_subject(buf, &subject_start);
+			strbuf_insert(sb, 8, subject_start, subject_len);
+			free(buf);
+		} else {
+			die("commit object %s could not be read",
+				sha1_to_hex(repl));
+		}
+		break;
+	case OBJ_TREE:
+		strbuf_addstr(sb, "tree object");
+		break;
+	case OBJ_BLOB:
+		strbuf_addstr(sb, "blob object");
+		break;
+	case OBJ_TAG:
+		strbuf_addstr(sb, "other tag object");
+		break;
+	}
+}
+
 struct msg_arg {
 	int given;
 	struct strbuf buf;
@@ -335,6 +372,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf ref = STRBUF_INIT;
+	struct strbuf reflog_msg = STRBUF_INIT;
 	unsigned char object[20], prev[20];
 	const char *object_ref, *tag;
 	struct create_tag_options opt;
@@ -494,6 +532,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	else
 		die(_("Invalid cleanup mode %s"), cleanup_arg);
 
+	create_reflog_msg(object, &reflog_msg);
+
 	if (create_tag_object) {
 		if (force_sign_annotate && !annotate)
 			opt.sign = 1;
@@ -504,7 +544,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (!transaction ||
 	    ref_transaction_update(transaction, ref.buf, object, prev,
 				   create_reflog ? REF_FORCE_CREATE_REFLOG : 0,
-				   NULL, &err) ||
+				   reflog_msg.buf, &err) ||
 	    ref_transaction_commit(transaction, &err))
 		die("%s", err.buf);
 	ref_transaction_free(transaction);
@@ -514,5 +554,6 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	strbuf_release(&err);
 	strbuf_release(&buf);
 	strbuf_release(&ref);
+	strbuf_release(&reflog_msg);
 	return 0;
 }
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 072e6c6..0a92b2c 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -83,7 +83,19 @@ test_expect_success 'creating a tag using default HEAD should succeed' '
 test_expect_success 'creating a tag with --create-reflog should create reflog' '
 	test_when_finished "git tag -d tag_with_reflog" &&
 	git tag --create-reflog tag_with_reflog &&
-	git reflog exists refs/tags/tag_with_reflog
+	git reflog exists refs/tags/tag_with_reflog &&
+	git log -1 --format="format:commit: %s%n" > expected &&
+	sed -e "s/^.*\t//" .git/logs/refs/tags/tag_with_reflog > actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'annotated tag with --create-reflog has correct message' '
+	test_when_finished "git tag -d tag_with_reflog" &&
+	git tag -m "annotated tag" --create-reflog tag_with_reflog &&
+	git reflog exists refs/tags/tag_with_reflog &&
+	git log -1 --format="format:commit: %s%n" > expected &&
+	sed -e "s/^.*\t//" .git/logs/refs/tags/tag_with_reflog > actual &&
+	test_cmp expected actual
 '
 
 test_expect_success '--create-reflog does not create reflog on failure' '
-- 
2.10.2


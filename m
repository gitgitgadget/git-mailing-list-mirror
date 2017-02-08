Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0B691FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 23:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751807AbdBHXgi (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 18:36:38 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:5534 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751374AbdBHXgf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 18:36:35 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 7C2241E18B2;
        Wed,  8 Feb 2017 23:42:58 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id sVS7wz8Ovzyx; Wed,  8 Feb 2017 23:42:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id D63F61E301E;
        Wed,  8 Feb 2017 23:42:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id x4gX_NH_GIiK; Wed,  8 Feb 2017 23:42:57 +0100 (CET)
Received: from localhost.localdomain (aftr-185-17-206-26.dynamic.mnet-online.de [185.17.206.26])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id 5167E1E18B2;
        Wed,  8 Feb 2017 23:42:57 +0100 (CET)
From:   cornelius.weig@tngtech.com
To:     git@vger.kernel.org
Cc:     Cornelius Weig <cornelius.weig@tngtech.com>, gitster@pobox.com,
        bitte.keine.werbung.einwerfen@googlemail.com
Subject: [PATCH v5] tag: generate useful reflog message
Date:   Wed,  8 Feb 2017 23:41:18 +0100
Message-Id: <20170208224118.18425-1-cornelius.weig@tngtech.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <xmqqshnov0c4.fsf@gitster.mtv.corp.google.com>
References: <xmqqshnov0c4.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Cornelius Weig <cornelius.weig@tngtech.com>

When tags are created with `--create-reflog` or with the option
`core.logAllRefUpdates` set to 'always', a reflog is created for them.
So far, the description of reflog entries for tags was empty, making the
reflog hard to understand. For example:
6e3a7b3 refs/tags/test@{0}:

Now, a reflog message is generated when creating a tag, following the
pattern "tag: tagging <short-sha1> (<description>)". If
GIT_REFLOG_ACTION is set, the message becomes "$GIT_REFLOG_ACTION
(<description>)" instead. If the tag references a commit object, the
description is set to the subject line of the commit, followed by its
commit date. For example:
6e3a7b3 refs/tags/test@{0}: tag: tagging 6e3a7b3398 (Git 2.12-rc0, 2017-02-03)

If the tag points to a tree/blob/tag objects, the following static
strings are taken as description:

 - "tree object"
 - "blob object"
 - "other tag object"

Signed-off-by: Cornelius Weig <cornelius.weig@tngtech.com>
---

Notes:
    Interdiff v4..v5
    diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
    index 894959f..1a3230f 100755
    --- a/t/t7004-tag.sh
    +++ b/t/t7004-tag.sh
    @@ -80,9 +80,10 @@ test_expect_success 'creating a tag using default HEAD should succeed' '
     	test_must_fail git reflog exists refs/tags/mytag
     '
    
    -git log -1 > expected \
    -	--format="format:tag: tagging %h (%s, %cd)%n" --date=format:%F
     test_expect_success 'creating a tag with --create-reflog should create reflog' '
    +	git log -1 \
    +		--format="format:tag: tagging %h (%s, %cd)%n" \
    +		--date=format:%Y-%m-%d >expected &&
     	test_when_finished "git tag -d tag_with_reflog" &&
     	git tag --create-reflog tag_with_reflog &&
     	git reflog exists refs/tags/tag_with_reflog &&
    @@ -90,9 +91,10 @@ test_expect_success 'creating a tag with --create-reflog should create reflog' '
     	test_cmp expected actual
     '
    
    -git log -1 > expected \
    -	--format="format:tag: tagging %h (%s, %cd)%n" --date=format:%F
     test_expect_success 'annotated tag with --create-reflog has correct message' '
    +	git log -1 \
    +		--format="format:tag: tagging %h (%s, %cd)%n" \
    +		--date=format:%Y-%m-%d >expected &&
     	test_when_finished "git tag -d tag_with_reflog" &&
     	git tag -m "annotated tag" --create-reflog tag_with_reflog &&
     	git reflog exists refs/tags/tag_with_reflog &&

 builtin/tag.c  | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 t/t7004-tag.sh | 18 +++++++++++++++++-
 2 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index e40c4a9..bca890f 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -302,6 +302,54 @@ static void create_tag(const unsigned char *object, const char *tag,
 	}
 }
 
+static void create_reflog_msg(const unsigned char *sha1, struct strbuf *sb)
+{
+	enum object_type type;
+	struct commit *c;
+	char *buf;
+	unsigned long size;
+	int subject_len = 0;
+	const char *subject_start;
+
+	char *rla = getenv("GIT_REFLOG_ACTION");
+	if (rla) {
+		strbuf_addstr(sb, rla);
+	} else {
+		strbuf_addstr(sb, _("tag: tagging "));
+		strbuf_add_unique_abbrev(sb, sha1, DEFAULT_ABBREV);
+	}
+
+	strbuf_addstr(sb, " (");
+	type = sha1_object_info(sha1, NULL);
+	switch (type) {
+	default:
+		strbuf_addstr(sb, _("object of unknown type"));
+		break;
+	case OBJ_COMMIT:
+		if ((buf = read_sha1_file(sha1, &type, &size)) != NULL) {
+			subject_len = find_commit_subject(buf, &subject_start);
+			strbuf_insert(sb, sb->len, subject_start, subject_len);
+		} else {
+			strbuf_addstr(sb, _("commit object"));
+		}
+		free(buf);
+
+		if ((c = lookup_commit_reference(sha1)) != NULL)
+			strbuf_addf(sb, ", %s", show_date(c->date, 0, DATE_MODE(SHORT)));
+		break;
+	case OBJ_TREE:
+		strbuf_addstr(sb, _("tree object"));
+		break;
+	case OBJ_BLOB:
+		strbuf_addstr(sb, _("blob object"));
+		break;
+	case OBJ_TAG:
+		strbuf_addstr(sb, _("other tag object"));
+		break;
+	}
+	strbuf_addch(sb, ')');
+}
+
 struct msg_arg {
 	int given;
 	struct strbuf buf;
@@ -335,6 +383,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf ref = STRBUF_INIT;
+	struct strbuf reflog_msg = STRBUF_INIT;
 	unsigned char object[20], prev[20];
 	const char *object_ref, *tag;
 	struct create_tag_options opt;
@@ -494,6 +543,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	else
 		die(_("Invalid cleanup mode %s"), cleanup_arg);
 
+	create_reflog_msg(object, &reflog_msg);
+
 	if (create_tag_object) {
 		if (force_sign_annotate && !annotate)
 			opt.sign = 1;
@@ -504,7 +555,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (!transaction ||
 	    ref_transaction_update(transaction, ref.buf, object, prev,
 				   create_reflog ? REF_FORCE_CREATE_REFLOG : 0,
-				   NULL, &err) ||
+				   reflog_msg.buf, &err) ||
 	    ref_transaction_commit(transaction, &err))
 		die("%s", err.buf);
 	ref_transaction_free(transaction);
@@ -514,5 +565,6 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	strbuf_release(&err);
 	strbuf_release(&buf);
 	strbuf_release(&ref);
+	strbuf_release(&reflog_msg);
 	return 0;
 }
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 072e6c6..1a3230f 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -81,9 +81,25 @@ test_expect_success 'creating a tag using default HEAD should succeed' '
 '
 
 test_expect_success 'creating a tag with --create-reflog should create reflog' '
+	git log -1 \
+		--format="format:tag: tagging %h (%s, %cd)%n" \
+		--date=format:%Y-%m-%d >expected &&
 	test_when_finished "git tag -d tag_with_reflog" &&
 	git tag --create-reflog tag_with_reflog &&
-	git reflog exists refs/tags/tag_with_reflog
+	git reflog exists refs/tags/tag_with_reflog &&
+	sed -e "s/^.*	//" .git/logs/refs/tags/tag_with_reflog > actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'annotated tag with --create-reflog has correct message' '
+	git log -1 \
+		--format="format:tag: tagging %h (%s, %cd)%n" \
+		--date=format:%Y-%m-%d >expected &&
+	test_when_finished "git tag -d tag_with_reflog" &&
+	git tag -m "annotated tag" --create-reflog tag_with_reflog &&
+	git reflog exists refs/tags/tag_with_reflog &&
+	sed -e "s/^.*	//" .git/logs/refs/tags/tag_with_reflog > actual &&
+	test_cmp expected actual
 '
 
 test_expect_success '--create-reflog does not create reflog on failure' '
-- 
2.10.2


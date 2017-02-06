Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C23951FAFC
	for <e@80x24.org>; Mon,  6 Feb 2017 22:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751592AbdBFWZG (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 17:25:06 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:22482 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751314AbdBFWZF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 17:25:05 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 93FB31E2D7C;
        Mon,  6 Feb 2017 23:25:01 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id xr1qtIWygSM2; Mon,  6 Feb 2017 23:25:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id C55171E2FD8;
        Mon,  6 Feb 2017 23:25:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AVL86k3uZvF7; Mon,  6 Feb 2017 23:25:00 +0100 (CET)
Received: from localhost.localdomain (aftr-185-17-204-129.dynamic.mnet-online.de [185.17.204.129])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id 48CDA1E2D65;
        Mon,  6 Feb 2017 23:25:00 +0100 (CET)
From:   cornelius.weig@tngtech.com
To:     git@vger.kernel.org
Cc:     Cornelius Weig <cornelius.weig@tngtech.com>, karthik.188@gmail.com,
        peff@peff.net, gitster@pobox.com,
        bitte.keine.werbung.einwerfen@googlemail.com
Subject: [PATCH v4] tag: generate useful reflog message
Date:   Mon,  6 Feb 2017 23:24:15 +0100
Message-Id: <20170206222416.28720-1-cornelius.weig@tngtech.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <xmqqpoiv15ew.fsf@gitster.mtv.corp.google.com>
References: <xmqqpoiv15ew.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Cornelius Weig <cornelius.weig@tngtech.com>

Thanks for taking a look at my last version.

> On the other hand, it's not like failing to describe the tagged
> commit in the reflog is such a grave error.  If we can get away with
> being vague on a tag that points at an object of unknown type like
> the above code does, we could loosen the "oops, we thought we got a
> commit, but it turns out that we cannot read it" case below from
> die() to just stuffing generic _("commit object") in the reflog.

Good point. I agree that failing to create the message should be no reason to
die().
As you also pointed out, "internal object" is no reliable description
for unhandled object types. I changed that as well.

Changes wrt v3 (interdiff below):
 - change default message for unhandled object types
 - do not die if commit is not readable, but use default description instead
 - test: use verbatim HT character instead of \t


Cornelius Weig (1):
  tag: generate useful reflog message

 builtin/tag.c  | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 t/t7004-tag.sh | 16 +++++++++++++++-
 2 files changed, 68 insertions(+), 2 deletions(-)

Interdiff v3..v4:
diff --git a/builtin/tag.c b/builtin/tag.c
index 638b68e..9b2eabd 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -323,19 +323,19 @@ static void create_reflog_msg(const unsigned char *sha1, struct strbuf *sb)
 	type = sha1_object_info(sha1, NULL);
 	switch (type) {
 	default:
-		strbuf_addstr(sb, _("internal object"));
+		strbuf_addstr(sb, _("object of unknown type"));
 		break;
 	case OBJ_COMMIT:
-		c = lookup_commit_reference(sha1);
-		buf = read_sha1_file(sha1, &type, &size);
-		if (!c || !buf) {
-			die(_("commit object %s could not be read"),
-				sha1_to_hex(sha1));
+		if ((buf = read_sha1_file(sha1, &type, &size)) != NULL) {
+			subject_len = find_commit_subject(buf, &subject_start);
+			strbuf_insert(sb, sb->len, subject_start, subject_len);
+		} else {
+			strbuf_addstr(sb, _("commit object"));
 		}
-		subject_len = find_commit_subject(buf, &subject_start);
-		strbuf_insert(sb, sb->len, subject_start, subject_len);
-		strbuf_addf(sb, ", %s", show_date(c->date, 0, DATE_MODE(SHORT)));
 		free(buf);
+
+		if ((c = lookup_commit_reference(sha1)) != NULL)
+			strbuf_addf(sb, ", %s", show_date(c->date, 0, DATE_MODE(SHORT)));
 		break;
 	case OBJ_TREE:
 		strbuf_addstr(sb, _("tree object"));
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 3c4cb58..894959f 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -86,7 +86,7 @@ test_expect_success 'creating a tag with --create-reflog should create reflog' '
 	test_when_finished "git tag -d tag_with_reflog" &&
 	git tag --create-reflog tag_with_reflog &&
 	git reflog exists refs/tags/tag_with_reflog &&
-	sed -e "s/^.*\t//" .git/logs/refs/tags/tag_with_reflog > actual &&
+	sed -e "s/^.*	//" .git/logs/refs/tags/tag_with_reflog > actual &&
 	test_cmp expected actual
 '

@@ -96,7 +96,7 @@ test_expect_success 'annotated tag with --create-reflog has correct message' '
 	test_when_finished "git tag -d tag_with_reflog" &&
 	git tag -m "annotated tag" --create-reflog tag_with_reflog &&
 	git reflog exists refs/tags/tag_with_reflog &&
-	sed -e "s/^.*\t//" .git/logs/refs/tags/tag_with_reflog > actual &&
+	sed -e "s/^.*	//" .git/logs/refs/tags/tag_with_reflog > actual &&
 	test_cmp expected actual
 '
-- 
2.10.2


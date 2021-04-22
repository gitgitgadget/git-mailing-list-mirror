Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDCBC433B4
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 01:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25D886142B
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 01:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237934AbhDVBIM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 21:08:12 -0400
Received: from mav.lukeshu.com ([104.207.138.63]:60148 "EHLO mav.lukeshu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235101AbhDVBIF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 21:08:05 -0400
Received: from lukeshu-dw-thinkpad (unknown [IPv6:2601:281:8200:26:527b:9dff:fe2b:180a])
        by mav.lukeshu.com (Postfix) with ESMTPSA id E227880592;
        Wed, 21 Apr 2021 21:07:26 -0400 (EDT)
From:   Luke Shumaker <lukeshu@lukeshu.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m . carlson " <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Luke Shumaker <lukeshu@datawire.io>
Subject: [PATCH 2/3] fast-export: fix bug with nested tags
Date:   Wed, 21 Apr 2021 19:06:58 -0600
Message-Id: <20210422010659.2498280-3-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210422010659.2498280-1-lukeshu@lukeshu.com>
References: <20210422010659.2498280-1-lukeshu@lukeshu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luke Shumaker <lukeshu@datawire.io>

The t9350-fast-export.sh 'handling nested tags' test takes an annotated
tag named 'muss' and creates a second annotated tag named 'nested' that
points to 'muss'.  As the test observes, fast-export indeed does spit out
a stream that creates a tag named 'nested' that points to another tag.

However, the test doesn't do a very thorough job of inspecting the
resulting tag.  It doesn't notice that the output 'nested' isn't quite the
same as the input 'nested'.

The 'nested' tags are different because the 'muss' tags that they point to
are different; fast-export accidentally creates the 'muss' tag object as
saying "tag nested" instead of "tag muss".

This is because of a quirk in how the fast-export walk sets the refname
for objects that aren't directly pointed to by an exported ref.  So, fix
the bug by getting the tagname from the tag object itself, rather than
from the refname.

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
---
 builtin/fast-export.c  | 28 +++++++++++++++++++++++++---
 t/t9350-fast-export.sh |  9 ++++++++-
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index e697f87172..2bf83fe52e 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -550,6 +550,21 @@ static const char *anonymize_refname(const char *refname)
 	return anon.buf;
 }
 
+static const char *anonymize_tagname(size_t tagname_len, const char *tagname)
+{
+	/*
+	 * Use anonymize_refname internally, so that the anonymization
+	 * is consistent between a tag's refname and its internal
+	 * tagname (if they were consistent to begin with, anyway).
+	 */
+	static struct strbuf as_refname = STRBUF_INIT;
+
+	strbuf_reset(&as_refname);
+	strbuf_addf(&as_refname, "refs/tags/%.*s", (int)tagname_len, tagname);
+
+	return anonymize_refname(as_refname.buf) + strlen("refs/tags/");
+}
+
 /*
  * We do not even bother to cache commit messages, as they are unlikely
  * to be repeated verbatim, and it is not that interesting when they are.
@@ -775,6 +790,7 @@ static void handle_tag(const char *refname, struct tag *tag)
 	const char *message;
 	size_t message_size = 0;
 	const char *tagname;
+	size_t tagname_len;
 	const char *tagger, *tagger_end;
 	struct object *tagged;
 	int tagged_mark;
@@ -804,6 +820,12 @@ static void handle_tag(const char *refname, struct tag *tag)
 		message_size = strlen(message);
 	}
 
+	tagname = memmem(buf, message ? message - buf : size, "\ntag ", 5);
+	if (!tagname)
+		die("malformed tag %s", oid_to_hex(&tag->object.oid));
+	tagname += 5;
+	tagname_len = (size_t)(strchrnul(tagname, '\n') - tagname);
+
 	tagger = memmem(buf, message ? message - buf : size, "\ntagger ", 8);
 	if (!tagger) {
 		if (fake_missing_tagger)
@@ -821,6 +843,8 @@ static void handle_tag(const char *refname, struct tag *tag)
 
 	if (anonymize) {
 		refname = anonymize_refname(refname);
+		tagname = anonymize_tagname(tagname_len, tagname);
+		tagname_len = strlen(tagname);
 		if (message) {
 			static struct hashmap tags;
 			message = anonymize_str(&tags, anonymize_tag,
@@ -890,9 +914,7 @@ static void handle_tag(const char *refname, struct tag *tag)
 		printf("reset %s\nfrom %s\n\n",
 		       refname, oid_to_hex(&null_oid));
 	}
-	tagname = refname;
-	skip_prefix(tagname, "refs/tags/", &tagname);
-	printf("tag %s\n", tagname);
+	printf("tag %.*s\n", (int)tagname_len, tagname);
 	if (mark_tags) {
 		mark_next_object(&tag->object);
 		printf("mark :%"PRIu32"\n", last_idnum);
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 409b48e244..0bcc1bd54e 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -572,10 +572,17 @@ test_expect_success 'handling tags of blobs' '
 
 test_expect_success 'handling nested tags' '
 	git tag -a -m "This is a nested tag" nested muss &&
+	NESTED=$(git rev-parse --verify nested) &&
 	git fast-export --mark-tags nested >output &&
 	grep "^from $ZERO_OID$" output &&
 	grep "^tag nested$" output >tag_lines &&
-	test_line_count = 2 tag_lines
+	test_line_count = 1 tag_lines &&
+	rm -rf new &&
+	mkdir new &&
+	git --git-dir=new/.git init &&
+	(cd new &&
+	 git fast-import &&
+	 test $NESTED = $(git rev-parse --verify refs/tags/nested)) <output
 '
 
 test_expect_success 'directory becomes symlink'        '
-- 
2.31.1


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EA2C43461
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 01:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECCCB61445
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 01:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238466AbhDVBIS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 21:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235562AbhDVBIF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 21:08:05 -0400
Received: from mav.lukeshu.com (mav.lukeshu.com [IPv6:2001:19f0:5c00:8069:5400:ff:fe26:6a86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FC2C06138A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 18:07:28 -0700 (PDT)
Received: from lukeshu-dw-thinkpad (unknown [IPv6:2601:281:8200:26:527b:9dff:fe2b:180a])
        by mav.lukeshu.com (Postfix) with ESMTPSA id 6F8EE80593;
        Wed, 21 Apr 2021 21:07:27 -0400 (EDT)
From:   Luke Shumaker <lukeshu@lukeshu.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m . carlson " <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Luke Shumaker <lukeshu@datawire.io>
Subject: [PATCH 3/3] fast-export, fast-import: let tags specify a different refname
Date:   Wed, 21 Apr 2021 19:06:59 -0600
Message-Id: <20210422010659.2498280-4-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210422010659.2498280-1-lukeshu@lukeshu.com>
References: <20210422010659.2498280-1-lukeshu@lukeshu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luke Shumaker <lukeshu@datawire.io>

A tag object contains the tag-name in the object, and is also pointed
to by a ref named 'refs/tags/{tag-name}'.  It's possible to end up
with a tag for which the internal name and the refname disagree.

This "shouldn't" happen, but sometimes it can:

 - In the "the coolest merge ever"[1], if Linus had wanted to import
   existing tags from Paul's gitk repo, he'd likely have wanted to give
   them a `gitk/` or `gitk-` prefix; you don't want gitk v0.0.1 to
   appear to be git v0.0.1, so when importing it, you'd rename the tag
   to `gitk/v0.0.1`.  (Less hypothetically, in-the-wild, my employer's
   repo has _several_ such merges/imports, where the tags from each repo
   were given a prefix.)
 - Sometimes tags are "archived" to something like
   "refs/archived-tags/foo".

That'd work fine if they're lightweight tags, but if they're annotated
tags, then after the rename the internal name in the tag object
(`v0.0.1`) is now different than the refname (`gitk/v0.0.1`).  Which
is still mostly fine, since not too many tools care if the internal
name and the refname disagree.

But, fast-export/fast-import are tools that do care: it's currently
impossible to represent these tags in a fast-import stream.

This patch adds an optional "refname" sub-command to fast-import's "tag"
top-level-command, the stream

    tag foo
    refname refs/tags/bar
    ...

will create a tag at "refs/tags/bar" that says "tag foo" internally.

[1]: https://lore.kernel.org/git/Pine.LNX.4.58.0506221433540.2353@ppc970.osdl.org/

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
---
 Documentation/git-fast-import.txt | 22 +++++++++++++---------
 builtin/fast-export.c             |  6 ++++++
 builtin/fast-import.c             | 10 ++++++++--
 t/t9350-fast-export.sh            | 11 ++++++++---
 4 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 39cfa05b28..8c1756bdad 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -822,24 +822,28 @@ Creates an annotated tag referring to a specific commit.  To create
 lightweight (non-annotated) tags see the `reset` command below.
 
 ....
-	'tag' SP <name> LF
+	'tag' SP <tagname> LF
 	mark?
+	('refname' SP <refname> LF)?
 	'from' SP <commit-ish> LF
 	original-oid?
 	'tagger' (SP <name>)? SP LT <email> GT SP <when> LF
 	data
 ....
 
-where `<name>` is the name of the tag to create.
+where `<tagname>` is the name of the tag that is stored in the tag
+object itself.  The value of `<tagname>` must be a valid for inclusion
+as part of a refname in Git and therefore may contain forward slashes.
+As `LF` is not valid in a Git refname, no quoting or escaping syntax
+is supported here.
 
-Tag names are automatically prefixed with `refs/tags/` when stored
-in Git, so importing the CVS branch symbol `RELENG-1_0-FINAL` would
-use just `RELENG-1_0-FINAL` for `<name>`, and fast-import will write the
-corresponding ref as `refs/tags/RELENG-1_0-FINAL`.
+The `refname` command controls where in the ref hierarchy to put the
+reference that points to the resulting tag object.  If `refname` is
+not given, then `refs/tags/<tagname>` is used.
 
-The value of `<name>` must be a valid refname in Git and therefore
-may contain forward slashes.  As `LF` is not valid in a Git refname,
-no quoting or escaping syntax is supported here.
+So, for example, importing the CVS branch symbol `RELENG-1_0-FINAL`
+would use just `RELENG-1_0-FINAL` for `<tagname>`, and fast-import
+will write the corresponding ref as `refs/tags/RELENG-1_0-FINAL`.
 
 The `from` command is the same as in the `commit` command; see
 above for details.
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 2bf83fe52e..de04aaf241 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -784,6 +784,7 @@ static void handle_tail(struct object_array *commits, struct rev_info *revs,
 
 static void handle_tag(const char *refname, struct tag *tag)
 {
+	static struct strbuf autorefname = STRBUF_INIT;
 	unsigned long size;
 	enum object_type type;
 	char *buf;
@@ -910,6 +911,9 @@ static void handle_tag(const char *refname, struct tag *tag)
 		}
 	}
 
+	strbuf_reset(&autorefname);
+	strbuf_addf(&autorefname, "refs/tags/%.*s", (int)tagname_len, tagname);
+
 	if (tagged->type == OBJ_TAG) {
 		printf("reset %s\nfrom %s\n\n",
 		       refname, oid_to_hex(&null_oid));
@@ -919,6 +923,8 @@ static void handle_tag(const char *refname, struct tag *tag)
 		mark_next_object(&tag->object);
 		printf("mark :%"PRIu32"\n", last_idnum);
 	}
+	if (strcmp(refname, autorefname.buf))
+		printf("refname %s\n", refname);
 	if (tagged_mark)
 		printf("from :%d\n", tagged_mark);
 	else
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 43287f929f..49e5a0c159 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -2794,9 +2794,15 @@ static void parse_new_tag(const char *arg)
 	read_next_command();
 	parse_mark();
 
+	/* refname ... */
 	strbuf_reset(&refname);
-	strbuf_addstr(&refname, "refs/tags/");
-	strbuf_addstr(&refname, tagname);
+	if (skip_prefix(command_buf.buf, "refname ", &v)) {
+		strbuf_addstr(&refname, v);
+		read_next_command();
+	} else {
+		strbuf_addstr(&refname, "refs/tags/");
+		strbuf_addstr(&refname, tagname);
+	}
 
 	/* from ... */
 	if (!skip_prefix(command_buf.buf, "from ", &from))
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 0bcc1bd54e..089c0c0a24 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -34,6 +34,9 @@ test_expect_success 'setup' '
 	git commit -m sitzt file2 &&
 	test_tick &&
 	git tag -a -m valentin muss &&
+	git tag -a -m joseph pure &&
+	git update-ref refs/english-tags/rein refs/tags/pure &&
+	git update-ref -d refs/tags/pure &&
 	git merge -s ours main
 
 '
@@ -42,6 +45,7 @@ test_expect_success 'fast-export | fast-import' '
 
 	MAIN=$(git rev-parse --verify main) &&
 	REIN=$(git rev-parse --verify rein) &&
+	PURE=$(git rev-parse --verify refs/english-tags/rein) &&
 	WER=$(git rev-parse --verify wer) &&
 	MUSS=$(git rev-parse --verify muss) &&
 	mkdir new &&
@@ -51,6 +55,7 @@ test_expect_success 'fast-export | fast-import' '
 	 git fast-import &&
 	 test $MAIN = $(git rev-parse --verify refs/heads/main) &&
 	 test $REIN = $(git rev-parse --verify refs/tags/rein) &&
+	 test $PURE = $(git rev-parse --verify refs/english-tags/rein) &&
 	 test $WER = $(git rev-parse --verify refs/heads/wer) &&
 	 test $MUSS = $(git rev-parse --verify refs/tags/muss)) <actual
 
@@ -359,7 +364,7 @@ test_expect_success 'fast-export | fast-import when main is tagged' '
 
 	git tag -m msg last &&
 	git fast-export -C -C --signed-tags=strip --all > output &&
-	test $(grep -c "^tag " output) = 3
+	test $(grep -c "^tag " output) = 4
 
 '
 
@@ -374,11 +379,11 @@ test_expect_success 'cope with tagger-less tags' '
 	TAG=$(git hash-object -t tag -w tag-content) &&
 	git update-ref refs/tags/sonnenschein $TAG &&
 	git fast-export -C -C --signed-tags=strip --all > output &&
-	test $(grep -c "^tag " output) = 4 &&
+	test $(grep -c "^tag " output) = 5 &&
 	! grep "Unspecified Tagger" output &&
 	git fast-export -C -C --signed-tags=strip --all \
 		--fake-missing-tagger > output &&
-	test $(grep -c "^tag " output) = 4 &&
+	test $(grep -c "^tag " output) = 5 &&
 	grep "Unspecified Tagger" output
 
 '
-- 
2.31.1


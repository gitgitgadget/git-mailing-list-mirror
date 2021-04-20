Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D19C433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 19:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45857613C2
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 19:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbhDTTG4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 15:06:56 -0400
Received: from mav.lukeshu.com ([104.207.138.63]:58270 "EHLO mav.lukeshu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233509AbhDTTGq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 15:06:46 -0400
Received: from lukeshu-dw-thinkpad (unknown [8.42.69.49])
        by mav.lukeshu.com (Postfix) with ESMTPSA id 1782C80590;
        Tue, 20 Apr 2021 15:06:13 -0400 (EDT)
From:   Luke Shumaker <lukeshu@lukeshu.com>
To:     git@vger.kernel.org
Cc:     Luke Shumaker <lukeshu@datawire.io>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH] fast-export, fast-import: Let tags specify an internal name
Date:   Tue, 20 Apr 2021 13:05:52 -0600
Message-Id: <20210420190552.822138-1-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luke Shumaker <lukeshu@datawire.io>

A tag object contains the tag-name in the object, and is also pointed
to by a ref named 'refs/tags/{tag-name}'.  It's possible to end up
with a tag for which the internal name and the refname disagree.

This "shouldn't" happen, but sometimes it can.  In the "the coolest
merge ever"[1], if Linus had wanted to import existing tags from
Paul's gitk repo, he'd likely have wanted to give them a `gitk/` or
`gitk-` prefix; you don't want gitk v0.0.1 to appear to be git v0.0.1,
so when importing it, you'd rename the tag to `gitk/v0.0.1`.

(Less hypothetically, my employer's repo has _several_ such
merges/imports, where the tags from each repo were given a prefix.)

That'd work fine if they're lightweight tags, but if they're annotated
tags, then after the rename the internal name in the tag object
(`v0.0.1`) is now different than the refname (`gitk/v0.0.1`).  Which
is still mostly fine, since not too many tools care if the internal
name and the refname disagree.

But, fast-export/fast-import are tools that do care: it's currently
impossible to represent these tags in a fast-import stream.

This patch adds an optional "name" sub-command to fast-import's "tag"
top-level-command, the stream

    tag foo
    name bar
    ...

will create a tag at "refs/tags/foo" that says "tag bar" internally.

These tags are things that "shouldn't" happen, so perhaps adding
support for them to fast-export/fast-import is unwelcome, which is why
I've marked this as an "RFC".  If this addition is welcome, then it
still needs tests and documentation.

[1]: https://lore.kernel.org/git/Pine.LNX.4.58.0506221433540.2353@ppc970.osdl.org/

---
 Documentation/git-fast-import.txt |  1 +
 builtin/fast-export.c             | 25 ++++++++++++++++++-------
 builtin/fast-import.c             | 11 +++++++++--
 3 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 39cfa05b28..6514b42d28 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -824,6 +824,7 @@ lightweight (non-annotated) tags see the `reset` command below.
 ....
 	'tag' SP <name> LF
 	mark?
+	('name' SP <name> LF)?
 	'from' SP <commit-ish> LF
 	original-oid?
 	'tagger' (SP <name>)? SP LT <email> GT SP <when> LF
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 85a76e0ef8..48e207a445 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -767,12 +767,13 @@ static void handle_tail(struct object_array *commits, struct rev_info *revs,
 	}
 }
 
-static void handle_tag(const char *name, struct tag *tag)
+static void handle_tag(const char *refname, struct tag *tag)
 {
 	unsigned long size;
 	enum object_type type;
 	char *buf;
-	const char *tagger, *tagger_end, *message;
+	const char *refbasename;
+	const char *tagname, *tagname_end, *tagger, *tagger_end, *message;
 	size_t message_size = 0;
 	struct object *tagged;
 	int tagged_mark;
@@ -800,6 +801,11 @@ static void handle_tag(const char *name, struct tag *tag)
 		message += 2;
 		message_size = strlen(message);
 	}
+	tagname = memmem(buf, message ? message - buf : size, "\ntag ", 5);
+	if (!tagname)
+		die("malformed tag %s", oid_to_hex(&tag->object.oid));
+	tagname += 5;
+	tagname_end = strchrnul(tagname, '\n');
 	tagger = memmem(buf, message ? message - buf : size, "\ntagger ", 8);
 	if (!tagger) {
 		if (fake_missing_tagger)
@@ -816,7 +822,7 @@ static void handle_tag(const char *name, struct tag *tag)
 	}
 
 	if (anonymize) {
-		name = anonymize_refname(name);
+		refname = anonymize_refname(refname);
 		if (message) {
 			static struct hashmap tags;
 			message = anonymize_str(&tags, anonymize_tag,
@@ -870,7 +876,7 @@ static void handle_tag(const char *name, struct tag *tag)
 				p = rewrite_commit((struct commit *)tagged);
 				if (!p) {
 					printf("reset %s\nfrom %s\n\n",
-					       name, oid_to_hex(&null_oid));
+					       refname, oid_to_hex(&null_oid));
 					free(buf);
 					return;
 				}
@@ -884,14 +890,19 @@ static void handle_tag(const char *name, struct tag *tag)
 
 	if (tagged->type == OBJ_TAG) {
 		printf("reset %s\nfrom %s\n\n",
-		       name, oid_to_hex(&null_oid));
+		       refname, oid_to_hex(&null_oid));
 	}
-	skip_prefix(name, "refs/tags/", &name);
-	printf("tag %s\n", name);
+	refbasename = refname;
+	skip_prefix(refbasename, "refs/tags/", &refbasename);
+	printf("tag %s\n", refbasename);
 	if (mark_tags) {
 		mark_next_object(&tag->object);
 		printf("mark :%"PRIu32"\n", last_idnum);
 	}
+	if ((size_t)(tagname_end - tagname) != strlen(refbasename) ||
+	    strncmp(tagname, refbasename, (size_t)(tagname_end - tagname)))
+		printf("name %.*s\n",
+		       (int)(tagname_end - tagname), tagname);
 	if (tagged_mark)
 		printf("from :%d\n", tagged_mark);
 	else
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 3afa81cf9a..24bdd46cba 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -2783,7 +2783,7 @@ static void parse_new_commit(const char *arg)
 static void parse_new_tag(const char *arg)
 {
 	static struct strbuf msg = STRBUF_INIT;
-	const char *from;
+	const char *name, *from;
 	char *tagger;
 	struct branch *s;
 	struct tag *t;
@@ -2803,6 +2803,13 @@ static void parse_new_tag(const char *arg)
 	read_next_command();
 	parse_mark();
 
+	/* name ... */
+	if (skip_prefix(command_buf.buf, "name ", &v)) {
+		name = strdupa(v);
+		read_next_command();
+	} else
+		name = NULL;
+
 	/* from ... */
 	if (!skip_prefix(command_buf.buf, "from ", &from))
 		die("Expected from command, got %s", command_buf.buf);
@@ -2850,7 +2857,7 @@ static void parse_new_tag(const char *arg)
 		    "object %s\n"
 		    "type %s\n"
 		    "tag %s\n",
-		    oid_to_hex(&oid), type_name(type), t->name);
+		    oid_to_hex(&oid), type_name(type), name ? name : t->name);
 	if (tagger)
 		strbuf_addf(&new_data,
 			    "tagger %s\n", tagger);
-- 
2.31.1

Happy hacking,
~ Luke Shumaker

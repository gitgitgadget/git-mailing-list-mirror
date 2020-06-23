Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48485C433DF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 15:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 268832070E
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 15:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733017AbgFWPZH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 11:25:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:40198 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732885AbgFWPZH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 11:25:07 -0400
Received: (qmail 11896 invoked by uid 109); 23 Jun 2020 15:25:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Jun 2020 15:25:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17014 invoked by uid 111); 23 Jun 2020 15:25:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Jun 2020 11:25:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 23 Jun 2020 11:25:05 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 09/10] fast-export: allow seeding the anonymized mapping
Message-ID: <20200623152505.GI1435482@coredump.intra.peff.net>
References: <20200623152436.GA50925@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200623152436.GA50925@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After you anonymize a repository, it can be hard to find which commits
correspond between the original and the result, and thus hard to
reproduce commands that triggered bugs in the original.

Let's make it possible to seed the anonymization map. This lets users
either:

  - mark names to be retained as-is, if they don't consider them secret
    (in which case their original commands would just work)

  - map names to new values, which lets them adapt the reproduction
    recipe to the new names without revealing the originals

The implementation is fairly straight-forward. We already store each
anonymized token in a hashmap (so that the same token appearing twice is
converted to the same result). We can just introduce a new "seed"
hashmap which is consulted first.

This does make a few more promises to the user about how we'll anonymize
things (e.g., token-splitting pathnames). But it's unlikely that we'd
want to change those rules, even if the actual anonymization of a single
token changes. And it makes things much easier for the user, who can
unblind only a directory name without having to specify each path within
it.

One alternative to this approach would be to anonymize as we see fit,
and then dump the whole refname and pathname mappings to a file. This
does work, but it's a bit awkward to use (you have to manually dig the
items you care about out of the mapping).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-fast-export.txt | 24 ++++++++++++++++
 builtin/fast-export.c             | 47 ++++++++++++++++++++++++++++++-
 t/t9351-fast-export-anonymize.sh  | 11 +++++++-
 3 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index e8950de3ba..2d7b62e835 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -119,6 +119,11 @@ by keeping the marks the same across runs.
 	the shape of the history and stored tree.  See the section on
 	`ANONYMIZING` below.
 
+--seed-anonymized=<from>[:<to>]::
+	Convert token `<from>` to `<to>` in the anonymized output. If
+	`<to>` is omitted, map `<from>` to itself (i.e., do not
+	anonymize it). See the section on `ANONYMIZING` below.
+
 --reference-excluded-parents::
 	By default, running a command such as `git fast-export
 	master~5..master` will not include the commit master{tilde}5
@@ -238,6 +243,25 @@ collapse "User 0", "User 1", etc into "User X"). This produces a much
 smaller output, and it is usually easy to quickly confirm that there is
 no private data in the stream.
 
+Reproducing some bugs may require referencing particular commits or
+paths, which becomes challenging after refnames and paths have been
+anonymized. You can ask for a particular token to be left as-is or
+mapped to a new value. For example, if you have a bug which reproduces
+with `git rev-list mybranch -- foo.c`, you can run:
+
+---------------------------------------------------
+$ git fast-export --anonymize --all \
+      --seed-anonymized=foo.c:secret.c \
+      --seed-anonymized=mybranch \
+      >stream
+---------------------------------------------------
+
+After importing the stream, you can then run `git rev-list mybranch --
+secret.c` in the anonymized repository.
+
+Note that paths and refnames are split into tokens at slash boundaries.
+The command above would anonymize `subdir/foo.c` as something like
+`path123/secret.c`.
 
 LIMITATIONS
 -----------
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 1cbca5b4b4..ef82497bbf 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -45,6 +45,7 @@ static struct string_list extra_refs = STRING_LIST_INIT_NODUP;
 static struct string_list tag_refs = STRING_LIST_INIT_NODUP;
 static struct refspec refspecs = REFSPEC_INIT_FETCH;
 static int anonymize;
+static struct hashmap anonymized_seeds;
 static struct revision_sources revision_sources;
 
 static int parse_opt_signed_tag_mode(const struct option *opt,
@@ -168,8 +169,18 @@ static const char *anonymize_str(struct hashmap *map,
 	hashmap_entry_init(&key.hash, memhash(orig, len));
 	key.orig = orig;
 	key.orig_len = len;
-	ret = hashmap_get_entry(map, &key, hash, &key);
 
+	/* First check if it's a token the user configured manually... */
+	if (anonymized_seeds.cmpfn)
+		ret = hashmap_get_entry(&anonymized_seeds, &key, hash, &key);
+	else
+		ret = NULL;
+
+	/* ...otherwise check if we've already seen it in this context... */
+	if (!ret)
+		ret = hashmap_get_entry(map, &key, hash, &key);
+
+	/* ...and finally generate a new mapping if necessary */
 	if (!ret) {
 		FLEX_ALLOC_MEM(ret, orig, orig, len);
 		hashmap_entry_init(&ret->hash, key.hash.hash);
@@ -1147,6 +1158,37 @@ static void handle_deletes(void)
 	}
 }
 
+static char *anonymize_seed(void *data)
+{
+	return xstrdup(data);
+}
+
+static int parse_opt_seed_anonymized(const struct option *opt,
+				     const char *arg, int unset)
+{
+	struct hashmap *map = opt->value;
+	const char *delim, *value;
+	size_t keylen;
+
+	BUG_ON_OPT_NEG(unset);
+
+	delim = strchr(arg, ':');
+	if (delim) {
+		keylen = delim - arg;
+		value = delim + 1;
+	} else {
+		keylen = strlen(arg);
+		value = arg;
+	}
+
+	if (!keylen || !*value)
+		return error(_("--seed-anonymized token cannot be empty"));
+
+	anonymize_str(map, anonymize_seed, arg, keylen, (void *)value);
+
+	return 0;
+}
+
 int cmd_fast_export(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
@@ -1188,6 +1230,9 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		OPT_STRING_LIST(0, "refspec", &refspecs_list, N_("refspec"),
 			     N_("Apply refspec to exported refs")),
 		OPT_BOOL(0, "anonymize", &anonymize, N_("anonymize output")),
+		OPT_CALLBACK_F(0, "seed-anonymized", &anonymized_seeds, N_("from:to"),
+			       N_("convert <from> to <to> in anonymized output"),
+			       PARSE_OPT_NONEG, parse_opt_seed_anonymized),
 		OPT_BOOL(0, "reference-excluded-parents",
 			 &reference_excluded_commits, N_("Reference parents which are not in fast-export stream by object id")),
 		OPT_BOOL(0, "show-original-ids", &show_original_ids,
diff --git a/t/t9351-fast-export-anonymize.sh b/t/t9351-fast-export-anonymize.sh
index dc5d75cd19..d84eec9bab 100755
--- a/t/t9351-fast-export-anonymize.sh
+++ b/t/t9351-fast-export-anonymize.sh
@@ -6,6 +6,7 @@ test_description='basic tests for fast-export --anonymize'
 test_expect_success 'setup simple repo' '
 	test_commit base &&
 	test_commit foo &&
+	test_commit retain-me &&
 	git checkout -b other HEAD^ &&
 	mkdir subdir &&
 	test_commit subdir/bar &&
@@ -18,7 +19,10 @@ test_expect_success 'setup simple repo' '
 '
 
 test_expect_success 'export anonymized stream' '
-	git fast-export --anonymize --all >stream
+	git fast-export --anonymize --all \
+		--seed-anonymized=retain-me \
+		--seed-anonymized=xyzzy:custom-name \
+		>stream
 '
 
 # this also covers commit messages
@@ -30,6 +34,11 @@ test_expect_success 'stream omits path names' '
 	! grep xyzzy stream
 '
 
+test_expect_success 'stream contains user-specified names' '
+	grep retain-me stream &&
+	grep custom-name stream
+'
+
 test_expect_success 'stream omits gitlink oids' '
 	# avoid relying on the whole oid to remain hash-agnostic; this is
 	# plenty to be unique within our test case
-- 
2.27.0.517.gbc32778fa3


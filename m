Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8652AC433DF
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 21:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C2402075A
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 21:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730686AbgFVVsB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 17:48:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:39336 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727049AbgFVVsB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jun 2020 17:48:01 -0400
Received: (qmail 1917 invoked by uid 109); 22 Jun 2020 21:48:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 22 Jun 2020 21:48:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8573 invoked by uid 111); 22 Jun 2020 21:48:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Jun 2020 17:48:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 22 Jun 2020 17:47:59 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 1/4] fast-export: allow dumping the refname mapping
Message-ID: <20200622214759.GA3303964@coredump.intra.peff.net>
References: <20200622214745.GA3302779@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200622214745.GA3302779@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After you anonymize a repository, it can be hard to find which commits
correspond between the original and the result, and thus hard to
reproduce commands that triggered bugs in the original.

Let's make it possible to dump the mapping separate from the output
stream. This can be used by a bug reporter to modify their reproduction
recipe without revealing the original names (see the example in the
documentation).

The implementation is slightly non-obvious. There's no point in the
program where we know the complete set of refs we're going to anonymize.
Nor do we have a complete set of anonymized refs after finishing (we
have a set of anonymized ref path components, but no knowledge of how
those are assembled into complete refs). So we lazily write to the dump
file as we anonymize each name, and keep a list of ones that we've
output in order to avoid duplicates.

Some possible alternatives:

  - we could just output the mapping of anonymized components (e.g.,
    that "foo" became "ref123"). That works OK when you have short
    refnames (e.g., "refs/heads/foo" becomes "refs/heads/ref123"), but
    longer names would require the user to look up each component to
    assemble the result. For example, "refs/remotes/origin/jk/foo" might
    become "refs/remotes/refs37/refs56/refs102".

  - instead of dumping the mapping, the same problem could be solved by
    allowing the user to leave some refs alone. So if you want to
    reproduce "git rev-list branch~17..HEAD" in the anonymized repo, we
    could allow something like:

      git tag anon-one branch
      git tag anon-two HEAD
      git fast-export --anonymize --all \
                      --no-anonymize-ref=anon-one \
		      --no-anonymize-ref=anon-two \
		      >stream

    and then presumably "git rev-list anon-one~17..anon-two" would
    behave the same in the re-imported repository. This is more
    convenient in some ways, but it does require modifying the
    original repository. And the concept doesn't easily extend to
    other fields (e.g., pathnames, which will be addressed in a
    subsequent patch).

  - we could dump before/after commit hashes; combined with rev-parse,
    that could convert these cases (as well as ones using raw hashes).
    But we don't actually know the anonymized commit hashes; we're just
    generating a stream that will produce them in the anonymized repo.

  - likewise, we probably could insert object names or other markers
    into commit messages, blob contents, etc, in order to let a user
    with the original repo figure out which parts correspond. But using
    this gets complicated (I have to find my commits in the result with
    "git log --all --grep" or similar). It also makes it less clear that
    the anonymized repo didn't leak any information (because we are
    relying on object ids being unguessable).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-fast-export.txt | 22 ++++++++++++++++++++
 builtin/fast-export.c             | 34 +++++++++++++++++++++++++++++++
 t/t9351-fast-export-anonymize.sh  | 14 +++++++++++++
 3 files changed, 70 insertions(+)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index e8950de3ba..e809bb3f18 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -119,6 +119,12 @@ by keeping the marks the same across runs.
 	the shape of the history and stored tree.  See the section on
 	`ANONYMIZING` below.
 
+--dump-anonymized-refnames=<file>::
+	Output the mapping of real refnames to anonymized refnames to
+	<file>. The output will contain one line per ref that appears in
+	the output stream, with the original refname, a space, and its
+	anonymized counterpart. See the section on `ANONYMIZING` below.
+
 --reference-excluded-parents::
 	By default, running a command such as `git fast-export
 	master~5..master` will not include the commit master{tilde}5
@@ -238,6 +244,22 @@ collapse "User 0", "User 1", etc into "User X"). This produces a much
 smaller output, and it is usually easy to quickly confirm that there is
 no private data in the stream.
 
+Reproducing some bugs may require referencing particular commits, which
+becomes challenging after the refnames have all been anonymized. You can
+use `--dump-anonymized-refnames` to output the mapping, and then alter
+your reproduction recipe to use the anonymized names. E.g., if you find
+a bug with `git rev-list v1.0..v2.0` in the private repository, you can
+run:
+
+---------------------------------------------------
+$ git fast-export --anonymize --all --dump-anonymized-refnames=refs.out >stream
+$ grep '^refs/tags/v[12].0' refs.out
+refs/tags/v1.0 refs/tags/ref31
+refs/tags/v2.0 refs/tags/ref50
+---------------------------------------------------
+
+which tells you that `git rev-list ref31..ref50` may produce the same
+bug in the re-imported anonymous repository.
 
 LIMITATIONS
 -----------
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 85868162ee..844726d45a 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -24,6 +24,7 @@
 #include "remote.h"
 #include "blob.h"
 #include "commit-slab.h"
+#include "khash.h"
 
 static const char *fast_export_usage[] = {
 	N_("git fast-export [rev-list-opts]"),
@@ -45,6 +46,7 @@ static struct string_list extra_refs = STRING_LIST_INIT_NODUP;
 static struct string_list tag_refs = STRING_LIST_INIT_NODUP;
 static struct refspec refspecs = REFSPEC_INIT_FETCH;
 static int anonymize;
+static FILE *anonymized_refnames_handle;
 static struct revision_sources revision_sources;
 
 static int parse_opt_signed_tag_mode(const struct option *opt,
@@ -118,6 +120,23 @@ static int has_unshown_parent(struct commit *commit)
 	return 0;
 }
 
+KHASH_INIT(strset, const char *, int, 0, kh_str_hash_func, kh_str_hash_equal);
+
+struct seen_set {
+	kh_strset_t *set;
+};
+
+static int check_and_mark_seen(struct seen_set *seen, const char *str)
+{
+	int hashret;
+	if (!seen->set)
+		seen->set = kh_init_strset();
+	if (kh_get_strset(seen->set, str) < kh_end(seen->set))
+		return 1;
+	kh_put_strset(seen->set, xstrdup(str), &hashret);
+	return 0;
+}
+
 struct anonymized_entry {
 	struct hashmap_entry hash;
 	const char *orig;
@@ -515,6 +534,8 @@ static const char *anonymize_refname(const char *refname)
 	};
 	static struct hashmap refs;
 	static struct strbuf anon = STRBUF_INIT;
+	static struct seen_set seen;
+	const char *full_refname = refname;
 	int i;
 
 	/*
@@ -533,6 +554,12 @@ static const char *anonymize_refname(const char *refname)
 	}
 
 	anonymize_path(&anon, refname, &refs, anonymize_ref_component);
+
+	if (anonymized_refnames_handle &&
+	    !check_and_mark_seen(&seen, full_refname))
+		fprintf(anonymized_refnames_handle, "%s %s\n",
+			full_refname, anon.buf);
+
 	return anon.buf;
 }
 
@@ -1144,6 +1171,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	char *export_filename = NULL,
 	     *import_filename = NULL,
 	     *import_filename_if_exists = NULL;
+	const char *anonymized_refnames_file = NULL;
 	uint32_t lastimportid;
 	struct string_list refspecs_list = STRING_LIST_INIT_NODUP;
 	struct string_list paths_of_changed_objects = STRING_LIST_INIT_DUP;
@@ -1177,6 +1205,9 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		OPT_STRING_LIST(0, "refspec", &refspecs_list, N_("refspec"),
 			     N_("Apply refspec to exported refs")),
 		OPT_BOOL(0, "anonymize", &anonymize, N_("anonymize output")),
+		OPT_STRING(0, "dump-anonymized-refnames",
+			   &anonymized_refnames_file, N_("file"),
+			   N_("output anonymized refname mapping to <file>")),
 		OPT_BOOL(0, "reference-excluded-parents",
 			 &reference_excluded_commits, N_("Reference parents which are not in fast-export stream by object id")),
 		OPT_BOOL(0, "show-original-ids", &show_original_ids,
@@ -1213,6 +1244,9 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		string_list_clear(&refspecs_list, 1);
 	}
 
+	if (anonymized_refnames_file)
+		anonymized_refnames_handle = xfopen(anonymized_refnames_file, "w");
+
 	if (use_done_feature)
 		printf("feature done\n");
 
diff --git a/t/t9351-fast-export-anonymize.sh b/t/t9351-fast-export-anonymize.sh
index 897dc50907..75cbc7b329 100755
--- a/t/t9351-fast-export-anonymize.sh
+++ b/t/t9351-fast-export-anonymize.sh
@@ -46,6 +46,20 @@ test_expect_success 'stream omits tag message' '
 	! grep "annotated tag" stream
 '
 
+test_expect_success 'refname mapping can be dumped' '
+	git fast-export --anonymize --all \
+		--dump-anonymized-refnames=refs.out >/dev/null &&
+	# we make no guarantees of the exact anonymized names,
+	# so just check that we have the right number and
+	# that a sample line looks sane.
+	expected_count=$(git for-each-ref | wc -l) &&
+	# Note that master is not anonymized, and so not included
+	# in the mapping.
+	expected_count=$((expected_count - 1)) &&
+	test_line_count = $expected_count refs.out &&
+	grep "^refs/heads/other refs/heads/" refs.out
+'
+
 # NOTE: we chdir to the new, anonymized repository
 # after this. All further tests should assume this.
 test_expect_success 'import stream to new repository' '
-- 
2.27.0.517.gbc32778fa3


Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461D8C433E0
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 21:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 297962075A
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 21:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730805AbgFVVsN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 17:48:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:39364 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730646AbgFVVsM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jun 2020 17:48:12 -0400
Received: (qmail 1959 invoked by uid 109); 22 Jun 2020 21:48:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 22 Jun 2020 21:48:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8611 invoked by uid 111); 22 Jun 2020 21:48:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Jun 2020 17:48:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 22 Jun 2020 17:48:09 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 4/4] fast-export: allow dumping the path mapping
Message-ID: <20200622214809.GD3303964@coredump.intra.peff.net>
References: <20200622214745.GA3302779@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200622214745.GA3302779@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When working with an anonymized repo, it can be useful to be able to
refer to particular paths. E.g., reproducing a bug with "git rev-list --
foo.c" in the original repo would need to replace "foo.c" with its
anonymized counterpart to produce the same effect.

We recently taught fast-export to dump the refname mapping. Let's do the
same thing for paths, which can reuse most of the same infrastructure.

We could also just introduce a "dump mapping" file that shows every
mapping we make. But it would be a bit more awkward to work with, as the
user would have to sort through more data to find the parts they're
interested in (and there are likely to be many more paths than refnames,
making it annoying for people who just want to dump the refnames).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-fast-export.txt | 12 ++++++++++++
 builtin/fast-export.c             | 16 ++++++++++++++++
 t/t9351-fast-export-anonymize.sh  | 21 +++++++++++++++++++--
 3 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index e809bb3f18..342e34fd89 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -125,6 +125,14 @@ by keeping the marks the same across runs.
 	the output stream, with the original refname, a space, and its
 	anonymized counterpart. See the section on `ANONYMIZING` below.
 
+--dump-anonymized-paths=<file>::
+	Output the mapping of real paths to anonymized paths to <file>.
+	The output will contain one line per path that appears in the
+	output stream, with the original path, a space, and its
+	anonymized counterpart. Paths may be quoted if they contain a
+	space, or unusual characters; see `core.quotePath` in
+	linkgit:git-config(1). See also `ANONYMIZING` below.
+
 --reference-excluded-parents::
 	By default, running a command such as `git fast-export
 	master~5..master` will not include the commit master{tilde}5
@@ -261,6 +269,10 @@ refs/tags/v2.0 refs/tags/ref50
 which tells you that `git rev-list ref31..ref50` may produce the same
 bug in the re-imported anonymous repository.
 
+Likewise, `--dump-anonymized-paths` may be useful for a bug that
+involves pathspecs. E.g., `git rev-list v1.0..v2.0 -- foo.c` requires
+knowing the path corresponding to `foo.c` in the result.
+
 LIMITATIONS
 -----------
 
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index aa7ac9761d..080ded92e4 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -47,6 +47,7 @@ static struct string_list tag_refs = STRING_LIST_INIT_NODUP;
 static struct refspec refspecs = REFSPEC_INIT_FETCH;
 static int anonymize;
 static FILE *anonymized_refnames_handle;
+static FILE *anonymized_paths_handle;
 static struct revision_sources revision_sources;
 
 static int parse_opt_signed_tag_mode(const struct option *opt,
@@ -394,9 +395,18 @@ static void print_path(const char *path)
 		print_path_1(stdout, path);
 	else {
 		static struct hashmap paths;
+		static struct seen_set seen;
 		static struct strbuf anon = STRBUF_INIT;
 
 		anonymize_path(&anon, path, &paths, anonymize_path_component);
+		if (anonymized_paths_handle &&
+		    !check_and_mark_seen(&seen, path)) {
+			print_path_1(anonymized_paths_handle, path);
+			fputc(' ', anonymized_paths_handle);
+			print_path_1(anonymized_paths_handle, anon.buf);
+			fputc('\n', anonymized_paths_handle);
+		}
+
 		print_path_1(stdout, anon.buf);
 		strbuf_reset(&anon);
 	}
@@ -1165,6 +1175,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	     *import_filename = NULL,
 	     *import_filename_if_exists = NULL;
 	const char *anonymized_refnames_file = NULL;
+	const char *anonymized_paths_file = NULL;
 	uint32_t lastimportid;
 	struct string_list refspecs_list = STRING_LIST_INIT_NODUP;
 	struct string_list paths_of_changed_objects = STRING_LIST_INIT_DUP;
@@ -1201,6 +1212,9 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "dump-anonymized-refnames",
 			   &anonymized_refnames_file, N_("file"),
 			   N_("output anonymized refname mapping to <file>")),
+		OPT_STRING(0, "dump-anonymized-paths",
+			   &anonymized_paths_file, N_("file"),
+			   N_("output anonymized path mapping to <file>")),
 		OPT_BOOL(0, "reference-excluded-parents",
 			 &reference_excluded_commits, N_("Reference parents which are not in fast-export stream by object id")),
 		OPT_BOOL(0, "show-original-ids", &show_original_ids,
@@ -1239,6 +1253,8 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 
 	if (anonymized_refnames_file)
 		anonymized_refnames_handle = xfopen(anonymized_refnames_file, "w");
+	if (anonymized_paths_file)
+		anonymized_paths_handle = xfopen(anonymized_paths_file, "w");
 
 	if (use_done_feature)
 		printf("feature done\n");
diff --git a/t/t9351-fast-export-anonymize.sh b/t/t9351-fast-export-anonymize.sh
index c726306c4d..ef72b1ec95 100755
--- a/t/t9351-fast-export-anonymize.sh
+++ b/t/t9351-fast-export-anonymize.sh
@@ -9,7 +9,7 @@ test_expect_success 'setup simple repo' '
 	git checkout -b other HEAD^ &&
 	mkdir subdir &&
 	test_commit subdir/bar &&
-	test_commit subdir/xyzzy &&
+	test_commit quoting "subdir/this needs quoting" &&
 	git tag -m "annotated tag" mytag
 '
 
@@ -23,7 +23,7 @@ test_expect_success 'stream omits path names' '
 	! grep foo stream &&
 	! grep subdir stream &&
 	! grep bar stream &&
-	! grep xyzzy stream
+	! grep quoting stream
 '
 
 test_expect_success 'stream omits refnames' '
@@ -54,6 +54,23 @@ test_expect_success 'refname mapping can be dumped' '
 	grep "^refs/heads/other refs/heads/" refs.out
 '
 
+test_expect_success 'path mapping can be dumped' '
+	git fast-export --anonymize --all \
+		--dump-anonymized-paths=paths.out >/dev/null &&
+	# as above, avoid depending on the exact scheme, but
+	# but check that we have the right number of mappings,
+	# and spot-check one sample.
+	expected_count=$(
+		git rev-list --objects --all |
+		git cat-file --batch-check="%(objecttype) %(rest)" |
+		sed -ne "s/^blob //p" |
+		sort -u |
+		wc -l
+	) &&
+	test_line_count = $expected_count paths.out &&
+	grep "^\"subdir/this needs quoting\" " paths.out
+'
+
 # NOTE: we chdir to the new, anonymized repository
 # after this. All further tests should assume this.
 test_expect_success 'import stream to new repository' '
-- 
2.27.0.517.gbc32778fa3

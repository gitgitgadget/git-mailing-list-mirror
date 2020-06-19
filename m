Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C192C433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 13:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A48320DD4
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 13:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732317AbgFSN30 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 09:29:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:37152 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729080AbgFSN3Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 09:29:25 -0400
Received: (qmail 2731 invoked by uid 109); 19 Jun 2020 13:29:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Jun 2020 13:29:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14651 invoked by uid 111); 19 Jun 2020 13:29:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Jun 2020 09:29:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 Jun 2020 09:29:23 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/3] fast-export: allow dumping the path mapping
Message-ID: <20200619132923.GA2540897@coredump.intra.peff.net>
References: <20200619132304.GA2540657@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200619132304.GA2540657@coredump.intra.peff.net>
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
Note that the output format isn't unambiguous here (because paths could
contain spaces). That's OK because this is meant to be examined by a
human.

We could also just introduce a "dump mapping" file that shows every
mapping we make. But it would be a bit more awkward to work with, as the
user would have to sort through more data to find the parts they're
interested in (and there are likely to be many more paths than refnames,
making it annoying for people who just want to dump the refnames).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-fast-export.txt | 10 ++++++++++
 builtin/fast-export.c             | 12 ++++++++++++
 t/t9351-fast-export-anonymize.sh  |  8 ++++++++
 3 files changed, 30 insertions(+)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index e809bb3f18..c63f109f1d 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -125,6 +125,12 @@ by keeping the marks the same across runs.
 	the output stream, with the original refname, a space, and its
 	anonymized counterpart. See the section on `ANONYMIZING` below.
 
+--dump-anonymized-paths=<file>::
+	Output the mapping of real paths to anonymized paths to <file>.
+	The output will contain one line per path that appears in the
+	output stream, with the original path, a space, and its
+	anonymized counterpart. See the section on `ANONYMIZING` below.
+
 --reference-excluded-parents::
 	By default, running a command such as `git fast-export
 	master~5..master` will not include the commit master{tilde}5
@@ -261,6 +267,10 @@ refs/tags/v2.0 refs/tags/ref50
 which tells you that `git rev-list ref31..ref50` may produce the same
 bug in the re-imported anonymous repository.
 
+Likewise, `--dump-anonymized-paths` may be useful for a bug that
+involves pathspecs. E.g., `git rev-list v1.0..v2.0 -- foo.c` requires
+knowing the path corresponding to `foo.c` in the result.
+
 LIMITATIONS
 -----------
 
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index cd0174d514..ed1f8daa7f 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -47,6 +47,7 @@ static struct string_list tag_refs = STRING_LIST_INIT_NODUP;
 static struct refspec refspecs = REFSPEC_INIT_FETCH;
 static int anonymize;
 static FILE *anonymized_refnames_handle;
+static FILE *anonymized_paths_handle;
 static struct revision_sources revision_sources;
 
 static int parse_opt_signed_tag_mode(const struct option *opt,
@@ -211,6 +212,9 @@ static void anonymize_path(struct strbuf *out, const char *path,
 			   struct hashmap *map,
 			   void *(*generate)(const void *, size_t *))
 {
+	static struct seen_set seen;
+	const char *full_path = path;
+
 	while (*path) {
 		const char *end_of_component = strchrnul(path, '/');
 		size_t len = end_of_component - path;
@@ -220,6 +224,8 @@ static void anonymize_path(struct strbuf *out, const char *path,
 		if (*path)
 			strbuf_addch(out, *path++);
 	}
+
+	maybe_dump_anon(anonymized_paths_handle, &seen, full_path, out->buf);
 }
 
 static inline void *mark_to_ptr(uint32_t mark)
@@ -1170,6 +1176,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	     *import_filename = NULL,
 	     *import_filename_if_exists = NULL;
 	const char *anonymized_refnames_file = NULL;
+	const char *anonymized_paths_file = NULL;
 	uint32_t lastimportid;
 	struct string_list refspecs_list = STRING_LIST_INIT_NODUP;
 	struct string_list paths_of_changed_objects = STRING_LIST_INIT_DUP;
@@ -1206,6 +1213,9 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "dump-anonymized-refnames",
 			   &anonymized_refnames_file, N_("file"),
 			   N_("output anonymized refname mapping to <file>")),
+		OPT_STRING(0, "dump-anonymized-paths",
+			   &anonymized_paths_file, N_("file"),
+			   N_("output anonymized path mapping to <file>")),
 		OPT_BOOL(0, "reference-excluded-parents",
 			 &reference_excluded_commits, N_("Reference parents which are not in fast-export stream by object id")),
 		OPT_BOOL(0, "show-original-ids", &show_original_ids,
@@ -1244,6 +1254,8 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 
 	if (anonymized_refnames_file)
 		anonymized_refnames_handle = xfopen(anonymized_refnames_file, "w");
+	if (anonymized_paths_file)
+		anonymized_paths_handle = xfopen(anonymized_paths_file, "w");
 
 	if (use_done_feature)
 		printf("feature done\n");
diff --git a/t/t9351-fast-export-anonymize.sh b/t/t9351-fast-export-anonymize.sh
index 88847b0f60..3607b9b972 100755
--- a/t/t9351-fast-export-anonymize.sh
+++ b/t/t9351-fast-export-anonymize.sh
@@ -53,6 +53,14 @@ test_expect_success 'refname mapping can be dumped' '
 	grep "^refs/heads/other refs/heads/" refs.out
 '
 
+test_expect_success 'path mapping can be dumped' '
+	git fast-export --anonymize --all \
+		--dump-anonymized-paths=paths.out >/dev/null &&
+	# do not assume a particular anonymization scheme or order;
+	# just sanity check that a sample line looks sensible.
+	grep "^foo " paths.out
+'
+
 # NOTE: we chdir to the new, anonymized repository
 # after this. All further tests should assume this.
 test_expect_success 'import stream to new repository' '
-- 
2.27.0.480.g4f98dbcb10

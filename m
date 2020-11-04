Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF07AC2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 13:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7162120867
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 13:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgKDN3I (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 08:29:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:47156 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728508AbgKDN3I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 08:29:08 -0500
Received: (qmail 9731 invoked by uid 109); 4 Nov 2020 13:29:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Nov 2020 13:29:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10195 invoked by uid 111); 4 Nov 2020 13:29:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Nov 2020 08:29:07 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 4 Nov 2020 08:29:07 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Postler <johannes.postler@txture.io>
Cc:     git@vger.kernel.org
Subject: [PATCH 3/3] format-patch: support --output option
Message-ID: <20201104132907.GC3030146@coredump.intra.peff.net>
References: <20201104132428.GA2491189@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201104132428.GA2491189@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We've never intended to support diff's --output option in format-patch.
And until baa4adc66a (parse-options: disable option abbreviation with
PARSE_OPT_KEEP_UNKNOWN, 2019-01-27), it was impossible to trigger. We
first parse the format-patch options before handing the remainder off to
setup_revisions(). Before that commit, we'd accept "--output=foo" as an
abbreviation for "--output-directory=foo". But afterwards, we don't
check abbreviations, and --output gets passed to the diff code.

This results in nonsense behavior and bugs. The diff code will have
opened a filehandle at rev.diffopt.file, but we'll overwrite that with
our own handles that we open for each individual patch file. So the
--output file will always just be empty. But worse, the diff code also
sets rev.diffopt.close_file, so log_tree_commit() will close the
filehandle itself. And then the main loop in cmd_format_patch() will try
to close it again, resulting in a double-free.

The simplest solution would be to just disallow --output with
format-patch, as nobody ever intended it to work. However, we have
accidentally documented it (because format-patch includes diff-options).
And it does work with "git log", which writes the whole output to the
specified file. It's easy enough to make that work for format-patch,
too: it's really the same as --stdout, but pointed at a specific file.

We can detect the use of the --output option by the "close_file" flag
(note that we can't use rev.diffopt.file, since the diff setup will
otherwise set it to stdout). So we just need to unset that flag, but
don't have to do anything else. Our situation is otherwise exactly like
--stdout (note that we don't fclose() the file, but nor does the stdout
case; exiting the program takes care of that for us).

Reported-by: Johannes Postler <johannes.postler@txture.io>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/log.c           |  9 ++++++++-
 t/t4014-format-patch.sh | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index 27c6d612e4..ddb3ea7326 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1942,11 +1942,18 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (rev.show_notes)
 		load_display_notes(&rev.notes_opt);
 
-	if (use_stdout + !!output_directory > 1)
+	if (use_stdout + rev.diffopt.close_file + !!output_directory > 1)
 		die(_("specify only one of --stdout, --output, and --output-directory"));
 
 	if (use_stdout) {
 		setup_pager();
+	} else if (rev.diffopt.close_file) {
+		/*
+		 * The diff code parsed --output; it has already opened the
+		 * file, but but we must instruct it not to close after each
+		 * diff.
+		 */
+		rev.diffopt.close_file = 0;
 	} else {
 		int saved;
 
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 294e76c860..64574c51c1 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1919,6 +1919,39 @@ test_expect_success 'format-patch -o overrides format.outputDirectory' '
 	test_path_is_dir patchset
 '
 
+test_expect_success 'format-patch forbids multiple outputs' '
+	rm -fr outfile outdir &&
+	test_must_fail \
+		git format-patch --stdout --output=outfile &&
+	test_must_fail \
+		git format-patch --stdout --output-directory=outdir &&
+	test_must_fail \
+		git format-patch --output=outfile --output-directory=outdir
+'
+
+test_expect_success 'configured outdir does not conflict with output options' '
+	rm -fr outfile outdir &&
+	test_config format.outputDirectory outdir &&
+	git format-patch --stdout &&
+	test_path_is_missing outdir &&
+	git format-patch --output=outfile &&
+	test_path_is_missing outdir
+'
+
+test_expect_success 'format-patch --output' '
+	rm -fr outfile &&
+	git format-patch -3 --stdout HEAD >expect &&
+	git format-patch -3 --output=outfile HEAD &&
+	test_cmp expect outfile
+'
+
+test_expect_success 'format-patch --cover-letter --output' '
+	rm -fr outfile &&
+	git format-patch --cover-letter -3 --stdout HEAD >expect &&
+	git format-patch --cover-letter -3 --output=outfile HEAD &&
+	test_cmp expect outfile
+'
+
 test_expect_success 'format-patch --base' '
 	git checkout patchid &&
 
-- 
2.29.2.559.g8ec94df761

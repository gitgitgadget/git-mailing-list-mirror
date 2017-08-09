Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E4751F991
	for <e@80x24.org>; Wed,  9 Aug 2017 12:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752598AbdHIMWf (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 08:22:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:33196 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752251AbdHIMWe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 08:22:34 -0400
Received: (qmail 2930 invoked by uid 109); 9 Aug 2017 12:22:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 12:22:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26682 invoked by uid 111); 9 Aug 2017 12:22:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 08:22:57 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Aug 2017 08:22:32 -0400
Date:   Wed, 9 Aug 2017 08:22:32 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/5] trailer: put process_trailers() options into a struct
Message-ID: <20170809122232.lfvznzh66m2a5i6o@sigill.intra.peff.net>
References: <20170809122147.g44nwaitzctbadzm@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170809122147.g44nwaitzctbadzm@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We already have two options and are about to add a few more.
To avoid having a huge number of boolean arguments, let's
convert to an options struct which can be passed in.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/interpret-trailers.c | 13 ++++++-------
 trailer.c                    |  9 +++++----
 trailer.h                    |  9 ++++++++-
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 175f14797b..bb0d7b937a 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -18,13 +18,12 @@ static const char * const git_interpret_trailers_usage[] = {
 
 int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 {
-	int in_place = 0;
-	int trim_empty = 0;
+	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
 	struct string_list trailers = STRING_LIST_INIT_NODUP;
 
 	struct option options[] = {
-		OPT_BOOL(0, "in-place", &in_place, N_("edit files in place")),
-		OPT_BOOL(0, "trim-empty", &trim_empty, N_("trim empty trailers")),
+		OPT_BOOL(0, "in-place", &opts.in_place, N_("edit files in place")),
+		OPT_BOOL(0, "trim-empty", &opts.trim_empty, N_("trim empty trailers")),
 		OPT_STRING_LIST(0, "trailer", &trailers, N_("trailer"),
 				N_("trailer(s) to add")),
 		OPT_END()
@@ -36,11 +35,11 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 	if (argc) {
 		int i;
 		for (i = 0; i < argc; i++)
-			process_trailers(argv[i], in_place, trim_empty, &trailers);
+			process_trailers(argv[i], &opts, &trailers);
 	} else {
-		if (in_place)
+		if (opts.in_place)
 			die(_("no input file given for in-place editing"));
-		process_trailers(NULL, in_place, trim_empty, &trailers);
+		process_trailers(NULL, &opts, &trailers);
 	}
 
 	string_list_clear(&trailers, 0);
diff --git a/trailer.c b/trailer.c
index 751b56c009..0a0c2c264d 100644
--- a/trailer.c
+++ b/trailer.c
@@ -968,7 +968,8 @@ static FILE *create_in_place_tempfile(const char *file)
 	return outfile;
 }
 
-void process_trailers(const char *file, int in_place, int trim_empty, struct string_list *trailers)
+void process_trailers(const char *file, struct process_trailer_options *opts,
+		      struct string_list *trailers)
 {
 	LIST_HEAD(head);
 	LIST_HEAD(arg_head);
@@ -980,7 +981,7 @@ void process_trailers(const char *file, int in_place, int trim_empty, struct str
 
 	read_input_file(&sb, file);
 
-	if (in_place)
+	if (opts->in_place)
 		outfile = create_in_place_tempfile(file);
 
 	/* Print the lines before the trailers */
@@ -990,14 +991,14 @@ void process_trailers(const char *file, int in_place, int trim_empty, struct str
 
 	process_trailers_lists(&head, &arg_head);
 
-	print_all(outfile, &head, trim_empty);
+	print_all(outfile, &head, opts->trim_empty);
 
 	free_all(&head);
 
 	/* Print the lines after the trailers as is */
 	fwrite(sb.buf + trailer_end, 1, sb.len - trailer_end, outfile);
 
-	if (in_place)
+	if (opts->in_place)
 		if (rename_tempfile(&trailers_tempfile, file))
 			die_errno(_("could not rename temporary file to %s"), file);
 
diff --git a/trailer.h b/trailer.h
index 65cc5d79c6..b33c5aa57d 100644
--- a/trailer.h
+++ b/trailer.h
@@ -22,7 +22,14 @@ struct trailer_info {
 	size_t trailer_nr;
 };
 
-void process_trailers(const char *file, int in_place, int trim_empty,
+struct process_trailer_options {
+	int in_place;
+	int trim_empty;
+};
+
+#define PROCESS_TRAILER_OPTIONS_INIT {0}
+
+void process_trailers(const char *file, struct process_trailer_options *opts,
 		      struct string_list *trailers);
 
 void trailer_info_get(struct trailer_info *info, const char *str);
-- 
2.14.0.609.gd2d1f7ddf


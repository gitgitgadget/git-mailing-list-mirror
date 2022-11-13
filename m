Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02744C4332F
	for <git@archiver.kernel.org>; Sun, 13 Nov 2022 16:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235252AbiKMQtY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Nov 2022 11:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbiKMQtX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Nov 2022 11:49:23 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7B2DFCE
        for <git@vger.kernel.org>; Sun, 13 Nov 2022 08:49:22 -0800 (PST)
Received: (qmail 9611 invoked by uid 109); 13 Nov 2022 16:49:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 13 Nov 2022 16:49:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 629 invoked by uid 111); 13 Nov 2022 16:49:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 13 Nov 2022 11:49:21 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 13 Nov 2022 11:49:20 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/3] pack-object: simplify --filter handling
Message-ID: <Y3EgEBWoPo2YhYXe@coredump.intra.peff.net>
References: <c64e4fa5-62c2-2a93-a4ef-bd84407ea570@web.de>
 <59abb8d2-e8e6-7423-ead8-49382293aaa6@web.de>
 <Y2/Rwvb2uiE40rW0@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2/Rwvb2uiE40rW0@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 12, 2022 at 12:02:58PM -0500, Jeff King wrote:

> > There is a better way: Use a stand-alone list_objects_filter_options
> > struct and build a rev_info struct with its .filter member after option
> > parsing.  This allows using the simpler OPT_PARSE_LIST_OBJECTS_FILTER()
> > and getting rid of the extra callback mechanism.
> 
> That seems like a reasonable fix (and I think we do it elsewhere). But I
> wonder if it wouldn't be simpler to just unconditionally initialize the
> rev_info in cmd_pack_objects(), and then unconditionally release it.
> True, we _might_ not use it if we are receiving objects directly over
> stdin, but I don't think initializing it is particularly costly.
> 
> And then we don't have to worry about whether it's valid (it always is),
> or about copying between two representations of the filter (there's only
> one).

Just to make sure I wasn't telling you absolute garbage, I sketched this
out quickly, so sharing it below (to illustrate, or maybe to save you 5
minutes if you want to go that direction).

If you do stick with copying the filter spec, yet another option is that
the rev_info variable could move back into get_object_list(), and we
could just pass in the filter_options. It was only moved out in
80f6de4f5b (pack-objects: move revs out of get_object_list(),
2022-03-22) so that we could parse --filter directly into it.

That's probably approaching bikeshed territory, and I'm happy enough
either way, but it keeps the outer cmd_pack_objects() to the absolute
minimum of what it needs to see.

-Peff

-- >8 --
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c702c09dd4..cadc2be35f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4149,22 +4149,6 @@ static int option_parse_cruft_expiration(const struct option *opt,
 	return 0;
 }
 
-struct po_filter_data {
-	unsigned have_revs:1;
-	struct rev_info revs;
-};
-
-static struct list_objects_filter_options *po_filter_revs_init(void *value)
-{
-	struct po_filter_data *data = value;
-
-	if (!data->have_revs)
-		repo_init_revisions(the_repository, &data->revs, NULL);
-	data->have_revs = 1;
-
-	return &data->revs.filter;
-}
-
 int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 {
 	int use_internal_rev_list = 0;
@@ -4175,7 +4159,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	int rev_list_index = 0;
 	int stdin_packs = 0;
 	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
-	struct po_filter_data pfd = { .have_revs = 0 };
+	struct rev_info revs;
 
 	struct option pack_objects_options[] = {
 		OPT_SET_INT('q', "quiet", &progress,
@@ -4266,7 +4250,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			      &write_bitmap_index,
 			      N_("write a bitmap index if possible"),
 			      WRITE_BITMAP_QUIET, PARSE_OPT_HIDDEN),
-		OPT_PARSE_LIST_OBJECTS_FILTER_INIT(&pfd, po_filter_revs_init),
+		OPT_PARSE_LIST_OBJECTS_FILTER(&revs.filter),
 		OPT_CALLBACK_F(0, "missing", NULL, N_("action"),
 		  N_("handling for missing objects"), PARSE_OPT_NONEG,
 		  option_parse_missing_action),
@@ -4297,6 +4281,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (git_env_bool(GIT_TEST_WRITE_REV_INDEX, 0))
 		pack_idx_opts.flags |= WRITE_REV;
 
+	repo_init_revisions(the_repository, &revs, NULL);
+
 	progress = isatty(2);
 	argc = parse_options(argc, argv, prefix, pack_objects_options,
 			     pack_usage, 0);
@@ -4386,7 +4372,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (!rev_list_all || !rev_list_reflog || !rev_list_index)
 		unpack_unreachable_expiration = 0;
 
-	if (pfd.have_revs && pfd.revs.filter.choice) {
+	if (revs.filter.choice) {
 		if (!pack_to_stdout)
 			die(_("cannot use --filter without --stdout"));
 		if (stdin_packs)
@@ -4473,16 +4459,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		read_cruft_objects();
 	} else if (!use_internal_rev_list) {
 		read_object_list_from_stdin();
-	} else if (pfd.have_revs) {
-		get_object_list(&pfd.revs, rp.nr, rp.v);
-		release_revisions(&pfd.revs);
 	} else {
-		struct rev_info revs;
-
-		repo_init_revisions(the_repository, &revs, NULL);
 		get_object_list(&revs, rp.nr, rp.v);
-		release_revisions(&revs);
 	}
+	release_revisions(&revs);
 	cleanup_preferred_base();
 	if (include_tag && nr_result)
 		for_each_tag_ref(add_ref_tag, NULL);

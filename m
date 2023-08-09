Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F93C0015E
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 14:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjHIOJK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 10:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjHIOJJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 10:09:09 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B641FC2
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 07:09:04 -0700 (PDT)
Received: (qmail 13182 invoked by uid 109); 9 Aug 2023 14:09:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 09 Aug 2023 14:09:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30560 invoked by uid 111); 9 Aug 2023 14:09:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 09 Aug 2023 10:09:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 9 Aug 2023 10:09:02 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] describe: fix --no-exact-match
Message-ID: <20230809140902.GA775795@coredump.intra.peff.net>
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
 <xmqqo7k9fa5x.fsf@gitster.g>
 <4eea7e15-6594-93e2-27b5-3d6e3c0baac6@web.de>
 <20230808212720.GA760752@coredump.intra.peff.net>
 <xmqqzg3156sy.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqzg3156sy.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 08, 2023 at 06:43:41PM -0700, Junio C Hamano wrote:

> > So before I sent a patch (either to switch to using opt->value, or to
> > add an UNUSED annotation), I wanted to see what you (or others) thought
> > between the two. I.e., should we have a rule of "try not to operate on
> > global data via option callbacks" or is that just being too pedantic for
> > one-off callbacks like this?
> 
> So, that was my preference, but I may be missing some obvious
> downsides.  I am interested in hearing from René, who often shows
> better taste than I do in these cases ;-)

Me too. :) The main downsides, I think, are:

  1. It's a little more ugly.

  2. We lose type safety, as the variable address passes through a void
     pointer (but that is true of all option callbacks).

Here's what it looks like, for reference.

diff --git a/builtin/describe.c b/builtin/describe.c
index b28a4a1f82..718b5c3073 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -561,9 +561,11 @@ static void describe(const char *arg, int last_one)
 static int option_parse_exact_match(const struct option *opt, const char *arg,
 				    int unset)
 {
+	int *val = opt->value;
+
 	BUG_ON_OPT_ARG(arg);
 
-	max_candidates = unset ? DEFAULT_CANDIDATES : 0;
+	*val = unset ? DEFAULT_CANDIDATES : 0;
 	return 0;
 }
 
@@ -578,7 +580,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "long",       &longformat, N_("always use long format")),
 		OPT_BOOL(0, "first-parent", &first_parent, N_("only follow first parent")),
 		OPT__ABBREV(&abbrev),
-		OPT_CALLBACK_F(0, "exact-match", NULL, NULL,
+		OPT_CALLBACK_F(0, "exact-match", &max_candidates, NULL,
 			       N_("only output exact matches"),
 			       PARSE_OPT_NOARG, option_parse_exact_match),
 		OPT_INTEGER(0, "candidates", &max_candidates,
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index d2a162d528..74c2225620 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4120,12 +4120,14 @@ static void add_extra_kept_packs(const struct string_list *names)
 static int option_parse_quiet(const struct option *opt, const char *arg,
 			      int unset)
 {
+	int *val = opt->value;
+
 	BUG_ON_OPT_ARG(arg);
 
 	if (!unset)
-		progress = 0;
-	else if (!progress)
-		progress = 1;
+		*val = 0;
+	else if (!*val)
+		*val = 1;
 	return 0;
 }
 
@@ -4190,7 +4192,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		LIST_OBJECTS_FILTER_INIT;
 
 	struct option pack_objects_options[] = {
-		OPT_CALLBACK_F('q', "quiet", NULL, NULL,
+		OPT_CALLBACK_F('q', "quiet", &progress, NULL,
 			       N_("do not show progress meter"),
 			       PARSE_OPT_NOARG, option_parse_quiet),
 		OPT_SET_INT(0, "progress", &progress,

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF06A20248
	for <e@80x24.org>; Wed, 20 Mar 2019 20:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfCTUWS (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 16:22:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:58090 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725988AbfCTUWS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 16:22:18 -0400
Received: (qmail 11457 invoked by uid 109); 20 Mar 2019 20:22:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Mar 2019 20:22:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3611 invoked by uid 111); 20 Mar 2019 20:22:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 20 Mar 2019 16:22:39 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Mar 2019 16:22:15 -0400
Date:   Wed, 20 Mar 2019 16:22:15 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 13/13] parse_opt_ref_sorting: always use with NONEG flag
Message-ID: <20190320202215.GA17382@sigill.intra.peff.net>
References: <20190320081258.GA5621@sigill.intra.peff.net>
 <20190320081650.GM10403@sigill.intra.peff.net>
 <CAN0heSrubOaXRbg=NBi0rCuzthUcOEU3HmUKGg+=t+N0CCJcbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSrubOaXRbg=NBi0rCuzthUcOEU3HmUKGg+=t+N0CCJcbA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 20, 2019 at 01:22:22PM +0100, Martin Ågren wrote:

> > +#define OPT_REF_SORT(var) \
> > +       OPT_CALLBACK_F(0, "sort", (var), \
> > +                      N_("key"), N_("field name to sort"), \
> > +                      PARSE_OPT_NONEG, parse_opt_ref_sorting)
> 
> This one is not identical though. ;-) You drop the "on". I trust you to
> know which of these is (more) correct, but I was a bit surprised to see
> "on" disappear without any mention. Mistake, or intended?

Mistake. I retyped when I should have cut-and-pasted.

Amusingly, I even carefully checked that the original four were all
identical, but didn't think to check against my new one. Revised patch
below.

> Other than that surprise ending, the whole series was a nice read.

I'm the M. Night Shyamalan of Git development.

Thanks for reading. :)

-- >8 --
Subject: [PATCH] parse_opt_ref_sorting: always use with NONEG flag

The "--sort" parameter of for-each-ref, etc, does not handle negation,
and instead returns an error to the parse-options code. But neither
piece of code prints anything for the user, which may leave them
confused:

  $ git for-each-ref --no-sort
  $ echo $?
  129

As the comment in the callback function notes, this probably should
clear the list, which would make it consistent with other list-like
options (i.e., anything that uses OPT_STRING_LIST currently).
Unfortunately that's a bit tricky due to the way the ref-filter code
works. But in the meantime, let's at least make the error a little less
confusing:

  - switch to using PARSE_OPT_NONEG in the option definition, which will
    cause the options code to produce a useful message

  - since this was cut-and-pasted to four different spots, let's define
    a single OPT_REF_SORT() macro that we can use everywhere

  - the callback can use BUG_ON_OPT_NEG() to make sure the correct flags
    are used (incidentally, this also satisfies -Wunused-parameters,
    since we're now looking at "unset")

  - expand the comment into a NEEDSWORK to make it clear that the
    direction is right, but the details need to be worked out

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/branch.c       | 3 +--
 builtin/for-each-ref.c | 3 +--
 builtin/ls-remote.c    | 3 +--
 builtin/tag.c          | 3 +--
 ref-filter.c           | 9 +++++++--
 ref-filter.h           | 5 +++++
 6 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 4c83055730..d4359b33ac 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -644,8 +644,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
 		OPT_COLUMN(0, "column", &colopts, N_("list branches in columns")),
-		OPT_CALLBACK(0 , "sort", sorting_tail, N_("key"),
-			     N_("field name to sort on"), &parse_opt_ref_sorting),
+		OPT_REF_SORT(sorting_tail),
 		{
 			OPTION_CALLBACK, 0, "points-at", &filter.points_at, N_("object"),
 			N_("print only branches of the object"), 0, parse_opt_object_name
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index e931be9ce4..465153e853 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -37,8 +37,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		OPT_INTEGER( 0 , "count", &maxcount, N_("show only <n> matched refs")),
 		OPT_STRING(  0 , "format", &format.format, N_("format"), N_("format to use for the output")),
 		OPT__COLOR(&format.use_color, N_("respect format colors")),
-		OPT_CALLBACK(0 , "sort", sorting_tail, N_("key"),
-			    N_("field name to sort on"), &parse_opt_ref_sorting),
+		OPT_REF_SORT(sorting_tail),
 		OPT_CALLBACK(0, "points-at", &filter.points_at,
 			     N_("object"), N_("print only refs which points at the given object"),
 			     parse_opt_object_name),
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 1d7f1f5ce2..6ef519514b 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -67,8 +67,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 		OPT_BIT(0, "refs", &flags, N_("do not show peeled tags"), REF_NORMAL),
 		OPT_BOOL(0, "get-url", &get_url,
 			 N_("take url.<base>.insteadOf into account")),
-		OPT_CALLBACK(0 , "sort", sorting_tail, N_("key"),
-			     N_("field name to sort on"), &parse_opt_ref_sorting),
+		OPT_REF_SORT(sorting_tail),
 		OPT_SET_INT_F(0, "exit-code", &status,
 			      N_("exit with exit code 2 if no matching refs are found"),
 			      2, PARSE_OPT_NOCOMPLETE),
diff --git a/builtin/tag.c b/builtin/tag.c
index 02f6bd1279..ad97595fbf 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -412,8 +412,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_WITHOUT(&filter.no_commit, N_("print only tags that don't contain the commit")),
 		OPT_MERGED(&filter, N_("print only tags that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only tags that are not merged")),
-		OPT_CALLBACK(0 , "sort", sorting_tail, N_("key"),
-			     N_("field name to sort on"), &parse_opt_ref_sorting),
+		OPT_REF_SORT(sorting_tail),
 		{
 			OPTION_CALLBACK, 0, "points-at", &filter.points_at, N_("object"),
 			N_("print only tags of the object"), PARSE_OPT_LASTARG_DEFAULT,
diff --git a/ref-filter.c b/ref-filter.c
index 3aca105307..8d11a94cbd 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2337,8 +2337,13 @@ void parse_ref_sorting(struct ref_sorting **sorting_tail, const char *arg)
 
 int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset)
 {
-	if (!arg) /* should --no-sort void the list ? */
-		return -1;
+	/*
+	 * NEEDSWORK: We should probably clear the list in this case, but we've
+	 * already munged the global used_atoms list, which would need to be
+	 * undone.
+	 */
+	BUG_ON_OPT_NEG(unset);
+
 	parse_ref_sorting(opt->value, arg);
 	return 0;
 }
diff --git a/ref-filter.h b/ref-filter.h
index 85c8ebc3b9..f1dcff4c6e 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -96,6 +96,11 @@ struct ref_format {
 #define OPT_MERGED(f, h) _OPT_MERGED_NO_MERGED("merged", f, h)
 #define OPT_NO_MERGED(f, h) _OPT_MERGED_NO_MERGED("no-merged", f, h)
 
+#define OPT_REF_SORT(var) \
+	OPT_CALLBACK_F(0, "sort", (var), \
+		       N_("key"), N_("field name to sort on"), \
+		       PARSE_OPT_NONEG, parse_opt_ref_sorting)
+
 /*
  * API for filtering a set of refs. Based on the type of refs the user
  * has requested, we iterate through those refs and apply filters
-- 
2.21.0.701.g4401309e11


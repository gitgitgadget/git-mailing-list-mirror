Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A016AC83F37
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 21:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347500AbjHaVQm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 17:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244113AbjHaVQm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 17:16:42 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA039132
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 14:16:38 -0700 (PDT)
Received: (qmail 25935 invoked by uid 109); 31 Aug 2023 21:16:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 31 Aug 2023 21:16:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11514 invoked by uid 111); 31 Aug 2023 21:16:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Aug 2023 17:16:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 31 Aug 2023 17:16:37 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v2 0/10] more unused parameters in parseopt callbacks
Message-ID: <20230831211637.GA949188@coredump.intra.peff.net>
References: <20230831070935.GA3197495@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230831070935.GA3197495@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 31, 2023 at 03:09:35AM -0400, Jeff King wrote:

> Here are some more patches silencing -Wunused-parameter warnings. I've
> prepared them on top of the patches queued in jk/unused-post-2.42, but
> they should apply equally well directly on 'master'.

And here's a re-roll based on feedback from Junio:

  [01/10]: merge: make xopts a strvec
  [02/10]: merge: simplify parsing of "-n" option
  [03/10]: format-patch: use OPT_STRING_LIST for to/cc options
  [04/10]: checkout-index: delay automatic setting of to_tempfile
  [05/10]: parse-options: prefer opt->value to globals in callbacks
  [06/10]: parse-options: mark unused "opt" parameter in callbacks
  [07/10]: merge: do not pass unused opt->value parameter
  [08/10]: parse-options: add more BUG_ON() annotations
  [09/10]: interpret-trailers: mark unused "unset" parameters in option callbacks
  [10/10]: parse-options: mark unused parameters in noop callback

Range-diff is below, but the most interesting changes are in the two new
patches (3 and 4):

  - patch 3 simplifies away a few string-list callbacks (which can then
    be omitted from patch 6, the "mark unused opt" one).

  - patch 4 fixes some minor bugs with "checkout-index --stage". In
    doing so, it's now eligible for cleanup in patch 5 ("prefer
    opt->value") and its annotation dropped from patch 6

  - patch 5 ("prefer opt->value") converts the missed refmap callback,
    and so its annotation is gone from patch 6 now

  - a few extra clarifying comments

 1:  8750d92016 !  1:  82940b6936 merge: make xopts a strvec
    @@ Commit message
     
         As a bonus, this means that "--no-strategy-option", which was previously
         a silent noop, now does something useful: like other list-like options,
    -    it will clear the list of -X options seen so far.
    +    it will clear the list of -X options seen so far. This matches the
    +    behavior of revert/cherry-pick, which made the same change in fb60b9f37f
    +    (sequencer: use struct strvec to store merge strategy options,
    +    2023-04-10).
     
         Signed-off-by: Jeff King <peff@peff.net>
     
 2:  ffdae69bd6 =  2:  c98b87feb9 merge: simplify parsing of "-n" option
 -:  ---------- >  3:  615fef8f90 format-patch: use OPT_STRING_LIST for to/cc options
 -:  ---------- >  4:  66cf7bcf08 checkout-index: delay automatic setting of to_tempfile
 3:  f00c78cc49 !  5:  a7c2bfecba parse-options: prefer opt->value to globals in callbacks
    @@ Commit message
     
         Signed-off-by: Jeff King <peff@peff.net>
     
    + ## builtin/checkout-index.c ##
    +@@ builtin/checkout-index.c: static const char * const builtin_checkout_index_usage[] = {
    + static int option_parse_stage(const struct option *opt,
    + 			      const char *arg, int unset)
    + {
    ++	int *stage = opt->value;
    ++
    + 	BUG_ON_OPT_NEG(unset);
    + 
    + 	if (!strcmp(arg, "all")) {
    +-		checkout_stage = CHECKOUT_ALL;
    ++		*stage = CHECKOUT_ALL;
    + 	} else {
    + 		int ch = arg[0];
    + 		if ('1' <= ch && ch <= '3')
    +-			checkout_stage = arg[0] - '0';
    ++			*stage = arg[0] - '0';
    + 		else
    + 			die(_("stage should be between 1 and 3 or all"));
    + 	}
    +@@ builtin/checkout-index.c: int cmd_checkout_index(int argc, const char **argv, const char *prefix)
    + 			N_("write the content to temporary files")),
    + 		OPT_STRING(0, "prefix", &state.base_dir, N_("string"),
    + 			N_("when creating files, prepend <string>")),
    +-		OPT_CALLBACK_F(0, "stage", NULL, "(1|2|3|all)",
    ++		OPT_CALLBACK_F(0, "stage", &checkout_stage, "(1|2|3|all)",
    + 			N_("copy out the files from named stage"),
    + 			PARSE_OPT_NONEG, option_parse_stage),
    + 		OPT_END()
    +
      ## builtin/describe.c ##
     @@ builtin/describe.c: static void describe(const char *arg, int last_one)
      static int option_parse_exact_match(const struct option *opt, const char *arg,
    @@ builtin/fast-export.c: static int parse_opt_tag_of_filtered_mode(const struct op
      			return error("Unknown reencoding mode: %s", arg);
      	}
     
    + ## builtin/fetch.c ##
    +@@ builtin/fetch.c: static int parse_refmap_arg(const struct option *opt, const char *arg, int unset
    + 	 * "git fetch --refmap='' origin foo"
    + 	 * can be used to tell the command not to store anywhere
    + 	 */
    +-	refspec_append(&refmap, arg);
    ++	refspec_append(opt->value, arg);
    + 
    + 	return 0;
    + }
    +@@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const char *prefix)
    + 			   PARSE_OPT_HIDDEN, option_fetch_parse_recurse_submodules),
    + 		OPT_BOOL(0, "update-shallow", &update_shallow,
    + 			 N_("accept refs that update .git/shallow")),
    +-		OPT_CALLBACK_F(0, "refmap", NULL, N_("refmap"),
    ++		OPT_CALLBACK_F(0, "refmap", &refmap, N_("refmap"),
    + 			       N_("specify fetch refmap"), PARSE_OPT_NONEG, parse_refmap_arg),
    + 		OPT_STRING_LIST('o', "server-option", &server_options, N_("server-specific"), N_("option to transmit")),
    + 		OPT_IPVERSION(&family),
    +
      ## builtin/interpret-trailers.c ##
     @@ builtin/interpret-trailers.c: static enum trailer_if_missing if_missing;
      static int option_parse_where(const struct option *opt,
 4:  19621fc01c !  6:  bd915fe4de parse-options: mark unused "opt" parameter in callbacks
    @@ Commit message
     
         Signed-off-by: Jeff King <peff@peff.net>
     
    - ## builtin/checkout-index.c ##
    -@@ builtin/checkout-index.c: static const char * const builtin_checkout_index_usage[] = {
    - 	NULL
    - };
    - 
    --static int option_parse_stage(const struct option *opt,
    -+static int option_parse_stage(const struct option *opt UNUSED,
    - 			      const char *arg, int unset)
    - {
    - 	BUG_ON_OPT_NEG(unset);
    -
    - ## builtin/fetch.c ##
    -@@ builtin/fetch.c: static int git_fetch_config(const char *k, const char *v,
    - 	return git_default_config(k, v, ctx, cb);
    - }
    - 
    --static int parse_refmap_arg(const struct option *opt, const char *arg, int unset)
    -+static int parse_refmap_arg(const struct option *opt UNUSED,
    -+			    const char *arg, int unset)
    - {
    - 	BUG_ON_OPT_NEG(unset);
    - 
    -
      ## builtin/gc.c ##
     @@ builtin/gc.c: static void initialize_task_config(int schedule)
      	strbuf_release(&config_name);
    @@ builtin/log.c: static int inline_callback(const struct option *opt, const char *
      {
      	if (unset) {
      		string_list_clear(&extra_hdr, 0);
    -@@ builtin/log.c: static int header_callback(const struct option *opt, const char *arg, int unset)
    - 	return 0;
    - }
    - 
    --static int to_callback(const struct option *opt, const char *arg, int unset)
    -+static int to_callback(const struct option *opt UNUSED, const char *arg,
    -+		       int unset)
    - {
    - 	if (unset)
    - 		string_list_clear(&extra_to, 0);
    -@@ builtin/log.c: static int to_callback(const struct option *opt, const char *arg, int unset)
    - 	return 0;
    - }
    - 
    --static int cc_callback(const struct option *opt, const char *arg, int unset)
    -+static int cc_callback(const struct option *opt UNUSED, const char *arg,
    -+		       int unset)
    - {
    - 	if (unset)
    - 		string_list_clear(&extra_cc, 0);
     
      ## builtin/merge.c ##
     @@ builtin/merge.c: static void append_strategy(struct strategy *s)
 5:  2d6a3b9e1b =  7:  1720ddebc1 merge: do not pass unused opt->value parameter
 6:  7669758cc7 =  8:  a93f155f21 parse-options: add more BUG_ON() annotations
 7:  b80020daec !  9:  529573e281 interpret-trailers: mark unused "unset" parameters in option callbacks
    @@ Commit message
         false). But none of these do.
     
         So the code is fine as-is. But we'll want to mark the unused "unset"
    -    parameters to quiet -Wunused-parameter.
    +    parameters to quiet -Wunused-parameter. I've also added a comment to
    +    make this rather subtle situation more explicit.
     
         Signed-off-by: Jeff King <peff@peff.net>
     
    @@ builtin/interpret-trailers.c: static enum trailer_if_exists if_exists;
     -			      const char *arg, int unset)
     +			      const char *arg, int unset UNUSED)
      {
    ++	/* unset implies NULL arg, which is handled in our helper */
      	return trailer_set_where(opt->value, arg);
      }
      
      static int option_parse_if_exists(const struct option *opt,
     -				  const char *arg, int unset)
     +				  const char *arg, int unset UNUSED)
      {
    ++	/* unset implies NULL arg, which is handled in our helper */
      	return trailer_set_if_exists(opt->value, arg);
      }
      
      static int option_parse_if_missing(const struct option *opt,
     -				   const char *arg, int unset)
     +				   const char *arg, int unset UNUSED)
      {
    ++	/* unset implies NULL arg, which is handled in our helper */
      	return trailer_set_if_missing(opt->value, arg);
      }
    + 
 8:  f21961ed23 = 10:  943161eaf2 parse-options: mark unused parameters in noop callback

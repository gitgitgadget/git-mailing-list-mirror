Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DEBC1F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 18:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730069AbfJUSt4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 14:49:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:54112 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726672AbfJUSt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 14:49:56 -0400
Received: (qmail 19534 invoked by uid 109); 21 Oct 2019 18:49:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 21 Oct 2019 18:49:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9552 invoked by uid 111); 21 Oct 2019 18:53:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 21 Oct 2019 14:53:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 21 Oct 2019 14:49:55 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-progress: fix test failures on big-endian systems
Message-ID: <20191021184954.GA2526@sigill.intra.peff.net>
References: <b0bec82e-ad0a-32f6-e2e6-e1f0e6920639@physik.fu-berlin.de>
 <20190731071755.GF4545@pobox.com>
 <f1ce445e-6954-8e7b-2dca-3a566ce689a5@physik.fu-berlin.de>
 <20191019233706.GM29845@szeder.dev>
 <xmqq36fmor7o.fsf@gitster-ct.c.googlers.com>
 <20191021032144.GB13083@sigill.intra.peff.net>
 <xmqqftjmlbvb.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqftjmlbvb.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 21, 2019 at 05:51:52PM +0900, Junio C Hamano wrote:

> > -	void *value;
> > +	union {
> > +		int *intp;
> > +		const char *strp;
> > +	} value;
> [...]
> The side that actually use .vale would need to change for obvious
> reasons, which may be painful, but I agree it would have easily
> prevented the regression from happening in the first place.

I was curious just how painful, so here's what I found.

The conversion is indeed annoying. There are 330 sites that need
touched to handle the switch to a union (both declarations and places
that access the variables).

Most of the declarations are hidden by the OPT_*() macros, but there's a
fair bit of changes like this sprinkled around:

@@ -4952,13 +4952,13 @@ int apply_parse_options(int argc, const char **argv,
                        const char * const *apply_usage)
 {
        struct option builtin_apply_options[] = {
-               { OPTION_CALLBACK, 0, "exclude", state, N_("path"),
+               { OPTION_CALLBACK, 0, "exclude", { .voidp = state }, N_("path"),
                        N_("don't apply changes matching the given path"),
                        PARSE_OPT_NONEG, apply_option_parse_exclude },
-               { OPTION_CALLBACK, 0, "include", state, N_("path"),
+               { OPTION_CALLBACK, 0, "include", { .voidp = state }, N_("path"),
                        N_("apply changes matching the given path"),
                        PARSE_OPT_NONEG, apply_option_parse_include },
-               { OPTION_CALLBACK, 'p', NULL, state, N_("num"),
+               { OPTION_CALLBACK, 'p', NULL, { .voidp = state }, N_("num"),
                        N_("remove <num> leading slashes from traditional diff paths"),
                        0, apply_option_parse_p },
                OPT_BOOL(0, "no-add", &state->no_add,

which is strictly worse syntactically, and doesn't give us any type
safety (and won't ever, because parse-options is never going to learn
about "struct apply_state").

Likewise the access side gets slightly uglier, but not too bad:

@@ -4768,7 +4768,7 @@ static int apply_patch(struct apply_state *state,
 static int apply_option_parse_exclude(const struct option *opt,
                                      const char *arg, int unset)
 {
-       struct apply_state *state = opt->value;
+       struct apply_state *state = opt->value.voidp;
 
        BUG_ON_OPT_NEG(unset);
 

For things that actually use intp, I think the access side is fine (and
possibly even slightly nicer):

@@ -101,65 +101,65 @@ static enum parse_opt_result get_value(struct parse_opt_ctx_t *p,
 
        case OPTION_BIT:
                if (unset)
-                       *(int *)opt->value &= ~opt->defval;
+                       *opt->value.intp &= ~opt->defval;
                else
-                       *(int *)opt->value |= opt->defval;
+                       *opt->value.intp |= opt->defval;
                return 0;
 

The declaration side is mostly handled by OPT_INTEGER(), etc, but
hand-written ones still need to adjust as you'd expect:

@@ -298,7 +298,7 @@ static struct option builtin_add_options[] = {
        OPT_BOOL(0, "renormalize", &add_renormalize, N_("renormalize EOL of tracked files (implies -u)")),
        OPT_BOOL('N', "intent-to-add", &intent_to_add, N_("record only the fact that the path will be added later")),
        OPT_BOOL('A', "all", &addremove_explicit, N_("add changes from all tracked and untracked files")),
-       { OPTION_CALLBACK, 0, "ignore-removal", &addremove_explicit,
+       { OPTION_CALLBACK, 0, "ignore-removal", { .intp = &addremove_explicit },
          NULL /* takes no arguments */,
          N_("ignore paths removed in the working tree (same as --no-all)"),
          PARSE_OPT_NOARG, ignore_removal_cb },

That's ugly, but at least we're getting some type safety out of it.

But here's where it gets tricky. In addition to catching any size
mismatches, this will also catch signedness problems. I.e., if we make
OPT_INTEGER() use "intp", then everybody passing in &unsigned_var now
gets a compiler warning. Which maybe is a good thing, I dunno. But it
triggers a lot of warnings. We probably ought to be using a "uintp" for
OPT_BIT(), etc, but that just complains about callers passing in signed
integers. ;)

So that's where I gave up. Converting between signed and unsigned
variables needs to be done very carefully, as there are often subtle
impacts (e.g., loop terminations). And because we have so many sign
issues already, compiling with "-Wsign-compare", etc, isn't likely to
help.

But if anybody wants to take a stab at it, the work I've done so far is
can be fetched from:

  https://github.com/peff/git jk/parseopt-intp-wip

-Peff

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545A5CA0FE2
	for <git@archiver.kernel.org>; Tue,  5 Sep 2023 16:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbjIEQAp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353611AbjIEGwn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2023 02:52:43 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D371B4
        for <git@vger.kernel.org>; Mon,  4 Sep 2023 23:52:40 -0700 (PDT)
Received: (qmail 13638 invoked by uid 109); 5 Sep 2023 06:52:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 05 Sep 2023 06:52:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19474 invoked by uid 111); 5 Sep 2023 06:52:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 Sep 2023 02:52:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 5 Sep 2023 02:52:37 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 05/10] parse-options: prefer opt->value to globals in
 callbacks
Message-ID: <20230905065237.GB199565@coredump.intra.peff.net>
References: <20230831211637.GA949188@coredump.intra.peff.net>
 <20230831212107.GE949469@coredump.intra.peff.net>
 <8f03fa13-11b3-1f9f-1e1f-8f7d8ce74a23@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f03fa13-11b3-1f9f-1e1f-8f7d8ce74a23@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 02, 2023 at 09:34:32AM +0200, René Scharfe wrote:

> >  static int option_parse_if_missing(const struct option *opt,
> >  				   const char *arg, int unset)
> >  {
> > -	return trailer_set_if_missing(&if_missing, arg);
> > +	return trailer_set_if_missing(opt->value, arg);
> >  }
> 
> Not your fault, but these all silently exit if "arg" contains an
> unrecognized value.  Reporting the error would be better.

Hmm, yeah. On the config side, git_trailer_default_config() issues a
warning after the functions return -1. I'd have guessed we at least
printed a usage message or something here, but we don't even do that.
You get a silent 129 exit code.

Gross, but it's something I think we should fix separately, as it's
orthogonal to this series.

> >  static void new_trailers_clear(struct list_head *trailers)
> > @@ -97,11 +97,11 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
> >  		OPT_BOOL(0, "in-place", &opts.in_place, N_("edit files in place")),
> >  		OPT_BOOL(0, "trim-empty", &opts.trim_empty, N_("trim empty trailers")),
> >
> > -		OPT_CALLBACK(0, "where", NULL, N_("action"),
> > +		OPT_CALLBACK(0, "where", &where, N_("action"),
> >  			     N_("where to place the new trailer"), option_parse_where),
> > -		OPT_CALLBACK(0, "if-exists", NULL, N_("action"),
> > +		OPT_CALLBACK(0, "if-exists", &if_exists, N_("action"),
> >  			     N_("action if trailer already exists"), option_parse_if_exists),
> > -		OPT_CALLBACK(0, "if-missing", NULL, N_("action"),
> > +		OPT_CALLBACK(0, "if-missing", &if_missing, N_("action"),
> >  			     N_("action if trailer is missing"), option_parse_if_missing),
> 
> And I wonder if "action" should be replaced by "(after|before|end|start)",
> "(addIfDifferent|addIfDifferentNeighbor|add|replace|doNothing)" and
> "(doNothing|add)", respectively.  Gets a bit long in the middle, but would
> be more helpful.  #leftoverbits

I don't have a strong opinion. It is sometimes nice to provide more
detail to save the user having to look it up separately. But sometimes
those details can be overwhelming and make it hard to read, especially
if they grow over time. I'm thinking less of "-h" output and more of
people like to put:

  git foo [--optionA|--optionB|--optionC]

and so on, until eventually the options block is like 4 lines long. Just
saying [options] and then listing them is more friendly. I'm not sure if
we're approaching that kind of problem here or not.

-Peff

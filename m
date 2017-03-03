Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CF862023D
	for <e@80x24.org>; Fri,  3 Mar 2017 06:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751384AbdCCG5k (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 01:57:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:37726 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751333AbdCCG5i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 01:57:38 -0500
Received: (qmail 9056 invoked by uid 109); 3 Mar 2017 06:30:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 06:30:54 +0000
Received: (qmail 25249 invoked by uid 111); 3 Mar 2017 06:31:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 01:31:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Mar 2017 01:30:52 -0500
Date:   Fri, 3 Mar 2017 01:30:52 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, sschuberth@gmail.com,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Philip Oakley <philipoakley@iee.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v7 3/3] config: add conditional include
Message-ID: <20170303063052.xkjoipuaohcwdl4n@sigill.intra.peff.net>
References: <20170224131425.32409-1-pclouds@gmail.com>
 <20170301112631.16497-1-pclouds@gmail.com>
 <20170301112631.16497-4-pclouds@gmail.com>
 <xmqqo9xkhosj.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo9xkhosj.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 01, 2017 at 09:47:40AM -0800, Junio C Hamano wrote:

> > @@ -185,6 +271,12 @@ int git_config_include(const char *var, const char *value, void *data)
> >  
> >  	if (!strcmp(var, "include.path"))
> >  		ret = handle_path_include(value, inc);
> > +
> > +	if (!parse_config_key(var, "includeif", &cond, &cond_len, &key) &&
> > +	    (cond && include_condition_is_true(cond, cond_len)) &&
> > +	    !strcmp(key, "path"))
> > +		ret = handle_path_include(value, inc);
> > +
> >  	return ret;
> >  }
> 
> So "includeif.path" (misspelled one without any condition) falls
> through to "return ret" and gives the value we got from inc->fn().
> I am OK with that (i.e. "missing condition is false").

Yeah, I think that is sensible, just as not-understood nonsense like
"include.foobar" would be ignored, as well.

> Or we can make it go to handle_path_include(), effectively making
> the "include.path" a short-hand for "includeIf.path".  I am also OK
> with that (i.e. "missing condition is true").

I think we want "missing condition is false". Certainly an empty
condition like "includeIf..path" is false, as are conditions we don't
understand.

> Or we could even have "include.[<condition>.]path" without
> "includeIf"?  I am not sure if it is a bad idea that paints
> ourselves in a corner, but somehow I find it tempting.

That was how I had originally envisioned the namespace working when I
introduced include.path long ago. And I think Duy's v1 used that, but
the feedback was that it was not sufficiently obvious that the
subsection was a conditional.

-Peff

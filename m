Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 715B7202C9
	for <e@80x24.org>; Tue, 28 Feb 2017 22:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751673AbdB1Wfm (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 17:35:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:36126 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751470AbdB1Wff (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 17:35:35 -0500
Received: (qmail 25316 invoked by uid 109); 28 Feb 2017 21:37:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 21:37:28 +0000
Received: (qmail 31251 invoked by uid 111); 28 Feb 2017 21:37:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 16:37:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Feb 2017 16:37:26 -0500
Date:   Tue, 28 Feb 2017 16:37:26 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 4/8] interpret_branch_name: allow callers to restrict
 expansions
Message-ID: <20170228213726.3gvwomlpn2ukdcfl@sigill.intra.peff.net>
References: <20170228120633.zkwfqms57fk7dkl5@sigill.intra.peff.net>
 <20170228121434.2dhngs4peq5acic2@sigill.intra.peff.net>
 <xmqqr32ijc1q.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr32ijc1q.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 28, 2017 at 12:27:45PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The original purpose of interpret_branch_name() was to be used by
> > get_sha1() in resolving refs.  As such, some of its expansions may
> > point to refs outside of the local "refs/heads" namespace.
> 
> I am not sure the reference to "get_sha1()" is entirely correct.
> 
> Until it was renamed at 431b1969fc ("Rename interpret/substitute
> nth_last_branch functions", 2009-03-21), the function was called
> interpret_nth_last_branch() which was originally introduced for the
> name, not sha1, at ae5a6c3684 ("checkout: implement "@{-N}" shortcut
> name for N-th last branch", 2009-01-17).  The use of the same syntax
> and function for the object name came a bit later.
> 
> But I think that is an insignificant detail.  Let's read on.

Yeah, sorry, I was lazy about digging up the history. I think the
problem actually started in ae0ba8e20a (Teach @{upstream} syntax to
strbuf_branchanme(), 2010-01-19), when the features were ported over
from get_sha1() to interpret_branch_name().

Since I need to re-roll anyway, I'll tweak this to be more accurate.

> > @@ -405,7 +405,7 @@ int refname_match(const char *abbrev_name, const char *full_name)
> >  static char *substitute_branch_name(const char **string, int *len)
> >  {
> >  	struct strbuf buf = STRBUF_INIT;
> > -	int ret = interpret_branch_name(*string, *len, &buf);
> > +	int ret = interpret_branch_name(*string, *len, &buf, 0);
> >  
> >  	if (ret == *len) {
> >  		size_t size;
> 
> This is the one used by dwim_ref/log, so we'd need to allow it to
> resolve to anything, e.g. "@" -> "HEAD", and pretend that the user
> typed that expansion.  OK.

Yeah. Left them all as "0" here, and then split the updates into their
own commits. So there's no commit that says "and we are leaving this
spot, because it is correct as-is". The other notable one is the
strbuf_branchname() call in merge_name().

I can mention those in the commit message here (I think I did in the
cover letter, but it would be nice to stick it in the history, since
that will be what comes up if you blame those lines).

-Peff

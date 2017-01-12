Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7701520756
	for <e@80x24.org>; Thu, 12 Jan 2017 06:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750734AbdALG7v (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 01:59:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:38266 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750723AbdALG7v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 01:59:51 -0500
Received: (qmail 9994 invoked by uid 109); 12 Jan 2017 06:59:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 Jan 2017 06:59:49 +0000
Received: (qmail 27725 invoked by uid 111); 12 Jan 2017 07:00:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 Jan 2017 02:00:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Jan 2017 01:59:47 -0500
Date:   Thu, 12 Jan 2017 01:59:47 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 3/2] vreportf: add prefix to each line
Message-ID: <20170112065947.qgukcozdi333yqgi@sigill.intra.peff.net>
References: <20170111140138.5p647xuqpqrej63b@sigill.intra.peff.net>
 <20170111140758.yyfsc3r3spqpi6es@sigill.intra.peff.net>
 <xmqqpojtmeld.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpojtmeld.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 11, 2017 at 02:11:42PM -0800, Junio C Hamano wrote:

> > It's actually kind of ugly.  For instance, a failing test in
> > t3600 now produces:
> >
> >    error: the following files have staged content different from both the
> >    error: file and the HEAD:
> >    error:     bar.txt
> >    error:     foo.txt
> >    error: (use -f to force removal)
> >
> > which seems a bit aggressive.  
> 
> I agree that it is ugly, but one reason I was hoping to do this
> myself (or have somebody else do it by procrastinating) was that I
> thought it may help i18n.  That is, for an original
> 
> 	error(_("we found an error"))
> 
> a .po file may translate the string to a multi-line string that has
> LFs in it and the output would look correct.  The translator already
> can do so by indenting the second and subsequent lines by the same
> column-width as "error: " (or its translation in their language, if
> we are going to i18n these headers), but that (1) is extra work for
> them, and (2) makes it impossible to have the same message appear in
> different contexts (i.e. "error:" vs "warning:" that have different
> column-widths).

Yes, I agree that would be a functional benefit. I'm just hoping we can
do it in a way that is visually pleasing.

> > It also screws up messages which indent with tabs (the prefix eats
> > up some of the tabstop, making the indentation smaller).
> 
> This is unavoidable and at the same time is a non-issue, isn't it?
> Messages that indent the second and subsequent lines with tabs are
> compensating the lack of the multi-line support of vreportf(), which
> this RFC patch fixes.  They may need to be adjusted to the new world
> order, but that is a good thing.  New multi-line messages no longer
> have to worry about the prefix that is added only to the first line
> when continuing the message to multiple lines.

I'm not so sure it is just about compensating. Look at the message
quoted above. The original looks like:

  error: the following files have staged content different from both the
  file and the HEAD:
      bar.txt
      foo.txt
  (use -f to force removal)

The leading whitespace is visually separating the list of files, not
just from the line with "error:", but from the other lines.

Though I think if we replaced tabs with spaces in this instance, then
they would still be bumped relative to the rest of the text.

> > It may be possible to address some of that by using some
> > other kind of continuation marker (instead of just repeating
> > the prefix), and expanding initial tabs.
> 
> Yes indeed.  The "some other kind of continuation marker" could just
> be a run of spaces that fill the same column as the "error: " or
> other prefix given to the first line.

I tried that, along with several other variants, but it gets
confusing/ugly when mixed with indentation that is significant to the
line. For example, the t3600 message becomes:

  error: the following files have staged content different from both the
         file and the HEAD:
             bar.txt
             foo.txt
         (use -f to force removal)

Which is arguably better than what we have now, but still looks pretty
bad to me.

I wonder if it would help for the marker to end in a non-whitespace
character. Like:

  error: the following files have staged content different from both the
       :  file and the HEAD:
       :     bar.txt
       :     foo.txt
       : (use -f to force removal)

or something. The ":" is a bit sparse looking. Maybe there are better
options. That does ruin line-by-line selection for cut-and-paste,
though.

So I dunno. I am open to ideas, but I didn't find one that I really
liked (this patch is actually a leftover from before Christmas, so I
don't even remember all the things I tried, just that I didn't like any
of them ;) ).

-Peff

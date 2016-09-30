Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0FC9207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 22:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933498AbcI3WNY (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 18:13:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:50685 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751147AbcI3WNW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 18:13:22 -0400
Received: (qmail 9426 invoked by uid 109); 30 Sep 2016 22:13:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Sep 2016 22:13:21 +0000
Received: (qmail 14379 invoked by uid 111); 30 Sep 2016 22:13:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Sep 2016 18:13:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Sep 2016 18:13:19 -0400
Date:   Fri, 30 Sep 2016 18:13:19 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, David Turner <dturner@twosigma.com>
Subject: Re: [PATCH 3/6] tmp-objdir: introduce API for temporary object
 directories
Message-ID: <20160930221319.a6dwhqarcj4v7vwu@sigill.intra.peff.net>
References: <20160930193533.ynbepaago6oycg5t@sigill.intra.peff.net>
 <20160930193613.dwpjiw5xps6a3wgj@sigill.intra.peff.net>
 <xmqqponl84h4.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqponl84h4.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 30, 2016 at 02:25:43PM -0700, Junio C Hamano wrote:

> > +void add_to_alternates_internal(const char *reference)
> > +{
> > +	prepare_alt_odb();
> > +	link_alt_odb_entries(reference, strlen(reference), '\n', NULL, 0);
> > +}
> > +
> 
> A function _internal being extern felt a bit funny.  We are only
> appending so the first one does not have to be reprepare.

It's a match for add_to_alternates_file(). Suggestions for a better word
are welcome.

We do need to prepare_alt_odb(), as that is what sets up the
alt_odb_tail pointer. And also, a later prepare() call would overwrite
our entry.  We could refactor the alt_odb code, but it seemed simplest
to just make sure we don't add to an unprepared list.

> > +	t = xmalloc(sizeof(*t));
> > +	strbuf_init(&t->path, 0);
> > +	argv_array_init(&t->env);
> > +
> > +	strbuf_addf(&t->path, "%s/incoming-XXXXXX", get_object_directory());
> 
> I was wondering where you would put this in.  Inside .git/objects/
> sounds good.

The name "incoming" is kind of arbitrary and related to the fact that
this is used for receive-pack (though if we were to use it on the
fetching side, I think it would be equally correct). I don't think it
really matters in practice.

> > +static int pack_copy_priority(const char *name)
> > +{
> > +	if (!starts_with(name, "pack"))
> > +		return 0;
> > +	if (ends_with(name, ".keep"))
> > +		return 1;
> > +	if (ends_with(name, ".pack"))
> > +		return 2;
> > +	if (ends_with(name, ".idx"))
> > +		return 3;
> > +	return 4;
> > +}
> 
> Thanks for being careful.  A blind "cp -r" would have ruined the
> day.
> 
> We do not do bitmaps upon receiving, I guess.

But we don't, but they (and anything else) would just sort at the end,
which is OK.

> > + *	struct tmp_objdir *t = tmp_objdir_create();
> > + *	if (!run_command_v_opt_cd_env(cmd, 0, NULL, tmp_objdir_env(t)) &&
> > + *	    !tmp_objdir_migrate(t))
> > + *		printf("success!\n");
> > + *	else
> > + *		die("failed...tmp_objdir will clean up for us");
> 
> Made me briefly wonder if a caller might want to use appropriate
> environment to use the tmp-objdir given by the API in addition to
> its own, but then such a caller just needs to prepare its own argv-array
> and concatenate tmp_objdir_env() before making the opt_cd_env call,
> so this is perfectly fine.

Yep, and that's exactly what happens in one spot of the next patch.
My original had just open-coded, but I was happy to see we have
argv_array_pushv() these days, so it's a one-liner.

In the very original version, the receive-pack process did not need to
access the new objects at all (not until ref update time anyway, at
which point they've been migrated). And that's why the environment is
intentionally kept separate, and the caller can feed it to whichever
sub-programs it chooses. But a later version of git that handled shallow
pushes required receive-pack to actually look at the objects, and I
added the add_to_alternates_internal() call you see here.

At that point, it does make me wonder if a better interface would be for
tmp_objdir to just set up the environment variables in the parent
process in the first place, and then restore them upon
tmp_objdir_destroy(). It makes things a bit more automatic, which makes
me hesitate, but I think it would be fine for receive-pack.

I dunno. I mostly left it alone because I did it this way long ago, and
it wasn't broke. Polishing for upstream is an opportunity to fix old
oddities, but I think there is some value in applying a more
battle-tested patch.

-Peff


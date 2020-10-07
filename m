Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2E9C4363C
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 19:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7295C207EA
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 19:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbgJGTs0 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 7 Oct 2020 15:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbgJGTs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 15:48:26 -0400
Received: from mx.pao1.isc.org (mx.pao1.isc.org [IPv6:2001:4f8:0:2::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD26C061755
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 12:48:26 -0700 (PDT)
Received: from zmx1.isc.org (zmx1.isc.org [149.20.0.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.pao1.isc.org (Postfix) with ESMTPS id B07743AB0CA;
        Wed,  7 Oct 2020 19:48:25 +0000 (UTC)
Received: from zmx1.isc.org (localhost [127.0.0.1])
        by zmx1.isc.org (Postfix) with ESMTPS id A56AE16005B;
        Wed,  7 Oct 2020 19:48:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zmx1.isc.org (Postfix) with ESMTP id 95C23160085;
        Wed,  7 Oct 2020 19:48:25 +0000 (UTC)
Received: from zmx1.isc.org ([127.0.0.1])
        by localhost (zmx1.isc.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ny1IYwKy3GZJ; Wed,  7 Oct 2020 19:48:25 +0000 (UTC)
Received: from larwa.hq.kempniu.pl (unknown [212.180.223.213])
        by zmx1.isc.org (Postfix) with ESMTPSA id CD15716005B;
        Wed,  7 Oct 2020 19:48:24 +0000 (UTC)
Date:   Wed, 7 Oct 2020 21:48:21 +0200
From:   =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] diff: add -I<regex> that ignores matching changes
Message-ID: <20201007194821.GA20549@larwa.hq.kempniu.pl>
References: <20201001120606.25773-1-michal@isc.org>
 <20201001120606.25773-2-michal@isc.org>
 <xmqqy2kpbye9.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy2kpbye9.fsf@gitster.c.googlers.com>
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Apart from adding a new field to struct diff_options, also define a new
> > flag, XDF_IGNORE_REGEX, for the 'xdl_opts' field of that structure.
> > This is done because the xpparam_t structure (which is used for passing
> > around the regular expression supplied to -I) is not zeroed out in all
> > call stacks involving xdl_diff() and thus only performing a NULL check
> > on xpp->ignore_regex could result in xdl_mark_ignorable_regex() treating
> > garbage on the stack as a regular expression.  As the 'flags' field of
> > xpparam_t is initialized in all call stacks involving xdl_diff(), adding
> > a flag check avoids that problem.
> 
> You mentioned in your cover letter about this, and I tend to agree
> that this feels like a hack, at least from the first glance.  The
> next feature that wants to have an optional pointer in xpparam_t and
> have the code behave differently with the data pointed by it would
> need to waste another bit the same way.

Agreed.

> Do you already know (read:
> I am not asking you to dig to find out immediately---just asking if
> you already know the answer) if there is an inherent reason why they
> cannot be memset(0) before use?  It seems like a much better
> approach to ensure that we clear the structure.

I do not know of any reason for xpparam_t structures to not be
zero-initialized.  In fact, they _are_ zero-initialized most of the
time; AFAICT, there are just three places in the tree in which they are
not.

Would you like me to address that in a separate patch in this patch
series?

> Doesn't existing
> anchors array share the same issue (at least anchors_nr must be
> cleared if there is no interesting anchors) already?  IOW, should
> "git grep anchors_nr" be a valid way to identify _all_ places where
> you need to clear the ignore_regex field?

Yes, the 'anchors' and 'anchors_nr' fields of xpparam_t are also
affected by the same problem, but the symptoms are more benign in their
case because these fields are only used in xdiff/xpatience.c, i.e. when
XDF_PATIENCE_DIFF is set in 'flags' - and as I already mentioned in
commit messages, that field is always initialized properly, so there is
currently no practical possibility of stack garbage being interpreted as
e.g. a pointer to the anchor array.

> > +-I<regex>::
> > +	Ignore changes whose all lines match <regex>.
> > +
> 
> The implementation seems to allow only one regex, but I suspect we'd
> want to mimic
> 
>     $ printf "%s\n" a a a >test_a
>     $ printf "%s\n" b b b >test_b
>     $ diff -Ia     test_a test_b
>     $ diff     -Ib test_a test_b
>     $ diff -Ia -Ib test_a test_b

Ah, sure.  After skimming through various man pages available online, I
was not sure whether all standalone versions of diff which support -I
allow that switch to be used multiple times and I thought it would be
better to start with the simplest thing possible.  If you would rather
have the above implemented immediately, I can sure try that in v2.

> and until that happens, the explanation needs to say something about
> earlier <regex> being discarded when this option is given more than
> once.

Sorry, where do I look for that explanation?  I tried to make -I behave
similarly to -G and -S, each of which can be specified more than once,
but the last value provided overrides the earlier ones - and I could not
find any mention of that behavior in the docs.  Please help?

> > @@ -5203,6 +5205,17 @@ static int diff_opt_patience(const struct option *opt,
> >  	return 0;
> >  }
> >  
> > +static int diff_opt_ignore_regex(const struct option *opt,
> > +				 const char *arg, int unset)
> > +{
> > +	struct diff_options *options = opt->value;
> > +
> > +	BUG_ON_OPT_NEG(unset);
> > +	options->xdl_opts |= XDF_IGNORE_REGEX;
> > +	options->ignore_regex = arg;
> 
> When given twice or more, the earlier value gets lost (it does not
> leak, luckily, though).

Right, as I mentioned above, I just wanted to start with something
simple that resembles -G/-S.  I will revise this part in v2 if you would
like to see support for multiple regular expressions in this patch
series.

> > +	return 0;
> > +}
> 
> If we somehow can lose the use of XDF_IGNORE_REGEX bit, we do not
> have to have this as a callback.  Instead, it can be OPT_STRING with
> the current semantics of "only the last one is used", or we can use
> OPT_STRING_LIST to keep all the expressions.

I see, thanks for the hints!

> On the other hand, I wonder if it would be a valid approach to make
> the new field(s) in diff_options a "regex_t *ignore_regex" (and add
> an "int ignore_regex_nr" next to it, if we shoot for multiple -I
> options), instead of "const char *".  For that, we would need a
> callback even without XDF_IGNORE_REGEX bit having to futz with
> xdl_opts field.
> 
> Doing so would give us a chance to compile and notice a malformed
> regular expression in diff.c, before it hits xdiff/ layer, which may
> or may not be a good thing.

I have not thought about this approach before, but it sounds elegant to
me, at least at first glance - option parsing code sounds like the right
place for sanitizing user-provided parameters.  Doubly so if we take the
multiple -I options approach.  I will try this in v2.

> > @@ -1019,6 +1019,39 @@ static void xdl_mark_ignorable(xdchange_t *xscr, xdfenv_t *xe, long flags)
> >  	}
> >  }
> 
> I agree with what you said in the cover letter that it would be a
> good idea to name the existing xdl_mark_ignorable() and the new one
> in such a way that they look similar and parallel, by renaming the
> former to xdl_mark_ignorable_lines or something.

Then I will do that in v2.  Separate patch?

> > +static void
> > +xdl_mark_ignorable_regex(xdchange_t *xscr, const xdfenv_t *xe,
> > +			 const char *ignore_regex)
> 
> I know some coding standard do chomp line immediately before the
> function name (I grew up with one), but that is not what this
> project uses, and judging from the surrounding code, it is not what
> the upstream xdiff source we borrowed uses, either.

Oh, right, sorry - force of habit.  I will fix this in v2.

> > +{
> > +	xdchange_t *xch;
> > +	regex_t regex;
> > +
> > +	if (regcomp(&regex, ignore_regex, REG_EXTENDED | REG_NEWLINE))
> > +		die("invalid regex: %s", ignore_regex);
> 
> If we compile in diff.c layer and pass regex_t down here, we won't
> have to fail here this deep in the callchain.

Agreed - I already responded to this remark above.

> > +	for (xch = xscr; xch; xch = xch->next) {
> > +		regmatch_t regmatch;
> > +		xrecord_t **rec;
> > +		int ignore = 1;
> > +		long i;
> > +
> > +		rec = &xe->xdf1.recs[xch->i1];
> > +		for (i = 0; i < xch->chg1 && ignore; i++)
> > +			ignore = !regexec_buf(&regex, rec[i]->ptr, rec[i]->size,
> > +					      1, &regmatch, 0);
> > +		rec = &xe->xdf2.recs[xch->i2];
> > +		for (i = 0; i < xch->chg2 && ignore; i++)
> > +			ignore = !regexec_buf(&regex, rec[i]->ptr, rec[i]->size,
> > +					      1, &regmatch, 0);
> > +
> > +		/*
> > +		 * Do not override --ignore-blank-lines.
> > +		 */
> > +		xch->ignore |= ignore;
> 
> Well, you could optimize out the whole regexp matching by adding
> 
> 		if (xch->ignore)
> 			continue;
> 
> before the two loops try to find a non-matching line, no?

Ah, of course, it looks so obvious now that you pointed it out :-)  I
guess I was copy-past^W^W^Wtrying to make xdl_mark_ignorable_regex()
look similar to xdl_mark_ignorable().  I will use your suggestion in v2.

> > +	}
> > +}
> > +
> >  int xdl_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
> >  	     xdemitconf_t const *xecfg, xdemitcb_t *ecb) {
> >  	xdchange_t *xscr;
> > @@ -1040,6 +1073,9 @@ int xdl_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
> >  		if (xpp->flags & XDF_IGNORE_BLANK_LINES)
> >  			xdl_mark_ignorable(xscr, &xe, xpp->flags);
> >  
> > +		if ((xpp->flags & XDF_IGNORE_REGEX) && xpp->ignore_regex)
> > +			xdl_mark_ignorable_regex(xscr, &xe, xpp->ignore_regex);
> > +
> >  		if (ef(&xe, xscr, ecb, xecfg) < 0) {
> >  
> >  			xdl_free_script(xscr);
> 
> Thanks for an exciting read ;-)

My pleasure ;-)  And thanks for taking a look.  Sorry about the long
turnaround time, but unfortunately this is the best I can do at the
moment.

-- 
Best regards,
Michał Kępień

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 002391FCA9
	for <e@80x24.org>; Tue, 13 Sep 2016 07:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751967AbcIMHuK (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 03:50:10 -0400
Received: from mail2.tiolive.com ([94.23.229.207]:41922 "EHLO
        mail2.tiolive.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751625AbcIMHuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 03:50:09 -0400
Received: from teco.navytux.spb.ru (pppoe.95-55-154-162.dynamic.avangarddsl.ru [95.55.154.162])
        by mail2.tiolive.com (Postfix) with ESMTPSA id 112BCBF0346;
        Tue, 13 Sep 2016 09:50:05 +0200 (CEST)
Received: from kirr by teco.navytux.spb.ru with local (Exim 4.87)
        (envelope-from <kirr@teco.navytux.spb.ru>)
        id 1bjiTl-0006It-6c; Tue, 13 Sep 2016 10:50:05 +0300
Date:   Tue, 13 Sep 2016 10:50:05 +0300
From:   Kirill Smelkov <kirr@nexedi.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Vicent Marti <tanoku@gmail.com>,
        =?iso-8859-1?Q?J=E9rome?= Perrin <jerome@nexedi.com>,
        Isabelle Vallet <isabelle.vallet@nexedi.com>,
        Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
        Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2 v8] pack-objects: respect
 --local/--honor-pack-keep/--incremental when bitmap is in use
Message-ID: <20160913075004.xlteg44fgtemkcwh@teco.navytux.spb.ru>
References: <20160910150110.18844-1-kirr@nexedi.com>
 <xmqqd1k8wc6h.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd1k8wc6h.fsf@gitster.mtv.corp.google.com>
User-Agent: NeoMutt/ (1.7.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 12, 2016 at 11:23:18PM -0700, Junio C Hamano wrote:
> Kirill Smelkov <kirr@nexedi.com> writes:
> 
> > +static int want_found_object(int exclude, struct packed_git *p)
> > +{
> > +	if (exclude)
> > +		return 1;
> > +	if (incremental)
> > +		return 0;
> > +
> > +	/*
> > +	 * When asked to do --local (do not include an object that appears in a
> > +	 * pack we borrow from elsewhere) or --honor-pack-keep (do not include
> > +	 * an object that appears in a pack marked with .keep), finding a pack
> > +	 * that matches the criteria is sufficient for us to decide to omit it.
> > +	 * However, even if this pack does not satisfy the criteria, we need to
> > +	 * make sure no copy of this object appears in _any_ pack that makes us
> > +	 * to omit the object, so we need to check all the packs.
> > +	 *
> > +	 * We can however first check whether these options can possible matter;
> > +	 * if they do not matter we know we want the object in generated pack.
> > +	 * Otherwise, we signal "-1" at the end to tell the caller that we do
> > +	 * not know either way, and it needs to check more packs.
> > +	 */
> > +	if (!ignore_packed_keep &&
> > +	    (!local || !have_non_local_packs))
> > +		return 1;
> > +
> > +	if (local && !p->pack_local)
> > +		return 0;
> > +	if (ignore_packed_keep && p->pack_local && p->pack_keep)
> > +		return 0;
> > +
> > +	/* we don't know yet; keep looking for more packs */
> > +	return -1;
> > +}
> 
> Moving this logic out to this helper made the main logic in the
> caller easier to grasp.
> 
> > @@ -958,15 +993,30 @@ static int want_object_in_pack(const unsigned char *sha1,
> >  			       off_t *found_offset)
> >  {
> >  	struct packed_git *p;
> > +	int want;
> >  
> >  	if (!exclude && local && has_loose_object_nonlocal(sha1))
> >  		return 0;
> >  
> > +	/*
> > +	 * If we already know the pack object lives in, start checks from that
> > +	 * pack - in the usual case when neither --local was given nor .keep files
> > +	 * are present we will determine the answer right now.
> > +	 */
> > +	if (*found_pack) {
> > +		want = want_found_object(exclude, *found_pack);
> > +		if (want != -1)
> > +			return want;
> > +	}
> >  
> >  	for (p = packed_git; p; p = p->next) {
> > +		off_t offset;
> > +
> > +		if (p == *found_pack)
> > +			offset = *found_offset;
> > +		else
> > +			offset = find_pack_entry_one(sha1, p);
> > +
> >  		if (offset) {
> >  			if (!*found_pack) {
> >  				if (!is_pack_valid(p))
> > @@ -974,31 +1024,9 @@ static int want_object_in_pack(const unsigned char *sha1,
> >  				*found_offset = offset;
> >  				*found_pack = p;
> >  			}
> > +			want = want_found_object(exclude, p);
> > +			if (want != -1)
> > +				return want;
> >  		}
> >  	}
> 
> As Peff noted in his earlier review, however, MRU code needed to be
> grafted in to the caller (an update to the MRU list was done in the
> code that was moved to the want_found_object() helper).  I think I
> did it correctly, which ended up looking like this:
> 
>                 want = want_found_object(exclude, p);
>                 if (!exclude && want > 0)
>                         mru_mark(packed_git_mru, entry);
>                 if (want != -1)
>                         return want;
> 
> I somewhat feel that it is ugly that the helper knows about exclude
> (i.e. in the original code, we immediately returned 1 without
> futzing with the MRU when we find an entry that is to be excluded,
> which now is done in the helper), and the caller also knows about
> exclude (i.e. the caller knows that the helper may return positive
> in two cases, it knows that MRU marking needs to happen only one of
> the two cases, and it also knows that "exclude" is what
> differentiates between the two cases) at the same time.
> 
> But probably the reason why I feel it ugly is only because I knew
> how the original looked like.  I dunno.

Junio, the code above is correct semantic merge of pack-mru and my
topic, because in pack-mru if found and exclude=1, 1 was returned
without marking found pack.

But I wonder: even if we exclude an object, we were still looking for it
in packs, and when we found it, we found the corresponding pack too. So,
that pack _was_ most-recently-used, and it is correct to mark it as MRU.

We can do the simplification in the follow-up patch after the merge, so
merge does not change semantics and it is all bisectable, etc.

Jeff?

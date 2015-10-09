From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 0/1] merge: fix cache_entry use-after-free
Date: Fri, 09 Oct 2015 18:16:03 -0400
Organization: Twitter
Message-ID: <1444428963.8836.36.camel@twopensource.com>
References: <1444330071-8909-1-git-send-email-dturner@twitter.com>
	 <1444330071-8909-2-git-send-email-dturner@twitter.com>
	 <xmqqmvvtqgei.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 10 00:16:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkfxV-0004tf-Of
	for gcvg-git-2@plane.gmane.org; Sat, 10 Oct 2015 00:16:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757599AbbJIWQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2015 18:16:09 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:34011 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757565AbbJIWQH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2015 18:16:07 -0400
Received: by qgez77 with SMTP id z77so81166322qge.1
        for <git@vger.kernel.org>; Fri, 09 Oct 2015 15:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=WQC+Pmt1zPCJ79IioJS1xnyTqBMcPVlytyB6C9iWU50=;
        b=JH7OrvDsfS1rWmt/1qCRx/hnI2VLUreCOjQIPEAPz7TRvteT76ltHLXiFOJZi0CeyG
         Sdz0DqRH4oohJrVvFr870sWA+vZ+DOGBPDIrJRd/HJozOtcxLkSIUzCjvq/ZDGS8URTB
         AXN0hcPyggFt6vtcMnCkLIxhg3JGD2QqueQ9iMx3PG03sInu0e6LQKZksp9x57wwbSI0
         5vOn1UuCWywqR0AQ4fTWMhgoRVrfFJ1fXjDEXxYc4A1mMHppZCDhCyt0JhsLgg2WE7T2
         g8Vx3fmX8qz+H3kIcniYOzsqxD9jZwfN8SifW2NtCKesHPMVBN8bN1ZY5Vd5ENQ099Qc
         LH3w==
X-Gm-Message-State: ALoCoQkonuQ9kTL55LS/Y6LNOWI4AM8U5/X3TzZ8IJnInTBCujZKITDC5VHdM6BvBb+gqoldNhjE
X-Received: by 10.140.144.8 with SMTP id 8mr18549992qhq.54.1444428965693;
        Fri, 09 Oct 2015 15:16:05 -0700 (PDT)
Received: from ubuntu ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id c2sm1600027qkh.6.2015.10.09.15.16.04
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Oct 2015 15:16:04 -0700 (PDT)
In-Reply-To: <xmqqmvvtqgei.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279319>

+Duy Nguyen, who knows the split index better.

On Thu, 2015-10-08 at 13:00 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > From: Keith McGuigan <kmcguigan@twitter.com>
> >
> > During merges, we would previously free entries that we no longer need
> > in the destination index.  But those entries might also be stored in
> > the dir_entry cache, and when a later call to add_to_index found them,
> > they would be used after being freed.
> >
> > To prevent this, add a ref count for struct cache_entry.  Whenever
> > a cache entry is added to a data structure, the ref count is incremented;
> > when it is removed from the data structure, it is decremented.  When
> > it hits zero, the cache_entry is freed.
> >
> > Signed-off-by: David Turner <dturner@twopensource.com>
> > Signed-off-by: Keith McGuigan <kmcguigan@twitter.com>
> > ---
> 
> Thanks.
> 
> > @@ -213,6 +214,32 @@ struct cache_entry {
> >  struct pathspec;
> >  
> >  /*
> > + * Increment the cache_entry reference count.  Should be called
> > + * whenever a pointer to a cache_entry is retained in a data structure,
> > + * thus marking it as alive.
> > + */
> > +static inline void add_ce_ref(struct cache_entry *ce)
> > +{
> > +	assert(ce != NULL && ce->ref_count >= 0);
> > +	++ce->ref_count;
> > +}
> 
> We tend to prefer post-increment when the distinction between pre-
> or post- does not make any difference, which is the case here.

Will fix.

> > diff --git a/name-hash.c b/name-hash.c
> > index 702cd05..f12c919 100644
> > --- a/name-hash.c
> > +++ b/name-hash.c
> > @@ -92,7 +93,9 @@ static void remove_dir_entry(struct index_state *istate, struct cache_entry *ce)
> >  	struct dir_entry *dir = hash_dir_entry(istate, ce, ce_namelen(ce));
> >  	while (dir && !(--dir->nr)) {
> >  		struct dir_entry *parent = dir->parent;
> > -		hashmap_remove(&istate->dir_hash, dir, NULL);
> > +		struct dir_entry *removed = hashmap_remove(&istate->dir_hash, dir, NULL);
> > +		assert(removed == dir);
> > +		drop_ce_ref(dir->ce);
> 
> This is curious.  In remove_name_hash() you do not have the
> corresponding assert.  Why is it necessary here (or is it
> unnecessary over there)?

It is unnecessary in any case: it's an assert rather than a check for an
expected (or even unexpected) case.  That just happens to be where Keith
first managed to track down the use-after free, so that's where he
happened to put the assert while trying to debug it.  I'm in general in
favor of more asserts rather than fewer, so I would prefer to keep it
in.  But I can remove it if you like.

> > @@ -147,6 +151,7 @@ void remove_name_hash(struct index_state *istate, struct cache_entry *ce)
> >  		return;
> >  	ce->ce_flags &= ~CE_HASHED;
> >  	hashmap_remove(&istate->name_hash, ce, ce);
> > +	drop_ce_ref(ce);
> >  
> >  	if (ignore_case)
> >  		remove_dir_entry(istate, ce);
> > diff --git a/read-cache.c b/read-cache.c
> > index 87204a5..442de34 100644
> > --- a/read-cache.c
> > +++ b/read-cache.c
> > @@ -53,6 +53,7 @@ static const char *alternate_index_output;
> >  static void set_index_entry(struct index_state *istate, int nr, struct cache_entry *ce)
> >  {
> >  	istate->cache[nr] = ce;
> > +	add_ce_ref(ce);
> >  	add_name_hash(istate, ce);
> >  }
> 
> What happens to the existing entry that used to be istate->cache[nr],
> which may or may not be 'ce' that is replacing it?
> 
> It turns out that all three calling sites are safe, but it is not
> immediately obvious why.  Perhaps some comment in front of the
> function is in order, to warn those who may have to add a new caller
> or restructure the existing calling chain, that istate->cache[nr] is
> expected not to hold a live reference when the function is called,
> or something?

Happy to add it if you want, but to me it was clear without because if
there were a value in istate->cache[nr], that old value would be leaked.
Let me know.

> > @@ -314,8 +314,10 @@ void replace_index_entry_in_base(struct index_state *istate,
> >  	    istate->split_index->base &&
> >  	    old->index <= istate->split_index->base->cache_nr) {
> >  		new->index = old->index;
> > -		if (old != istate->split_index->base->cache[new->index - 1])
> > -			free(istate->split_index->base->cache[new->index - 1]);
> > +		if (old != istate->split_index->base->cache[new->index - 1]) {
> > +			struct cache_entry *ce = istate->split_index->base->cache[new->index - 1];
> > +			drop_ce_ref(ce);
> > +		}
> >  		istate->split_index->base->cache[new->index - 1] = new;
> 
> Does 'new' already have the right refcount at this point?

I spoke to Keith, and he thinks we do need an add_ce_ref there. I'll fix
that on the reroll.  Duy, do you agree?

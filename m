Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C3C51F461
	for <e@80x24.org>; Thu, 27 Jun 2019 21:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfF0VNI (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 17:13:08 -0400
Received: from resqmta-po-12v.sys.comcast.net ([96.114.154.171]:52270 "EHLO
        resqmta-po-12v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726513AbfF0VNE (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 27 Jun 2019 17:13:04 -0400
Received: from resomta-po-02v.sys.comcast.net ([96.114.154.226])
        by resqmta-po-12v.sys.comcast.net with ESMTP
        id gZQghZ2S9TbnXgbhWhqh4O; Thu, 27 Jun 2019 21:13:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1561669982;
        bh=vmo6Njrr3YWLP1/u5s1TgRSpTSlymo7xo8Ri5cFCyTA=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=GBLwYToStYf4RkOnSexG+NwLqRVChNijz+jvQshHKREcAQXGGKnmpB0/tqLTtJcCP
         QiXWL64zFKLx/WfiTjCUhvs6AUtSXPaRJ0LVetYdJ3H/y7jZqLQyrGkuy/cGmTud7R
         tofPbBxbh0nCi3NWccwbDria42EBAoWZDLOVkiHiAc/gkz5wJgQ3UtNdLdMDn28lM0
         FK4xA9+xMVlN7vterI5S5DOoLIy+CYR5AT31cJBkERZHPBOBS611hmYNmfOsvp54VN
         LRzwq9oapc/ZbG79Lm134Z3AYU6UjcHx9R+aa2Eh8a/P7bT0qJnCeK+KjoZ/cOws4T
         6UGR+RT8Gp5wA==
Received: from comcast.net ([IPv6:2620:15c:2ce:200:ac3b:83cd:e5c7:24f4])
        by resomta-po-02v.sys.comcast.net with ESMTPSA
        id gbhHhNEQPobG3gbhMhmWdD; Thu, 27 Jun 2019 21:13:00 +0000
X-Xfinity-VMeta: sc=0;st=legit
Date:   Thu, 27 Jun 2019 14:12:47 -0700
From:   Matthew DeVore <matvore@comcast.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     matvore@google.com, git@vger.kernel.org
Subject: Re: [PATCH v4 04/10] list-objects-filter: implement composite filters
Message-ID: <20190627211247.GB54617@comcast.net>
References: <47a2680875e6f68fbf1f2e5a5a2630d263cdf426.1560558910.git.matvore@google.com>
 <20190622002626.245441-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622002626.245441-1-jonathantanmy@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 21, 2019 at 05:26:26PM -0700, Jonathan Tan wrote:
> > Allow combining filters such that only objects accepted by all filters
> > are shown. The motivation for this is to allow getting directory
> > listings without also fetching blobs. This can be done by combining
> > blob:none with tree:<depth>. There are massive repositories that have
> > larger-than-expected trees - even if you include only a single commit.
> 
> First of all, patches 2 and 3 are straightforward and LGTM. On to patch
> 4...
> 
> [snip]
> 
> > The current usage requires passing the filter to rev-list in the
> > following form:
> > 
> > 	--filter=<FILTER1> --filter=<FILTER2> ...
> > 
> > Such usage is currently an error, so giving it a meaning is backwards-
> > compatible.
> > 
> > The URL-encoding scheme is being introduced before the repeated flag
> > logic, and the user-facing documentation for URL-encoding is being
> > withheld until the repeated flag feature is implemented. The
> > URL-encoding is in general not meant to be used directly by the user,
> > and it is better to describe the URL-encoding feature in terms of the
> > repeated flag.
> 
> As of this commit, we don't support such arguments passed to rev-list in
> this way, so I would write these paragraphs as:
> 
>   A combined filter supports any number of subfilters, and is written in
>   the following form:
> 
>     combine:<filter 1>+<filter 2>+<filter 3>
> 
>   Certain non-alphanumeric characters in each filter must be
>   URL-encoded.
> 
>   For now, combined filters must be specified in this form. In a
>   subsequent commit, rev-list will support multiple --filter arguments
>   which will have the same effect as specifying one filter argument
>   starting with "combine:".

Done, but I've amended your last paragraph to include the excuse about the
missing documentation:

    For now, combined filters must be specified in this form. In a
    subsequent commit, rev-list will support multiple --filter arguments
    which will have the same effect as specifying one filter argument
    starting with "combine:". The documentation will be updated in that
    commit, as the URL-encoding scheme is in general not meant to be used
    directly by the user, and it is better to describe the URL-encoding
    feature in terms of the repeated flag.

> > +
> > +	/* LOFC_COMBINE values */
> > +
> > +	/* This array contains all the subfilters which this filter combines. */
> > +	size_t sub_nr, sub_alloc;
> > +	struct list_objects_filter_options *sub;
> > +
> > +	/*
> > +	 * END choice-specific parsed values.
> > +	 */
> >  };
> 
> I still think it's cleaner to just have a "left subfilter" and "right
> subfilter", but I don't feel strongly about it. In any case, this is an
> internal detail and can always be changed in the future.
> 

Interesting. I think there are two reasonable ways of thinking about it:

a. we are parsing a nested left-associative binary expression, and it's
   helpful if the internal representation matches that semantic.  (Maybe
   this is what you're thinking?)

b. linked-lists are somewhat aberrational and should only be used in a
   very narrow class of code. Arrays are more universal and therefore more
   readable.

I'll keep it as-is for now since I don't see a great reason to revert it to the
previous style. Thank you for pointing this out - I *did* suspect there was a
big subjective factor to people's preference for the array form.

> > +	/*
> > +	 * Optional. If this function is supplied and the filter needs to
> > +	 * collect omits, then this function is called once before free_fn is
> > +	 * called.
> > +	 */
> > +	void (*finalize_omits_fn)(struct oidset *omits, void *filter_data);
> 
> This is needed because a combined filter's omits actually lie in the
> subfilters. Resolving it this way means that callers must call
> list_objects_filter__free() before using the omits set. Can you add
> documentation to __init() (which is the first function to take in the
> omits set) and __free() describing this?
> 
> (As stated in the test below, we cannot just share one omits set amongst
> all the subfilters - see filter_trees_update_omits and the call site
> that relies on its return value.)
> 

I documented __init as follows:

/*
 * Constructor for the set of defined list-objects filters.
 * The `omitted` set is optional. It is populated with objects that the
 * filter excludes. This set should not be considered finalized until
 * after list_objects_filter__free is called on the returned `struct
 * filter *`.
 */

And __free:

/*
 * Destroys `filter` and finalizes the `omitted` set, if present. Does
 * nothing if `filter` is null.
 */

And finalize_omits_fn (which has the internal specifics):

	/*
	 * Optional. If this function is supplied and the filter needs
	 * to collect omits, then this function is called once before
	 * free_fn is called.
	 *
	 * This is required because the following two conditions hold:
	 *
	 *   a. A tree filter can add and remove objects as an object
	 *      graph is traversed.
	 *   b. A combine filter's omit set is the union of all its
	 *      subfilters, which may include tree: filters.
	 *
	 * As such, the omits sets must be separate sets, and can only
	 * be unioned after the traversal is completed.
	 */

> Here comes the tricky part...
> 
> > +static int should_delegate(enum list_objects_filter_situation filter_situation,
> > +			   struct object *obj,
> > +			   struct subfilter *sub)
> > +{
> > +	if (!sub->is_skipping_tree)
> > +		return 1;
> > +	if (filter_situation == LOFS_END_TREE &&
> > +		oideq(&obj->oid, &sub->skip_tree)) {
> > +		sub->is_skipping_tree = 0;
> > +		return 1;
> > +	}
> > +	return 0;
> > +}
> 
> Optional: I think this should be called "test_and_set_skip_tree" or
> something like that, made to return the inverse of its current return
> value, and documented:
> 
>   Returns the value of sub->is_skipping_tree at the moment of
>   invocation. If iteration is at the LOFS_END_TREE of the tree currently
>   being skipped, first clears sub->is_skipping_tree before returning.
> 

That is not totally accurate, since in the second if block
(LOFS_END_TREE) we would return 0 even though is_skipping_tree starts
out as 1.

Since it's not equal to is_skipping_tree before invocation, I don't
think there is a better name to give it ATM.

So in the interest of removing "trickiness" I've inlined the function
(since there is no real way to express what it's doing in a function
name anyway) and I think it's more readable. This is the new callsite:

	/*
	 * Check and update is_skipping_tree before oidset_contains so
	 * that is_skipping_tree gets unset even when the object is
	 * marked as seen.  As of this writing, no filter uses
	 * LOFR_MARK_SEEN on trees that also uses LOFR_SKIP_TREE, so the
	 * ordering is only theoretically important. Be cautious if you
	 * change the order of the below checks and more filters have
	 * been added!
	 */
	if (sub->is_skipping_tree) {
		if (filter_situation == LOFS_END_TREE &&
		    oideq(&obj->oid, &sub->skip_tree))
			sub->is_skipping_tree = 0;
		else
			return LOFR_ZERO;
	}

Hopefully that's agreeable for everyone.

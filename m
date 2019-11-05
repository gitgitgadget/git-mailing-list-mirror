Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3BDF1F454
	for <e@80x24.org>; Tue,  5 Nov 2019 04:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387416AbfKEEhv (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 23:37:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:38960 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726640AbfKEEhu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 23:37:50 -0500
Received: (qmail 7984 invoked by uid 109); 5 Nov 2019 04:37:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Nov 2019 04:37:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8541 invoked by uid 111); 5 Nov 2019 04:41:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 Nov 2019 23:41:07 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 4 Nov 2019 23:37:49 -0500
From:   Jeff King <peff@peff.net>
To:     Davide Berardi <davide.berardi6@unibo.it>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v2] clone: Don't segfault on -b specifing a non-commit
Message-ID: <20191105043749.GA27601@sigill.intra.peff.net>
References: <20191101002432.GA49846@carpenter.lan>
 <20191103180716.GA72007@carpenter.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191103180716.GA72007@carpenter.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 03, 2019 at 06:07:18PM +0000, Davide Berardi wrote:

> -static void update_head(const struct ref *our, const struct ref *remote,
> +static struct commit *lookup_commit_helper(const struct ref *our,
> +					   const struct ref *remote,
> +					   const char *msg, int *err)
> +{
> +	const struct object_id *tip = NULL;
> +	struct commit *tip_commit = NULL;
> +
> +	if (our)
> +		tip = &our->old_oid;
> +	else if (remote)
> +		tip = &remote->old_oid;
> +
> +	if (!tip)
> +		return NULL;
> +
> +	tip_commit = lookup_commit_reference_gently_err(the_repository, tip, 1, err);
> +	if (!tip_commit) {
> +		/*
> +		 * The given non-commit cannot be checked out,
> +		 * so have a 'master' branch and leave it unborn.
> +		 */
> +		warning(_("non-commit cannot be checked out"));
> +		create_symref("HEAD", "refs/heads/master", msg);
> +		return NULL;
> +	}
> +
> +	return tip_commit;
> +}

I like the logic flow in this function, which is IMHO clearer than the
existing code. But the "err" thing puzzled me for a moment. I think you
are trying to tell the difference between the case that both "our" and
"remote" are NULL, and the case that we saw a non-commit. In either case
we return NULL, but only one is an error.

But:

  - I don't think that logic needs to extend down into
    lookup_commit_reference_gently(); a NULL return from it would always
    be an error, wouldn't it?

  - we could probably simplify this by just inlining it into
    update_head(). Something like:

      if (our)
              tip = &our->old_oid;
      else if (remote)
              tip = &remote->old_oid;

      if (!tip) {
	      /*
	       * We have no local branch requested with "-b", and the
	       * remote HEAD is unborn. There's nothing to update HEAD
	       * to, but this state is not an error.
	       */
              return 0;
      }

      tip_commit = lookup_commit_reference_gently(...);
      if (!tip_commit) {
              /*
	       * The given non-commit cannot be checked out, etc...
	       */
	      warning(...);
	      create_symref(...);
	      return -1;
      }

      ...and then existing code to use tip_commit...

      /*
       * we'd always return 0 here, because our update_ref calls die on
       * error
       */
      return 0;

> @@ -1268,8 +1303,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	}
>  
>  	junk_mode = JUNK_LEAVE_REPO;
> -	fetch_if_missing = 1;
> -	err = checkout(submodule_progress);
> +	if (!err) {
> +		fetch_if_missing = 1;
> +		err = checkout(submodule_progress);
> +	}

This part makes sense. We might want an explanatory comment along the
lines of:

  /*
   * Only try to checkout if we successfully updated HEAD; otherwise
   * HEAD isn't pointing to the thing the user wanted.
   /
   if (!err) {
       ...
   

> -struct commit *lookup_commit_reference_gently(struct repository *r,
> -		const struct object_id *oid, int quiet)
> +struct commit *lookup_commit_reference_gently_err(struct repository *r,
> +		const struct object_id *oid, int quiet, int *err)

And this part I think could just go away, if you take my suggestion
above.

> diff --git a/t/t5609-clone-branch.sh b/t/t5609-clone-branch.sh
> index 6e7a7be052..d57f750eeb 100755
> --- a/t/t5609-clone-branch.sh
> +++ b/t/t5609-clone-branch.sh
> @@ -20,7 +20,10 @@ test_expect_success 'setup' '
>  	 echo one >file && git add file && git commit -m one &&
>  	 git checkout -b two &&
>  	 echo two >file && git add file && git commit -m two &&
> -	 git checkout master) &&
> +	 git checkout master &&
> +	 blob=$(git rev-parse HEAD:file)  &&
> +	 echo $blob > .git/refs/heads/broken-tag &&
> +	 echo $blob > .git/refs/heads/broken-head) &&

Minor style nit, but we usually avoid the space after ">".

> +test_expect_success 'clone -b with a non-commit tag must fallback' '
> +	test_must_fail git clone -b broken-tag parent clone-broken-tag &&
> +	(cd clone-broken-tag &&
> +	 check_HEAD master)
> +'
> +test_expect_success 'clone -b with a non-commit head must fallback' '
> +	test_must_fail git clone -b broken-head parent clone-broken-head &&
> +	(cd clone-broken-head &&
> +	 check_HEAD master)
> +'

OK, this second one covers the first conditional from update_head():

  if (our && skip_prefix(our->name, "refs/heads/", &head)) {

and the first one covers the second conditional:

  } else if (our) {

Should we cover the third conditional, too?

I think it would be the case that the remote HEAD is pointing to a
non-commit (since that's a corrupt repository, it might make sense
create a separate sub-repository).

-Peff

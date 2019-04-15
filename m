Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C78120248
	for <e@80x24.org>; Mon, 15 Apr 2019 22:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbfDOWBL (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 18:01:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:59190 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725804AbfDOWBL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 18:01:11 -0400
Received: (qmail 2528 invoked by uid 109); 15 Apr 2019 22:01:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 15 Apr 2019 22:01:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6431 invoked by uid 111); 15 Apr 2019 22:01:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 15 Apr 2019 18:01:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Apr 2019 18:01:08 -0400
Date:   Mon, 15 Apr 2019 18:01:08 -0400
From:   Jeff King <peff@peff.net>
To:     Damien Robert <damien.olivier.robert@gmail.com>
Cc:     git@vger.kernel.org,
        Damien Robert <damien.olivier.robert+git@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 1/1] Fix %(push:track) in ref-filter
Message-ID: <20190415220108.GD28128@sigill.intra.peff.net>
References: <20190415210416.7525-1-damien.olivier.robert+git@gmail.com>
 <20190415210416.7525-2-damien.olivier.robert+git@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190415210416.7525-2-damien.olivier.robert+git@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 15, 2019 at 11:04:16PM +0200, Damien Robert wrote:

> In ref-filter.c, when processing the atom %(push:track), the
> ahead/behind values are computed using `stat_tracking_info` which refers
> to the upstream branch.

Good catch. I think this has been broken since %(push) was added in
29bc88505f (for-each-ref: accept "%(push)" format, 2015-05-21). I don't
actually use the track option, so I never noticed.

> Fix that by introducing a new function `stat_push_info` in remote.c
> (exported in remote.h), which does the same thing but for the push
> branch. Factorise the ahead/behind computation of `stat_tracking_info` into
> `stat_compare_info` so that it can be reused for `stat_push_info`.

Makes sense.

> This bug was not detected in t/t6300-for-each-ref.sh because in the test
> for push:track, both the upstream and the push branch were ahead by 1.
> Change the test so that the upstream branch is ahead by 2 while the push
> branch is ahead by 1, this allow us to test that %(push:track) refer to
> the correct branch.

Nice. I wish all patches were this careful about thinking through
details like this.

> diff --git a/ref-filter.c b/ref-filter.c
> index 3aca105307..82e277222b 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1391,8 +1391,11 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
>  	if (atom->u.remote_ref.option == RR_REF)
>  		*s = show_ref(&atom->u.remote_ref.refname, refname);
>  	else if (atom->u.remote_ref.option == RR_TRACK) {
> -		if (stat_tracking_info(branch, &num_ours, &num_theirs,
> -				       NULL, AHEAD_BEHIND_FULL) < 0) {
> +		if ((atom->u.remote_ref.push ?
> +		     stat_push_info(branch, &num_ours, &num_theirs,
> +				    NULL, AHEAD_BEHIND_FULL) :
> +		     stat_tracking_info(branch, &num_ours, &num_theirs,
> +					NULL, AHEAD_BEHIND_FULL)) < 0) {
>  			*s = xstrdup(msgs.gone);
>  		} else if (!num_ours && !num_theirs)

I'm a big fan of the "?" operator, but this ternary-within-an-if might
be pushing even my boundaries of taste. :) I wonder if it would be more
readable as:

  int ret;
  if (atom->u.remote_ref.push)
	stat_push_info(...);
  else
	stat_tracking_info(...);
  if (ret < 0)
	... gone ...
  else if (!num_ours && !num_theirs)
	... etc ...

I'd even be OK with a ternary for assigning "ret". :)

All that said, we would need to do the exact same conditional for
":trackshort", wouldn't we? The tests don't pick it up because the
symbol is still ">" for both branches (deja vu!). So it might be worth
not just having push be 2 ahead, but have it actually be behind instead
(or in addition to).

So since we have to do it twice, maybe that makes it worth factoring
out something like:

  int stat_remote_ref(struct used_atom *atom, struct branch *branch,
                      int *num_ours, int *num_theirs)
  {
        if (atom->u.remote_ref.push)
                return stat_push_info(branch, &num_ours, &num_theirs,
                                      NULL, AHEAD_BEHIND_FULL);
        else
                return stat_tracking_info(branch, &num_ours, &num_theirs,
                                          NULL, AHEAD_BEHIND_FULL);
  }

Or perhaps it argues for just giving access to the more generic stat_*
function, and letting callers pass in a flag for push vs upstream (and
either leaving stat_tracking_info() as a wrapper, or just updating its
few callers).

> -int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
> -		       const char **upstream_name, enum ahead_behind_flags abf)
> +
> +int stat_compare_info(const char **branch_name, const char **base,
> +		      int *num_ours, int *num_theirs,
> +		      enum ahead_behind_flags abf)

In the original, we need a pointer-to-pointer for upstream_name, because
we return the string as an out-parameter. But here we're just taking two
strings as input. We can drop the extra layer of indirection, like the
patch below.

Also, since this is an internal helper function for the file, we should
mark it as static.

diff --git a/remote.c b/remote.c
index b2b37d1e8d..e6ca62dc19 100644
--- a/remote.c
+++ b/remote.c
@@ -1895,23 +1895,23 @@ int resolve_remote_symref(struct ref *ref, struct ref *list)
  * commits are different.
  */
 
-int stat_compare_info(const char **branch_name, const char **base,
-		      int *num_ours, int *num_theirs,
-		      enum ahead_behind_flags abf)
+static int stat_compare_info(const char *branch_name, const char *base,
+			     int *num_ours, int *num_theirs,
+			     enum ahead_behind_flags abf)
 {
 	struct object_id oid;
 	struct commit *ours, *theirs;
 	struct rev_info revs;
 	struct argv_array argv = ARGV_ARRAY_INIT;
 
 	/* Cannot stat if what we used to build on no longer exists */
-	if (read_ref(*base, &oid))
+	if (read_ref(base, &oid))
 		return -1;
 	theirs = lookup_commit_reference(the_repository, &oid);
 	if (!theirs)
 		return -1;
 
-	if (read_ref(*branch_name, &oid))
+	if (read_ref(branch_name, &oid))
 		return -1;
 	ours = lookup_commit_reference(the_repository, &oid);
 	if (!ours)
@@ -1987,7 +1987,7 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	if (!base)
 		return -1;
 
-	return stat_compare_info(&(branch->refname), &base, num_ours, num_theirs, abf);
+	return stat_compare_info(branch->refname, base, num_ours, num_theirs, abf);
 }
 
 /*
@@ -2006,7 +2006,7 @@ int stat_push_info(struct branch *branch, int *num_ours, int *num_theirs,
 	if (!base)
 		return -1;
 
-	return stat_compare_info(&(branch->refname), &base, num_ours, num_theirs, abf);
+	return stat_compare_info(branch->refname, base, num_ours, num_theirs, abf);
 }
 
 /*

Of course if you buy my argument above that we should just let
ref-filter call into the generic form of the function, then all of that
would change. :)

> [...]

Other than that, the patch looked quite reasonable. I didn't dig too far
into the ripple effects of the test changes, since I think we'll end up
changing them again to make sure ":trackshort" is distinct.

Thanks for working on this.

-Peff

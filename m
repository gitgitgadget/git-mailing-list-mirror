Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAA331FBEC
	for <e@80x24.org>; Mon,  6 Mar 2017 07:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752659AbdCFDyd (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Mar 2017 22:54:33 -0500
Received: from cloud.peff.net ([104.130.231.41]:38938 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752545AbdCFDxY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Mar 2017 22:53:24 -0500
Received: (qmail 1238 invoked by uid 109); 6 Mar 2017 03:46:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 06 Mar 2017 03:46:43 +0000
Received: (qmail 13619 invoked by uid 111); 6 Mar 2017 03:46:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 05 Mar 2017 22:46:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Mar 2017 22:46:40 -0500
Date:   Sun, 5 Mar 2017 22:46:40 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?QW5kcsOp?= Laszlo <andre@laszlo.nu>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] pull: do not segfault when HEAD refers to missing object
 file
Message-ID: <20170306034639.tji4s4m5mnzou2m2@sigill.intra.peff.net>
References: <20170305234222.4590-1-andre@laszlo.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170305234222.4590-1-andre@laszlo.nu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 06, 2017 at 12:42:22AM +0100, André Laszlo wrote:

> git pull --rebase on a corrupted HEAD used to segfault;it has been
> corrected to error out with a message. A test has also been added to
> verify this fix.

Your commit message mostly tells us the "what" that we can see from the
diff. But why are we segfaulting? What assumption is being violated, and
why is the fix the right thing?

You've stuck some of the details in your notes, and they should probably
make it into the commit message.

>     When add_head_to_pending fails to add a pending object, git pull
>     --rebase segfaults. This can happen if HEAD is referring to a corrupt
>     or missing object.

The other obvious time when HEAD is not valid is when you are on an
unborn branch. So we should also consider how such a case interacts with
the callsites you are touching.

I think it is primarily this hunk:

> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -2252,6 +2252,11 @@ int has_uncommitted_changes(int ignore_submodules)
>  		DIFF_OPT_SET(&rev_info.diffopt, IGNORE_SUBMODULES);
>  	DIFF_OPT_SET(&rev_info.diffopt, QUICK);
>  	add_head_to_pending(&rev_info);
> +
> +	/* The add_head_to_pending call might not have added anything. */
> +	if (!rev_info.pending.nr)
> +		die("bad object %s", "HEAD");
> +
>  	diff_setup_done(&rev_info.diffopt);
>  	result = run_diff_index(&rev_info, 1);
>  	return diff_result_code(&rev_info.diffopt, result);

that is the fix. We assume that add_head_to_pending() put something into
rev_info.pending, but it might not.

In the case of corruption, "bad object HEAD" is a reasonable outcome.

In the case of an unborn branch, we'd probably want to compare against
the empty tree. This trick is used elsewhere in wt-status.c, as in
wt_status_collect_changes_index().

I'm not sure if we need to deal with that here or not. I wasn't able to
trigger this code with an unborn branch. If you have no index, then the
is_cache_unborn() check triggers earlier in the function. If you do have
an index, then we have an earlier check:

  if (is_null_sha1(orig_head) && !is_cache_unborn())
	die(_("Updating an unborn branch with changes added to the index."));

that covers this case. I am not 100% sure that check is correct, though.
If I do:

  git init
  echo content >foo
  git add foo
  git rm -f foo

then I have an index which is not "unborn", but also does not contain
any changes. I think the conditional above should just be checking
"active_nr". If we were to fix that, then I think
has_uncommitted_changes() would need to be adjusted as well.

I admit that this is probably an absurd corner case.  So I think I am OK
with your fix for now, and we can revisit the logic later if anybody
starts to care.

>     I discovered this segfault on my machine after pulling a repo from
>     GitHub, but I have been unable to reproduce the sequence of events
>     that lead to the corrupted HEAD (I think it may have been caused by a
>     lost network connection in my case).

Yikes. That should never lead to a corrupted HEAD (unless you are on a
networked filesystem). I can't think of another read add_head_to_pending
would fail, though, aside from a missing or corrupted object.

Arguably add_head_to_pending() should die loudly if it can't parse the
object pointed to by HEAD, rather than quietly returning without adding
anything.

> diff --git a/diff-lib.c b/diff-lib.c
> index 52447466b..9d26b18c3 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -512,7 +512,7 @@ int run_diff_index(struct rev_info *revs, int cached)
>  	struct object_array_entry *ent;
>  
>  	ent = revs->pending.objects;
> -	if (diff_cache(revs, ent->item->oid.hash, ent->name, cached))
> +	if (!ent || diff_cache(revs, ent->item->oid.hash, ent->name, cached))
>  		exit(128);

So if I understand correctly, this hunk should not trigger anymore,
because we would never call run_diff_index() without something in
pending.

I think it would be a programming error elsewhere to do so, and we
should treat this as an assertion by complaining loudly (for this and
any other confusing cases):

  if (revs->pending.nr != 1)
          die("BUG: run_diff_index requires exactly one rev (got %d)",
	      revs->pending.nr);

Lastly, I think this is your first patch. So welcome, and thank you. :)
I know there was a lot of discussion and critique above, but I think
overall your patch is going in the right direction.

-Peff


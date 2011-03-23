From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] diffcore-rename: fall back to -C when -C -C busts
 the rename limit
Date: Wed, 23 Mar 2011 11:58:54 -0400
Message-ID: <20110323155854.GB30337@sigill.intra.peff.net>
References: <7vk4fqkewo.fsf@alter.siamese.dyndns.org>
 <1300830649-22830-1-git-send-email-gitster@pobox.com>
 <1300830649-22830-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 16:59:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2QSc-0006B8-Vx
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 16:59:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933225Ab1CWP65 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 11:58:57 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60871
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933157Ab1CWP64 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 11:58:56 -0400
Received: (qmail 5934 invoked by uid 107); 23 Mar 2011 15:59:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 23 Mar 2011 11:59:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Mar 2011 11:58:54 -0400
Content-Disposition: inline
In-Reply-To: <1300830649-22830-3-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169847>

On Tue, Mar 22, 2011 at 02:50:49PM -0700, Junio C Hamano wrote:

> When there are too many paths in the project, the number of rename source
> candidates "git diff -C -C" finds will exceed the rename detection limit,
> and no inexact rename detection is performed.  We however could fall back
> to "git diff -C" if the number of modified paths is sufficiently small.

Hmm. Compared to the previous iteration, this also seems to turn on
warnings for the diff and log families. It would have been a little
easier to review as a separate patch, I think. In particular, I'm not
sure I like the "just warn once at the end" strategy when we show
multiple diffs.

For example, in the trash repo created by your new t4001, I did:

  git commit -a -m foo &&
  git config diff.renamelimit 4 &&
  git log --raw -C -C

And like most users, I read through the commits in the order they're
presented. So I get to the second one and see that it has a bunch of
additions, but no copies. Then I keep reading and finally, after the
third commit, I see a warning that we didn't do copy detection.

Here's what I see wrong with that from the user's perspective:

  1. You give me the warning at some unspecified time after I've already
     read and digested the results of the commit it affects. So at best
     I've wasted my time looking at results that you later tell me might
     be bogus.

  2. The warning is at the very end of the potentially long output. With
     three commits, I'm likely to actually scroll all the way to the end.
     But how often do you run "git log" in git.git and then kill the
     pager after finding the answer you want, never seeing the bottom of
     git's output (and potentially before git even generates it!). So I
     may miss the warning entirely.

  3. Even if I do see the warning, I have no idea which commits it
     applies to. I have to bump the rename limit and re-run just to find
     out whether the commits I cared about were affected.

So I think it would be much more sensible to show something like:

  commit f3ba51f2e2025d15c84873cb24dcf51b77f6b8e1
  Author: A U Thor <author@example.com>
  Date:   Thu Apr 7 15:13:13 2005 -0700

      hundred

  warning: only found copies from modified paths due to too many files.
  warning: you may want to set your diff.renamelimit variable to at
           least 102 and retry the command.
  :000000 100644 0000000... 4daddb7... A  path00
  :000000 100644 0000000... 8a0f05e... A  path01
  [etc]

One argument against that is that we may end up printing many such
warnings. For the pager case, where stderr and stdout are combined, that
is probably fine. Any commit which blows the rename limit is going to
have a ton of diff output anyway, so a few extra lines doesn't hurt
(with some careful flushing, those lines are placed in the right spot).

When stderr is separated, though, it's going to be annoyingly verbose,
and multiple warnings wouldn't match up with their respective commits,
anyway.

So maybe it is worth detecting the pager case and behaving differently
based on whether stderr and stdout are combined.

Another alternative would be to embed the warning in the stdout stream,
but I don't see a clean way of doing that. The best I could come up with
is something like:

    commit f3ba51f2e2025d15c84873cb24dcf51b77f6b8e1
    Author: A U Thor <author@example.com>
    Date:   Thu Apr 7 15:13:13 2005 -0700
    X-Diff-Warning: only found copies...

which just seems a little too hack-ish.

Also, on a somewhat related note: which commands should have rename
progress reporting turned on? It makes sense for "git diff" to do it to
me. And probably even "git show". Probably not for "git log", though.
I think we'd also have to look at how that interacts with the
stderr-to-stdout pager thing. We obviously don't want progress going to
the pager.

> +static const char rename_limit_warning[] =
> +"inexact rename detection was skipped due to too many files.";
> +
> +static const char degrade_cc_to_c_warning[] =
> +"only found copies from modified paths due to too many files.";

Somehow the phrase "due to too many files" seems awkward. The
merge-recursive warning this replaces used "because there were too many
files". Which is longer, of course, but seems more natural.

> +static const char rename_limit_advice[] =
> +"you may want to set your %s variable to at least "
> +"%d and retry the command.";

And this one ends up overflowing reasonably-sized terminals, because it
gets prefixed with "warning: ", and because the variable name is
something like "diff.renamelimit".

> @@ -445,6 +452,20 @@ static int too_many_rename_candidates(int num_create,
>  
>  	options->needed_rename_limit =
>  		num_src > num_create ? num_src : num_create;

This is obviously not introduced by your patch, but I noticed once again
during testing that this number is conservatively high, isn't it? I
think the number we want is actually:

  ceil(sqrt(num_create * num_src))

right? I don't know if it is worth being more accurate.

> @@ -1656,8 +1651,9 @@ int merge_recursive(struct merge_options *o,
>  		commit_list_insert(h2, &(*result)->parents->next);
>  	}
>  	flush_output(o);
> -	if (o->needed_rename_limit)
> -		warning(rename_limit_advice, o->needed_rename_limit);
> +	if (show(o, 2))
> +		diff_warn_rename_limit("merge.renamelimit",
> +				       o->needed_rename_limit, 0);

With the call to show(), we are showing the warning only for the
outermost diff. Which is probably way better than generating a bunch of
warnings, one for each rename-detect we do. But aren't we now failing to
mention limits we hit in recursive invocations, even though they can
affect the results? In other words, isn't this a candidate for the
"find the highest limit needed and report once" strategy you used above?

-Peff

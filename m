From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH Second draft] Fast forward strategies allow, never,
 and only
Date: Wed, 19 Mar 2008 13:35:38 -0700
Message-ID: <7vskym310l.fsf@gitster.siamese.dyndns.org>
References: <402c10cd0803101959q619efa86pbd501e5e2cc018c2@mail.gmail.com>
 <402c10cd0803172127u480276c9s4f9d716b4912ad5e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Sverre Hvammen Johansen" <hvammen@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 21:50:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc5Dq-000683-B5
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 21:49:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934152AbYCSUf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 16:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756831AbYCSUf6
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 16:35:58 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36010 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755122AbYCSUfz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 16:35:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 08026335E;
	Wed, 19 Mar 2008 16:35:52 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 9DD31335C; Wed, 19 Mar 2008 16:35:46 -0400 (EDT)
In-Reply-To: <402c10cd0803172127u480276c9s4f9d716b4912ad5e@mail.gmail.com>
 (Sverre Hvammen Johansen's message of "Mon, 17 Mar 2008 20:27:13 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77545>

"Sverre Hvammen Johansen" <hvammen@gmail.com> writes:

> New fast forward strategies, only, is introduced.  This new fast
> forward strategy prevents real merges.
>
> FF strategy "only" fails if the specified heads and HEAD can not
> be reduced down to only one real parent.  The only allowed
> outcome is a fast forward unless HEAD is up to date with
> the specified heads.
>
> This patch also uses the real heads found instead of those
> specified for real merges.  This means that merge startegies
> that only take two heads can now accept more than two heads
> if they can be reduced down to only two real heads.  However,
> fast-forward of head in combination with a real merge is
> handled as before.

This might be easier to review if split into two parts.  Code suffling to
do --ff/--no-ff => ff={allow,never} and documentation updates to improve
the description of these two options in the first patch, and addition of
"only" to code and the updated docuemntation in the second.

> +If your workflow is always to branch from the special branch
> +("master") when working on a topic and merge that back to "master", if
> +you happen to have worked only on a single topic and the "master" was
> +never advanced during the time you worked on that topic, merging the
> +topic back to "master" will result in a fast-forward.  When you look
> +back that history, you will not be able to tell where the topic
> +started and ended by following the ancestry chain of the "master"
> +branch.
> +
> +Using "never fast forward" policy on such a special branch will be a
> +way to make sure that all commits on the first-parent ancestry of that
> +special branch will be merges from something else.  From the history
> +you can determine where the topic started and ended.
> +
> +The following shows two branches forked off from "master".  The branch
> +"master" have merged in changes from branch "topicA" twice and
> +"topicB" once:
> +
> +------------
> +         o---o---o---o---o  topicA
> +        /     \           \
> +    ---*-------*-------*---*  master
> +      /         \     /
> +                 o---o  topicB
> +------------
> +
> +The first merge of topicA or the only merge of topicB would have
> +resulted in a fast forward without '--ff=never'.  The last merge of
> +topicA would have failed with '--ff=only'.  Topic A consist of those
> +commits that can be reached from master^2 without passing through any
> +of the first-parent ancestries of master.

If you remove one sentence "The last merge ... =only'." from it, this part
is a very good write-up on how "never fast forward" could be useful, and
might even be a worthy addition to the current documentation.  However it
lacks a crucial bit of information: it is _not enough_ to just use --no-ff
to maintain the "special status" of "master".  You also need to prevent
direct committing to it.  So while --no-ff is an ingredient you can
construct such a workflow out of, it by itself is not the whole solution.
You need additional discipline.

> +However, if your workflow require a linear history for the special
> +branch ("master"), topic branches must be rebased before merging them
> +back to "master".  A pull or a merge from the "master branch of a
> +topic branch may accidentally introduce a merge commit that was not
> +already in the topic branch if the topic that were merged was not
> +properly rebased.  This will creating a none linear history.

This,...

> +Using "only fast forward" policy ensures that whenever a pull or a
> +merge is performed it will fail unless the merge can be resolved as a
> +fast forward.  This will however not guarantee a linear history since
> +the topic branches that are merged in may have merge commits recorded.
>
> +You may therefor need to use this policy on the topic branches as
> +well.

combined with the above, would make "only" an incomplete implementation of
the goal you stated earlier, i.e. "to force a completely linear history",
but I think you can trivially fix this by making sure that there is no
merge commit in ORIG_HEAD..MERGE_HEAD and refusing if you find one.  And
by fixing the implementation, you do not have to make excuses like the
above two and half paragraphs.

Having said that, I doubt what you are trying to achieve is to force a
totally linear history, as that is quite useless policy unless you are
talking about a one-man project.

When your project has gained meaningful number of developers, there will
always be more than one nontrivial changes outstanding.  Forcing a linear
history everywhere means whenever somebody wants his changes accepted, he
needs to fetch + rebase whenever anybody else's change is accepted to the
special "master".  The more developers you have, the narrower window
between acceptance of changes to the "master" becomes, and eventually the
window will become shorter than the time needed to rebase and retest any
nontrivial change on top of the tip of "master".  At that point, nobody
can get anything but a trivially rebasable and untested series accepted.
Such a policy would encourage people to merge only "early half" of their
series (because they do not have enough time to rebase the full series) in
a poorly tested shape.  So in that sense it is not just "practicaly
useless", but can be actively harmful by encouraging a bad workflow.

But your "merge has to fast-forward, but the merged branch can have
nonlinear history itself" semantics is different from "require linear
history".  For example, if you want the top-level integrator to do
absolutely _nothing_ (not even a trivial merge), in order to shift the
burden of integration testing to contributors, then use of such semantics
(which is _different_ from "completely linear") by the top-level
integrator could achieve that.  Nobody can ask the top-level to pull which
would result in a tree that he built and tested himself.  The top-level
integrator would say "Your tree is not a fast-forward from mine, because I
merged with somebody else between the time you prepared your tree and I
learned about it.  Please try again", and in response, the contributor can
pull from the top-level integrator and re-test the merge result and ask
again.  With luck, the top-level integrator may not have merged with
anybody else and a pull from that contributor would fast-forward.

So if that is what you are trying to achieve, you need to update your
description.  If you aim for "Totally linear", I think many people will
find it is practically useless, but if you are aiming for something
different, you should advertise it as such.

I think the scaling issue (iow "narrowing window") is the same either way,
and the documentaion should warn about it to the users.  Unclueful people
may think, without really thinking ;-), that it is a good thing in any
occassions to require totally linear history, unless downsides are also
explained.

> diff --git a/git-merge.sh b/git-merge.sh
> index 7dbbb1d..a98cd77 100755
> --- a/git-merge.sh
> +++ b/git-merge.sh
> @@ -12,7 +12,7 @@ summary              show a diffstat at the end of the merge
>  n,no-summary         don't show a diffstat at the end of the merge
>  squash               create a single commit instead of doing a merge
>  commit               perform a commit if the merge sucesses (default)
> -ff                   allow fast forward (default)
> +ff?                  fast forward options
>  s,strategy=          merge strategy to use
>  m,message=           message to be used for the merge commit (if any)
>  "
> @@ -35,7 +35,7 @@ no_fast_forward_strategies='subtree ours'
>  no_trivial_strategies='recursive recur subtree ours'
>  use_strategies=
>
> -allow_fast_forward=t
> +fast_forward=allow
>  allow_trivial_merge=t
>  squash= no_commit=
>
> @@ -153,8 +153,6 @@ parse_config () {
>                 --summary)
>                         show_diffstat=t ;;
>                 --squash)
> -                       test "$allow_fast_forward" = t ||
> -                               die "You cannot combine --squash with --no-ff."

I do not think you defended why it is good idea to drop this sanity check.

>                         squash=t no_commit=t ;;
>                 --no-squash)
>                         squash= no_commit= ;;
> @@ -163,18 +161,33 @@ parse_config () {
>                 --no-commit)
>                         no_commit=t ;;
>                 --ff)
> -                       allow_fast_forward=t ;;
> +                       case "$2" in
> +                       allow|never|only)
> +                               fast_forward=$2; shift ;;
> +                       -*)
> +                               fast_forward=allow ;;
> +                       *)
> +                               die "Available fast-forward strategies
> are: allow, newer, and only" ;;

Strategies?  "fast forward options" you used in the option description is
a reasonable one, and it would be better to keep it consistent.

I didn't look at the rest of the patch (yet).

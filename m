From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Help: approach for rebasing to older commits after merging more 
 recent commits
Date: Mon, 14 Dec 2009 13:33:30 -0800
Message-ID: <7vy6l5gs0l.fsf@alter.siamese.dyndns.org>
References: <76718490912091204u3a4596fdi504005624d5a5bce@mail.gmail.com>
 <76718490912141238k4ca1ba55jeff928efe875f020@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 22:34:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKIYY-0006mb-Nx
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 22:34:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758319AbZLNVdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 16:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758316AbZLNVdm
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 16:33:42 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41925 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758310AbZLNVdj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 16:33:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5AD70A71A8;
	Mon, 14 Dec 2009 16:33:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a8cI2gNGzpk1JkHdIcgNXJAj3SE=; b=KS2efW
	FGQz4wrQH2XVIPnH7CHpPyFadtYgrnS6cYVP8mxc0l32D2j0cZXcKWfMnHFrOfGq
	bvdjlI15j7/sRREsBw4mr6u32I2QeD2w4ZAJx0tLUQ6efAS0CKE+eCWaSUIQikMT
	yNqchKASvMQ4Sa8a4rj87x8mBZK994k4ODLRw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o06uI0kdMbC15BDg0Nc49S0FqC6hO5mo
	BowDmyijXxnFUk01f6GT8g0pcWcrV1grlGaXAgYwWxsItyGUExNaaonh4Vkwenid
	qjfAqbGczYLqHS/eAr6QqejzxP3gZQZQK5tg5HS4VcI1ItVuCQbePt+LGh9A+dwN
	pzF4c1Fm92I=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 39C4DA71A7;
	Mon, 14 Dec 2009 16:33:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D222FA71A6; Mon, 14 Dec 2009
 16:33:32 -0500 (EST)
In-Reply-To: <76718490912141238k4ca1ba55jeff928efe875f020@mail.gmail.com>
 (Jay Soffian's message of "Mon\, 14 Dec 2009 15\:38\:32 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 561C6552-E8F8-11DE-A993-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135243>

Jay Soffian <jaysoffian@gmail.com> writes:

> [He asks again...]
>
> I have an interesting problem I'm not sure how best to tackle.
>
> A small development team is basing its product on an upstream git repo that is
> itself an svn clone. Currently the process looks like this:
>
> r1--r2--r3--r4--r5   upstream trunk   (git svn clone)
>  \       \       \
>  A---B---C---D---E  local trunk      (git clone of upstream)
>       \     /
>        F---G        developerN trunk (git clones of local)
>
> So local trunk has both daily merges from the local developers, as well as
> less periodic (typically weekly) merges from upstream trunk. The reason being
> that it is necessary to remain on top of the upstream bleeding edge.
>
> This works out okay, but there is a minor problem and a major problem.
>
> The minor problem is that the local trunk is cluttered with the developerN
> merges. That is easy to solve by having local developers rebase before pushing
> to local trunk. That would look like:
>
> r1--r2--r3--r4--r5            upstream trunk
>  \       \       \
>  A---B---C---D---E---F'---G'  local trunk
>
> The major problem is that local trunk is also cluttered with merges from
> upstream. The is a problem because at some point in the future, upstream
> is going to declare some rN as being officially blessed. And we're going to
> want to rewind any rN changes past that point.
>
> So the question is, what's the best way to do this? Say r2 is blessed by
> upstream.

You should re-think your earlier claim:

    The reason being that it is necessary to remain on top of the upstream
    bleeding edge.

and then think about ways you can take advantage of the distributed nature
of git, especially the topic branch workflow it supports well.

The key realization is this:

    It is necessary to remain on top of the upstream" does not mean "all
    of the new development done by my group must build _on top of_ the
    upstream" at all.

for one obvious reason: near the tip of the upstream is not necessarily
what you want in your final product.  If the "blessed" point will be r2,
you won't want any topic to be based on r3 or later before forking your
release branch that contains the upstream up to r2.

You _would_ want to remain as compatible as possible with upstream later
than r2 even if the "blessed" point _for this cycle_ is r2, so you would
need a daily integration testing branch that is rebuilt by merging all the
topics from your group _and_ upstream tip and run your tests there.  But
once you know which commit from the upstream side (r2 in your example)
will be the one your group will base your changes on and go into a pre-
release mode, you will likely to want to have _another_ test integration
branch to merge all the topics from your group that have forked from a
commit before r2, on top of r2.  There _will_ be topics from some members
who unfortunately based their topic on commits newer than r2 and they need
to adjust their work on r2 or older.  If they didn't depend on new API,
new features, or modified semantics r3 or later introduced, this rebase
should be trivial.  On the other hand, if they did depend on new things,
the project management needs to make a decision.  You may choose to
keep the topic out of your upcoming release (because it will depend on
features of upstream newer than the "blassed" upstream release your
product will be based on), or you may choose to "backport" the upstream
features the topic needs without slurping all the new and unstable
upstream features (e.g. if a topic based its work on a new feature
implemented in r5, but what r3 or r4 do are unnecessary for it, or any
other topics in your product, you will cherry-pick r5 on top of r2 and
then rebase the topic on top of the result). 

It also means that your group members try not to base their work on the
daily integration branch which is your 'master' branch current is, nor
rebase their work on it before merging.  Instead, fork from a known good
state where the result of building on it and then merging that with the
tip of the upstream and with other topics won't introduce excessive
conflicts.

The project manager may want to establish and maintain a reasonable
baseline that:

 - merges from upstream trunk (but not its tip) only occasionally; Being
   behind is perfectly fine and even preferable than being too hasty and
   merging r3 and later into this branch.

 - merges from group members' topics _only_ after they are _fully_
   completed _and_ you are sure that you want these topics in your next
   release.

and have group members fork from its tip.  I'd recommend using 'master'
for that.  Don't let random topics that are half-done (i.e. "this doesn't
do what it should do, but it hopefully doesn't break other things") merged
into this branch.

Then every test cycle (once a day, or continuous, it doesn't matter)
creates a throw-away test branch to the tip of this branch, merges all the
topics that are still cooking and testable, and merges from the updated
upstream.  This may need conflict resolution, and rerere will help here.
And test the result.  That way you will ensure that you will be "on top of
the bleeding edge".

When conflicts with the updated upstream become getting excessive, it is a
good sign that you would want to update the "baseline" (see above) with
(an early part of) the upstream.

If conflicts between topics of your group members become excessive, it is
a sign that you are not partitioning the work correctly.  SCM is never a
substitute for developer communication and you may need to have the
members involved in the conflict talk with each other and resolve the
conflict between themselves.  E.g. they may want to decide to merge their
work so far and build their topics upon a consolidated base.

And that "reasonable baseline", as long as it won't overstep 'r2' in the
end, will be directly the branch you cut your release from.  On the day
you decide to base your next product on r2, you will fork 'release' branch
from the tip of 'master', and merge up to 'r2' from the upstream, and you
have your release with fully cooked topics.  If on the other hand you have
already merged from the upstream up to 'r5' to 'master', then you would
need to build a separate 'release' branch, forking from some commits in
'master' before the branch merged commits later than 'r2' from the
upstream.  Betweeen this fork-point and the tip of your 'master', there
will be some topics that have graduated to 'master'.  You need to examine
them and see if they merge to 'release' without dragging 'r3' and later in
from the upstream, and make the management decision I mentioned 60 lines
ago.

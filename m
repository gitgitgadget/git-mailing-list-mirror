From: Johan Herland <jherland@gmail.com>
Subject: Re: [WIP PATCH 0/3] implement merge strategy for submodule links
Date: Tue, 22 Jun 2010 12:48:08 +0200
Message-ID: <201006221248.08756.jherland@gmail.com>
References: <cover.1276059473.git.hvoigt@hvoigt.net> <201006220035.31166.johan@herland.net> <7vmxung1bk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 22 12:55:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OR18j-00057r-Rl
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 12:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759156Ab0FVKzd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jun 2010 06:55:33 -0400
Received: from smtp.opera.com ([213.236.208.81]:34440 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755437Ab0FVKzb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jun 2010 06:55:31 -0400
X-Greylist: delayed 417 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Jun 2010 06:55:31 EDT
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o5MAm84E025857
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 22 Jun 2010 10:48:09 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <7vmxung1bk.fsf@alter.siamese.dyndns.org>
X-Face: yd/RLXZ@3u;&:C1I$AEH?\d18w+mK:]sZDl52'=Pa{>%,97])P+G2Z<=?iso-8859-1?q?An=5C=5Fs-+5=5DS5USYj=0A=09ZV9-=27+?="}0!v$zY.4.~5V*'(.9b`>|'YyP1]1%Ge/"bi}Z9PaqbK.9K"yXj#v-CuX,=?iso-8859-1?q?i=26=2E8=5D=0A=09?=)yTm>+T04D
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149472>

On Tuesday 22 June 2010, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > True, but as I've argued above, I'm not sure that adding another
> > setting (aka. .merge_branch) for this special/limited kind of
> > branch tracking is worth it.
>
> I don't think .merge_branch is necessary nor even desired.

Good.

> In fact, 
> I think your use of .branch, especially in the variant that does not
> have any submodule entry in the superproject tree, of your version
> (B) does not have conceptual advantage.  You checkout the
> superproject first (which would be the natural thing to do, as you
> may get update to its .gitmodules there), and checkout the then-tip
> of the named branch of the submodule, you would immediately get a
> stale checkout when you then go fetch the updates to the submodule.

Not if the initial checkout of the submodule included an implicit 
fetch/pull within the submodule (exact behaviour probably to be 
controlled with some config).

> And the worst part is that you wouldn't even _notice_ that your
> checkout is stale, as there is no record in the superproject which
> commit you were supposed to be using to be consistent with the
> version the committer of the superproject commit used to record it.

The idea (in B.1.) is that if you _truly_ don't care which version of 
the submodule you're checking out, then there should be no submodule 
entry in the superproject that would "pollute" your status/diffs.

Note that I'm not in this camp myself, as I would very much like to keep 
track of where my submodule is (and has been) checked out. So I'll stop 
trying to argue for a use case that I'm not going to use. At the time, 
it seemed like a logical conclusion of the tracking-submodule-branches 
debate, but if it's not going to be used in practice, there's no point 
in keeping it alive.

> I on the other hand think what you called "hybrid" makes sense (and I
> don't even think it is hybrid but rather is a natural way to do
> this).

Agreed. I too believe that the "hybrid" is much more useful in practice 
than the extreme version (without a gitlink entry in the superproject).

But I also believe that Git shouldn't enforce specific workflows, so 
that if people actually want to track submodule branches in the 
non-"hybrid" (haphazard) manner, then Git should not stand in their 
way.

On the other hand, if nobody's gonna do this, there's no point in 
implementing support for it.

> With the submodule.*.branch entry, you can: 
>
>  - make sure that your checkout is consistent; if your submodule
> checks out a different commit or branch from what the superproject
> records in its tree or in its .gitmodules (e.g. you forgot to update
> the submodule when you switched superproject branch), git can notice
> the situation and can help you implement policy decisions;
>
>  - record a commit that is different from the tip of the submodule
> branch when making a superproject commit; git can notice the
> situation and can help you implement policy decisions (e.g. you could
> choose to reject and tell the user to advance the submodule branch
> first before making the commit in the superproject);
>
>  - use it as an advisory "existing merge commit selector", as
> discussed in this thread.

Ah, I see. IINM you indeed prefer to use the same setting (aka. 
submodule.<name>.branch) for controlling both the merging of submodules 
(as discussed in this thread), and the other aspects of the submodule 
branch tracking feature. We agree here.

However, it seems you would like the .branch setting to be more advisory 
in nature: Instead of blindly checking out whatever .branch specifies, 
you'd rather have a more careful interplay where the .branch option 
should only check whether it is consistent with what happens to be 
checked out in the submodule, and warn when this is not the case.

This may be better than what I suggested, but it's hard to say anything 
for sure until the various alternatives are tested in practice.

> Thinking about what would happen in your (B) that doesn't record the
> exact commit, I think that it doesn't have any advantage over the
> "hybrid" one. The "hybrid" one can help you to make sure that what
> you commit in the superproject's .gitmodules and submodule's branch
> tip are kept consistent. When they are kept consistent, then
> switching branches in the superproject should always flip between the
> tips of branches, no?

Yes, if branch "foo" in the superproject records "branch = subfoo" 
in .gitmodules, and the current tip of "subfoo" as a gitlink, and 
branch "bar" in the superproject records "branch = subbar" 
in .gitmodules and the current tip of "subbar" as a gitlink, then, 
indeed, switching between these two branches should auto-flip between 
the branch tips.

One of the remaining questions is what happens when the superproject 
does not change, but commits are added to the submodule branches. Now, 
when switching between branches in the superproject, should Git:

1. Do nothing (this is the current behaviour, the user is forced to 'git 
submodule update' after 'git checkout' in the superproject)

2. Only checkout the recorded gitlink (this defeats the purpose of 
branch-tracking, IMO)

3. Checkout the recorded gitlink, but warn about the updated branch tip 
(a valid behaviour IMO)

4. Checkout the updated branch tip of the submodule, and warn about the 
out-of-date gitlink entry (also a valid behaviour IMO)

5. Checkout the updated branch tip AND stage a new gitlink in the 
superproject (this is a bit to "magic", IMO)


...Johan

-- 
Johan Herland, <jherland@gmail.com>
www.herland.net

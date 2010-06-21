From: Johan Herland <johan@herland.net>
Subject: Re: [WIP PATCH 0/3] implement merge strategy for submodule links
Date: Tue, 22 Jun 2010 00:35:30 +0200
Message-ID: <201006220035.31166.johan@herland.net>
References: <cover.1276059473.git.hvoigt@hvoigt.net>
 <201006211219.02911.johan@herland.net>
 <7vlja8if5r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 22 00:35:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQpaf-0006m9-7L
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 00:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755090Ab0FUWff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jun 2010 18:35:35 -0400
Received: from smtp.getmail.no ([84.208.15.66]:51088 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752932Ab0FUWff (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jun 2010 18:35:35 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L4D00I14YR9I5A0@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 22 Jun 2010 00:35:33 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id DFF441EA580D_C1FE934B	for <git@vger.kernel.org>; Mon,
 21 Jun 2010 22:35:32 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 90AD41EA43BA_C1FE934F	for <git@vger.kernel.org>; Mon,
 21 Jun 2010 22:35:31 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L4D0070GYR7WT30@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 22 Jun 2010 00:35:31 +0200 (MEST)
User-Agent: KMail/1.13.3 (Linux/2.6.33-ARCH; KDE/4.4.4; x86_64; ; )
In-reply-to: <7vlja8if5r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149457>

On Monday 21 June 2010, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > I still don't like this, as IMHO it's too subtle, and possibly
> > conflicts with explicitly tracking submodule branches (which, to me,
> > is a more important feature).
> 
> If you mean, by "explicitly tracking", to say "I don't care which commit
> from the submodule appears at this path, as long as it is at the tip of
> this branch", I still don't think it makes much sense, but what I
> outlined is not _incompatible_ with such a scheme.  In fact I think it
> would rather fit naturally as a sanity/safety measure.

I'll first try to explain where I'm coming from, to hopefully eliminate any 
confusion about my position:

IMHO, there should be 2 primary modes for submodules in Git:

A. Explicitly tracking submodule commits. This is the existing submodule 
behaviour. The superproject refers directly (in its tree) to a submodule 
commit. The .gitmodules file contains associated information 
(submodule.<name>.path, .url and .update).

B. Explicitly tracking submodule branches. An extra setting 
(submodule.<name>.branch) is added to the .gitmodules file, to determine 
which submodule branch to checkout. This setting overrides whatever 
submodule commit, if any, is stored in the superproject tree. There are two 
sub-modes for this mode:

B.1. There is no submodule entry at all in the superproject tree. This 
indicates that you are not at all interested in tracking the history of the 
submodule relative to the superproject. You are always interested in 
checking out the tip of submodule.<name>.branch in the submodule, even when 
digging into the superproject's history.

B.2. There is a submodule entry in the superproject tree. This "hybrid" 
approach indicates that although you primarily want to track a branch in the 
submodule (i.e. you mostly want the latest version of the submodule's 
branch), you still want a record of where your submodule has been pointing, 
in your superproject's history. Exactly when (or how often) the 
superproject's submodule entry should be updated is yet TBD. So is when to 
check out according to .branch, and when to use the recorded submodule 
commit. In the end, it'll probably be a policy decision for the projects 
that choose this approach.

Ok, that hopefully explains the basic idea of tracking submodule commits (A) 
vs. tracking submodule branches (B). Now, how would this apply to merging 
submodules?

In case of B, I'd argue that the submodule merging should _only_ look at the 
value of submodule.<name>.branch from the superproject's .gitmodules. If 
this setting is ambiguous (because of merge conflicts in .gitmodules), Git 
should not touch the submodule at all (until .gitmodules is resolved). 
Otherwise, Git's only task is to checkout whatever branch is specified by 
.gitmodules. If the commit that is checked out does not descend from all of 
the merge alternatives, a warning should be printed.

With that in mind, I enter this discussion because it might provide insight 
on how to solve the problem of merging submodules in scenario A.

In mode A there is no submodule.<name>.branch setting, and I would not like 
to add an additional setting (let's call it submodule.<name>.merge_branch 
for now) that is "weaker" than submodule.<name>.branch (meaning that it does 
not trigger the transition from mode A to mode B). There are two major 
reasons for this:

1. submodule.<name>.merge_branch would add semantics to the case of merging 
submodules that would be similar in spirit to what submodule.<name>.branch 
does (the "spirit" here is the special relationship to a submodule branch 
that we're establishing), but still the .merge_branch setting would be 
different in practice, by (a) only applying to the case of merging 
submodules (while .branch changes the semantics of almost all submodule 
operations), and (b) not even in the case of merging submodules would the 
options do the same thing. I fear the semantics of the .merge_branch option 
would be too complicated for an average user, and that its similarity to 
.branch would cause confusion.

2. What would happen if you enabled _both_ .merge_branch and .branch? In the 
case of merging submodules which setting will "win"? Even worse, if you set 
.merge_branch to "foo", and .branch to "bar", what will then happen?

Ok, so if I oppose adding .merge_branch, what do I propose instead?

Currently, not much, I'm afraid. But I have a gut feeling that the use case 
presented by Heiko and Jens is best solved EITHER by having no special 
branch relationships between the superproject and submodule (which AFAICS is 
what we currently agree on in this thread, and Heiko has already submitted a 
patch to this effect), OR by employing a conservative version of mode B.2 in 
which we use .branch to track a submodule branch, but still keep a close 
look at the recorded submodule commit, and, if necessary, maybe introduce 
some other options to tell Git when to use the recorded commit, and when to 
use the branch tip.

In other words, I think we should explore the .branch direction before we 
add complexity and potential confusion by prematurely adding another option 
that it somewhat similar to .branch in some contexts.

> I presume that in your "explicitly tracked" world, if the user tries to
> commit at the superproject level with a submodule commit that is
> inconsistent with that "explicitly tracked" branch (e.g. the commit is
> not reachable from the tip of that branch), you would issue a warning of
> some sort, using that knowledge.

Yes.

> What I outlined uses the exact same
> knowledge of which branch in the submodule the superproject branch is
> tied to to reject irrelevant existing merges as resolution candidates.

True, but as I've argued above, I'm not sure that adding another setting 
(aka. .merge_branch) for this special/limited kind of branch tracking is 
worth it.

> Of course, this ".gitmodule in superproject can tell you which branch of
> submodule it follows" is optional; the user needs to take responsibility
> of picking the right one among I, E and G, of course, if the information
> does not exist or is not available.

Yes, of course. And this corresponds to what I've proposed for scenario A, 
when there is no branch-related setting specified for the submodule.


Hope this helps,

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net

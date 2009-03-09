From: Andreas Ericsson <ae@op5.se>
Subject: Re: Help designing work flow
Date: Mon, 09 Mar 2009 11:55:37 +0100
Message-ID: <49B4F5A9.5060304@op5.se>
References: <450196A1AAAE4B42A00A8B27A59278E709F07D30@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: John Dlugosz <JDlugosz@TradeStation.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 11:57:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgdAW-0003PU-Hc
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 11:57:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753435AbZCIKzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 06:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753284AbZCIKzn
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 06:55:43 -0400
Received: from spsmtp02oc.mail2world.com ([74.202.142.148]:4407 "EHLO
	spsmtp02oc.mail2world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753216AbZCIKzm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 06:55:42 -0400
Received: from mail pickup service by spsmtp02oc.mail2world.com with Microsoft SMTPSVC;
	 Mon, 9 Mar 2009 03:54:06 -0700
auth-sender: exon@home.se
Received: from 212.112.174.166 unverified ([212.112.174.166]) by spsmtp02oc.mail2world.com with Mail2World SMTP Server; 
	Mon, 09 Mar 2009 03:54:05 -0700
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E709F07D30@EXCHANGE.trad.tradestation.com>
X-OriginalArrivalTime: 09 Mar 2009 10:54:06.0418 (UTC) FILETIME=[5E04A320:01C9A0A5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112687>

John Dlugosz wrote:
> I know we (my group) should use "topic" branches and apply them back to
> the dev branch when done.  There is concern that the commit history gets
> too full of detailed stuff, especially with several developers, that you
> can't tell what "really changed".  So, our dev branch should appear to
> contain only commit nodes representing completed assignments; not every
> day's checkpoint and trying to keep one's own stuff on top to avoid
> merging later.
> 
> I guess that's how it is on these Open Source projects where patches are
> submitted by email and applied by the maintainer.  We don't see the
> details, just the final patch.  But, my situation will be developers
> gathered around an in-house master repo, and everyone should be able to
> push their own changes as assignments are completed.
> 
> What is the best procedure to achieve that?  Or what are some good
> alternatives with trade-offs?
> 

Use topic-branches and let someone merge them into master after having
verified that they work properly.

We usually commit simple bugfixes directly to master and then have
developers rebase their changes onto master when they're ready to
integrate it. They push their development branches though, and further
changes to the topic are done on the topic-branches which can get
merged to master (or stable) many times. Once a topic is merged, we
always "git commit --amend" the merge commit to write a proper
commit-message for it, adding a link to our bug- and feature-tracker
so we get the at-a-glance information quickly and can dig up the
entire discussion history around the bug/feature later. Each topic
should be complete with documentation and test-cases before it's
merged.


> I see that if a topic branch is merged (disabling FF if applicable), the
> main line (leftmost parent) will be a history of completed topics.  But,
> we don't need to keep the detailed side-branches forever, and even if
> gitk and other visualization  tools can be told to just show the main
> line, advanced use such as git log this..that will forever be packed
> with the micro-details.
> 

You can tell "git log" to only show one line of history too, but besides
that, micro-details are good. You definitely want to be able to search
the micro-details when things go awry (and they will), so you see exactly
why some particular algorithm changed later.

> So, unless someone has more input along that line, I'm assuming that we
> want to apply the completed topic as a single-parent commit.  That is
> the natural result if preparing patches and then applying them, but is
> there a simpler, direct way to do that in git?
> 

You do not want to do that. We did it for a while, and it was hell when
we found out that one of them broke down. The really, really *nice* thing
about git is called "git bisect". What makes it so awesomely nice is
that, instead of looking at a 100k diff-file knowing that somewhere in
there a bug was introduced, you get (with good discipline using small
commits), a 1-40 line patch with a clear and concise message of why
those changes were thought necessary at that time. Applying a topic
branch as a single patch would rob you of that functionality, and you
will regret it. Trust me on this.

> The detailed topic branches can be kept around for a while, for the
> original author to extend if it needs to be returned to, and to examine
> if the gestalt change in the single commit is too overwhelming to
> understand, or to help figure out what might have broken.  But after a
> while they can be deleted and then gc will free up the disk space.
> 

But if they do need to be returned to, you cannot merge them again if
you've already applied the topic-patch (ugh), since you'd get conflicts
if any of the sections touched by the patch have been changed since.

We use topic-branches quite a lot. When we're done with them we delete
the branch-pointers but I wouldn't, ever, dream of re-cooking them as
mega-patches when applying them to master.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.

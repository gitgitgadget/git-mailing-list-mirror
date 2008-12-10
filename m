From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: Forcing --no-ff on pull
Date: Wed, 10 Dec 2008 13:07:38 -0600
Organization: Exigence
Message-ID: <20081210130738.0662082f.stephen@exigencecorp.com>
References: <1228815240.18611.48.camel@starfruit.local>
	<20081209191704.6117@nanako3.lavabit.com>
	<1228819087.18611.73.camel@starfruit.local>
	<alpine.LNX.1.00.0812091651360.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "R. Tyler Ballance" <tyler@slide.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Dec 10 20:09:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAUQh-0006mK-U9
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 20:09:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755512AbYLJTHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 14:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755332AbYLJTHp
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 14:07:45 -0500
Received: from smtp162.sat.emailsrvr.com ([66.216.121.162]:37223 "EHLO
	smtp162.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754531AbYLJTHo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 14:07:44 -0500
Received: from relay6.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay6.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id 892E41B4CFF;
	Wed, 10 Dec 2008 14:07:42 -0500 (EST)
Received: by relay6.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTPSA id 221451B4CE3;
	Wed, 10 Dec 2008 14:07:42 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0812091651360.19665@iabervon.org>
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102700>

On Tue, 9 Dec 2008 17:32:36 -0500 (EST)
Daniel Barkalow <barkalow@iabervon.org> wrote:

> > At this point, QA is involved and what can happen is that QA realizes
> > that this code is *not* stable and *never* should have been brought into
> > the stable branch.
>
> How do you prevent the (IMHO more likely) case of:
> 
> % git checkout -b project
> % git checkout stable
> <fix some bug in stable>
> % git commit -a
> <forget to switch branches back>
> <work>
> % git commit -am "A"
> <work>
> % git commit -am "B"
> ...
> % git push origin stable
> 
> That is, the developer makes a whole bunch of inappropriate commits on 
> their stable branch instead of their project branch and then pushes it out 
> (perhaps as part of a push rule, or thinking only the bug fix went there). 
> I suspect that "pull" step there isn't the point where things are going 
> wrong.

Well, two things:

1) The hook script at [1] really would prevent this from getting published.
   Although it only looks for "stable"--if you have per-team stable branches,
   you might need to match on "*-stable" or something like that. But it does
   (copy/paste from [1]):

# * stable must move by only 1 commit-per-push
# * the stable commit must have 2 and only 2 parents
#   * The first parent must be the previous stable commit
#   * The second parent is the tip of the candidate branch being released
# * the stable commit must have the same contents as the candidate tip
#   * Any merge conflicts should have been resolved in the candidate tip
#     by pulling stable into the candidate and having qa/tests done--pulling
#     candidate into stable should then apply cleanly

So, no fast forwards, no direct commits, only "good"/empty merges of
topic branches can move stable. Anything else is rejected and LazyDev
has to try again.

2) As far as "pull" isn't where things are going wrong, that is not
   entirely true, as even with the server-side enforcement like [1],
   I think you'd still like to help LazyDev out and have `git pull`
   "just work" for your given setup. Especially if you don't have full
   management buy-in to git, pacifying LazyDev's can be necessary.

- Stephen

1: http://github.com/stephenh/gc/tree/master/server/update-stable

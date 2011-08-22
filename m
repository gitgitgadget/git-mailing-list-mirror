From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: How to check out the repository at a particular point in time
Date: Mon, 22 Aug 2011 15:25:31 +0200
Message-ID: <201108221525.32982.trast@student.ethz.ch>
References: <1314015902.48377.YahooMailClassic@web25403.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: <rdiezmail-temp2@yahoo.de>
X-From: git-owner@vger.kernel.org Mon Aug 22 15:25:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvUVZ-0006eU-5O
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 15:25:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752489Ab1HVNZh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 09:25:37 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:34504 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752428Ab1HVNZf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 09:25:35 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.289.1; Mon, 22 Aug
 2011 15:25:32 +0200
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.289.1; Mon, 22 Aug
 2011 15:25:33 +0200
User-Agent: KMail/1.13.7 (Linux/3.0.1-40-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <1314015902.48377.YahooMailClassic@web25403.mail.ukl.yahoo.com>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179863>

I'll basically reply from bottom up so you can see the motivation and
then my suggestions for the solution.

R. Diez wrote:
> 
>   Note that this looks up the state of your local ref at
>   a given time; e.g., what was in your local master branch last week.
>   If you want to look at commits made during certain times,
>   see --since and --until. 
[...]
> Say, for example, an hour ago I had temporarily checked out last
> year's versions, but half an hour ago I went back to this year's
> versions. If I check out at HEAD@{1 hour ago}, will I get then last
> year's version, or this year's?

The @{date} and @{n} syntax refers to the reflog, which as the name
tries to imply, is a log of where *your local ref* was at that
time/step.  Since the HEAD ref is by definition what you have checked
out at the moment, HEAD@{1 hour ago} indeed refers to last year's
version.

> Anyway, my real problem is with the mentioned --until option. "git
> checkout" does not understand that option, so I guess I need to feed
> the date to some other git command in order to get the commit ID for
> "git checkout", right? Can someone help me here?

It is a git-log option (or more precisely, revision walker option).
The main problem is that your request is not very well-defined: in
nonlinear history there will in general be more than one commit at the
time requested.

    ---a----b----c----M----       (M is a merge)
        \            /
         d-----e----f

             ^---- April 1st

Suppose you ask git for "the newest commit as of April 1st" in this
history.  Is it supposed to give you b or d?  [If you think nonlinear
history is easy, try to figure out a good rule in the presence of time
skew, where misconfigured clocks/timezones resulted in parents being
younger than children.]

Hence:

> For extra karma points, git checkout could understand the --until option itself.

It probably never will, because that is an ill-defined request.

You can indeed say

  git log -1 --until="april 1"

to get *one* commit that happened before April 1st, but which one is
up to the order internally used by git.  You can also say

  git log -1 --first-parent --until="april 1"

to get the first such commit along the first-parent ancestry, which
might suit the ticket.

But there is a more fundamental issue.  Let me explain.

> I'm writing a daily build script for all the OpenRISC components, so
> every day I need to check out several git repositories with the
> source code of many tools that depend on each other.
> 
> The hole process takes hours. In order to minimize the risk of
> repository skew

Step back and consider the real problem here.  In the simplest case
you are getting two components A and B which depend on each other,
e.g., A depends on B.  But there is a race condition in the case where
a user updates an API between them in a backward-incompatible way: she
has to update both A and B, and an unfortunate coworker/buildbot may
pull old-A and new-B (or vice versa) and get a broken build.
[Incidentally this seems to be a frequent problem with SVN externals.]

You might say: if only we had a way to record the fact that the
"blessed" version of B to go with old-A is old-B, and for new-A it's
new-B.

And indeed we do.  Submodules were invented to allow B to be "linked"
into A's repository, such that a checkout of any commit of A "knows"
the correct corresponding version of B.  A user who updates the API
can record the update to B inside the API-changing commit in A.

So while you can kludge your way around the problem with clever use of
'git log --until', submodules would be the "correct" solution.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch

From: Paul Jakma <paul@clubi.ie>
Subject: Re: impure renames / history tracking
Date: Wed, 1 Mar 2006 19:13:36 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0603011851430.13612@sheen.jakma.org>
References: <Pine.LNX.4.64.0603011343170.13612@sheen.jakma.org> 
 <4405C012.6080407@op5.se>  <Pine.LNX.4.64.0603011558390.13612@sheen.jakma.org>
 <46a038f90603011005m68af7485qfdfffb9f82717427@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Andreas Ericsson <ae@op5.se>, git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 01 20:20:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEWnQ-00049Z-5k
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 20:15:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWCATPc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 14:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbWCATPc
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 14:15:32 -0500
Received: from hibernia.jakma.org ([212.17.55.49]:34455 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S1750725AbWCATPc
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Mar 2006 14:15:32 -0500
Received: from sheen.jakma.org (IDENT:U2FsdGVkX1/e5W/NpsSNmfPad7JZ9/CFaagPlJNXuLk@sheen.jakma.org [212.17.55.53])
	by hibernia.jakma.org (8.13.1/8.13.1) with ESMTP id k21JDasZ002284;
	Wed, 1 Mar 2006 19:13:53 GMT
X-X-Sender: paul@sheen.jakma.org
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90603011005m68af7485qfdfffb9f82717427@mail.gmail.com>
Mail-Copies-To: paul@hibernia.jakma.org
Mail-Followup-To: paul@hibernia.jakma.org
X-NSA: al aqsar fluffy jihad cute musharef kittens jet-A1 ear avgas wax ammonium bad qran dog inshallah allah al-akbar martyr iraq hammas hisballah rabin ayatollah korea revolt pelvix mustard gas x-ray british airways washington peroxide cool
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on hibernia.jakma.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17006>

On Thu, 2 Mar 2006, Martin Langhoff wrote:

> The moment you 'merge' by using git-diff | patch you lose all the 
> support git gives you, because you are discarding all of git's 
> metadata! git's metadata is about all the commits you are merging, 
> and is good enough that it will help future merges across renames.

> You should really use git-pull/git-merge at that point.

Let's try not get stuck on the workflow.

I probably shouldn't have brought it up. However, just assume it's 
been decided that 'detail' of the project implementation is too much 
clutter for the 'master'. I note that people do this already even in 
the "keep all the details" Linux and Git workflows, where they 
rejiggle commits in order to cut-out 'oops, made a typo' type of 
commits.

So the level of detail that is suitable is for 'merging upstream' 
clearly is arbitrary and subjective, and even with git and Linux that 
knob already is set past 0 (all detail), maybe to 1 - the workflow 
I'm thinking of has it set to (say) 2.

For sake of argument assume the workflow corresponds to:

     o-o-o-o---o--o
    /              \
--o----------------m->

And collapsing just the 'oops, made a typo' commits so it looks like:

     o-----o------o
    /              \
--o----------------m->


The /real/ point, other than workflow, is:

- can we track 'rename and rewrite'?

> And you can modify your practices ever so slightly to match the
> benefits of the old model:

I agree completely on the workflow argument, I intend to make it to 
the project concerned ;).

> And what I've found, managing a project with 13K files, is that in 
> practice git does far better tracking renames than several SCMs 
> that do explicit tracking. Don't be distracted by the 'we don't 
> track renames posturing'. We do, and it's so magic that it just 
> works.

Yep, I know. :).

I just wonder if that magic could use additional hints (*not* Attic/ 
type stuff, ick ye gods no! Agree fully there!). Cause 'rename and 
rewrite' it just does not get right.

Simplest test-case (simulating 'rename and rewrite half the file') 
is:

- create a one-line file
- commit to git
- mv it and add a line

To show:

$ git status
nothing to commit
$ cat test
foo
$ git-mv test toast
$ echo bar >> toast
$ git-update-index toast
$ git status
#
# Updated but not checked in:
#   (will commit)
#
#       deleted:  test
#       new file: toast
#

A year later, someone comes along and looks at the history for 
'toast', they'll never know they can look back further by following 
'test'.

I'd like to fix the above somehow, possibly by adding 'renamed test 
toast' meta-data to index cache and commit objects. Having git-mv / 
git-cp add that meta-data.

Then diffcore using that meta-data as /advisory/ and auxilliary 
information *only* in /helping/ to determining renames, as an 
additional input to its existing heuristics. This meta-data would not 
be intrinsic to the operation git, it would /only/ be to aid humans 
(or their tools rather) in tracking back/forward through history.

Would that be the best way to explore solving the above problem?

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
Human resources are human first, and resources second.
 		-- J. Garbers

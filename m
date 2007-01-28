From: Nicolas Pitre <nico@cam.org>
Subject: Re: What's cooking in git.git (topics)
Date: Sat, 27 Jan 2007 21:51:34 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701272049480.3021@xanadu.home>
References: <7vps90lvoh.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0701271415280.3021@xanadu.home>
 <7vhcuci0z0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Jan 28 03:51:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HB08t-00083Q-3k
	for gcvg-git@gmane.org; Sun, 28 Jan 2007 03:51:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbXA1Cvh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 21:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbXA1Cvg
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 21:51:36 -0500
Received: from relais.videotron.ca ([24.201.245.36]:25976 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932367AbXA1Cvg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 21:51:36 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCK00D2L59YA0H0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 27 Jan 2007 21:51:35 -0500 (EST)
In-reply-to: <7vhcuci0z0.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38013>

On Sat, 27 Jan 2007, Junio C Hamano wrote:

> My understanding of the situation after your patch (disregarding
> the problem that prune and friends may happily break the logs
> for detached HEAD), is that if you say "git show HEAD@{...}",
> while on a branch, it looks at the log of the current branch but
> while on a detached HEAD it shows the log from .git/logs/HEAD.
> I have a feeling that this would be confusing.  

It would indeed.  But that's not exactly what's happening.

> Ideally, while
> on a branch, say 'master', these two should behave differently:
> 
> 	$ git show 'master@{5.minutes.ago}'
>         $ git show 'HEAD@{5.minutes.ago}'
> 
> The former talks only about where the tip of that particular
> branch were while the latter also should tell you on which
> branch you were on.

Exactly!

Try this script:

git init
echo 1 > foo
git add foo
git commit -m 1
echo 2 > foo
git add foo
git commit -m 2
echo 3 > foo
git add foo
git commit -m 3
git checkout -b otherbranch
echo 4 > foo
git add foo
git commit -m 4
echo 5 > foo
git add foo
git commit -m 5
echo 6 > foo
git add foo
git commit -m 6
git checkout master
echo 7 > foo
git add foo
git commit -m 7
echo 8 > foo
git add foo
git commit -m 8
git checkout otherbranch
git checkout master

Then you should get the following results:

$ git log -g --pretty=oneline master
58cc540d459fc0c796c2eef796b84cb003ebbf3e master@{0}: 8
b68b1cd29ad2d6157174338a3e9f871c59b5aedd master@{1}: 7
9dfb1ec50c44d0057981cccda90ee29c644ae336 master@{2}: 3
014bdcf6604056e1cda8b6d8d88d6c846db73826 master@{3}: 2
007ed39dd47696c4ab8e8ccdfcb536b8e21ec8e7 master@{4}: 1

$ git log -g --pretty=oneline otherbranch
2483023022b3167343670b209a5d98e4f192430a otherbranch@{0}: 6
3ae298d1b258c24dd2180de9b6cdb93148399920 otherbranch@{1}: 5
ca18ea0eb4e1aabde80add1761f74da9136c59ec otherbranch@{2}: 4
9dfb1ec50c44d0057981cccda90ee29c644ae336 otherbranch@{3}: 3

And finally:

$ git log -g --pretty=oneline HEAD
58cc540d459fc0c796c2eef796b84cb003ebbf3e HEAD@{0}: 8
b68b1cd29ad2d6157174338a3e9f871c59b5aedd HEAD@{1}: 7
9dfb1ec50c44d0057981cccda90ee29c644ae336 HEAD@{2}: 3
3ae298d1b258c24dd2180de9b6cdb93148399920 HEAD@{3}: 5
ca18ea0eb4e1aabde80add1761f74da9136c59ec HEAD@{4}: 4
9dfb1ec50c44d0057981cccda90ee29c644ae336 HEAD@{5}: 3
014bdcf6604056e1cda8b6d8d88d6c846db73826 HEAD@{6}: 2
007ed39dd47696c4ab8e8ccdfcb536b8e21ec8e7 HEAD@{7}: 1

OK there is kind of a screw-up with HEAD@{2} since it should have shown 
"6", and I think it should have shown the movement between branches as 
well, but clearly the output for HEAD doesn't depend on the current 
branch already.

> But then that raises two new problems:
> 
>  - We always said: 'HEAD' means the same thing as your current branch.
>    This is not true anymore.

I think reflogs are a different concept from branch history and that we 
should make sure this is well understood.  And since we seem to agree on 
what the ideal behavior should be I think this has to go in before 
1.5.0 in order to avoid changing this behavior later when more people 
are accustomed to reflogs.

>  - You do not record which branch you were on in the log for
>    HEAD itself (it is merely a dup), so while the latter would
>    report which commit you were at, you cannot tell which branch
>    you were on (or if your head was detached).

Well, it _is_ recorded:

$ sed 's/.*\t//' < .git/logs/HEAD
commit (initial): 1
commit: 2
commit: 3
checkout: moving to otherbranch
commit: 4
commit: 5
commit: 6
checkout: moving to master
commit: 7
commit: 8
checkout: moving to otherbranch
checkout: moving to master

> While I am sure that prune problem is solvable, I have a feeling
> that it would take some time to iron out the semantic issues
> like the above (and I suspect there might be even more).

I think that the problem with HEAD@{n} is that it doesn't take all 
entries into account.  For example the log output skips over the "moving 
to" entries.  If that can be fixed then the difference in semantic 
between git-log HEAD and git-log -g HEAD should be obvious enough simply 
looking at the reflog message lines.

The --pretty=oneline output when using -g should probably display the 
reflog message instead of the commit message as well.


Nicolas

From: Johan Herland <johan@herland.net>
Subject: Re: Recording the current branch on each commit?
Date: Sun, 27 Apr 2014 21:33:05 +0200
Message-ID: <CALKQrgemFx=2JaC1BaRqCwEV+knC8QftxcZ7K0AsT9azzuyVdA@mail.gmail.com>
References: <535C47BF.2070805@game-point.net>
	<CALKQrgfmBByMwMhxu3HkJqJGWy2Rwvij6Hi1_4npjfsxcSgpaQ@mail.gmail.com>
	<535D4085.4040707@game-point.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>
To: Jeremy Morton <admin@game-point.net>
X-From: git-owner@vger.kernel.org Sun Apr 27 21:33:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeUpB-0002Gw-9N
	for gcvg-git-2@plane.gmane.org; Sun, 27 Apr 2014 21:33:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbaD0TdN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2014 15:33:13 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:36262 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178AbaD0TdM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2014 15:33:12 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1WeUp4-0007i0-1d
	for git@vger.kernel.org; Sun, 27 Apr 2014 21:33:10 +0200
Received: from mail-pb0-f41.google.com ([209.85.160.41])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1WeUn7-000H5u-Hl
	for git@vger.kernel.org; Sun, 27 Apr 2014 21:31:09 +0200
Received: by mail-pb0-f41.google.com with SMTP id rr13so5047912pbb.0
        for <git@vger.kernel.org>; Sun, 27 Apr 2014 12:33:05 -0700 (PDT)
X-Received: by 10.68.139.137 with SMTP id qy9mr24510723pbb.11.1398627185256;
 Sun, 27 Apr 2014 12:33:05 -0700 (PDT)
Received: by 10.70.48.232 with HTTP; Sun, 27 Apr 2014 12:33:05 -0700 (PDT)
In-Reply-To: <535D4085.4040707@game-point.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247222>

On Sun, Apr 27, 2014 at 7:38 PM, Jeremy Morton <admin@game-point.net> wrote:
> On 27/04/2014 10:09, Johan Herland wrote:
>> On Sun, Apr 27, 2014 at 1:56 AM, Jeremy Morton<admin@game-point.net>
>> wrote:
>>> Currently, git records a checksum, author, commit date/time, and commit
>>> message with every commit (as get be seen from 'git log').  I think it
>>> would
>>> be useful if, along with the Author and Date, git recorded the name of
>>> the
>>> current branch on each commit.
>>
>> This has been discussed multiple times in the past. One example here:
>> http://thread.gmane.org/gmane.comp.version-control.git/229422
>>
>> I believe the current conclusion (if any) is that encoding such
>> information as a _structural_ part of the commit object is not useful.
>> See the old thread(s) for the actual pro/con arguments.
>
> As far as I can tell from that discussion, the general opposition to
> encoding the branch name as a structural part of the commit object is that,
> for some people's workflows, it would be unhelpful and/or misleading. Well
> fair enough then - why don't we make it a setting that is off by default,
> and can easily be switched on?  That way the people for whom tagging the
> branch name would be useful have a very easy way to switch it on.

Obviously, the feature would necessarily have to be optional, simply
because Git would have to keep understanding the old commit object
format for a LONG time (probably indefinitely), and there's nothing
you can do to prevent others from creating old-style commit objects.

Which brings us to another big con at this point: The cost of changing
the commit object format. One can argue for or against a new commit
object format, but the simple truth at this point is that changing the
structure of the commit object is expensive. Even if we were all in
agreement about the change (and so far we are not), there are multiple
Git implementations (libgit2, jgit, dulwich, etc.) that would all have
to learn the new commit object, not to mention that bumping
core.repositoryformatversion would probably make your git repo
incompatible with a huge number of existing deployments for the
foreseeable future.

Therefore, the most pragmatic and constructive thing to do at this
point, is IMHO to work within the confines of the existing commit
object structure. I actually believe using commit message trailers
like "Made-on-branch: frotz" in addition to some helpful
infrastructure (hooks, templates, git-interpret-trailers, etc.) should
get you pretty much exactly what you want. And if this feature turns
out to be extremely useful for a lot of users, we can certainly
consider changing the commit object format in the future.

> I know
> that for the workflows I personally have used in the past, such tagging
> would be very useful.  Quite often I have been looking through the Git log
> and wondered what feature a commit was "part of", because I have feature
> branches.  Just knowing that branch name would be really useful, but the
> branch has since been deleted... and in the case of a ff-merge (which I
> thought was recommended in Git if possible), the branch name is completely
> gone.

True. The branch name is - for better or worse - simply not considered
very important by Git, and a Git commit is simply not considered (by
Git at least) to "be part of" or otherwise "belong to" any branch.
Instead the commit history/graph is what Git considers important, and
the branch names are really just more-or-less ephemeral pointers into
that graph.

AFAIK, recording the current branch name in commits was not considered
to the worth including in Linus' original design, and since then it
seems to only have come up a few times on the mailing list. This is
quite central to Git's design, and changing it at this point should
not be done lightly.

IINM, Mercurial does this differently, so that may be a better fit for
the workflows where keeping track of branch names is very important.

>> That said, you are of course free to add this information to your own
>> commit messages, by appending something like "Made-on-branch: frotz".
>> In a company setting, you can even create a commit message template or
>> (prepare-)commit-msg hook to have this line created automatically for
>> you and your co-workers. You could even append such information
>> retroactively to existing commits with "git notes". There is also the
>> current interpret-trailers effort by Christian Couder [1] that should
>> be useful in creating and managing such lines.
>>
>> [1]: http://thread.gmane.org/gmane.comp.version-control.git/245874
>
> Well I guess that's another way of doing it.  So, why aren't Author and Date
> trailers?  They don't seem any more fundamental to me than branch name.  I
> mean the only checkin information you really *need* is the checksum, and
> commit's parents.  The Author and Date are just extra pieces of information
> you might find useful sometimes, right?  A bit like some people might find
> branch checkin name useful sometimes...?

Yeah, sure. Author and Date (and Committer, for that matter) is just
metadata, and the current branch name is simply just another kind of
metadata. All of them are more-or-less free-form text fields, and off
the top of my head, I can't really say that if we were to design Git
from scratch today, they wouldn't all become optional trailers (or
headers, or what-have-you).

However, we're not designing Git from scratch, and we have to work
with what is already there...

>>> The branch name can provide useful
>>> contextual information.  For instance, let's say I'm developing a suite
>>> of
>>> games.  If the commit message says "Added basic options dialog", it might
>>> be
>>> useful to see that the branch name is "pacman-minigame" indicating that
>>> the
>>> commit pertains to the options dialog in the Pacman minigame.
>>
>> In that partcular case, ISTM that the context ("pacman-minigame")
>> would actually be better preserved elsewhere. E.g. the commits touch
>> files in a particular "minigames/pacman" subdir, or you prefix the
>> context in the commit message ("pacman-minigame: Added basic options
>> dialog"). Also, such a "topic" branch is often tied to a specific
>
> Again, this is a pain because you have to remember to manually tag every
> commit message with "pacman-minigame", and it takes up precious space in the
> (already short) commit message.

Yes, which is why I advise you to look at commit message templates,
hooks, and interpret-trailers to see if you can find a way to automate
this for you and your co-workers.

[...]

>> anyway, if the branch ends up getting merged to the mainline, the
>> merge commit defaults to a message like "Merge branch
>> 'pacman-minigame'".
>
> Only if it's a non-ff merge, which results in less tidy commit trees, and
> hence is often recommended against.

Not at all. If you're developing a series of commits with a common
purpose (a.k.a. a topic branch) I would very much argue for
non-ff-merging this, _exactly_ because the merge commit allows you to
introduce the entire topic as a single entity. The merge commit
message (in addition to containing the branch name) is also the
natural place to describe more general things about the topic as a
whole - sort of like the cover letter to a patch series.

The problem is not really "less tidy commit trees" - by which I gather
you mean history graphs that are non-linear. IMHO, the history graph
should reflect parallel/branched development when that is useful.
Blindly rebasing everything into a single line is IMHO just as bad as
doing all your work directly on master and blindly running "git pull"
between each of your own commits (which results in a lot of useless
merges). The merge commits themselves are not the problem. Merge
commits are a tool, and when used properly (to introduce topics to the
master branch like described above) they are a good tool. When abused
(like blindly running "git pull" and accepting useless "merge
bubbles") they create more problems than they solve.

>  Whatsmore, tracking down which branch a
> commit pertains to is still rather difficult using this approach.  You can
> go back through the history and find "Merge branch 'pacman-minigame'", but
> how do you know which commit was the *start* of that branch, if they are not
> tagged with the branch name?

Once you have found the merge commit (M), git log M^1..M^2 should list
all the commits that were made on that branch. The parent of the last
in that list can be considered the starting point for the branch.


Hope this helps,

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net

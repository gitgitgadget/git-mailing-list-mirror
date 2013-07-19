From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Git Clone Parameter
Date: Fri, 19 Jul 2013 18:19:39 +0100
Organization: OPDS
Message-ID: <101D1917805742BE86814C6E6E51C378@PhilipOakley>
References: <FB572366-0B1D-4053-9255-979CB213B160@gmail.com> <7v4nbqzj7u.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Allan Acheampong" <allanadjei@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 20:20:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0FIC-0004Iu-J9
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 20:20:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760997Ab3GSSUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 14:20:33 -0400
Received: from smtp2go.com ([207.58.142.213]:56994 "EHLO smtp2go.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760631Ab3GSSUc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 14:20:32 -0400
X-Greylist: delayed 3666 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Jul 2013 14:20:32 EDT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230836>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Friday, July 19, 2013 4:02 PM
> Allan Acheampong <allanadjei@gmail.com> writes:
>
>> ... I'm new to git, but I found it very
>> confusing to understand the difference between "remote" ,
>> "remotes". Is it in the cloned repo, or is it in a remote place?
>> If its local, why doesn't it get shown when I do 'git branch' but
>> when I do 'git branch -a'.

Allan,
This (not being sure about local remote branches and distant remote
branches, while coping with multiple remote servers) appears to be a
common problem for new folks, which those well versed in the use of Git
have become well used to so don't see the problem.

For the uninitiated, the lack of distinct terminology can cause no end
of confusion as most explanations presume that you will implicitly
understand the context, which can't be true for such newbies. It doesn't
help that the 'remotes' model of the Git DVCS fits a work flow style
that isn't the same as the expectation of the newbie.

For example, in a larger collaboration there can be many many branches
(on a communal server) that essentially belong to other contributors
which one would never be interested in, and you (and they) would want
ignored.

>> ...
>> For example, I create a project locally
>> with multiple branches, push it, delete it locally and clone it
>> back to my machine. On a 'git branch' I would only see the head
>> branch.

Junio explains below how your suggestion of 'only the head branch'
viewpoint is too limiting (among other things).

That said, if you have a terminology for the distinction between the
confusing aspects (once understood), then that would be worth something
to help ease the path of understanding for others. I had the same
confusions for a while, and even now have to use some of the awkward
terminology I used above, so any improvements in that area would be
useful. -- Branching models are an endless source of discussion!

Philip

>> ...
>> I'd like to know your opinions about that and what you think about
>> the suggestion.
>
> Not very interested, for a few reasons:
>
> (1) It is actively harmful if the aim is to blur the distinction
>     between local branches and remote-tracking branches. New users
>     will be in a lot of hurt if they are not aware that the
>     'master' branch in their repository is unique and different
>     from the 'master' branch of everybody else's repository and the
>     'origin' remote repository they cloned from.
>
> (2) It is not necessary. You can do interesting things to the
>     history on your local branch, like creating new commits to grow
>     the branch, only after checking it out. And modern Git lets you
>     say
>
>     $ git checkout topic
>
>     and it DWIMs the request to "check out the topic branch" to do
>     the equivalent of
>
>     $ git branch -t topic origin/topic && git checkout topic
>
>     when 'topic' does not exist as your local branch and there is a
>     single remote (i.e. 'origin') that has a remote-tracking branch
>     of that same name 'topic'. This lets you create a corresponding
>     local branch lazily any time you want to work on extending the
>     work on a branch taken from the remote, and output from "git
>     branch --list" to be meaningful: it only lists your local
>     branch, the ones you have already said that you are interested
>     in working on in this repository.
>
> (3) It makes "git branch --list" output less useful if you create
>     local branches that correspond to all the branches taken from
>     the remote.  You cannot tell which ones you have worked on and
>     which ones you haven't even touched yet.
>
> Having said that, it is fairly trivial to script it, if you really
> want to do so, ignoring all of the above downsides.  Something like:
>
> git for-each-ref --format='%(refname)' refs/remotes/origin/ |
> sed -e 's|^refs/remotes/origin/||' -e '/^HEAD$/d' |
> while read branchname
>        do
> git show-ref -q --verify "refs/heads/$branchname" ||
>                git branch -t "$branchname" "origin/$branchname"
> done
>
> But for the reasons stated, it is not a particularly good way to
> work to start from many local branches that are copies of all the
> remote-tracking branches, many of which you may not even touch, so I
> personally do not think we would want to add such an option to
> "clone".  The implementation would be fairly trivial, as you can see
> from the "trivial script" above, but it would encourage a wrong
> workflow.
>
> Older Git around 1.4.x days used to conflate remote-tracking
> branches and local branches, and threw everything in refs/heads/
> hierarchy, which had the exact set of problems above, and that is
> why modern Git uses refs/remotes/origin/ hierarchy to store the
> remote-tracking branches separately, for less cluttered local branch
> namespace.
>

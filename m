From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git annoyances
Date: Wed, 09 Apr 2008 14:04:33 -0700
Message-ID: <7vfxtu3fku.fsf@gitster.siamese.dyndns.org>
References: <20080409101428.GA2637@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Wed Apr 09 23:07:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjhVV-0005ol-4i
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 23:07:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755351AbYDIVFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 17:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755006AbYDIVFw
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 17:05:52 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44188 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754513AbYDIVFv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 17:05:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DDCCE1D1DC;
	Wed,  9 Apr 2008 17:04:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id AAF051D1A2; Wed,  9 Apr 2008 17:04:41 -0400 (EDT)
In-Reply-To: <20080409101428.GA2637@elte.hu> (Ingo Molnar's message of "Wed,
 9 Apr 2008 12:14:28 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79136>

Ingo Molnar <mingo@elte.hu> writes:

> i just had a rather annoying session with git - here's the dump and 
> commentary, in case anyone is interested in usability fineprint.

Thanks.  It is always enlightening to see this kind of walkthru session to
learn where the UI warts are.  The ones with concrete suggestions for
improvements are even more appreciated.

> usually i just have a single git repo that tracks everything 
> interesting, but this time i did something i rarely do: i tried to merge 
> one local tree of mine into another local tree of mine. So i had no 
> commands (or even concepts) cached in my short-term memory that would 
> achieve this goal, i just tried the commands that i thought to be 
> 'obvious', without applying much (or any) IQ to those commands:
>
>  $ cd linux-2.6-sched-devel.git
>
>  $ git-remote add ~/linux-2.6-x86.git

You told git that "I'll interact with this other repository from now on,
so please help me with some extra settings to do so.  Namely I do not want
to keep typing it in full URL all the time so I want an abbreviated way to
tell you I am talking about this remote repository, and also I want to
have set of remote tracking branches for this one".

Maybe "remote add" is not quite the right name to convey the above
concept.

>  $ git-remote show x86
>   * remote x86
>     URL: /home/mingo/linux-2.6-x86.git
>   New remote branches (next fetch will store in remotes/x86)
>   base for-akpm for-linus latest master testing

So the command did as you told it to.

>  $ git-merge x86/latest
>  x86/latest - not something we can merge

You told git "I want to merge a commit into the current branch, and that
commit is called x86/latest".  Alas, no such commit exists in your
repository (yet).  Should we be saying "no such commit exists, you need to
fetch it from elsewhere first"?

>  $ git-fetch x86/latest
>  fatal: 'x86/latest': unable to chdir or not a git archive
>  fatal: The remote end hung up unexpectedly

"Not a git archive" should be clear enough.  You already said "remote show
x86" correctly above, and it makes me wonder why you are now saying
"x86/latest", not "x86" without "latest".

In other words, "git fetch x86".

With that, you would tell git "Hey, I've already told you what I want you
to do with this short-hand name "x86". It is the name for the long URL
I've previously given you and I want you to fetch from that repository,
and I want its branches to be stored in remote tracking branches in my
repository".

But you didn't.  You are not taking advantage of your previous "git remote
add".

I am suspecting that a cause of this confusion is partly because earlier
in 1.3.0 days we tried to make things easy for CVS migrants where they
always interact with a single "upstream" repository and with _the_ single
branch, and we were _too_ successful in doing so.

That made us allowing the users to type "git pull" and "git fetch" without
parameters.  This is generally a good thing: shorter to type for doing
common things is always good, as long as the user knows what he is doing.

But at the same time, this allowed docs and cheat-sheets that mention only
the form without parameters and not the normative "repository refspec"
form.  This dumbed down the users not understand that in that context
fetch (and pull, which is a fetch followed by a merge) is always happening
against a single branch of single remote repository, the way to name
remote repository and its branch(es) is to give them as separate
parameters, and their not typing the pair explicitly is a mere convenience
feature.  This particular aspect of the shorthand is actually very bad.
It makes the mental model fuzzy, and hiding important rules of how the
world works from new people would lead them to unnecessary confusion.  In
short, we made it harder for the new people to "get" it.

The introductory documents may need to be updated to teach explicit "git
pull $repo $branch" form first, and if they are short documents, end in
introductory phase and leave the remainder to "further reading", they
should probably be fixed not talk about the shorthand form "git pull
$nick" and "git pull" without parameters at all.  That may help fixing
this mental-model breakdown.

>  $ git-pull x86 latest
>
> (that fetch+merge went problem-free.)

Yes.

Because git is distributed, a branch in the global scope is named with a
pair "remote" and "branch" as two separate parameters, and we consistently
do so.  Always.  Just like you are supposed to say in your "Linus, please
pull" requests (e.g. http://article.gmane.org/gmane.linux.kernel/321590).

> but it was a PITA and all of git's messages about the problem were not 
> only unhelpful, they confused me into looking for problems where there 
> were none IMO.

Yes, we need to teach "git" to do more mind-reading (I am not being
sarcastic).  There should be a pattern in common user errors that share
their roots to the same user misperception, and if we can identify that,
maybe we can make git guess what the user was really trying to do and give
better error messages than it currently does.

> also, the first natural thing i did was to just type:
>
>  $ git-merge ~/linux-2.6-x86.git/
>
> which i naively assumed would sort things out for me and provide some 
> reasonable default behavior - but instead it just gave an annoyingly 
> unhelpful error message:
>
>  /home/mingo/linux-2.6-x86.git/ - not something we can merge

I'd agree that it is fair to get frustrated with this.

We actually did not have "git merge" as the first level UI citizen for
quite some time, and the way to merge in _anything_ was done with "git
pull", even within the local repository.  If you did not know "git merge"
existed, the above would have been either one of

	$ git pull ~/linux-2.6-x86.git/
	$ git pull ~/linux-2.6-x86.git/ master

and would have been nicer.  But people wanted "git merge" which is a
purely local operation, which made (and still does makes) sense.  But now
people need to know two different commands, one that works globally and
the other that works locally.

C.f.

 http://thread.gmane.org/gmane.comp.version-control.git/10778/focus=10900
 http://thread.gmane.org/gmane.comp.version-control.git/31351/focus=31528
 http://thread.gmane.org/gmane.comp.version-control.git/31351/focus=31490

> there should really be a consciously established "route of failure 
> resolution" - directing people towards relevant sources of information 
> or commands when the git command-line utilities return some error due to 
> user incompetence. Otherwise users just guess around and get frustrated.

Yes, I called it mind-reading above, but we are wishing for the same
thing.

by the way, because you already paid for your Shift keys, you might want
to use it consistently to enhance readability. i find it somewhat
irritating not to be able to tell where each sentence begins with enough
visual cues (i.e. full-stop, two spaces and initial capital letter) and
first person subject not spelled with capital letter i.

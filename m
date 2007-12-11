From: Andreas Ericsson <ae@op5.se>
Subject: Re: "remote end hung up unexpectedly"
Date: Tue, 11 Dec 2007 07:54:13 +0100
Message-ID: <475E3415.3030208@op5.se>
References: <CE1FB037-26E3-475E-9F9D-AC3874987B9C@gmail.com> <475D3AF9.60402@op5.se> <5F13DCA7-5072-4D76-89A7-7F05A5928FA2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Clifford Heath <clifford.heath@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 07:54:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1z0x-0005Gh-ES
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 07:54:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702AbXLKGyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 01:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbXLKGyS
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 01:54:18 -0500
Received: from mail.op5.se ([193.201.96.20]:38370 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751024AbXLKGyS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 01:54:18 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id A4FF21F08037;
	Tue, 11 Dec 2007 07:54:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id szPjgCrL6R-H; Tue, 11 Dec 2007 07:54:15 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id D30B91F08035;
	Tue, 11 Dec 2007 07:54:14 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <5F13DCA7-5072-4D76-89A7-7F05A5928FA2@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67808>

I'm bringing this back on the list. It's very uncharitable of you to not
do so yourself, as it prevents others with the same problem to find the
answer in the archives. Also, I don't run a private support-center for
git, so emailing me privately with questions regarding it is just plain
rude. Everyone's entitled to a second chance though, so read on below.

Clifford Heath wrote:
> On 11/12/2007, at 12:11 AM, Andreas Ericsson wrote:
>> How did you clone it? If you cloned via git:// protocol, you most likely
>> can't push back there. The git-daemon supports pushing, but does no
>> authentication.
> 
> That was a problem - shame git didn't say "connection refused" instead,
> that would have been more obvious. The manpages are loaded with
> git-specific jargon - almost impenetrable for a newbie.
> 

Git doesn't see that. It only knows it didn't get a proper response from
the other end.

> 
>> Not really. You can do "git rebase --onto origin/master master". However,
>> since you merged origin/master earlier, a rebase will only tell you that
>> you're up-to-date.
> 
> I don't think that anything I've done has affected the remote repository.


It hasn't. The only way you can update the remote repository, short of
editing it manually, is to use "git push". That's not strictly true, but
for the sake of this argument, it will suffice.


> At least, no changes are visible in the web view.
> 

You can merge between local branches and still get the "up-to-date" message.


> Most of the instructions and manpages I've read show how to do things
> to local repositories and push changes back. Here's what I most recently
> tried, perhaps you can see where I went wrong. I've changed the project
> name for PROJECT, and the branch name with BRANCH
> 
> git clone git+ssh://cjheath@repo.or.cz/srv/git/PROJECT.git
> cd PROJECT
> git checkout --track -b BRANCH origin/BRANCH
> git rebase origin/master
> 
> At this point the local branch seems to have the content I want, so I tried
> to push the changes back in:
> 

You mean, "at this point BRANCH seems to have the content I want"?

> git push
> 
> Which replied:
> 
> error: remote 'refs/heads/BRANCH' is not a strict subset of local ref 
> 'refs/heads/BRANCH'. maybe you are not up-to-date and need to pull first?
> error: failed to push to 'git+ssh://cjheath@repo.or.cz/srv/git/PROJECT.git'
> 

Yes. What you did caused history to be rewritten. Push is fast-forward[1]
only by default, to prevent published history from being modified, so when
you moved one line of development onto another you effectively changed its
ancestry.

If you do

git checkout BRANCH
git reset --hard origin/BRANCH
git merge origin/master
git push

you will achieve the desired end-result. If you really, really want a linear
history, you can do

git push -f origin BRANCH

but beware that this will cause errors for everyone fetching from you, and
for yourself if you fetch into multiple local clones of the same remote.

I suggest you sit down and really read through the git rebase man-page to
understand what it does and the precautions one must take when rewriting
history like that.


[1]fast-forward:
    A fast-forward is a special type of merge where you have a
    revision and you are "merging" another branch's changes that
    happen to be a descendant of what you have. In such cases,
    you do not make a new merge commit but instead just update
    to his revision. This will happen frequently on a tracking
    of a remote repository.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

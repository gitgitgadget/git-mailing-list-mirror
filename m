From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: contrib/workdir/git-new-workdir broken in 1.7.10 after introducing
 gitfiles
Date: Sun, 22 Apr 2012 14:58:56 -0400
Message-ID: <jn1kdh$6he$1@dough.gmane.org>
References: <CAHsq6J6JOTYfEtK0Z=_qfMFf9N1DWQ4zx46YhBbNu-1gEMyfog@mail.gmail.com> <4F930043.1080506@web.de> <xmqq397wzwwd.fsf@junio.mtv.corp.google.com> <xmqqy5poxtsc.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 22 20:59:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SM20F-000880-KK
	for gcvg-git-2@plane.gmane.org; Sun, 22 Apr 2012 20:59:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752208Ab2DVS7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Apr 2012 14:59:15 -0400
Received: from plane.gmane.org ([80.91.229.3]:34494 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752146Ab2DVS7O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2012 14:59:14 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SM205-00081m-Rh
	for git@vger.kernel.org; Sun, 22 Apr 2012 20:59:09 +0200
Received: from pool-173-79-109-71.washdc.fios.verizon.net ([173.79.109.71])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 Apr 2012 20:59:09 +0200
Received: from mlevedahl by pool-173-79-109-71.washdc.fios.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 Apr 2012 20:59:09 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: pool-173-79-109-71.washdc.fios.verizon.net
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120329 Thunderbird/11.0.1
In-Reply-To: <xmqqy5poxtsc.fsf@junio.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196088>

On 04/22/2012 12:41 AM, Junio C Hamano wrote:
> Junio C Hamano<gitster@pobox.com>  writes:
>
>> As you analyzed correctly, core.worktree lets a GIT_DIR to declare that
>> there is a single working tree associated with it. It fundamentally is
>> incompatible with new-workdir, which is a hack to let more than one
>> working tree associated with a single GIT_DIR.
>>
>> I however do not think a simplistic "unset core.worktree" is a good
>> suggestion, though, as we do not know why the original repository has
>> that variable set pointing at somewhere.  Blindly removing it will break
>> the use of the original repository.  If somebody _really_ wants to use
>> new-workdir for whatever reason in such a setting, I would imagine that
>> doing something like this:
>> ...
>> may work.
>
> I am too lazy to try it out myself, but a hack something along the line
> of the attached patch _might_ turn out to work well.
>
> At least, it gives an incentive to people to update to more recent
> versions of git ;-)  I dunno.
>
> -- >8 --
> Subject: new-workdir: use its own config file
>
> Instead of letting a new workdir share the same config, we simply
> include the original config and override core.worktree in it.  This
> obviously changes the behaviour from the traditional workdir, by making
> any update to the config in a workdir private to that workdir and not
> reflected back to the original repository.  Because a workdir is
> supposed to be just a peek only window to check out a branch that is
> different from the main working tree, and you are not expected to modify
> the config file in any way (e.g. you do not create a new branch with
> remote configuration in a workdir), it may not be a huge issue.
>

This change will break my use of new-workdir, which is maintaining 
multiple checked out branches in separate directories, some with 
embedded modules, and being able to share changes and remote branches 
between them. These directories are time-consuming to set up, so the 
usually suggested approach of "git-checkout $other_branch" is not very 
useful. All of the workdirs are set up off of a common set of bare repos 
kept elsewhere.

There are other ways to share between multiple independent repositories 
on the same machine, but new-workdir is the simplest as there is no push 
/ pull / patch / am involved.

I think the "peek-only" use case is better supported by clone, which on 
a local machine does not copy the object store, and is of course 
well-documented and in core-git. Perhaps a better patch is to just 
suggest "clone" to the user who has core.worktree and/or submodules in use?

Mark

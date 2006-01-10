From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 2/2] Remember and use GIT_EXEC_PATH on exec()'s
Date: Tue, 10 Jan 2006 20:13:34 +0100
Message-ID: <43C4075E.4070407@op5.se>
References: <1136849678.11717.514.camel@brick.watson.ibm.com>	 <1136849810.11717.518.camel@brick.watson.ibm.com>	 <7vwth8bxqd.fsf@assigned-by-dhcp.cox.net>	 <1136900174.11717.537.camel@brick.watson.ibm.com> <43C3CC4A.4030805@op5.se> <1136910406.11717.579.camel@brick.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 20:13:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwOw6-0007uF-Th
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 20:13:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbWAJTNg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 14:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWAJTNg
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 14:13:36 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:46739 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751291AbWAJTNf
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2006 14:13:35 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 68DD46BD03; Tue, 10 Jan 2006 20:13:34 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Michal Ostrowski <mostrows@watson.ibm.com>
In-Reply-To: <1136910406.11717.579.camel@brick.watson.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14436>

Michal Ostrowski wrote:
> On Tue, 2006-01-10 at 16:01 +0100, Andreas Ericsson wrote:
> 
> 
>>This is the case in the git potty already. git.c must prepend 
>>--exec-path to $PATH, or the whole idea of being able to move scripts 
>>out of the $PATH fails (at least it fails without changing quite a few 
>>of the scripts).
> 
> 
> One could make all the scripts depend on GIT_EXEC_PATH instead of PATH.
> At build time one could generate wrapper functions in git-sh-setup:
> 
> function git-foo () {
> 	$(GIT_EXEC_PATH)/git-foo $*;
> }
> 
> Presuming that all scripts include git-sh-setup, no other shell script
> changes would be needed.
> 

Yuck, for two reasons.

* Not all scripts include git-sh-setup, and for good reasons. If this is 
what you intend please make sure you don't break anything in the process.

* This will spawn a sub-shell for each git-foo process called. Shells 
are way more expensive than the git potty, so the performance hit in 
iterations might be considerable. Think StGit and Cogito as well.


On a side-note, $* will break quoting (you should use "$@" instead, with 
double-quotes attached), and

	$(GIT_EXEC_PATH)/git-foo $*

will try to execute GIT_EXEC_PATH and prepend its output to the rest of 
the command, which is quite obviously wrong.


> 
>>Since it's already in place in the potty and that's required to be in 
>>the $PATH, I think Junio's suggestion of running execlp("git", "git", 
>>...) is a good one. It will add one extra fork() and execve() for each 
>>clone/pull/push, but that isn't much of an issue, really.
>>
> 
> 
> The patch I posted most recently does something comparable; all exec's
> by C git programs go through exec_git_cmd, which actually implements the
> "git potty" logic (and git.c itself uses exec_git_cmd).  If there is to
> be a consistent rule for how to exec a git program from a git C program,
> I think that it's reasonable that there be an API to enforce it.  
> 

True. Perhaps I misread your patch or your reasoning.


> Note that the creation and use of such a function simply means that we
> hide the logic that handles PATH/GIT_EXEC_PATH; how git_exec_cmd()
> actually calls execve() and how PATH and GIT_EXEC_PATH are used is a
> separate issue.  When it comes to the former, I think it is best to have
> all exec's of git programs go through an interface that imposes the same
> PATH/GIT_EXEC_PATH logics.  As to the latter, my only concern is that we
> should never do 'setenv("PATH",....)'.
> 

setenv("PATH", ..) is way preferrable over the git-setup.sh hackery 
suggested above, so long as it's only ever done in the git potty. That's 
what the potty is there for, after all.

> 
>>>An approach that I think is better is to require all exec's of git
>>>programs from within git programs to use a specific git interface,
>>>rather than letting each one set up it's own exec parameters.
>>>
>>
>>A better idea would be to teach {send,upload}-pack about $GIT_EXEX_PATH 
>>and export it from your shells rc-file.
>>
> 
> 
> My shell's rc-file doesn't get invoked when using ssh as a transport;
> that's part of the problem.
> 

It does for me and everybody else. $HOME/.bashrc is read even for 
non-interactive shells. $HOME/.bash_profile isn't. If you're using 
git-shell you're in to a whole different situation, but you didn't say 
so so I don't think you are.

>>
>>If a user invokes "/home/user/bin/git-foo" rather than 
>>"/home/user/bin/git foo" he/she will have to have the rest of the 
>>git-suite in the $PATH. Prepending whatever directory any git-* program 
>>happens to reside in to $PATH is not a good idea. 
> 
> 
> Isn't this exactly what git.c is doing currently via prepend_to_path()?
> 

No. git prepends whatever was passed in --exec-path=/some/path, what's 
found in $GIT_EXEC_PATH or the GIT_EXEC_PATH pre-processor macro set at 
compile-time, in that order of preference. There's a very big difference.


> git programs exec other git programs, but they also exec non-git
> programs.  I think it is not appropriate to change PATH (via
> prepend_to_path) because this may result in unexpected behavior when
> exec'ing non-git programs:
> 
> Suppose git is installed in /usr/bin, where a "diff" resided.
> I've got my own version of "diff" in /home/user/bin.
> PATH=/home/user/bin:/usr/bin.
> 
> If git now tries to execute "diff", after having run
> prepend_to_path(), /usr/bin/diff gets executed, not /home/user/bin/diff.
> The user has set up PATH to ensure that /home/user/bin/diff is the diff,
> but by mucking with PATH we subvert their intentions.
> 

Good point. Perhaps we should only prepend to path when the directory 
isn't already in $PATH, or append rather than prepend.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 2/2] Remember and use GIT_EXEC_PATH on exec()'s
Date: Tue, 10 Jan 2006 16:01:30 +0100
Message-ID: <43C3CC4A.4030805@op5.se>
References: <1136849678.11717.514.camel@brick.watson.ibm.com>	 <1136849810.11717.518.camel@brick.watson.ibm.com>	 <7vwth8bxqd.fsf@assigned-by-dhcp.cox.net> <1136900174.11717.537.camel@brick.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 16:02:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwL0E-00088t-MR
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 16:01:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbWAJPBd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 10:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWAJPBd
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 10:01:33 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:12690 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751088AbWAJPBd
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2006 10:01:33 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 384AC6BD03; Tue, 10 Jan 2006 16:01:31 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Michal Ostrowski <mostrows@watson.ibm.com>
In-Reply-To: <1136900174.11717.537.camel@brick.watson.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14422>

Michal Ostrowski wrote:
> On Mon, 2006-01-09 at 18:52 -0800, Junio C Hamano wrote:
> 
>>About fetch-clone.c (which is shared by fetch-pack and
>>clone-pack), it runs "git-index-pack" from finish_pack and
>>"git-unpack-objects" from unpack_pack, so spelling these exec
>>with execlp("git", "git", "index-pack", ...) might be cleaner,
>>since "git" is required to be in users' PATH even though git-*
>>may be moved out of the PATH in later versions of git.  I
>>dunno...
>>
>>In send-pack.c, I wonder why you didn't do a setup_exec_path()
>>at the beginning of main() instead of having two calls close to
>>exec*() call site.
>>
>>The same comment applies for run-command.c; you do it once for
>>each child, but calling it once at the beginning of receive-pack
>>would be good enough.  The same thing for daemon.c.
>>
>>I suspect you are trying to limit the extent of damage, but I do
>>not think of a downside if we just call setup_exec_path() once
>>at the beginning of main().  $GIT_EXEC_PATH _could_ have a
>>private copy of broken "diff" to confuse diff-* family, but you
>>cannot say "git diff" in such a setup anyway because "git" does
>>the PATH prefixing already, so it would be a moot point.
>>
> 
> 
> I'm not actually happy with the idea of mucking around with PATH, even
> within git.c.  Hence I tried to only change PATH if the code had already
> committed to an exec.
> 

This is the case in the git potty already. git.c must prepend 
--exec-path to $PATH, or the whole idea of being able to move scripts 
out of the $PATH fails (at least it fails without changing quite a few 
of the scripts).

Since it's already in place in the potty and that's required to be in 
the $PATH, I think Junio's suggestion of running execlp("git", "git", 
...) is a good one. It will add one extra fork() and execve() for each 
clone/pull/push, but that isn't much of an issue, really.


> An approach that I think is better is to require all exec's of git
> programs from within git programs to use a specific git interface,
> rather than letting each one set up it's own exec parameters.
> 

A better idea would be to teach {send,upload}-pack about $GIT_EXEX_PATH 
and export it from your shells rc-file.


> Once you have that implemented, we can have a separate discussion of how
> the executable is to be found; 
>  - should we use PATH?
>  - should we change PATH?
>  - should we always exec using an absolute file name? (my preference)
>  
> If a user invokes /home/user/bin/git-foo, and git-foo wants to call
> git-bar, is it legitimate for git-foo to call /usr/local/bin/git-bar, or
> should it require /home/user/bin/git-bar?
> 

If a user invokes "/home/user/bin/git-foo" rather than 
"/home/user/bin/git foo" he/she will have to have the rest of the 
git-suite in the $PATH. Prepending whatever directory any git-* program 
happens to reside in to $PATH is not a good idea. Trying to execute 
programs residing in the same directory is an even worse.


> Should the same rules be applied to the shell scripts? (In which case
> we'd want to do something like s:git-:$(GIT_EXEC_PATH)/git-:g.)
> 

All shell-scripts (that I'm aware of) are porcelainish. They should be 
run through the git potty and thus should always run the git-programs 
from the same release as they themselves were built from regardless of 
whether they call them through the potty or directly. This is both sane 
and simple. It was also one of the reasons that the 'git' program was 
implemented in C to begin with.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

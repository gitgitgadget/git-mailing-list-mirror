From: Michal Ostrowski <mostrows@watson.ibm.com>
Subject: Re: [PATCH 2/2] Remember and use GIT_EXEC_PATH on exec()'s
Date: Tue, 10 Jan 2006 11:26:46 -0500
Message-ID: <1136910406.11717.579.camel@brick.watson.ibm.com>
References: <1136849678.11717.514.camel@brick.watson.ibm.com>
	 <1136849810.11717.518.camel@brick.watson.ibm.com>
	 <7vwth8bxqd.fsf@assigned-by-dhcp.cox.net>
	 <1136900174.11717.537.camel@brick.watson.ibm.com> <43C3CC4A.4030805@op5.se>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 17:25:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwMJS-00054F-9M
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 17:25:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbWAJQZ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 11:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbWAJQZ2
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 11:25:28 -0500
Received: from igw2.watson.ibm.com ([129.34.20.6]:54206 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP id S932187AbWAJQZ1
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2006 11:25:27 -0500
Received: from sp1n293en1.watson.ibm.com (sp1n293en1.watson.ibm.com [129.34.20.41])
	by igw2.watson.ibm.com (8.12.11/8.13.1/8.13.1-2005-04-25 igw) with ESMTP id k0AGRPE1009128;
	Tue, 10 Jan 2006 11:27:25 -0500
Received: from sp1n293en1.watson.ibm.com (localhost [127.0.0.1])
	by sp1n293en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_2) with ESMTP id k0AGPBk399878;
	Tue, 10 Jan 2006 11:25:12 -0500
Received: from mgsmtp00.watson.ibm.com (mgsmtp00.watson.ibm.com [9.2.40.58])
	by sp1n293en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_1) with ESMTP id k0AGPBu373378;
	Tue, 10 Jan 2006 11:25:11 -0500
Received: from kitch0.watson.ibm.com (kitch0.watson.ibm.com [9.2.224.107])
	by mgsmtp00.watson.ibm.com (8.12.11/8.12.11/2005/09/01) with ESMTP id k0AHLv55018595;
	Tue, 10 Jan 2006 12:21:57 -0500
Received: from brick (brick.watson.ibm.com [9.2.216.48])
	by kitch0.watson.ibm.com (AIX5.1/8.11.6p2/8.11.0/03-06-2002) with ESMTP id k0AGP8m32162;
	Tue, 10 Jan 2006 11:25:08 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43C3CC4A.4030805@op5.se>
X-Mailer: Evolution 2.4.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14426>

On Tue, 2006-01-10 at 16:01 +0100, Andreas Ericsson wrote:

> 
> This is the case in the git potty already. git.c must prepend 
> --exec-path to $PATH, or the whole idea of being able to move scripts 
> out of the $PATH fails (at least it fails without changing quite a few 
> of the scripts).

One could make all the scripts depend on GIT_EXEC_PATH instead of PATH.
At build time one could generate wrapper functions in git-sh-setup:

function git-foo () {
	$(GIT_EXEC_PATH)/git-foo $*;
}

Presuming that all scripts include git-sh-setup, no other shell script
changes would be needed.



> 
> Since it's already in place in the potty and that's required to be in 
> the $PATH, I think Junio's suggestion of running execlp("git", "git", 
> ...) is a good one. It will add one extra fork() and execve() for each 
> clone/pull/push, but that isn't much of an issue, really.
> 

The patch I posted most recently does something comparable; all exec's
by C git programs go through exec_git_cmd, which actually implements the
"git potty" logic (and git.c itself uses exec_git_cmd).  If there is to
be a consistent rule for how to exec a git program from a git C program,
I think that it's reasonable that there be an API to enforce it.  

Note that the creation and use of such a function simply means that we
hide the logic that handles PATH/GIT_EXEC_PATH; how git_exec_cmd()
actually calls execve() and how PATH and GIT_EXEC_PATH are used is a
separate issue.  When it comes to the former, I think it is best to have
all exec's of git programs go through an interface that imposes the same
PATH/GIT_EXEC_PATH logics.  As to the latter, my only concern is that we
should never do 'setenv("PATH",....)'.

> 
> > An approach that I think is better is to require all exec's of git
> > programs from within git programs to use a specific git interface,
> > rather than letting each one set up it's own exec parameters.
> > 
> 
> A better idea would be to teach {send,upload}-pack about $GIT_EXEX_PATH 
> and export it from your shells rc-file.
> 

My shell's rc-file doesn't get invoked when using ssh as a transport;
that's part of the problem.

> 
> > Once you have that implemented, we can have a separate discussion of how
> > the executable is to be found; 
> >  - should we use PATH?
> >  - should we change PATH?
> >  - should we always exec using an absolute file name? (my preference)
> >  
> > If a user invokes /home/user/bin/git-foo, and git-foo wants to call
> > git-bar, is it legitimate for git-foo to call /usr/local/bin/git-bar, or
> > should it require /home/user/bin/git-bar?
> > 
> 
> If a user invokes "/home/user/bin/git-foo" rather than 
> "/home/user/bin/git foo" he/she will have to have the rest of the 
> git-suite in the $PATH. Prepending whatever directory any git-* program 
> happens to reside in to $PATH is not a good idea. 

Isn't this exactly what git.c is doing currently via prepend_to_path()?

git programs exec other git programs, but they also exec non-git
programs.  I think it is not appropriate to change PATH (via
prepend_to_path) because this may result in unexpected behavior when
exec'ing non-git programs:

Suppose git is installed in /usr/bin, where a "diff" resided.
I've got my own version of "diff" in /home/user/bin.
PATH=/home/user/bin:/usr/bin.

If git now tries to execute "diff", after having run
prepend_to_path(), /usr/bin/diff gets executed, not /home/user/bin/diff.
The user has set up PATH to ensure that /home/user/bin/diff is the diff,
but by mucking with PATH we subvert their intentions.

This is why in my original patch I tried to put the manipulations to
PATH only in points where I knew that it would only affect the exec'ing
of a git program.




> 
> 
> > Should the same rules be applied to the shell scripts? (In which case
> > we'd want to do something like s:git-:$(GIT_EXEC_PATH)/git-:g.)
> > 
> 
> All shell-scripts (that I'm aware of) are porcelainish. They should be 
> run through the git potty and thus should always run the git-programs 
> from the same release as they themselves were built from regardless of 
> whether they call them through the potty or directly. This is both sane 
> and simple. It was also one of the reasons that the 'git' program was 
> implemented in C to begin with.
> 

As described above, we can have shells scripts "always run the
git-programs from the same release as they themselves were built from"
without ever changing PATH.


-- 
Michal Ostrowski <mostrows@watson.ibm.com>

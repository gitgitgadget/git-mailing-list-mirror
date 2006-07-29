From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Call setup_git_directory() early
Date: Sat, 29 Jul 2006 09:52:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607290943550.4168@g5.osdl.org>
References: <Pine.LNX.4.64.0607281811580.4168@g5.osdl.org>
 <7v3bclkwfj.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0607282118230.4168@g5.osdl.org>
 <7vodv9j8yg.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0607282223320.4168@g5.osdl.org>
 <7vzmesg4g3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 29 18:53:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6s3l-0005ty-UW
	for gcvg-git@gmane.org; Sat, 29 Jul 2006 18:53:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbWG2QwZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Jul 2006 12:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752017AbWG2QwZ
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Jul 2006 12:52:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49896 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751374AbWG2QwY (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Jul 2006 12:52:24 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6TGqLnW021538
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 29 Jul 2006 09:52:21 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6TGqKfo014163;
	Sat, 29 Jul 2006 09:52:20 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmesg4g3.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.535 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.141 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24429>



On Sat, 29 Jul 2006, Junio C Hamano wrote:
> 
> > +#define NEEDS_PREFIX 1
> >...
> >  		{ "init-db", cmd_init_db },
> 
> This is an oddball that wants to always use $GIT_DIR environment
> or "./.git" if $GIT_DIR is not exported, and should never go
> looking for GIT_DIR, so we should not give NEEDS_PREFIX, ever.

Well, the way I did things, each command _can_ still decide to call 
"setup_git_directory()" on their own, and we don't actually say up front 
whether they will or not.

So some commands will just choose to let the git.c wrapper do it for them, 
and others can do it their own way, which leaves the maximum of 
flexibility, and doesn't mean that odd-balls like "init-db" really have to 
even be an issue.

> >  		{ "stripspace", cmd_stripspace },
> >  		{ "mailsplit", cmd_mailsplit },
> >  		{ "get-tar-commit-id", cmd_get_tar_commit_id },
> 
> These are the other extreme -- they really do not care about
> operating in a git context.

Right.

>   		{ "push", cmd_push },
>   		{ "count-objects", cmd_count_objects },
> 		{ "check-ref-format", cmd_check_ref_format },
> 
> One rule seems to be that the commands that work at the while
> repository level do not have NEEDS_PREFIX -- they will never
> work from a subdirectory.

Well, maybe we will make them do so, and maybe we won't. 

The way I chose the NEED_PREFIX ones was actually really simple and 
totally automated: I changed every builtin function to first _not_ have 
NEEDS_PREFIX, but changed the prototype to take "const char *prefix" 
instead of the "char **envp" that nobody actually used.

I then compiled them, and for each function that _already_ had a "prefix" 
in their existing implementation (which the compiler warned about), I 
just removed the old "prefix = setup_git_directory()", and added the 
NEEDS_PREFIX flag for that command.

> There is no technical reason not to let count-objects find
> $GIT_DIR on its own, but the current implementation does not do
> that and you are keeping the behaviour bug-to-bug compatible.

Exactly. My conversions (both the first smaller one, and the second thing) 
were really totally mindless translations, nothing fancy. I fixed a few 
bugs as I hit them (ie the first one moved the "setup_git_directory()" 
call earlier over some "git_config()" calls), but other than those kinds 
of local changes, I tried to keep not just the patch, but very much the 
process of me creating it, very straightforward.

> >  		{ "rev-list", cmd_rev_list },
> 
> I think we should mark this with NEEDS_PREFIX, and lose the call
> to setup_git_directory() it has here:

I think you're right, and the above explanation of how the patch was 
mindlessly created explains why my patch didn't do it that way ;)

When I do re-organizations, I like doing them in two stages: the 
"mindless" stage that does the bulk of the syntactic stuff and the 
movement of code, but that pretty much by definition should not introduce 
any new bugs, and then the second stage is the "ok, now we have the new 
organization, we can clean up and fix problems".

			Linus

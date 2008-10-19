From: Maciej Pasternacki <maciej@pasternacki.net>
Subject: Re: [PATCH] -C/--chdir command line option
Date: Sun, 19 Oct 2008 15:47:04 +0200
Message-ID: <86685067-021C-4DC5-A462-AA6834208BDE@pasternacki.net>
References: <20081019000227.GA9423@charybdis.dreamhost.com> <20081019131745.GA8643@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 20 06:46:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrYfg-0004nB-MG
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 15:50:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbYJSNsu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 09:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbYJSNsu
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 09:48:50 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:45915 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbYJSNst (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 09:48:49 -0400
Received: from jankymail-a5.g.dreamhost.com (sd-green-bigip-145.dreamhost.com [208.97.132.145])
	by hapkido.dreamhost.com (Postfix) with ESMTP id E72D6179200
	for <git@vger.kernel.org>; Sun, 19 Oct 2008 06:48:48 -0700 (PDT)
Received: from [192.168.11.248] (vide-sat.pl [213.192.64.46])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jankymail-a5.g.dreamhost.com (Postfix) with ESMTP id 1E66813EE0;
	Sun, 19 Oct 2008 06:47:14 -0700 (PDT)
In-Reply-To: <20081019131745.GA8643@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98610>


On 2008-10-19, at 15:17, Jeff King wrote:

> On Sat, Oct 18, 2008 at 05:02:27PM -0700, Maciej Pasternacki wrote:
>
>> In my project cl-librarian, which is a layer built upon different
>> version control systems, I need to run git pull, but start it from
>> outside of work tree; however, pull needs to be in work tree (as in
>> getcwd()) in order to update said work tree.  --git-dir and
>> --work-tree options don't work; I discussed it on #git yesterday,
>> and it turned out that this issue is nontrivial:
>> [...]
>> the best workaround that occured to me was adding -C/--chdir option  
>> to
>> main git binary, like one that Make accepts.  This fixed my  
>> problem, I
>> paste the resulting patch below:
>
> I'm not completely opposed to -C, as it does match some other tools,
> but it does seem superfluous with --git-dir and --work-tree. Which  
> makes
> me feel like we are just papering over a bug instead of actually  
> fixing
> it (and to be honest, I always wondered what the point of "make -C"  
> was
> in the face of "cd dir && make").

The point of make -C is exactly my usage pattern: invoking make from  
external program.  I have seen, at least in Lisp (external-program)  
and Python (os.spawn, subprocess), libraries to safely and portably  
execute external program by giving literal list of arguments (an easy  
to use wrapper to fork()+exec(); I don't know if such feature exists  
for C).  This allows me not to worry about quoting strange characters  
in pathnames (think injections, if just making it possible to use "&"  
character in directory name is not good enough a reason).  The  
equivalent of "cd dir && make" would be to use system() or invoke sh - 
c; both would require shell-quoting the directory pathname, and would  
carry portability issues -- how do I know that shell on target system  
is actually called "sh" and it supports "&&"?  At least Windows  
systems would be problematic.

The -C option allows me to just specify the directory as it is, and  
child process, after the fork, will take care of the chdir().  No  
quoting, no portability problems, injection-safety included.

As for -C being superfluous: --git-dir and --work-tree seem to support  
weird usage patterns (like work tree separate from git-dir), but it  
seems to me that --work-tree could be just made a synonym of -C, and  
it would behave as expected without creating chicken-and-egg problem  
that doener on #git found (which I don't really understand, but I also  
can't see what --work-tree allows that -C would not -- except creating  
more fragility).  I won't push on --work-tree and -C being  
functionally synonymous, since I don't know git well enough, it's just  
my impression at the moment.

> Please follow the usual list conventions; this stuff should be the
> actual headers of your mail, not in the body of the message. And  
> some of
> the justification you gave above should be part of the commit message.

ACK.  That was how I understood instructions linked from git.or.cz,  
I'll paste message correctly for next version of the patch.

>> +		} else if (!strcmp(cmd, "-C") || !strcmp(cmd, "--chdir")) {
>> +                        chdir((*argv)[1]);
>
> No error detection and reporting? I think I would be quite happy for
> "git -C /some/path clean -dx" to bail out when it saw that it couldn't
> change directory instead of just deleting the contents of wherever I
> happened to be.

Oops.  Looks like I'm spoiled by high-level languages that would  
automatically catch and display an error.  I'll prepare patch v2 today.

> Also, the envchanged flag should probably be set, as for the git-dir  
> and
> work-tree options.

OK.  I thought it means literally environment change, as in setenv().

Thank you for your comments, off to make v2 patch,
Maciej.

-- 
-><- Maciej Pasternacki -><- http://www.pasternacki.net/ -><-

From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Add ability to specify environment extension to run_command
Date: Wed, 23 May 2007 01:14:42 +0200
Message-ID: <20070522231442.GM30871@steel.home>
References: <20070520153908.GF5412@admingilde.org> <20070520181433.GA19668@steel.home> <20070521090339.GH942MdfPADPa@greensroom.kotnet.org> <20070521224828.GA10890@steel.home> <7v7ir1dbl9.fsf@assigned-by-dhcp.cox.net> <20070522214754.GD30871@steel.home> <7v1wh88prw.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sven Verdoolaege <skimo@kotnet.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 23 01:15:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqdZM-0003iU-F6
	for gcvg-git@gmane.org; Wed, 23 May 2007 01:15:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760755AbXEVXOu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 19:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760892AbXEVXOt
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 19:14:49 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:49930 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760755AbXEVXOr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 19:14:47 -0400
Received: from tigra.home (Fc8ee.f.strato-dslnet.de [195.4.200.238])
	by post.webmailer.de (klopstock mo32) (RZmta 6.5)
	with ESMTP id B04717j4MMww1i ; Wed, 23 May 2007 01:14:44 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id A40EC277BD;
	Wed, 23 May 2007 01:14:43 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 30102D195; Wed, 23 May 2007 01:14:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v1wh88prw.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWow37lQ=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48131>

Junio C Hamano, Wed, May 23, 2007 00:19:47 +0200:
> > Others already discussed the issue. Just to be sure, I reimplemented
> > that comfortable putenv with unsetenv: if an environment entry ends
> > with a "=" it will be unset.
> 
> Although combination of putenv and unsetenv gives a somewhat
> queasy feeling for obvious reasons, I'll let it pass.  As we
> are coming up with an interface that uses only one string per
> environment element, that is probably a sensible thing to do,
> rather than trying to do the "historically correct" pairing of
> setenv/unsetenv.
> 
> However, I do not think "VAR=" to unset it is a good interface.
> Having an environment variable whose value happens to be an
> empty string and not having the variable at all are two
> different things.

Right

> Because you _scan_ the whole string in your patch to see if it
> ends with = anyway, a trivial improvement would be to do:
> 
> 	if (strchr(cmd->env, '='))
>                 putenv(cmd->env);
> 	else
>         	unsetenv(cmd->env);

I like this one. The env field in struct child_process and run_command
will have to mention it in comments (in run-command.h), it's kind of
special.

> If you do not mind such a special syntax (e.g. "VAR="), I would
> suggest doing that as a prefix (e.g. "!VAR") and do:

Nah, !VAR is a _working_ environment variable name.

    int main(int argc, char *argv[], char *envp[])
    {
	    const char *argv1[] = {"/usr/bin/perl", "-e", "print $ENV{'!VAR'}", NULL};
	    const char *envp1[] = {"!VAR=value", NULL};
	    execve(*argv, (char**)argv1, (char**)envp1);
	    return 0;
    }

    $ gcc ... && ./a.out
    value

Someone could want it. We surely could use "=", though :)

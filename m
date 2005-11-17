From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix git_config_set() for mean cases
Date: Thu, 17 Nov 2005 22:10:15 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511172200490.18177@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0511161045310.16596@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vwtj847kj.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0511170027380.9687@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vhdab3nlz.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0511171115200.20898@wbgn013.biozentrum.uni-wuerzburg.de>
 <7voe4jwm5w.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0511171252070.737@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v1x1ful7j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 22:10:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ecr1W-0000xf-HC
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 22:10:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbVKQVKT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 16:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbVKQVKT
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 16:10:19 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:63664 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964872AbVKQVKR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 16:10:17 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5369513FD2B; Thu, 17 Nov 2005 22:10:16 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 33C9D9F347; Thu, 17 Nov 2005 22:10:16 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id DE0B298FA6; Thu, 17 Nov 2005 22:10:15 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C9E2F13FD2B; Thu, 17 Nov 2005 22:10:15 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1x1ful7j.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12152>

Hi,

[taking the discussion back to public]

On Thu, 17 Nov 2005, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Also, I felt that a function like git_config_set() was lacking for too 
> > long from git. Maybe git-init-db does not need that flag, but I guess that 
> > we'd want to write config variables comfortably from C at some stage.
> 
> Yes.  But I hesitate to throw in an interface that dismisses the
> multivalued key problem without thinking things through first.

Okay, I gave it some thought. See below for my points.

> BTW, I think this discussion should be thrown back to the
> public.  It went private by accident.

Hereby done.

> Mind rehashing the discussion so far in the open?
> 
> The main points I can think of are:
> 
>  - configuration file format and semantics cleanups (methinks
>    it is premature to talk about implementation and interface
>    before discussing this).
> 
>    - allowing sectionless variables seems to be a bug.  disallow
>      it.

 Agree.

>    - section names are alnum (i.e. they can start with a digit)
>      while variable names are alpha+alnum.  is this what we
>      want?  otherwise how should the rule be changed?

It seems natural to make variables start with alpha, since people are so 
used to it. It would not hurt the parsing to make them possibly start with 
a digit, but I think it's okay to let it be as it is.

>    - multivalued variables.  it is nice to have such, and is
>      easier to read by humans (methinks).  it is not how other
>      systems do .ini format, and the tools can live with single
>      value and parse it into list of values (methinks that is
>      what you are saying).  which way are we going?  does the
>      order matter in such list valued variable in either case?

To recap:

        [proxy]
                command="ssh" for "ssh://kernel.org/"
                command="proxy-command" for kernel.org
                command="myprotocol-command" for "my://"

It should be possible to set only the command for kernel.org while leaving 
the others. I actually implemented a function

	git_config_set_multivar(const char* name, const char* value,
		const char* value_regex);

which you can call like this:

	git_config_set_multivar(
		"proxy.command",
		"\"rsh\" for kernel.org",
		"for kernel.org$");

to change just the second command. You can use that function also to 
unset (i.e. remove) an entry:

	git_config_set_multivar(
		"proxy.command",
		NULL,
		"for \"ssh://kernel.org\"$");

>  - having a way for scripts to query and update the config file
>    programatically is a good thing, both from C level and script
>    level (i do not think there is a disagreement between us on
>    this point).

There is no disagreement.

>    - _if_ we do multivalued variables, what is the interface to
>      append, replace, and remove one of the values?  (we may be
>      able to get away by only supporting "replace the whole
>      thing", in which case the program can do git_config_get()
>      to grab the list, manipulate the list and feed the updated
>      list to git_config_set()).

See above. For clarities sake, I left "git_config_set(name,value)" as 
shortcut to "git_config_set_multivar(name,value,NULL)", i.e. calling the 
multivar version with value_regex==NULL actually reverts to singlevar 
version.

I'll send out the patches in a few minutes (have to get them into shape 
first).

Ciao,
Dscho

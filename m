From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH][RESEND] git-submodule: provide easy way of adding new
 submodules
Date: Sun, 24 Jun 2007 17:17:50 +0200
Message-ID: <20070624151750.GA997MdfPADPa@greensroom.kotnet.org>
References: <20070621095300.GA27071MdfPADPa@greensroom.kotnet.org>
 <7v8xaa4f5g.fsf@assigned-by-dhcp.pobox.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 24 17:18:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2Tqh-0004TH-SP
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 17:18:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752568AbXFXPRx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 11:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752378AbXFXPRx
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 11:17:53 -0400
Received: from psmtp13.wxs.nl ([195.121.247.25]:53234 "EHLO psmtp13.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751596AbXFXPRw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 11:17:52 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp13.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JK500BG8BTQ9I@psmtp13.wxs.nl> for git@vger.kernel.org; Sun,
 24 Jun 2007 17:17:51 +0200 (MEST)
Received: (qmail 7155 invoked by uid 500); Sun, 24 Jun 2007 15:17:50 +0000
In-reply-to: <7v8xaa4f5g.fsf@assigned-by-dhcp.pobox.com>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50799>

On Sat, Jun 23, 2007 at 12:58:03PM -0700, Junio C Hamano wrote:
> Somehow "git submodule add $URL $my_subdirectory" feels
> unnatural, although it certainly is simpler to write the command

The order of the arguments is the same as those of git-clone and
you can read it as "git: add submodule $URL (at) $my_subdirectory"

> usage string.  Wouldn't a commit on the maintenance branch of
> cgit.git want to say "Add the 'maint' branch of git.git as my
> submodule", for example?

Sounds plausible

> The alternatives I can come up with do not feel right either, though.
> 
> 	git submodule $my_subdirectory $URL [$branch]
> 	git submodule $URL [--branch $branch] $my_subdirectory

I'll add the latter, although it's not clear if you actually
want me to.

> > diff --git a/git-submodule.sh b/git-submodule.sh
> > index 89a3885..3df7121 100755
> > --- a/git-submodule.sh
> > +++ b/git-submodule.sh
> > @@ -1,13 +1,14 @@
> >  #!/bin/sh
> >  #
> > -# git-submodules.sh: init, update or list git submodules
> > +# git-submodules.sh: add, init, update or list git submodules
> >  #
> >  # Copyright (c) 2007 Lars Hjemli
> >  
> > -USAGE='[--quiet] [--cached] [status|init|update] [--] [<path>...]'
> > +USAGE='[--quiet] [--cached] [add <repo>|status|init|update] [--] [<path>...]'
> 
> Can a single repo added at more than one path with this syntax?

No.  I was trying to be brief.  The more correct syntax would be the one
in the documentation, but I thought that would be a bit lengthy for
USAGE.

> I've seen this code before elsewhere.  We do not need to
> refactor right now with this patch, but please mark this copy
> with something like:
> 
> 	# NEEDSWORK: identical function exists in get_repo_base
>         # in clone.sh
> 	get_repo_base () {
>         	...

OK

> > +	test -e "$path" &&
> > +	die "'$path' already exists"
> > +
> > +	module_clone "$path" "$repo" || exit
> 
>  - module_clone catches the "$path already exists" case; but the
>    test is done differently.  One particular case of "an empty
>    directory exists" is allowed there, but you are dying early
>    to forbid it.  Is that warranted?  My gut feeling is that
>    they should share the same check, iow, don't check yourself
>    but have module_clone take care of the error case.

They're different because submodule update (which also calls module_clone)
is performed on a module that already exists in the repo and
was therefore checked out by git as an empty directory.  If you
add a new submodule, then there is no reason for the subdirectory
to exist already.

>  - If $path does not exist in the worktree (because it hasn't
>    been checked out), but does exist in the index, what should
>    happen?  Should it be flagged as an error (in module_clone,
>    not here)?

Good question.  It should fail.  However, I think this new check
does belong here, because when module_clone is called from
modules_update, the path _should_ exist in the index.

skimo

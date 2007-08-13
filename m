From: Sven Verdoolaege <skimo@liacs.nl>
Subject: Re: [PATCH v3] git-apply: apply submodule changes
Date: Mon, 13 Aug 2007 11:37:40 +0200
Message-ID: <20070813093740.GA4684@liacs.nl>
References: <20070810093049.GA868MdfPADPa@greensroom.kotnet.org> <20070812142340.GA10399MdfPADPa@greensroom.kotnet.org> <7vwsw0ipp2.fsf@assigned-by-dhcp.cox.net> <20070812185006.GG999MdfPADPa@greensroom.kotnet.org> <7vr6m8imj6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>,
	Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 11:38:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKWNp-0000e9-Se
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 11:38:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S943640AbXHMJiH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Aug 2007 05:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S943646AbXHMJiG
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 05:38:06 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:58374 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S943640AbXHMJh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2007 05:37:59 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l7D9bfZZ019917;
	Mon, 13 Aug 2007 11:37:46 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 091843C00C; Mon, 13 Aug 2007 11:37:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vr6m8imj6.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55754>

On Sun, Aug 12, 2007 at 12:24:29PM -0700, Junio C Hamano wrote:
> Sven Verdoolaege <skimo@kotnet.org> writes:
> 
> >>  - what does ce have to do in this codepath?  read_old_data()
> >>    does not care about what is in the index (in fact, in the
> >>    index the entry can be a symlink when the path on the
> >>    filesystem is a regular file, and it reads from the regular
> >>    file as asked--it does not even look at ce by design).  
> >>    if you have a regular file there in the current version, ce
> >>    would say it is a regular file blob and you would not want
> >>    read_gitlink_or_skip() to say "Subproject commit xyz...".
> >
> > Hmmm... the documentation says that if --index is in effect
> > then the file to be patched in the work tree is supposed to be 
> > up-to-date.
> 
> But that is the job of check_patch(), not this function, isn't it?

Ah... so you want me to check that there has been no type change
to the submodule in check_patch (and then I can use my
read_gitlink_or_skip as is).  Is that right?

> >> The type-mismatch case to attempt to apply gitlink patch to a
> >> regular blob is covered much earlier in check_patch().  It
> >> complains if st_mode does not match patch->old_mode; I think you
> >> need to adjust it a bit to:
> >> 
> >>  - allow gitlink patch to a path that currently has nothing (no
> >>    submodule checked out) or a directory that has ".git/"
> >>    (i.e. submodule checked out).
> >> 
> >>  - reject gitlink patch otherwise.
> >
> > Are you talking about the case where --index is specified?
> 
> Talking about both cases, and the division of responsibility
> between check_patch() and apply_data().

I'll do that for the --index case, but I really think it doesn't
make sense for the other case.  If we're not in a git repo,
then the submodule, which may very well be present, is not
going to be a git repo either.

What could make sense is to enforce that in the --index case,
the submodule directory is either empty or a git repo and
that in the non --index case it is empty.

skimo

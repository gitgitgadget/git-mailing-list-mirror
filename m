From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH v3] git-apply: apply submodule changes
Date: Sun, 12 Aug 2007 20:50:06 +0200
Message-ID: <20070812185006.GG999MdfPADPa@greensroom.kotnet.org>
References: <20070810093049.GA868MdfPADPa@greensroom.kotnet.org>
 <20070812142340.GA10399MdfPADPa@greensroom.kotnet.org>
 <7vwsw0ipp2.fsf@assigned-by-dhcp.cox.net>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>,
	Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 12 20:50:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKIVz-0002Ht-Ci
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 20:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933647AbXHLSuM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 14:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933696AbXHLSuM
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 14:50:12 -0400
Received: from psmtp08.wxs.nl ([195.121.247.22]:49671 "EHLO psmtp08.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933743AbXHLSuK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2007 14:50:10 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp08.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JMO00BGRCBJXQ@psmtp08.wxs.nl> for git@vger.kernel.org; Sun,
 12 Aug 2007 20:50:08 +0200 (MEST)
Received: (qmail 9786 invoked by uid 500); Sun, 12 Aug 2007 18:50:06 +0000
In-reply-to: <7vwsw0ipp2.fsf@assigned-by-dhcp.cox.net>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55701>

On Sun, Aug 12, 2007 at 11:16:09AM -0700, Junio C Hamano wrote:
> Sven Verdoolaege <skimo@kotnet.org> writes:
> >  	else if (patch->old_name) {
> >  		size = xsize_t(st->st_size);
> >  		alloc = size + 8192;
> >  		buf = xmalloc(alloc);
> > -		if (read_old_data(st, patch->old_name, &buf, &alloc, &size))
> > +		if (S_ISGITLINK(patch->old_mode))
> > +			size = read_gitlink_or_skip(patch, ce, buf, alloc);
> > +		else if (read_old_data(st, patch->old_name, &buf, &alloc, &size))
> >  			return error("read of %s failed", patch->old_name);
> >  	}
> 
> read_old_data() gets the lstat information from the current
> filesystem data at old_name, and gives the preimage to be
> patched, and naturally it bombs out if it is a directory, but
> when we are applying a change to gitlink, the patch expects
> old_name to be a directory.
> 
> So you introduced read_gitlink_or_skip() to work it around.  But
> this makes me wonder...
> 
>  - what does ce have to do in this codepath?  read_old_data()
>    does not care about what is in the index (in fact, in the
>    index the entry can be a symlink when the path on the
>    filesystem is a regular file, and it reads from the regular
>    file as asked--it does not even look at ce by design).  
>    if you have a regular file there in the current version, ce
>    would say it is a regular file blob and you would not want
>    read_gitlink_or_skip() to say "Subproject commit xyz...".

Hmmm... the documentation says that if --index is in effect
then the file to be patched in the work tree is supposed to be 
up-to-date.  Then for files it shouldn't matter if the data
comes from the index or not.  For submodules it's crucial to
look at the index (if it is available), since that's the
only place you can find the current state of the submodule.
(Remember that git currently doesn't automatically update submodules.)

If I specify --index (e.g., through git rebase), then I really
wouldn't want the patch to apply if the old submodule commit
in the patch doesn't match the submodule commit in the index.
Would you?

>  - what is alloc at this point?  it is based on the size of
>    directory st->st_size.

I assume you mean "size".  For submodules, the value isn't used,
except to test that the "file" is empty (size==0) on delete.
So it seems safe to set it to zero for submodules in any case.

> I think dropping fragments for a patch that tries to modify a
> gitlink here is fine, but that can be done regardless of what ce
> is.

As explained above, I don't think it would a good idea to
just drop gitlink patches if --index is specified.

> The type-mismatch case to attempt to apply gitlink patch to a
> regular blob is covered much earlier in check_patch().  It
> complains if st_mode does not match patch->old_mode; I think you
> need to adjust it a bit to:
> 
>  - allow gitlink patch to a path that currently has nothing (no
>    submodule checked out) or a directory that has ".git/"
>    (i.e. submodule checked out).
> 
>  - reject gitlink patch otherwise.

Are you talking about the case where --index is specified?
Otherwise, I don't think we can make any assumptions on
what's inside the subdirectory.

skimo

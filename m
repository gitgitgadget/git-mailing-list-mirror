From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix handle leak in write_tree
Date: Tue, 24 Apr 2007 11:30:07 +0200
Message-ID: <81b0412b0704240230x3a5b473k5da3d45d9c997c3b@mail.gmail.com>
References: <20070423194925.GA5163@steel.home>
	 <7vps5u9wsk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 24 11:30:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgHLl-00087c-AO
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 11:30:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754617AbXDXJaN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 05:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754621AbXDXJaN
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 05:30:13 -0400
Received: from an-out-0708.google.com ([209.85.132.242]:46416 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754617AbXDXJaL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 05:30:11 -0400
Received: by an-out-0708.google.com with SMTP id b33so2162913ana
        for <git@vger.kernel.org>; Tue, 24 Apr 2007 02:30:10 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XUTwYEPImvo2FMOEMKNK9qm/ircKuQ55GPHpDesFCmEd5muYPzug/YICUUVX1IVlN66TM/SKykWsBnsuInEEFpI+bWnON5f0OL2ymSFRh2lcfC3Hgcm2nSo/NWP0zAZLBqt5nRGxUF/bvKLu8Je6DqLHEuOXq9lxMGwZOUvM9PE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mVnMxdTwM6jHFFYmAtaLWYxBSctG41lUcOOg2zN21EJsaXhYW011oGFdMIpx0hj75fSJUF009ufEDE7g3xOyScOMVUqOqRs3bAugsq+dRMkC/KND8CFM/vwEBx0LWja13OVAmhqKOFLGPEAmSZRiCLxxS5GGHVg2vxkkMS4QbNY=
Received: by 10.100.215.11 with SMTP id n11mr1723720ang.1177407007591;
        Tue, 24 Apr 2007 02:30:07 -0700 (PDT)
Received: by 10.100.86.19 with HTTP; Tue, 24 Apr 2007 02:30:07 -0700 (PDT)
In-Reply-To: <7vps5u9wsk.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45435>

On 4/24/07, Junio C Hamano <junkio@cox.net> wrote:
> > How about something like this (just interface):
> >
> > struct lock_file
> > {
> >       struct lock_file *next;
> >       pid_t owner;
> >       int fd;
> >       char on_list;
> >       char filename[PATH_MAX];
> > };
> >
> > struct lock_file *open_locked(const char *path, int die_on_error);
> > struct lock_file *open_index_locked(int die_on_error);
> > void commit_lock_file(struct lock_file *); /* always assuming .lock */
> > void rollback_lock_file(struct lock_file *);
>
> I agree that making commit and rollback close the file
> descriptor and lock holders to use lock->fd for write() makes
> more sense, although it is a bit unclear from the above set of
> function signatures what your plan on the lifetime rule for
> "struct lock_file" is.  If it will be linked to the list given
> to the atexit() handler and the caller of open_locked() never
> frees it, I think I am fine with the interface.

I actually expected the caller to define the lifetime. atexit is not exactly
libification-effort friendly. I could imagine open*locked with an additional
argument for atexit registration, I just don't like the idea (dislike
die_on_error
too). Isn't such kind of resource control _generally_ nicer to implement
in the top levels of a program?

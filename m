From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git on afs
Date: Fri, 19 Oct 2007 01:48:14 -0400
Message-ID: <20071019054814.GJ14735@spearce.org>
References: <20071018203106.GA13518@fries.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Brandon Casey <casey@nrlssc.navy.mil>
To: "Todd T. Fries" <todd@fries.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 07:48:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iikip-0001tA-TJ
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 07:48:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754501AbXJSFsY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 01:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755262AbXJSFsY
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 01:48:24 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:47894 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754351AbXJSFsX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 01:48:23 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IikiW-0006FS-1K; Fri, 19 Oct 2007 01:48:16 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3324820FBAE; Fri, 19 Oct 2007 01:48:15 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20071018203106.GA13518@fries.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61653>

There's two different issues here so I'm going to split the thread
into two to simplify the discussion.  Well, for me anyway.  ;-)

"Todd T. Fries" <todd@fries.net> wrote:
> 1) git presumes that link() works fine across subdirs; in afs land,
>    hardlinks do not succeed ever
...
> diff --git a/sha1_file.c b/sha1_file.c
> index 83a06a7..1b93322 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1961,7 +1961,7 @@ static int link_temp_to_file(const char *tmpfile, const char *filename)
>  	int ret;
>  	char *dir;
>  
> -	if (!link(tmpfile, filename))
> +	if (!rename(tmpfile, filename))
>  		return 0;
>  
>  	/*
> @@ -1980,7 +1980,7 @@ static int link_temp_to_file(const char *tmpfile, const char *filename)
>  			return -2;
>  		}
>  		*dir = '/';
> -		if (!link(tmpfile, filename))
> +		if (!rename(tmpfile, filename))
>  			return 0;
>  		ret = errno;
>  	}

These cases should already be handled lower, see l.1997-2012 of
sha1_file.c:

    /*
     * Coda hack - coda doesn't like cross-directory links,
     * so we fall back to a rename, which will mean that it
     * won't be able to check collisions, but that's not a
     * big deal.
     *
     * The same holds for FAT formatted media.
     *
     * When this succeeds, we just return 0. We have nothing
     * left to unlink.
     */
    if (ret && ret != EEXIST) {
        if (!rename(tmpfile, filename))

> Brandon Casey <casey@nrlssc.navy.mil> wrote:
> On Thu, 18 Oct 2007, Todd T. Fries wrote:
> 
> > link() returns -1 errno 17 File exists on afs.
> >
> > To further muddy the waters, linking within the same dir is ok,
> > linking outside the same dir is not:
> >
> > todd@ispdesk/p6 ~/tmp=A661$ mkdir dir
> > todd@ispdesk/p6 ~/tmp=A662$ touch a
> > todd@ispdesk/p6 ~/tmp=A663$ ln a b
> > todd@ispdesk/p6 ~/tmp=A664$ ls -l a b
> > -rw-r--r--  2 4  wheel  0 Oct 18 17:09 a
> > -rw-r--r--  2 4  wheel  0 Oct 18 17:09 b
> > todd@ispdesk/p6 ~/tmp=A665$ ls -li a b
> > 2068032 -rw-r--r--  2 4  wheel  0 Oct 18 17:09 a
> > 2068032 -rw-r--r--  2 4  wheel  0 Oct 18 17:09 b
> > todd@ispdesk/p6 ~/tmp=A666$ ln a dir/b
> > ln: dir/b: File exists
> > todd@ispdesk/p6 ~/tmp=A667$ echo $?
> 
> That error is just bogus on afs. If it returned a sane
> error, things would just work.
> 
> But, looks like afs only supports linking within the same
> directory: http://www.angelfire.com/hi/plutonic/afs-faq.html

So according to that error message from "ln" we really should have
fallen into that Coda hack I just mentioned.  Did we instead get
a different errno here and not use that hack?


We probably could just use rename as you do above but then we would
want to remove the unlink(tmpfile) call on l.2013 in sha1_file.c.
Otherwise we're always incurring a syscall for no reason.  I'm not
against a change here, I just want to make sure we make the right
change for AFS.  :-)

-- 
Shawn.

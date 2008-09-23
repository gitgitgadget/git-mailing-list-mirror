From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] add GIT_FAST_STAT mode for Cygwin
Date: Tue, 23 Sep 2008 20:52:47 +0400
Message-ID: <20080923165247.GO21650@dpotapov.dyndns.org>
References: <20080923140144.GN21650@dpotapov.dyndns.org> <81b0412b0809230737s7498e214w4c58991e79f76507@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>,
	Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 18:54:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiB9J-00041b-QK
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 18:54:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbYIWQwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 12:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbYIWQwz
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 12:52:55 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:61081 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515AbYIWQwy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 12:52:54 -0400
Received: by ey-out-2122.google.com with SMTP id 6so627472eyi.37
        for <git@vger.kernel.org>; Tue, 23 Sep 2008 09:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=9Iq4kzGfKoGBKDVmnDiN6Oflnxi/Is3/1iuNuayRGB4=;
        b=bELAchOqVdA911inlwuy2t7Iw9Qj4SrL2kXHpTS1tQQ7O6KyxIda1lGIlxQ+nII8fL
         KjXxNjpsfbJPHHpZK66ZGw9CYu/TnbfJ3SFivZdARpglrQOJ5F+oCnFIVRZMKatm8KSi
         oU745F6f3MG0QEkFSRI1qbqkxHvUWoORY7Yu8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=RS3ySLVg6X9xHpRdqQGgKzoR2arXR8UPHb6FPlNyLGOfFbaqMd4B9eqmIGMgOpGYo6
         ITJHwddnourfcAFRGNXGz2pJtMZv4K80XszrEhmqSDElu15KY0k0c+op8FLTxRMiW1bI
         CXFfHSKMZoMOHvJKqp1YaY/qTOATxzQR3bVBU=
Received: by 10.86.80.5 with SMTP id d5mr6348617fgb.26.1222188771980;
        Tue, 23 Sep 2008 09:52:51 -0700 (PDT)
Received: from localhost (ppp85-140-168-121.pppoe.mtu-net.ru [85.140.168.121])
        by mx.google.com with ESMTPS id 4sm9185302fgg.4.2008.09.23.09.52.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Sep 2008 09:52:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <81b0412b0809230737s7498e214w4c58991e79f76507@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96577>

On Tue, Sep 23, 2008 at 04:37:14PM +0200, Alex Riesen wrote:
> 2008/9/23 Dmitry Potapov <dpotapov@gmail.com>:
> >
> > This fast mode works only for relative paths. It is assumed that the
> > whole repository is located inside one directory without using Cygwin
> > mount to bind external paths inside of the current tree.
> 
> Why runtime conditional? Why conditional at all?

I thought that in rather unusual circumstances (such as using Cygwin
mount to connect separately directories in one tree), this fast version
may not work. So, I made it conditional. It is runtime conditional,
because most users do not build Git themselves but install a ready
Cygwin package.

> Why not fallback
> to cygwin's slow stat on absolute pathnames like you do for symlinks?

Of course, I do:

+       if (file_name[0] == '/')
+               return cygstat (file_name, buf);

Sorry, if it was not clear from my above comment.

> 
> > +/*
> > + * This are startup stubs, which choose what implementation of lstat/stat
> 
> why do you need two of them? Isn't one not enough?

I did not want to give people reasons to say that I broke lstat :)
You can opt for the standard Cygwin version of it if for some reason,
this new function does not work. Now, I know only one case -- it is
when you use Cygwin mount inside of Git repo. Yet, I don't know enough
about Cygwin to be sure that there is no other cases. So, I just wanted
to be extra careful and not to break anything.

> 
> > +stat_fn_t cygwin_stat_fn = cygwin_stat_choice;
> > +stat_fn_t cygwin_lstat_fn = cygwin_lstat_choice;
> ...
> > +typedef int (*stat_fn_t)(const char*, struct stat*);
> > +extern stat_fn_t cygwin_stat_fn;
> > +extern stat_fn_t cygwin_lstat_fn;
> 
>     extern int (*cygwin_stat_fn)(const char *, struct stat *);
> 
> Is shorter, easier to read and easier to understand (for a C person).
> You don't even use the type anywhere else, it is just for the declaration sake!

I use it in description of a parameter of another function:

static int do_stat(const char *file_name, struct stat *buf, stat_fn_t cygstat)

Of course, you can avoid it here too, but the declaration will become
somewhat longer:

static int do_stat(const char *file_name, struct stat *buf,
       int (*cygstat)(const char *, struct stat *));

so I am not sure that removing stat_fn_t improves readability, but if
there are other people who think so, I will correct that.


Dmitry

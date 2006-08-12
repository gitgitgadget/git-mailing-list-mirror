From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: [PATCH] Better error message when we are unable to lock the index file
Date: Sat, 12 Aug 2006 21:19:30 +0200
Message-ID: <20060812191930.GA5205@c165.ib.student.liu.se>
References: <20060812073756.5442.5498.stgit@c165> <7v8xluqt24.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 12 21:19:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBz1E-00058h-I8
	for gcvg-git@gmane.org; Sat, 12 Aug 2006 21:19:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422642AbWHLTTd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Aug 2006 15:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422648AbWHLTTd
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Aug 2006 15:19:33 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:28859 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S1422642AbWHLTTc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Aug 2006 15:19:32 -0400
Received: from c165 ([213.114.27.85] [213.114.27.85])
          by mxfep02.bredband.com with ESMTP
          id <20060812191930.IAFY11843.mxfep02.bredband.com@c165>;
          Sat, 12 Aug 2006 21:19:30 +0200
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1GBz18-000296-00; Sat, 12 Aug 2006 21:19:30 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v8xluqt24.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25262>

On Sat, Aug 12, 2006 at 01:03:47AM -0700, Junio C Hamano wrote:
> Fredrik Kuivinen <freku045@student.liu.se> writes:
> 
> > diff --git a/builtin-update-index.c b/builtin-update-index.c
> > index 24dca47..f8f5e10 100644
> > --- a/builtin-update-index.c
> > +++ b/builtin-update-index.c
> > @@ -493,7 +493,7 @@ int cmd_update_index(int argc, const cha
> >  
> >  	newfd = hold_lock_file_for_update(lock_file, get_index_file());
> >  	if (newfd < 0)
> > -		die("unable to create new cachefile");
> > +		die("unable to lock index file: %s", strerror(errno));
> 
> Looking at output from:
> 
> 	$ git grep -A 3 hold_lock_file_for_update
> 
> I wonder if it might be more consistent to do something like
> this instead.  It removes more lines than it adds ;-).

Looks good, one small comment below.

> diff --git a/lockfile.c b/lockfile.c
> index 2346e0e..a5ea49b 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -22,7 +22,7 @@ static void remove_lock_file_on_signal(i
>  	raise(signo);
>  }
>  
> -int hold_lock_file_for_update(struct lock_file *lk, const char *path)
> +static int lock_file(struct lock_file *lk, const char *path)
>  {
>  	int fd;
>  	sprintf(lk->filename, "%s.lock", path);
> @@ -41,6 +41,14 @@ int hold_lock_file_for_update(struct loc
>  	return fd;
>  }
>  
> +int hold_lock_file_for_update(struct lock_file *lk, const char *path, int die_on_error)
> +{
> +	int fd = lock_file(lk, path);
> +	if (fd < 0 && die_on_error)
> +		die("unable to create new index file");

Could we have (something like)

    die("unable to lock index file: %s", strerror(errno));

here instead?

> +	return fd;
> +}
> +
>  int commit_lock_file(struct lock_file *lk)
>  {
> 	char result_file[PATH_MAX];

- Fredrik

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 7/7] Replace mmap with xmmap, better handling MAP_FAILED.
Date: Sun, 24 Dec 2006 14:22:48 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612241410400.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <487c7d0ea81f2f82f330e277e0aea38a66ca7cfe.1166939109.git.spearce@spearce.org>
 <20061224054723.GG8146@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 24 14:23:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyTJf-0007Eq-M2
	for gcvg-git@gmane.org; Sun, 24 Dec 2006 14:23:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbWLXNWy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Dec 2006 08:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751613AbWLXNWy
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Dec 2006 08:22:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:59694 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751483AbWLXNWx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Dec 2006 08:22:53 -0500
Received: (qmail invoked by alias); 24 Dec 2006 13:22:52 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp007) with SMTP; 24 Dec 2006 14:22:52 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20061224054723.GG8146@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35357>

Hi,

On Sun, 24 Dec 2006, Shawn O. Pearce wrote:

> diff --git a/diff.c b/diff.c
> index f14288b..244292a 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1341,10 +1341,8 @@ int diff_populate_filespec(struct diff_filespec *s, int size_only)
>  		fd = open(s->path, O_RDONLY);
>  		if (fd < 0)
>  			goto err_empty;
> -		s->data = mmap(NULL, s->size, PROT_READ, MAP_PRIVATE, fd, 0);
> +		s->data = xmmap(NULL, s->size, PROT_READ, MAP_PRIVATE, fd, 0);
>  		close(fd);
> -		if (s->data == MAP_FAILED)
> -			goto err_empty;

The only gripe I have here is that the old code could actually say where 
the problem occurred ("cannot read data blob for <blabla>"), but that 
probably does not matter so much, now that we can hardly run out of memory 
on a decent machine, even using big packfiles.

> diff --git a/read-cache.c b/read-cache.c
> index b8d83cc..ca3efbb 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -798,7 +798,7 @@ int read_cache_from(const char *path)
>  		cache_mmap_size = st.st_size;
>  		errno = EINVAL;
>  		if (cache_mmap_size >= sizeof(struct cache_header) + 20)
> -			cache_mmap = mmap(NULL, cache_mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
> +			cache_mmap = xmmap(NULL, cache_mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
>  	}
>  	close(fd);
>  	if (cache_mmap == MAP_FAILED)

This MAP_FAILED no longer has anything to do with MAP_FAILED, but rather 
with fstat failed, so you probably want to move that into an else 
construct just before "close(fd);".

All in all it is a good change -- for the builtin programs.

But it is less good for the libification. Maybe it is time for a 
discussion about the possible strategies to avoid dying in libgit.a?

Ciao,
Dscho

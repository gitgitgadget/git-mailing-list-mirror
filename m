From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [4/5] Add option for hardlinkable cache of extracted blobs
Date: Sun, 17 Apr 2005 19:47:36 +0200
Message-ID: <20050417174736.GA1461@pasky.ji.cz>
References: <Pine.LNX.4.21.0504171108060.30848-100000@iabervon.org> <Pine.LNX.4.21.0504171131230.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 19:44:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNDoe-0000Om-2l
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 19:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbVDQRsB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 13:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbVDQRsB
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 13:48:01 -0400
Received: from w241.dkm.cz ([62.24.88.241]:12436 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261375AbVDQRrl (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 13:47:41 -0400
Received: (qmail 2236 invoked by uid 2001); 17 Apr 2005 17:47:36 -0000
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0504171131230.30848-100000@iabervon.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, Apr 17, 2005 at 05:35:19PM CEST, I got a letter
where Daniel Barkalow <barkalow@iabervon.org> told me that...
> Index: checkout-cache.c
> ===================================================================
> --- 157b46ce1d82b3579e2e1258927b0d9bdbc033ab/checkout-cache.c  (mode:100644 sha1:5d3028df0a45329e45fff2006719c9267adeb946)
> +++ 08f7700831e056ad710af69f91e3a8a705b6b2b1/checkout-cache.c  (mode:100644 sha1:338588259e17dd235fdc7db759d770004a760e15)
> @@ -67,6 +71,80 @@
>  	return fd;
>  }
>  
> +#ifdef HARDLINK_CACHE
> +
> +/*
> + * NOTE! This returns a statically allocated buffer, so you have to be
> + * careful about using it. Do a "strdup()" if you need to save the
> + * filename.
> + */
> +char *sha1_blob_cache_file_name(const unsigned char *sha1)
> +{
..code basically identical with sha1_file_name()..
> +}

You can guess what would I like you to do. ;-)

> +
> +static int write_entry(struct cache_entry *ce)
> +{
> +	int fd;
> +	void *new;
> +	unsigned long size;
> +	long wrote;
> +	char type[20];
> +	char *cache_name;
> +	struct stat st;
> +
> +	cache_name = sha1_blob_cache_file_name(ce->sha1);
> +
> +	if (stat(cache_name, &st)) {
..basically cut'n'paste of non-hardlinking write_entry()..

BTW, I'd just use access(F_OK) instead of stat() it I don't care about
the file's stat at all anyway.

> +	}
> +	if (link(cache_name, ce->name)) {
> +		if (errno == ENOENT) {
> +			create_directories(ce->name);
> +			link(cache_name, ce->name);
> +		}
> +	}
> +	return 0;
> +}

I think it would be better to have this as hardlink_entry() and
write_entry() to take the file name to write the entry to. Then you
should explicitly multiplex in checkout_cache() between what you do.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor

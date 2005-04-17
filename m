From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Parsing code in revision.h
Date: Sun, 17 Apr 2005 18:09:29 +0200
Message-ID: <20050417160929.GJ1487@pasky.ji.cz>
References: <Pine.LNX.4.21.0504171108060.30848-100000@iabervon.org> <Pine.LNX.4.21.0504171120400.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 18:06:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNCHN-0007aM-3z
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 18:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbVDQQJi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 12:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVDQQJi
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 12:09:38 -0400
Received: from w241.dkm.cz ([62.24.88.241]:39826 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261346AbVDQQJa (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 12:09:30 -0400
Received: (qmail 27754 invoked by uid 2001); 17 Apr 2005 16:09:29 -0000
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0504171120400.30848-100000@iabervon.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, Apr 17, 2005 at 05:24:20PM CEST, I got a letter
where Daniel Barkalow <barkalow@iabervon.org> told me that...
> This adds support to revision.h for parsing commit records (but not going
> any further than parsing a single record). Something like this is needed
> by anything that uses revision.h, but older programs open-code it.
> 
> Signed-Off-By: Daniel Barkalow <barkalow@iabervon.org>

Could you please convert the current users (rev-tree.c and fsck-cache.c)
to use this in the same patch?

> Index: revision.h
> ===================================================================
> --- 45f926575d2c44072bfcf2317dbf3f0fbb513a4e/revision.h  (mode:100644 sha1:28d0de3261a61f68e4e0948a25a416a515cd2e83)
> +++ 37a0b01b85c2999243674d48bfc71cdba0e5518e/revision.h  (mode:100644 sha1:523bde6e14e18bb0ecbded8f83ad4df93fc467ab)
> @@ -24,6 +24,7 @@
>  	unsigned int flags;
>  	unsigned char sha1[20];
>  	unsigned long date;
> +	unsigned char tree[20];
>  	struct parent *parent;
>  };
>  
> @@ -111,4 +112,29 @@
>  	}
>  }
>  
> +static int parse_commit_object(struct revision *rev)
> +{
> +	if (!(rev->flags & SEEN)) {
> +		void *buffer, *bufptr;
> +		unsigned long size;
> +		char type[20];
> +		unsigned char parent[20];
> +
> +		rev->flags |= SEEN;
> +		buffer = bufptr = read_sha1_file(rev->sha1, type, &size);
> +		if (!buffer || strcmp(type, "commit"))
> +			return -1;
> +		get_sha1_hex(bufptr + 5, rev->tree);
> +		bufptr += 46; /* "tree " + "hex sha1" + "\n" */
> +		while (!memcmp(bufptr, "parent ", 7) && 
> +		       !get_sha1_hex(bufptr+7, parent)) {
> +			add_relationship(rev, parent);
> +			bufptr += 48;   /* "parent " + "hex sha1" + "\n" */
> +		}
> +		//rev->date = parse_commit_date(bufptr);

I don't like this.

> +		free(buffer);
> +	}
> +	return 0;
> +}
> +
>  #endif /* REVISION_H */

BTW, I think that in longer term having this stuffed in revision.h is a
bad idea, we should have revision.c. I will accept patches putting the
stuff to revision.h for now, though (unless it gets outrageous).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor

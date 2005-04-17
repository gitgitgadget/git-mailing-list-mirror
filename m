From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Parsing code in revision.h
Date: Sun, 17 Apr 2005 12:44:38 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504171237200.30848-100000@iabervon.org>
References: <20050417160929.GJ1487@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 18:41:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNCpE-0002SH-I0
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 18:40:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbVDQQob (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 12:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbVDQQoa
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 12:44:30 -0400
Received: from iabervon.org ([66.92.72.58]:51204 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261356AbVDQQoU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 12:44:20 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DNCsw-0000nk-00; Sun, 17 Apr 2005 12:44:38 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050417160929.GJ1487@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 17 Apr 2005, Petr Baudis wrote:

> Dear diary, on Sun, Apr 17, 2005 at 05:24:20PM CEST, I got a letter
> where Daniel Barkalow <barkalow@iabervon.org> told me that...
> > This adds support to revision.h for parsing commit records (but not going
> > any further than parsing a single record). Something like this is needed
> > by anything that uses revision.h, but older programs open-code it.
> > 
> > Signed-Off-By: Daniel Barkalow <barkalow@iabervon.org>
> 
> Could you please convert the current users (rev-tree.c and fsck-cache.c)
> to use this in the same patch?

They do things somewhat differently, so it would be more intrusive. Could
I send an extra patch to convert them instead of doing them here?

> > Index: revision.h
> > ===================================================================
> > --- 45f926575d2c44072bfcf2317dbf3f0fbb513a4e/revision.h  (mode:100644 sha1:28d0de3261a61f68e4e0948a25a416a515cd2e83)
> > +++ 37a0b01b85c2999243674d48bfc71cdba0e5518e/revision.h  (mode:100644 sha1:523bde6e14e18bb0ecbded8f83ad4df93fc467ab)
> > @@ -24,6 +24,7 @@
> >  	unsigned int flags;
> >  	unsigned char sha1[20];
> >  	unsigned long date;
> > +	unsigned char tree[20];
> >  	struct parent *parent;
> >  };
> >  
> > @@ -111,4 +112,29 @@
> >  	}
> >  }
> >  
> > +static int parse_commit_object(struct revision *rev)
> > +{
> > +	if (!(rev->flags & SEEN)) {
> > +		void *buffer, *bufptr;
> > +		unsigned long size;
> > +		char type[20];
> > +		unsigned char parent[20];
> > +
> > +		rev->flags |= SEEN;
> > +		buffer = bufptr = read_sha1_file(rev->sha1, type, &size);
> > +		if (!buffer || strcmp(type, "commit"))
> > +			return -1;
> > +		get_sha1_hex(bufptr + 5, rev->tree);
> > +		bufptr += 46; /* "tree " + "hex sha1" + "\n" */
> > +		while (!memcmp(bufptr, "parent ", 7) && 
> > +		       !get_sha1_hex(bufptr+7, parent)) {
> > +			add_relationship(rev, parent);
> > +			bufptr += 48;   /* "parent " + "hex sha1" + "\n" */
> > +		}
> > +		//rev->date = parse_commit_date(bufptr);
> 
> I don't like this.

Yeah, that's left over from the not-quite the same parsing code in the
other programs.

> > +		free(buffer);
> > +	}
> > +	return 0;
> > +}
> > +
> >  #endif /* REVISION_H */
> 
> BTW, I think that in longer term having this stuffed in revision.h is a
> bad idea, we should have revision.c. I will accept patches putting the
> stuff to revision.h for now, though (unless it gets outrageous).

I'd actually like to make them commit.{c,h}, since the system calls the
things they actually deal in commits, not revisions. But this is getting
into stuff that's likely to cause painful divergance from Linus's repo,
which is why I'm a bit leary of actually doing it now.

	-Daniel
*This .sig left intentionally blank*


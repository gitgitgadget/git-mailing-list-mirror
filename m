From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Avoid allocating 0 bytes, was Re: [PATCH 4/4]
 git-compat-util.h: dietlibc-friendly x{malloc,realloc,calloc}
Date: Mon, 26 Dec 2005 21:34:41 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512262134290.19331@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20051224121007.GA19136@mail.yhbt.net> <20051224121454.GC3963@mail.yhbt.net>
 <7v3bkis631.fsf@assigned-by-dhcp.cox.net> <20051224211546.GG3963@mail.yhbt.net>
 <Pine.LNX.4.63.0512261916440.8435@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzmmnisix.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 26 21:34:54 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eqz3T-0006IX-WF
	for gcvg-git@gmane.org; Mon, 26 Dec 2005 21:34:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbVLZUer (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Dec 2005 15:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbVLZUer
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Dec 2005 15:34:47 -0500
Received: from mail.gmx.de ([213.165.64.21]:50398 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932145AbVLZUer (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Dec 2005 15:34:47 -0500
Received: (qmail invoked by alias); 26 Dec 2005 20:34:45 -0000
Received: from lxweb002.wuerzburg.citynet.de (EHLO localhost) [81.209.129.202]
  by mail.gmx.net (mp032) with SMTP; 26 Dec 2005 21:34:45 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmmnisix.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14059>

Hi,

On Mon, 26 Dec 2005, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > diff --git a/csum-file.c b/csum-file.c
> > index 5f9249a..2c0f097 100644
> > --- a/csum-file.c
> > +++ b/csum-file.c
> > @@ -121,6 +121,9 @@ int sha1write_compressed(struct sha1file
> >  	unsigned long maxsize;
> >  	void *out;
> >  
> > +	if (size == 0)
> > +		return 0;
> > +
> >  	memset(&stream, 0, sizeof(stream));
> >  	deflateInit(&stream, Z_DEFAULT_COMPRESSION);
> >  	maxsize = deflateBound(&stream, size);
> 
> I think this and the one in sha1_file.c::write_sha1_file() are
> wrong; 0-size input would not result in 0-size output.  Have you
> tested them by actually exercising the codepaths you touched?

No, I did not test them. At least not consciously (I did the whole work on 
Dec 24, when I was lying in bed, ill, trying to distract myself from being 
miserable).

The reason I did it this way: If zlib inflates a buffer of 0 bytes, it 
makes no sense to expect anything than 0 bytes to come out of it, right? 
Therefore, if zlib encounters a deflated buffer of 0 bytes, it should 
inflate it to 0 bytes. So it is a good idea in any case to write out 0 
bytes.

However, thinking of it again, it might break backwards compatibility. But 
I don't think so.

> > diff --git a/diffcore-pathspec.c b/diffcore-pathspec.c
> > index 68fe009..a12337a 100644
> > --- a/diffcore-pathspec.c
> > +++ b/diffcore-pathspec.c
> > @@ -48,10 +48,14 @@ void diffcore_pathspec(const char **path
> 
> diffcore-pathspec and diffcore-order can probably return without
> touching diff_queued_diff if there is no work to be done.

To be honest: I did not completely understand what that code does. 
It seemed obvious, but I got a track record of breaking things. So I was 
cautious. I will not try to modify it myself without a good test case.

> > @@ -353,7 +353,8 @@ static void write_index_file(const char 
> >  {
> >  	struct sha1file *f;
> >  	struct object_entry **sorted_by_sha =
> > -		xcalloc(nr_objects, sizeof(struct object_entry *));
> > +		xcalloc(nr_objects ? nr_objects : 1,
> > +				sizeof(struct object_entry *));
> >  	struct object_entry **list = sorted_by_sha;
> >  	struct object_entry **last = sorted_by_sha + nr_objects;
> >  	unsigned int array[256];
> 
> This can be simplified by sorted_by_sha = list = last = NULL
> when nr_objects == 0 and avoiding qsort; that is what you did in
> pack-objects, I think.

If nr_objects == 0, we could write out a fixed index.

We could alternatively exit(1), because what sense does it make to have an 
index if the pack contains 0 objects? However, this has consequences: 
Every user of index-pack (does "fetch-pack --keep" call it?) has to be 
aware that empty packs are illegal.

Again, I did this so that the tool does not break. I'll try to come up 
with something better soon.

> > @@ -448,8 +449,10 @@ int main(int argc, char **argv)
> >  
> >  	open_pack_file();
> >  	parse_pack_header();
> > -	objects = xcalloc(nr_objects, sizeof(struct object_entry));
> > -	deltas = xcalloc(nr_objects, sizeof(struct delta_entry));
> > +	objects = xcalloc(nr_objects ? nr_objects : 1,
> > +			sizeof(struct object_entry));
> > +	deltas = xcalloc(nr_objects ? nr_objects : 1,
> > +			sizeof(struct delta_entry));
> >  	parse_pack_objects();
> >  	free(deltas);
> >  	write_index_file(index_name, sha1);
> 
> Likewise I suspect.  After all the special case is only when
> reindexing an empty pack ;-).

Right.

> My inclination is to do things in these steps:
> 
>  - apply cleanups that actually simplify the logic, while
>    leaving the ones that you needed to do (size ?  size : 1)
>    unmodified (BTW, must next_in/next_out point at non NULL when
>    avail_in/avail_out are zero?).

I was cautious. Maybe at some point in future, zlib relies on that. But it 
is probably better to try not calling zlib at all in these cases.

>  - change x*alloc like this, once the above is done:
> 
>         static inline void *xmalloc(size_t size)
>         {
>                 void *ret = malloc(size);
>         #ifdef MALLOC_CAN_RETURN_NULL_ON_0SIZE
>                 if (!ret && !size)
>                         ret = malloc(size+1);
>         #endif
>                 if (!ret)
>                         die("Out of memory, malloc failed");
>                 return ret;
>         }

Sounds easiest.

Ciao,
Dscho

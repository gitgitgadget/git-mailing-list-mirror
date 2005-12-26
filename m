From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Avoid allocating 0 bytes, was Re: [PATCH 4/4] git-compat-util.h: dietlibc-friendly x{malloc,realloc,calloc}
Date: Mon, 26 Dec 2005 11:10:14 -0800
Message-ID: <7vzmmnisix.fsf@assigned-by-dhcp.cox.net>
References: <20051224121007.GA19136@mail.yhbt.net>
	<20051224121454.GC3963@mail.yhbt.net>
	<7v3bkis631.fsf@assigned-by-dhcp.cox.net>
	<20051224211546.GG3963@mail.yhbt.net>
	<Pine.LNX.4.63.0512261916440.8435@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 26 20:10:22 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eqxjh-0007aE-DT
	for gcvg-git@gmane.org; Mon, 26 Dec 2005 20:10:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbVLZTKS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Dec 2005 14:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbVLZTKS
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Dec 2005 14:10:18 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:14529 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932104AbVLZTKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Dec 2005 14:10:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051226190803.UZYU20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 26 Dec 2005 14:08:03 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0512261916440.8435@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Mon, 26 Dec 2005 19:16:52 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14058>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This is the result of a relatively quick audit of the source code. There
> might still be a few odd places lurking out there, but I am quite certain
> I caught most if not all.

Thanks.

> diff --git a/csum-file.c b/csum-file.c
> index 5f9249a..2c0f097 100644
> --- a/csum-file.c
> +++ b/csum-file.c
> @@ -121,6 +121,9 @@ int sha1write_compressed(struct sha1file
>  	unsigned long maxsize;
>  	void *out;
>  
> +	if (size == 0)
> +		return 0;
> +
>  	memset(&stream, 0, sizeof(stream));
>  	deflateInit(&stream, Z_DEFAULT_COMPRESSION);
>  	maxsize = deflateBound(&stream, size);

I think this and the one in sha1_file.c::write_sha1_file() are
wrong; 0-size input would not result in 0-size output.  Have you
tested them by actually exercising the codepaths you touched?

> diff --git a/diffcore-pathspec.c b/diffcore-pathspec.c
> index 68fe009..a12337a 100644
> --- a/diffcore-pathspec.c
> +++ b/diffcore-pathspec.c
> @@ -48,10 +48,14 @@ void diffcore_pathspec(const char **path

diffcore-pathspec and diffcore-order can probably return without
touching diff_queued_diff if there is no work to be done.

> @@ -353,7 +353,8 @@ static void write_index_file(const char 
>  {
>  	struct sha1file *f;
>  	struct object_entry **sorted_by_sha =
> -		xcalloc(nr_objects, sizeof(struct object_entry *));
> +		xcalloc(nr_objects ? nr_objects : 1,
> +				sizeof(struct object_entry *));
>  	struct object_entry **list = sorted_by_sha;
>  	struct object_entry **last = sorted_by_sha + nr_objects;
>  	unsigned int array[256];

This can be simplified by sorted_by_sha = list = last = NULL
when nr_objects == 0 and avoiding qsort; that is what you did in
pack-objects, I think.

> @@ -448,8 +449,10 @@ int main(int argc, char **argv)
>  
>  	open_pack_file();
>  	parse_pack_header();
> -	objects = xcalloc(nr_objects, sizeof(struct object_entry));
> -	deltas = xcalloc(nr_objects, sizeof(struct delta_entry));
> +	objects = xcalloc(nr_objects ? nr_objects : 1,
> +			sizeof(struct object_entry));
> +	deltas = xcalloc(nr_objects ? nr_objects : 1,
> +			sizeof(struct delta_entry));
>  	parse_pack_objects();
>  	free(deltas);
>  	write_index_file(index_name, sha1);

Likewise I suspect.  After all the special case is only when
reindexing an empty pack ;-).

My inclination is to do things in these steps:

 - apply cleanups that actually simplify the logic, while
   leaving the ones that you needed to do (size ?  size : 1)
   unmodified (BTW, must next_in/next_out point at non NULL when
   avail_in/avail_out are zero?).

 - change x*alloc like this, once the above is done:

        static inline void *xmalloc(size_t size)
        {
                void *ret = malloc(size);
        #ifdef MALLOC_CAN_RETURN_NULL_ON_0SIZE
                if (!ret && !size)
                        ret = malloc(size+1);
        #endif
                if (!ret)
                        die("Out of memory, malloc failed");
                return ret;
        }

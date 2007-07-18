From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Rename read_pipe() with read_fd() and make its buffer nul-terminated.
Date: Wed, 18 Jul 2007 00:49:08 -0700
Message-ID: <7vps2q6tjf.fsf@assigned-by-dhcp.cox.net>
References: <469DBC8A.6090704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 09:49:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IB4Hb-0006Sa-CA
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 09:49:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752895AbXGRHtM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 03:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753032AbXGRHtL
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 03:49:11 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:49860 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913AbXGRHtK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 03:49:10 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070718074910.MPAB1358.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Wed, 18 Jul 2007 03:49:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Qvp81X0081kojtg0000000; Wed, 18 Jul 2007 03:49:09 -0400
In-Reply-To: <469DBC8A.6090704@gmail.com> (Carlos Rica's message of "Wed, 18
	Jul 2007 09:08:58 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52841>

Carlos Rica <jasampler@gmail.com> writes:

> The new name is closer to the purpose of the function.
>
> The other change just makes things easier for callers needing a
> NUL-terminated buffer.
>
> Since the function returns only the memory written with data,
> almost always allocating more space than needed because final
> size is unknown, an extra NUL terminating the buffer is harmless.
> It is not included in the returned size, so the function
> remains working as before.
>
> Also, now the function allows the buffer passed to be NULL at first,
> and alloc_nr is now used for growing the buffer, instead size=*2.

Some people may say function name change should be a separate
patch by itself, but I'd let it pass for now...

> diff --git a/sha1_file.c b/sha1_file.c
> index 1efd9ae..563ec07 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2304,27 +2304,38 @@ int has_sha1_file(const unsigned char *sha1)
>   *
>   * returns 0 if anything went fine and -1 otherwise
>   *
> + * The buffer is always NUL-terminated, not including it in returned size.
> + *
>   * NOTE: both buf and size may change, but even when -1 is returned
>   * you still have to free() it yourself.
>   */
> -int read_pipe(int fd, char** return_buf, unsigned long* return_size)
> +int read_fd(int fd, char** return_buf, unsigned long* return_size)
>  {
>  	char* buf = *return_buf;

Our code seems to prefer pointer declaration to be spelled as
"type **var", not "type** var".

>  	unsigned long size = *return_size;
>  	ssize_t iret;
>  	unsigned long off = 0;
>
> +	if (!buf || size <= 1) {
> +		size = alloc_nr(size);
> +		buf = xrealloc(buf, size);
> +	}
> +

Hmph.  The reason this is not "!size" is because you would want
more than one.  As your plan is to use this mostly for the -F
option of "tag/commit", I suspect using a bit larger default,
such as 80 (just a line), or probably 1k (most log messages
would fit in such a buffer), would be more practical.

>  	do {
>  		iret = xread(fd, buf + off, size - off);
>  		if (iret > 0) {
>  			off += iret;
>  			if (off == size) {
> -				size *= 2;
> +				size = alloc_nr(size);
>  				buf = xrealloc(buf, size);
>  			}
>  		}
>  	} while (iret > 0);
>
> +	if (off == size)
> +		buf = xrealloc(buf, size + 1);
> +	buf[off] = '\0';
> +

I wonder if doing xread(... (size-1) - off) in the loop would
ensure (off <= size-1) here.  You also would need to update the
realloc condition inside loop if you do so.

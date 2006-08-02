From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 8/10] Fix some minor warnings to allow -Werror.
Date: Wed, 02 Aug 2006 00:46:23 -0700
Message-ID: <7vvepbvauo.fsf@assigned-by-dhcp.cox.net>
References: <00be01c6b5cf$7f7e9e20$c47eedc1@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 02 09:46:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8BR9-0000kv-5i
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 09:46:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbWHBHqZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 03:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWHBHqZ
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 03:46:25 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:16352 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751353AbWHBHqY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Aug 2006 03:46:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060802074623.JQHW18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 2 Aug 2006 03:46:23 -0400
To: "Ramsay Jones" <ramsay@ramsay1.demon.co.uk>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24636>

"Ramsay Jones" <ramsay@ramsay1.demon.co.uk> writes:

> diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
> index 3e40747..bb5e7b7 100644
> --- a/builtin-mailinfo.c
> +++ b/builtin-mailinfo.c
> @@ -531,7 +531,8 @@ static int decode_b_segment(char *in, ch
>  static void convert_to_utf8(char *line, char *charset)
>  {
>  #ifndef NO_ICONV
> -	char *in, *out;
> +	const char *in;
> +	char *out;
>  	size_t insize, outsize, nrc;
>  	char outbuf[4096]; /* cheat */
>  	static char latin_one[] = "latin1";

This kills the compilation with:

gcc -o builtin-mailinfo.o -c -O2 -Werror -ansi -pedantic -std=c99 -D_XOPEN_SOURCE=500 -D_BSD_SOURCE -Wall -Wdeclaration-after-statement -g -DSHA1_HEADER='<openssl/sha.h>' -DNO_STRLCPY builtin-mailinfo.c
cc1: warnings being treated as errors
builtin-mailinfo.c: In function 'convert_to_utf8':
builtin-mailinfo.c:561: warning: passing argument 2 of 'iconv' from incompatible pointer type

where the line 561 reads:

	nrc = iconv(conv, &in, &insize, &out, &outsize);

> diff --git a/diff.c b/diff.c
> index 5a71489..81630c0 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -614,6 +614,7 @@ static void emit_binary_diff(mmfile_t *o
>  	 * whichever is smaller.
>  	 */
>  	delta = NULL;
> +	orig_size = 0;
>  	deflated = deflate_it(two->ptr, two->size, &deflate_size);
>  	if (one->size && two->size) {
>  		delta = diff_delta(one->ptr, one->size,

This is not wrong per se, but is working around a stupid compiler that
do not understand the dataflow.  orig_size is only used when
delta is non NULL, and when delta is non NULL, the variable is
always set.  Not very happy but is acceptable.

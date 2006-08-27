From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Refactoring tracing code in "git.c" and "exec_cmd.c".
Date: Sat, 26 Aug 2006 22:42:50 -0700
Message-ID: <7vmz9qybs5.fsf@assigned-by-dhcp.cox.net>
References: <20060824074547.a8fa0005.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 27 07:42:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHDPg-0008Qo-OP
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 07:42:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbWH0Fm0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Aug 2006 01:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbWH0Fm0
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 01:42:26 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:40326 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751310AbWH0FmZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Aug 2006 01:42:25 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060827054224.LBKD4015.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>;
          Sun, 27 Aug 2006 01:42:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo01.cox.net with bizsmtp
	id EtiN1V00F4Noztg0000000
	Sun, 27 Aug 2006 01:42:23 -0400
To: Christian Couder <chriscool@tuxfamily.org>
In-Reply-To: <20060824074547.a8fa0005.chriscool@tuxfamily.org> (Christian
	Couder's message of "Thu, 24 Aug 2006 07:45:47 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26087>

Christian Couder <chriscool@tuxfamily.org> writes:

> Some new helper functions in "quote.c" are used for this.
> The goal is also to get near the point where we can use
> one write(2) call to trace in any open file descriptor.
> This is why we put the trace string into one buffer.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>

I really liked the fact (not necessarily the way, though) this
shortens the callers.

> diff --git a/quote.c b/quote.c
> index e220dcc..84d0b7b 100644
> --- a/quote.c
> +++ b/quote.c
> @@ -74,6 +74,84 @@ char *sq_quote(const char *src)
>  	return buf;
>  }
>  
> +char *sq_quote_argv(const char** argv, int count)
> +{
> +	char *buf, *to;
> +	int i;
> +	size_t len;
> +
> +	/* Count argv if needed. */
> +	if (count < 0) {
> +		char **p = (char **)argv;
> +		count = 0;
> +		while (*p++) count++;
> +	}

Wouldn't this be easier to read?

	if (count < 0)
        	for (count = 0; argv[count]; count++)
                	; /* just counting */


> +	/* Get destination buffer length. */
> +	len = count ? count : 1;

This confused me quite a bit.  Wouldn't it be simpler to special
case the count==0 case and return xcalloc(1,1) here (this would
allow you to lose "if (!count)" later as well)?

> +	/* Copy into destination buffer. */
> +	for (i = 0; i < count; ++i) {
> +		if (i) *to++ = ' ';

(style)
	if (i)
        	*to++ = ' ';

> +		to += sq_quote_buf(to, len, argv[i]);
> +	}
> +
> +	if (!count)
> +		*buf = 0;
> +	
> +	return buf;
> +}

> +/* Return a newly allocated copy of "format" where the
> + * first occurence of "old" has been replaced by "new". */
> +static char *str_subst(const char *format, const char *old, const char *new)
> +{

I do not think there is anything wrong with this function
per-se, but...

> +void sq_quote_argv_printf(FILE* out, const char **argv, int count,
> +			   const char *format, ...)
> +{
> +	/* Replace the string "ARGV" in format with the quoted arg values. */
> +	char *argv_str = sq_quote_argv(argv, count);
> +	char *new_format = str_subst(format, "ARGV", argv_str);
> +
> +	/* Print into "out" using the new format. */
> +	va_list rest;
> +	va_start(rest, format);
> +	vfprintf(out, new_format, rest);
> +	va_end(rest);

this feels wrong.  What happens when the original argv had
a per-cent in it?

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Function stripspace now gets a buffer instead file descriptors.
Date: Wed, 11 Jul 2007 15:24:03 -0700
Message-ID: <7vd4yy1svw.fsf@assigned-by-dhcp.cox.net>
References: <4695267A.7080202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 00:24:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8kbT-0002WQ-Sp
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 00:24:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762966AbXGKWYI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 18:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762132AbXGKWYH
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 18:24:07 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:55580 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758012AbXGKWYF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 18:24:05 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070711222404.IKFB1399.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Wed, 11 Jul 2007 18:24:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id NNQ31X00D1kojtg0000000; Wed, 11 Jul 2007 18:24:03 -0400
In-Reply-To: <4695267A.7080202@gmail.com> (Carlos Rica's message of "Wed, 11
	Jul 2007 20:50:34 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52219>

Carlos Rica <jasampler@gmail.com> writes:

> diff --git a/builtin-stripspace.c b/builtin-stripspace.c
> index d8358e2..949b640 100644
> --- a/builtin-stripspace.c
> +++ b/builtin-stripspace.c
> @@ -2,12 +2,11 @@
>  #include "cache.h"
>
>  /*
> - * Remove trailing spaces from a line.
> + * Returns the length of a line removing trailing spaces.

This did not parse well for me; perhaps a comma before
"removing" would make it easier to read?

> @@ -28,52 +26,67 @@ static int cleanup(char *line, int len)
>   * Remove empty lines from the beginning and end
>   * and also trailing spaces from every line.
>   *
> + * Note that the buffer will not be null-terminated.
> + *

The name of the sentinel character '\0' is NUL, not null (which
is a different word, used to call a pointer that points
nowhere).  The buffer will not be "NUL-terminated".

> -void stripspace(FILE *in, FILE *out, int skip_comments)
> +size_t stripspace(char *buffer, size_t length, int skip_comments)
>  {
> +		newlen = cleanup(buffer + i, len);
>
>  		/* Not just an empty line? */
> +		if (newlen) {
> +			if (empties != -1)
> +				buffer[j++] = '\n';
>  			if (empties > 0)
> +				buffer[j++] = '\n';
>  			empties = 0;
> +			memmove(buffer + j, buffer + i, newlen);
>  			continue;
>  		}

It somehow strikes me odd that, given this:

	buffer       j        i
        **********************texttext  \n.......

you would first do this with cleanup():

	buffer       j        i
        **********************texttext\n.......

and then do this with this memmove():

	buffer       j        i
        *************texttext\n.......

Would it become simpler if cleanup() knew where the final text
goes (i.e. buffer+j)?

>  int cmd_stripspace(int argc, const char **argv, const char *prefix)
>  {
> -	stripspace(stdin, stdout, 0);
> +	char *buffer;
> +	unsigned long size;
> +
> +	size = 1024;
> +	buffer = xmalloc(size);
> +	if (read_pipe(0, &buffer, &size))
> +		die("could not read the input");

The command used to be capable of streaming and filtering a few
hundred gigabytes of text on a machine with small address space,
as it operated one line at a time, but now it cannot as it has
to hold everything in core before starting.

I do not think we miss that loss of capability too much, but I
wonder if we can be a bit more clever about it, perhaps feeding
a chunk at a time.  Not a very strong request, but just
wondering if it is an easy change.

From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix mishandling of $Id$ expanded in the repository copy in convert.c
Date: Sat, 26 May 2007 01:09:45 -0700
Message-ID: <7vlkfcm2eu.fsf@assigned-by-dhcp.cox.net>
References: <200705251150.09439.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 26 10:09:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrrLW-0003Vb-P2
	for gcvg-git@gmane.org; Sat, 26 May 2007 10:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752516AbXEZIJt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 04:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbXEZIJs
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 04:09:48 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:57081 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516AbXEZIJq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 04:09:46 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070526080945.CTCU19731.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sat, 26 May 2007 04:09:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3k9l1X00W1kojtg0000000; Sat, 26 May 2007 04:09:46 -0400
In-Reply-To: <200705251150.09439.andyparkins@gmail.com> (Andy Parkins's
	message of "Fri, 25 May 2007 11:50:08 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48459>

Andy Parkins <andyparkins@gmail.com> writes:

> I've included the comments I wrote while debugging in this patch, which
> I'm sure will annoy you, because you'd rather the fix and the comments
> separately.  I'll supply that if you wish - just holler.

Actually I like well commented code, although some of your
comments feel a tad too much at places.  For example,

>  	for (dst = buf; size; size--) {
>  		const char *cp;
> +		/* Fetch next source character, move the pointer on */
>  		char ch = *src++;
> +		/* Copy the current character to the destination */
>  		*dst++ = ch;

These are too much.

> +		/* If the current character is "$" or there are less than three
> +		 * remaining bytes or the two bytes following this one are not
> +		 * "Id", then simply read the next character */
>  		if ((ch != '$') || (size < 3) || memcmp("Id", src, 2))
>  			continue;
> +		/*
> +		 * Here when
> +		 *  - There are more than 2 bytes remaining
> +		 *  - The current three bytes are "$Id$"
> +		 * with
> +		 *  - ch == "$"
> +		 *  - src[0] == "I"
> +		 */

But this is very good, if you fix it to read the current 3 are
"$Id" ;-).

> +		/*
> +		 * It's possible that an expanded Id has crept its way into the
> +		 * repository, we cope with that by stripping the expansion out
> +		 */

So are all the other comments.

Thanks for the fix.  It would be very nice for the patch to be
accompanied with a new test to expose the bug and demonstrate
that the patch fixes it.

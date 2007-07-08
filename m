From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make attributes "-diff" and "diff" work as advertized
Date: Sat, 07 Jul 2007 17:08:29 -0700
Message-ID: <7vy7hr69ky.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707071749220.4093@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 08 02:08:43 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7KKR-0003zR-1U
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 02:08:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753641AbXGHAIb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 20:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753619AbXGHAIb
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 20:08:31 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:52326 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753138AbXGHAIa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 20:08:30 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070708000830.NKJN22777.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sat, 7 Jul 2007 20:08:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Lo8V1X00D1kojtg0000000; Sat, 07 Jul 2007 20:08:30 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51848>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> diff --git a/diff.c b/diff.c
> index 21e61af..e92db5c 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1170,13 +1170,19 @@ static void diff_filespec_check_attr(struct diff_filespec *one)
>  	one->is_binary = 0;
>  	one->funcname_pattern_ident = NULL;
>  
> +	if (!one->data && DIFF_FILE_VALID(one))
> +		diff_populate_filespec(one, 0);
> +
> +	if (one->data)
> +		one->is_binary = buffer_is_binary(one->data, one->size);
> +
>  	if (!git_checkattr(one->path, 1, &attr_diff_check)) {
>  		const char *value;
>  
>  		/* binaryness */
>  		value = attr_diff_check.value;
>  		if (ATTR_TRUE(value))
> -			;
> +			one->is_binary = 0;

I wanted to make sure we do not have to read data and run
buffer_is_binary() when attribute says we do not have to.  I
wonder why moving the code around makes the difference.

>  		else if (ATTR_FALSE(value))
>  			one->is_binary = 1;
>  
> @@ -1186,13 +1192,6 @@ static void diff_filespec_check_attr(struct diff_filespec *one)
>  		else
>  			one->funcname_pattern_ident = value;
>  	}
> -
> -	if (!one->data && DIFF_FILE_VALID(one))
> -		diff_populate_filespec(one, 0);
> -
> -	if (one->data)
> -		one->is_binary = buffer_is_binary(one->data, one->size);
> -
>  }

Ah, I see, because these are done unconditionally.  That was
silly of me.

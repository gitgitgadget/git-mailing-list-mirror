From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/3] diff --stat: allow custom diffstat output width.
Date: Thu, 28 Sep 2006 22:26:37 -0700
Message-ID: <7vr6xvp7jm.fsf@assigned-by-dhcp.cox.net>
References: <7vr6xyjal0.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609281349110.3952@g5.osdl.org>
	<7vac4ju1f1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609281458420.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 29 07:26:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTAtm-0003w4-KX
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 07:26:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161420AbWI2F0k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Sep 2006 01:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161421AbWI2F0k
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Sep 2006 01:26:40 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:12482 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1161419AbWI2F0i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Sep 2006 01:26:38 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060929052637.KABI6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Fri, 29 Sep 2006 01:26:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id U5SZ1V00u1kojtg0000000
	Fri, 29 Sep 2006 01:26:34 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609281458420.3952@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 28 Sep 2006 15:07:16 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28088>

Linus Torvalds <torvalds@osdl.org> writes:

> I could have made it a more obvious "stupid" parser, I just think it's 
> better to do it this way.
>
> +	else if (!strncmp(arg, "--stat", 6)) {
> +		char *end;
> +		int width = options->stat_width;
> +		int name_width = options->stat_name_width;
> +		arg += 6;
> +		end = arg;
> +
> +		switch (*arg) {
> +		case '-':
> +			if (!strncmp(arg, "-width=", 7))
> +				width = strtoul(arg + 7, &end, 10);
> +			else if (!strncmp(arg, "-name-width=", 12))
> +				name_width = strtoul(arg + 12, &end, 10);
> +			break;
> +
> +		case '=':
> +			width = strtoul(arg+1, &end, 10);
> +			if (*end == ',')
> +				name_width = strtoul(end+1, &end, 10);
> +		}
> +
> +		/* Important! This checks all the error cases! */
> +		if (*end)
> +			return 0;
>  		options->output_format |= DIFF_FORMAT_DIFFSTAT;
> +		options->stat_name_width = name_width;
> +		options->stat_width = width;
>  	}

This is simply too clever; -pedantic does not like assignment of
arg to end (constness -- and strtoul takes pointer to non-const
char *, so making the type of end const char * is not an answer
either).

And I do not like casting constness away: end = (char *) arg.

Hmmmm.

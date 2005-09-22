From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Verbose git-daemon logging
Date: Thu, 22 Sep 2005 01:52:18 -0700
Message-ID: <7vwtl9mqm5.fsf@assigned-by-dhcp.cox.net>
References: <20050921213933.GB10575@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 22 10:54:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIMoY-0005td-VE
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 10:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbVIVIwU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 04:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbVIVIwU
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 04:52:20 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:40864 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751455AbVIVIwT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2005 04:52:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050922085218.JFAF29515.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 22 Sep 2005 04:52:18 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050921213933.GB10575@pasky.or.cz> (Petr Baudis's message of
	"Wed, 21 Sep 2005 23:39:33 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9097>

Overall looks very informative to me.  Couple of points,
although your patch was not directly addressed to me... ;-).

> +static void logreport(const char *err, va_list params)
> +{
> +	/* We should do a single write so that it is atomic and output
> +	 * of several threads does not get intermangled. */

"threads"?  Nevertheless yes it is nicer to do a single write.

> +	char buf[1024];
> +	int buflen;
> +
> +	buflen = snprintf(buf, 1024, "[%d] ", getpid());

sizeof(buf)?

> +	buflen += vsnprintf(buf + buflen, 1024 - buflen, err, params);

vsnprintf() would return number of characters that would have
been written if the buffer were sufficiently long, so buflen can
grow outside buf[].  I could ask for a deeeeeeeeeeep directory
to git-daemon, have it say "Request for 'diiiiiiiiiiiiii....r'",
and have this code

> +	buf[buflen++] = '\n';
> +	buf[buflen] = '\0';

overwrite the stack with these two bytes; overwriting with
constant bytes may or may not be exploitable, though.

Also the man page says glibc 2.0.6 returned -1 upon output
truncation.  Do we care?

> @@ -212,6 +275,9 @@ static void child_handler(int signo)
>  			unsigned reaped = children_reaped;
>  			dead_child[reaped % MAX_CHILDREN] = pid;
>  			children_reaped = reaped + 1;
> +			/* XXX: Custom logging, since we don't wanna getpid() */
> +			if (verbose)
> +				fprintf(stderr, "[%d] Disconnected\n", pid);

"we don't wanna getpid()" because the guy reporting is the
parent?  I would presume knowing parent PID would also useful,
so maybe we could say "[1012] child 1014 disconnected\n" for
parent 1012 reaping chilid 1014? 

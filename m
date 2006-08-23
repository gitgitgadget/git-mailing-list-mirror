From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-daemon virtual hosting implementation.
Date: Wed, 23 Aug 2006 13:11:01 -0700
Message-ID: <7vmz9vgqlm.fsf@assigned-by-dhcp.cox.net>
References: <11563591572194-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 23 22:11:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFz48-0003Gj-Ul
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 22:11:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965183AbWHWULF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Aug 2006 16:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965181AbWHWULF
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Aug 2006 16:11:05 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:4066 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S965179AbWHWULC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Aug 2006 16:11:02 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060823201102.JVTI12581.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Wed, 23 Aug 2006 16:11:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo01.cox.net with bizsmtp
	id DYB11V00D4Noztg0000000
	Wed, 23 Aug 2006 16:11:01 -0400
To: Pierre Habouzit <madcoder@debian.org>
In-Reply-To: <11563591572194-git-send-email-madcoder@debian.org> (Pierre
	Habouzit's message of "Wed, 23 Aug 2006 20:52:37 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25927>

Pierre Habouzit <madcoder@debian.org> writes:

> just add the hostname in the path when using --base-path and --user-path.
> this should be enough for most needs.
>
> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> ---
>  Here is a proposal for daemon side virtualhosting support.

> @@ -158,6 +160,11 @@ static char *path_ok(char *dir)
>  		return NULL;
>  	}
>  
> +	if (use_vhosts && !vhost) {
> +		logerror("using virtual hosting, and not host= was specified !");
> +		return NULL;
> +	}
> +

This part is objectionable -- older clients do not give "host=".
I think the plan, when virtual hosting was proposed and we added
this to the client side first, was to treat older clients as if
they specified the "primary" host.  So we would need some
mechanism to say where the repositories of the "primary" host
lives.

> +			if (use_vhosts) {
> +				loginfo("host <%s>, "
> +					"userpath <%s>, request <%s>, "
> +					"namlen %d, restlen %d, slash <%s>",
> +					vhost,
> +					user_path, dir,
> +					namlen, restlen, slash);
> +				snprintf(rpath, PATH_MAX, "%.*s/%s/%s%.*s",
> +					 namlen, dir, user_path, vhost,
> +					 restlen, slash);

I am not sure if the interaction between user-path and vhost
should go like this, but I do not think of a good alternative to
suggest right now.  Your code allows ~user/host1 and ~user/host2
to host different set of repositories, but I suspect if somebody
is setting up a virtual hosting of two hosts, he might want to
have two distinct set of users (iow to pretend that ~user exist
only on host1 but not on host2).  I dunno.

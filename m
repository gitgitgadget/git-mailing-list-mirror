From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] use appropriate typedefs
Date: Tue, 15 Aug 2006 00:41:59 -0700
Message-ID: <7vveou8myg.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0608142305290.23445@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 15 09:42:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCtYs-00085q-Iq
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 09:42:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965273AbWHOHmC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 03:42:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965278AbWHOHmB
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 03:42:01 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:33451 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S965273AbWHOHmB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Aug 2006 03:42:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060815074200.XTSC12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 15 Aug 2006 03:42:00 -0400
To: David Rientjes <rientjes@google.com>
In-Reply-To: <Pine.LNX.4.63.0608142305290.23445@chino.corp.google.com> (David
	Rientjes's message of "Mon, 14 Aug 2006 23:07:28 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25442>

David Rientjes <rientjes@google.com> writes:

> diff --git a/builtin-apply.c b/builtin-apply.c
> index be2c715..2862eb1 100644
> --- a/builtin-apply.c
> +++ b/builtin-apply.c
> @@ -2097,7 +2097,7 @@ static void create_one_file(char *path, 
>  	}
>  
>  	if (errno == EEXIST) {
> -		unsigned int nr = getpid();
> +		pid_t nr = getpid();

Since mkpath() is vararg, doesn't this make it necessary to cast
its parameter several lines down?

> diff --git a/builtin-read-tree.c b/builtin-read-tree.c
> index b30160a..f902fee 100644
> --- a/builtin-read-tree.c
> +++ b/builtin-read-tree.c
> @@ -23,7 +23,7 @@ static int nontrivial_merge = 0;
>...
> -static volatile int progress_update = 0;
> +static volatile sig_atomic_t progress_update = 0;

This is good.  Thanks.

> diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
> index 215892b..6fed919 100644
> --- a/builtin-tar-tree.c
> +++ b/builtin-tar-tree.c
> @@ -361,8 +361,8 @@ static const char *exec = "git-upload-ta
>  
>  static int remote_tar(int argc, const char **argv)
>  {
> -	int fd[2], ret, len;
> -	pid_t pid;
> +	int fd[2], len;
> +	pid_t pid, ret;

Hmph.  You might have made finish_connect() to return pid_t so
making "ret" of that type is consistent with that change, but it
also gets return value from copy_fd() -- which is "did we error
out?"  This part smells funny...

> diff --git a/connect.c b/connect.c
> index 4422a0d..a4c02d1 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -735,9 +735,9 @@ int git_connect(int fd[2], char *url, co
>  	return pid;
>  }
>  
> -int finish_connect(pid_t pid)
> +pid_t finish_connect(pid_t pid)
>  {
> -	int ret;
> +	pid_t ret;

This function wants to wait for the given process and return
zero on success otherwise the caller takes it as a sign for
failure.  Most existing callers do not check the return value,
which should be cleaned up, but we always call it with specific
pid, not wildcard values like 0 or -1, so returning pid_t to say
which child exited does not add value to the interface.  Please
leave its function signature (and one of the callers,
remote_tar() you changed above) as it is.

Having said that, I suspect the existing implementation is quite
buggy.  It says:

	for (;;) {
		ret = waitpid(pid, NULL, 0);
	        if (!ret)
                	break;
		if (errno != EINTR)
                	break;
	}
        return ret;

But it probably should read:

	for (;;) {
		pid_t ret = waitpid(pid, NULL, 0);
		if (ret < 0 && errno == EINTR)
			continue;
	        if (ret == pid)
			return 0;
		return -1;
	}

I do not remember what I was smoking when I wrote that code, but
I suspect somehow I incorrectly thought waitpid() would return
zero for success.

I then dig the history and find out that it was not me but Linus
who did this with commit f719259 on July 4th 2005.  Maybe this
was a program under influence, judging from the date of the
commit ;-)?

> diff --git a/fetch-clone.c b/fetch-clone.c
> index 5e84c46..c5cf477 100644
> --- a/fetch-clone.c
> +++ b/fetch-clone.c
>...
> diff --git a/merge-index.c b/merge-index.c
> index 0498a6f..a9c8cc1 100644
> --- a/merge-index.c
> +++ b/merge-index.c
>...
> diff --git a/run-command.c b/run-command.c
> index ca67ee9..3bacc1b 100644
> --- a/run-command.c
> +++ b/run-command.c
>...

These all look good, thanks.

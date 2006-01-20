From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] local push/pull env cleanup
Date: Thu, 19 Jan 2006 17:13:06 -0800
Message-ID: <7vhd7z8zx9.fsf@assigned-by-dhcp.cox.net>
References: <20060119205803.308.78669.stgit@della.draisey.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 20 02:13:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ezkq4-0001Lp-47
	for gcvg-git@gmane.org; Fri, 20 Jan 2006 02:13:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030406AbWATBNK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 20:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030410AbWATBNJ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 20:13:09 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:2496 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1030406AbWATBNI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2006 20:13:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060120011108.THSH17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 19 Jan 2006 20:11:08 -0500
To: Matt Draisey <matt@draisey.ca>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14944>

Matt Draisey <matt@draisey.ca> writes:

> From: Matt Draisey <matt@draisey.ca>
>
> remove environment variables relating to the current repository
> before execing the 'remote' half of a local push or pull operation
> ---
>
>  connect.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
>
> diff --git a/connect.c b/connect.c
> index d6f4e4c..50cc879 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -644,8 +644,13 @@ int git_connect(int fd[2], char *url, co
>  				ssh_basename++;
>  			execlp(ssh, ssh_basename, host, command, NULL);
>  		}
> -		else
> +		else {
> +			unsetenv("GIT_DIR");
> +			unsetenv("GIT_INDEX_FILE");
> +			unsetenv("GIT_OBJECT_DIRECTORY");
> +			unsetenv("GIT_ALTERNATE_OBJECT_DIRECTORIES");
>  			execlp("sh", "sh", "-c", command, NULL);
> +		}
>  		die("exec failed");
>  	}		
>  	fd[0] = pipefd[0][0];

There are platforms that lack unsetenv(3C), so you also need an
emulation similar to what we do for setenv(3) in
compat/setenv.c.

I suspect GIT_DIR is automatically set up by enter_repo on the
other side when upload-pack (for fetch case) or receive-pack
(for push case) is run, so that may not be necessary, but
cleaning it along with others here sounds sane, even if only for
consistency's sake.

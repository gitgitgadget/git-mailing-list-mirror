From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] runstatus: do not recurse into subdirectories if not needed
Date: Wed, 27 Sep 2006 17:09:28 -0700
Message-ID: <7vac4k97if.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0609271315470.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 02:09:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSjTG-0001WO-Po
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 02:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031276AbWI1AJa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 20:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031278AbWI1AJa
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 20:09:30 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:2794 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1031276AbWI1AJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 20:09:29 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060928000928.FFBJ21457.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Wed, 27 Sep 2006 20:09:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Tc9W1V00n1kojtg0000000
	Wed, 27 Sep 2006 20:09:31 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27949>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This speeds up the case when you run git-status, having an untracked
> subdirectory containing huge amounts of files.
>
> It also clarifies the handling of hide_empty_directories; the old version
> worked, but was hard to understand.
>
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ---
>  dir.c |   24 +++++++++++++++---------
>  1 files changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index e2f472b..e69663c 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -274,6 +274,15 @@ static int dir_exists(const char *dirnam
>  	return !strncmp(active_cache[pos]->name, dirname, len);
>  }
>  
> +static int dir_is_empty(const char *dirname)
> +{
> +	DIR *fdir = opendir(dirname);
> +	int result = (readdir(fdir) == NULL);
> +
> +	closedir(fdir);
> +	return result;
> +}
> +

Does this really check if the directory is empty (I think you
would read "." and ".." out of it at least)?

When the original code recurses into subdirectory, it seems to
behave identically for a truly empty directory and a directory
that has only ".git" (or excluded files in it under !show_ignored).

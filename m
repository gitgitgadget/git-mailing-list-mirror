From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Introduce core.sharedrepository
Date: Thu, 22 Dec 2005 14:40:51 -0800
Message-ID: <7vaceshi18.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0512222313070.12044@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 22 23:41:02 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpZ7H-0000yz-Rg
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 23:40:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965105AbVLVWkx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 17:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965180AbVLVWkx
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 17:40:53 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:63724 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S965105AbVLVWkx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2005 17:40:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051222224054.GVJH25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 22 Dec 2005 17:40:54 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0512222313070.12044@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 22 Dec 2005 23:13:56 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13977>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> +static int make_group_writable(const char *path)
> +{
> +	struct stat st;
> +
> +	if (lstat(path, &st) < 0)
> +		return -1;
> +	if (st.st_mode & S_IWUSR)
> +		st.st_mode |= S_IWGRP;
> +	if (S_ISDIR(st.st_mode))
> +		st.st_mode |= S_ISGID;
> +	if (chmod(path, st.st_mode) < 0)
> +		return -2;
> +	return 0;
> +}

Perhaps g+sx not just g+s on directories.

> +
>  int safe_create_leading_directories(char *path)
>  {
>  	char *pos = path;
> @@ -64,6 +79,10 @@ int safe_create_leading_directories(char
>  				*pos = '/';
>  				return -1;
>  			}
> +		if (shared_repository && make_group_writable(path)) {
> +			*pos = '/';
> +			return -2;
> +		}

Wouldn't this safe_create_leading_directories("/pub/git.git/objects")
try chmod "/pub" and fail?

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] setup_git_directory: Setup cwd properly if worktree is
 found
Date: Mon, 12 Nov 2007 11:57:23 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711121139010.4362@racer.site>
References: <20071112112408.GA5420@laptop>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-279833565-1194867836=:4362"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 12:58:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrXvU-0002qb-LZ
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 12:58:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758146AbXKLL5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 06:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758141AbXKLL5m
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 06:57:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:43420 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758139AbXKLL5l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 06:57:41 -0500
Received: (qmail invoked by alias); 12 Nov 2007 11:57:38 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp003) with SMTP; 12 Nov 2007 12:57:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX195jntAueh5ahUSXDw9ycnO3KddBhvjD9tsOMDb84
	5T2J3UkB5QqHy1
X-X-Sender: gene099@racer.site
In-Reply-To: <20071112112408.GA5420@laptop>
Content-ID: <Pine.LNX.4.64.0711121148170.4362@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64605>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-279833565-1194867836=:4362
Content-Type: TEXT/PLAIN; CHARSET=utf-8
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.64.0711121148171.4362@racer.site>

Hi,

On Mon, 12 Nov 2007, Nguyễn Thái Ngọc Duy wrote:

> diff --git a/setup.c b/setup.c
> index 6f8f769..d90f65e 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -360,7 +360,12 @@ const char *setup_git_directory(void)
>  		if (retval && chdir(retval))
>  			die ("Could not jump back into original cwd");
>  		rel = get_relative_cwd(buffer, PATH_MAX, get_git_work_tree());
> -		return rel && *rel ? strcat(rel, "/") : NULL;
> +		if (rel && *rel) {
> +			if (chdir(get_git_work_tree()))
> +				die ("Could not chdir to %s", get_git_work_tree());
> +			return strcat(rel, "/");
> +		}
> +		return NULL;

Hmm.  Maybe this needs a bit more clarification?

When setup_git_directory() returns, the cwd is supposed to be the current 
working tree's root.  Your patch fixes that nicely when the worktree 
setting was overridden by the config (which is read in 
check_repository_format()).

But what about setup_git_directory_gently()?  If the working tree is 
overridden by the config, this function is still bogus, right?

As far as I see, setup_git_directory_gently() only works correctly when 
core.worktree is _not_ set, unless GIT_WORK_TREE is set (which is supposed 
to override the config setting).  Note: I treat GIT_WORK_TREE the same as 
--work-tree, since at that time they are identical.

Maybe the config stuff has to move into _gently()?

Ciao,
Dscho

P.S.: Thanks for picking up the ball.  At some stage I got so fed up with 
the work-tree stuff that I had to take a long break from it.  It is a 
messy concept, and the implementation is messy, partly because of it, and 
partly because I wrote it.
--8323584-279833565-1194867836=:4362--

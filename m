From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] remove unnecessary loop
Date: Mon, 07 May 2007 22:05:53 -0700
Message-ID: <7virb352ha.fsf@assigned-by-dhcp.cox.net>
References: <463FEC07.8080605@gmail.com> <4640015F.1080407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Liu Yubao <yubao.liu@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 08 07:06:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlHtg-000495-UZ
	for gcvg-git@gmane.org; Tue, 08 May 2007 07:06:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967852AbXEHFF4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 01:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967846AbXEHFF4
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 01:05:56 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:54120 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967843AbXEHFFz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 01:05:55 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070508050556.CKEV6556.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Tue, 8 May 2007 01:05:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id wV5u1W0041kojtg0000000; Tue, 08 May 2007 01:05:55 -0400
In-Reply-To: <4640015F.1080407@gmail.com> (Liu Yubao's message of "Tue, 08 May
	2007 12:49:35 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46541>

Liu Yubao <yubao.liu@gmail.com> writes:

> Here is a ugly fix, I don't hope it will be merged into git tree as it's not
> git's fault, I will file a bug report for Cygwin.

> @@ -50,9 +53,18 @@ static void prune_directory(struct dir_struct *dir, const char **pathspec, int p
>  			continue;
>  
>  		/* Existing file? We must have ignored it */
> +#ifdef __CYGWIN__
> +		/*
> +		 * On cygwin, lstat("hello", &st) returns 0 when
> +		 * "hello.exe" exists, so test with open() again.
> +		 */
> +		if (lstat(match, &st) && -1 != (fd = open(match, O_RDONLY))) {
> +			struct dir_entry *ent;
> +			close(fd);
> +#else

We have lstat() everywhere, so if we were to work this around
without (or "waiting for") a proper fix on the Cygwin side, you
would be better off wrapping the above sequence in a separate
function (say "sane_lstat()"), and do

	#ifdef __CYGWIN__
        #define lstat(a,b) sane_lstat(a,b)
        #endif

somewhere near the top of git-compat-util.h

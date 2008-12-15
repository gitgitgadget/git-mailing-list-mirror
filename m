From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] modify/delete conflict resolution overwrites untracked
 file
Date: Mon, 15 Dec 2008 10:34:05 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812151032230.14632@racer>
References: <20081210201259.GA12928@localhost> <20081215004651.GA16205@localhost> <7v63lm1c76.fsf@gitster.siamese.dyndns.org> <7vmyeyyuuh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 10:36:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LC9sB-0005dP-8P
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 10:36:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548AbYLOJe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 04:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752700AbYLOJe6
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 04:34:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:53865 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752288AbYLOJe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 04:34:57 -0500
Received: (qmail invoked by alias); 15 Dec 2008 09:34:55 -0000
Received: from pD9EB376A.dip0.t-ipconnect.de (EHLO noname) [217.235.55.106]
  by mail.gmx.net (mp016) with SMTP; 15 Dec 2008 10:34:55 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/baapM6mbbaT95H68zS/0u1xk1jtvnWAKo030P2y
	/jMnLckRXNFzJ0
X-X-Sender: gene099@racer
In-Reply-To: <7vmyeyyuuh.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103143>

Hi,

On Sun, 14 Dec 2008, Junio C Hamano wrote:


> merge-recursive: do not clobber untracked working tree garbage
> 
> When merge-recursive wanted to create a new file in the work tree (either
> as the final result, or a hint for reference purposes while delete/modify
> conflicts), it unconditionally overwrote an untracked file in the working
> tree.  Be careful not to lose whatever the user has that is not tracked.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

Thanks, I had no time at all to look into this issue.

> diff --git c/merge-recursive.c w/merge-recursive.c
> index a0c804c..2da4333 100644
> --- c/merge-recursive.c
> +++ w/merge-recursive.c
> @@ -447,6 +447,30 @@ static void flush_buffer(int fd, const char *buf, unsigned long size)
>  	}
>  }
>  
> +static int would_lose_untracked(const char *path)
> +{
> +	int pos = cache_name_pos(path, strlen(path));
> +
> +	if (pos < 0)
> +		pos = -1 - pos;
> +	while (pos < active_nr &&
> +	       !strcmp(path, active_cache[pos]->name)) {
> +		/*
> +		 * If stage #0, it is definitely tracked.
> +		 * If it has stage #2 then it was tracked
> +		 * before this merge started.  All other
> +		 * cases the path was not tracked.
> +		 */
> +		switch (ce_stage(active_cache[pos])) {
> +		case 0:
> +		case 2:
> +			return 0;
> +		}
> +		pos++;
> +	}
> +	return file_exists(path);

I wonder if it is cheaper to test file_exists() when the index contains a 
lot of files...

Thanks,
Dscho

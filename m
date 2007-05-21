From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-pack-objects: cache small deltas between big objects
Date: Sun, 20 May 2007 21:54:53 -0700
Message-ID: <7v646mixnm.fsf@assigned-by-dhcp.cox.net>
References: <11796954641778-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Mon May 21 06:55:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpzvF-0003WR-9z
	for gcvg-git@gmane.org; Mon, 21 May 2007 06:55:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754322AbXEUEy7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 00:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754297AbXEUEy7
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 00:54:59 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:56034 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758244AbXEUEyz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 00:54:55 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070521045456.QQKD6556.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Mon, 21 May 2007 00:54:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 1guu1X00G1kojtg0000000; Mon, 21 May 2007 00:54:55 -0400
In-Reply-To: <11796954641778-git-send-email-mkoegler@auto.tuwien.ac.at>
	(Martin Koegler's message of "Sun, 20 May 2007 23:11:04 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47964>

Martin Koegler <mkoegler@auto.tuwien.ac.at> writes:

> Creating deltas between big blobs is a CPU and memory intensive task.
> In the writing phase, all (not reused) deltas are redone.
>
> This patch adds support for caching deltas from the deltifing phase, so
> that that the writing phase is faster.
>
> The caching is limited to small deltas to avoid increasing memory usage very much.
> The implemented limit is (memory needed to create the delta)/1024.
>
> Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
> ---
>  builtin-pack-objects.c |   35 +++++++++++++++++++++++++----------
>  1 files changed, 25 insertions(+), 10 deletions(-)

This is an interesting idea.

> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> index d165f10..13429d0 100644
> --- a/builtin-pack-objects.c
> +++ b/builtin-pack-objects.c
> ...
> @@ -1294,10 +1302,17 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
>  	if (!delta_buf)
>  		return 0;
>  
> +	if (trg_entry->delta_data)
> +		free (trg_entry->delta_data);
> +	trg_entry->delta_data = 0;
>  	trg_entry->delta = src_entry;
>  	trg_entry->delta_size = delta_size;
>  	trg_entry->depth = src_entry->depth + 1;
> -	free(delta_buf);
> +	/* cache delta, if objects are large enough compared to delta size */
> +	if ((src_size >> 20) + (trg_size >> 21) > (delta_size >> 10))
> +		trg_entry->delta_data = delta_buf;
> +	else
> +		free(delta_buf);
>  	return 1;
>  }

Care to justify this arithmetic?  Why isn't it for example like
this?

	((src_size + trg_size) >> 10) > delta_size

I am puzzled by the shifts on both ends, and differences between
20 and 21.

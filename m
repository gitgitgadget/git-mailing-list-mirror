From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 08/13] prevent try_delta from using objects not in pack
Date: Thu, 05 Apr 2007 16:04:38 -0700
Message-ID: <7v8xd6mni1.fsf@assigned-by-dhcp.cox.net>
References: <56b7f5510704051535ya98e86eu7f786f118c4fe229@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Dana How" <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 01:04:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZb0f-0007fo-VZ
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 01:04:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767407AbXDEXEl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 19:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767402AbXDEXEl
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 19:04:41 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:33294 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767407AbXDEXEj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 19:04:39 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070405230437.NLTO25613.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Thu, 5 Apr 2007 19:04:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id jb4e1W00l1kojtg0000000; Thu, 05 Apr 2007 19:04:39 -0400
In-Reply-To: <56b7f5510704051535ya98e86eu7f786f118c4fe229@mail.gmail.com>
	(Dana How's message of "Thu, 5 Apr 2007 15:35:12 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43881>

"Dana How" <danahow@gmail.com> writes:

> Subject: [PATCH 08/13] prevent try_delta from using objects not in pack
>
> ---
>  builtin-pack-objects.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> index 9eb5fd6..37b0150 100644
> --- a/builtin-pack-objects.c
> +++ b/builtin-pack-objects.c
> @@ -1251,6 +1251,10 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
>  	if (trg_entry->type != src_entry->type)
>  		return -1;
>  
> +	/* Don't try deltas involving already/non written objects */
> +	if (trg_entry->no_write || src_entry->no_write)
> +		return -1;
> +
>  	/* We do not compute delta to *create* objects we are not
>  	 * going to pack.
>  	 */

I think trg_entry->no_write case should return -1 (meaning:
doesn't delta with this source, nor any other sources you would
throw at try_delta()), but shouldn't src_entry->no_write case
return 0 (meaning: does not delta with this source, but do not
give up -- other source candidate you have might be usable)?

From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 6/9] Use uint32_t for pack-objects counters.
Date: Wed, 07 Mar 2007 11:02:22 -0800
Message-ID: <7v1wk0g9mp.fsf@assigned-by-dhcp.cox.net>
References: <20070307014424.GG26482@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 07 20:02:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HP1PP-0003M1-93
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 20:02:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965462AbXCGTC1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 14:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965486AbXCGTC0
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 14:02:26 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:43311 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992475AbXCGTCY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 14:02:24 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070307190223.OHSP748.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 7 Mar 2007 14:02:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Xv2N1W00n1kojtg0000000; Wed, 07 Mar 2007 14:02:23 -0500
In-Reply-To: <20070307014424.GG26482@spearce.org> (Shawn O. Pearce's message
	of "Tue, 6 Mar 2007 20:44:24 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41687>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> No logic change should be occuring here, with the exception that
> some comparsions will now work properly when the number of objects
> exceeds 2**31-1.
> ...
>  static void find_deltas(struct object_entry **list, int window, int depth)
>  {
> -	int i, idx;
> +	uint32_t i = nr_objects, idx = 0, processed = 0;
>  	unsigned int array_size = window * sizeof(struct unpacked);
> -	struct unpacked *array = xmalloc(array_size);
> -	unsigned processed = 0;
> +	struct unpacked *array;
>  	unsigned last_percent = 999;
>  
> +	if (!nr_objects)
> +		return;
> +	array = xmalloc(array_size);
>  	memset(array, 0, array_size);
> -	i = nr_objects;
> -	idx = 0;
>  	if (progress)
> -		fprintf(stderr, "Deltifying %d objects.\n", nr_result);
> +		fprintf(stderr, "Deltifying %u objects.\n", nr_result);
>  
> -	while (--i >= 0) {
> -		struct object_entry *entry = list[i];
> +	do {
> +		struct object_entry *entry = list[--i];
>  		struct unpacked *n = array + idx;
>  		int j;
> ...  
> @@ -1345,7 +1342,7 @@ static void find_deltas(struct object_entry **list, int window, int depth)
>  		idx++;
>  		if (idx >= window)
>  			idx = 0;
> -	}
> +	} while (i > 0);

I may not be reading the patch correctly, but doesn't this make
find_deltas() logic to scan the list backwards?  We sort the
list by type and size before we enter this, so that we scan from
bigger to smaller, because we prefer to leave biggest as a base
and represent smaller ones as deltas (removing deltas do not
have to record preimage and tend to be much smaller than adding
deltas).  I suspect this change may affect that optimization.

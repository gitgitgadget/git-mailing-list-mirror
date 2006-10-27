X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/3] make =?iso-8859-1?Q?index-p=E2ck?= able to complete
 thin packs
Date: Fri, 27 Oct 2006 15:28:55 -0700
Message-ID: <7vmz7hcs0o.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0610252323100.12418@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 27 Oct 2006 22:29:03 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30351>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdaCB-0006v2-Rr for gcvg-git@gmane.org; Sat, 28 Oct
 2006 00:29:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750820AbWJ0W25 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 18:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWJ0W25
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 18:28:57 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:55454 "EHLO
 fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP id S1750820AbWJ0W24
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 18:28:56 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061027222855.NNMN12581.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>; Fri, 27
 Oct 2006 18:28:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id faUd1V00j1kojtg0000000 Fri, 27 Oct 2006
 18:28:38 -0400
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre <nico@cam.org> writes:

> +static void fix_unresolved_deltas(int nr_unresolved)
> +{
> +	struct delta_entry **sorted_by_pos;
> +	int i, n = 0;
> +
> +	/*
> +	 * Since many unresolved deltas may well be themselves base objects
> +	 * for more unresolved deltas, we really want to include the
> +	 * smallest number of base objects that would cover as much delta
> +	 * as possible by picking the
> +	 * trunc deltas first, allowing for other deltas to resolve without
> +	 * additional base objects.  Since most base objects are to be found
> +	 * before deltas depending on them, a good heuristic is to start
> +	 * resolving deltas in the same order as their position in the pack.
> +	 */
> +	sorted_by_pos = xmalloc(nr_unresolved * sizeof(*sorted_by_pos));
>  	for (i = 0; i < nr_deltas; i++) {
> -		if (deltas[i].obj->real_type == OBJ_REF_DELTA ||
> -		    deltas[i].obj->real_type == OBJ_OFS_DELTA)
> -			die("pack has unresolved deltas");
> +		if (objects[deltas[i].obj_no].real_type != OBJ_REF_DELTA)
> +			continue;
> +		sorted_by_pos[n++] = &deltas[i];
>  	}
>
> +	qsort(sorted_by_pos, n, sizeof(*sorted_by_pos), delta_pos_compare);
> +
> +	for (i = 0; i < n; i++) {
> +		struct delta_entry *d = sorted_by_pos[i];
> +		void *data;
> +		unsigned long size;
> +		char type[10];
> +		enum object_type obj_type;
> +		int j, first, last;
> +
> +		if (objects[d->obj_no].real_type != OBJ_REF_DELTA)
> +			continue;

Just for the sake of my own sanity checking,...

Is it because base objects of OFS_DELTA _must_ exist in the same
pack (even when --thin) that we do not have to worry about them
in this function?

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git add: respect core.filemode even with unmerged entries in the index
Date: Fri, 29 Jun 2007 01:36:07 -0700
Message-ID: <7vir97f98o.fsf@assigned-by-dhcp.pobox.com>
References: <20070625064017.GA2839@mellanox.co.il>
	<7vlke833wr.fsf@assigned-by-dhcp.pobox.com>
	<20070625071752.GB15343@mellanox.co.il>
	<Pine.LNX.4.64.0706250846200.4059@racer.site>
	<81b0412b0706280152g5cbd777y76757d9c608ea483@mail.gmail.com>
	<Pine.LNX.4.64.0706281408280.4438@racer.site>
	<4683BDA5.996874EF@eudaptics.com>
	<Pine.LNX.4.64.0706281506390.4438@racer.site>
	<4683C5D2.FDF4ED02@eudaptics.com> <4683CA7A.7F8070D7@eudaptics.com>
	<Pine.LNX.4.64.0706281653260.4438@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 29 10:36:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4Bxj-00063Z-F4
	for gcvg-git@gmane.org; Fri, 29 Jun 2007 10:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754064AbXF2IgL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jun 2007 04:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752798AbXF2IgK
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jun 2007 04:36:10 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:60703 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961AbXF2IgI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2007 04:36:08 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070629083607.CMWO17683.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Fri, 29 Jun 2007 04:36:07 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id HLc71X0041kojtg0000000; Fri, 29 Jun 2007 04:36:07 -0400
In-Reply-To: <Pine.LNX.4.64.0706281653260.4438@racer.site> (Johannes
	Schindelin's message of "Thu, 28 Jun 2007 18:02:21 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51164>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> diff --git a/read-cache.c b/read-cache.c
> index 4362b11..a74e4a7 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -382,6 +382,12 @@ int add_file_to_index(struct index_state *istate, const char *path, int verbose)
>  		struct cache_entry *ent;
>  		int pos = index_name_pos(istate, path, namelen);
>  
> +		/* might be unmerged */
> +		if (pos < 0 && 1-pos < istate->cache_nr &&
> +				namelen == ce_namelen(istate->cache[1-pos]) &&
> +				!memcmp(path, istate->cache[1-pos]->name,
> +					namelen))
> +			pos = 1-pos;
>  		ent = (0 <= pos) ? istate->cache[pos] : NULL;
>  		ce->ce_mode = ce_mode_from_stat(ent, st.st_mode);
>  	}

Hmph.

 * Are you sure about (1-pos)?

 * I _think_ we would want to favor our stage (i.e. #2) when
   unmerged, over other stages.  Perhaps like this:

	if (pos < 0) {
        	int a_pos = -1, our_pos = -1;
		pos = -pos-1;
		while ((pos < istate->cache_nr) &&
			namelen == ce_namelen(istate->cache[pos]) &&
			!memcmp(path, istate->cache[pos]->name, namelen))
			if (a_pos < 0)
                        	a_pos = pos;
                        if (ce_stage(istate->cache[pos]) == 2)
                        	our_pos = pos;
			pos++;
                }
		if (our_pos >= 0)
                	pos = our_pos;
		else if (a_pos >= 0)
                	pos = a_pos;
		else
                	pos = -1;
	}
	ent = (0 <= pos) ? istate->cache[pos] : NULL;
	ce->ce_mode = ce_mode_from_stat(ent, st.st_mode);

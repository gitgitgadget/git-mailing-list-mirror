From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] commit: use a priority queue in merge base functions
Date: Wed, 29 Aug 2012 17:00:32 -0400
Message-ID: <20120829210032.GA29179@sigill.intra.peff.net>
References: <20120829110812.GA14069@sigill.intra.peff.net>
 <20120829111147.GB14734@sigill.intra.peff.net>
 <7vtxvlwt7o.fsf@alter.siamese.dyndns.org>
 <20120829205332.GA16064@sigill.intra.peff.net>
 <20120829205525.GA28696@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 29 23:00:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6pNU-0008D3-If
	for gcvg-git-2@plane.gmane.org; Wed, 29 Aug 2012 23:00:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753317Ab2H2VAi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Aug 2012 17:00:38 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:47376 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752628Ab2H2VAh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2012 17:00:37 -0400
Received: (qmail 2118 invoked by uid 107); 29 Aug 2012 21:00:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 29 Aug 2012 17:00:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Aug 2012 17:00:32 -0400
Content-Disposition: inline
In-Reply-To: <20120829205525.GA28696@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204498>

On Wed, Aug 29, 2012 at 04:55:25PM -0400, Jeff King wrote:

> On Wed, Aug 29, 2012 at 04:53:32PM -0400, Jeff King wrote:
> 
> > > Thanks.  This seems to break t6010-merge-base.sh for me, though...
> > 
> > Interesting. It works fine here, even under --valgrind. Did you apply
> > the patches directly on top of 1251cc7?
> 
> Hmm, this does seem to break t6024 for me, though.

Probably because:

>  	/* Clean up the result to remove stale ones */
> -	free_commit_list(list);
> -	list = result; result = NULL;
> -	while (list) {
> -		struct commit_list *next = list->next;
> -		if (!(list->item->object.flags & STALE))
> -			commit_list_insert_by_date(list->item, &result);
> -		free(list);
> -		list = next;
> -	}
> -	return result;
> +	while (result.nr)
> +		commit_list_append(queue_pop(&result), &tail);
> +	queue_clear(&result);
> +	queue_clear(&list);
> +	return ret;

I forgot to to port the STALE flag handling here.

-Peff

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 09/10] Introduce get_octopus_merge_bases() in commit.c
Date: Fri, 6 Jun 2008 13:28:09 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806061316350.1783@racer>
References: <cover.1212698317.git.vmiklos@frugalware.org> <0a2c2130f9fd87e98192ab0fe0d23e16c902997c.1212698317.git.vmiklos@frugalware.org> <9867fa302ce1c28f4bd8534a70bda19786c75971.1212698317.git.vmiklos@frugalware.org>
 <5aca216074b88d68f97b8223ebf6272dfe6bddeb.1212698317.git.vmiklos@frugalware.org> <3168647573b1325f47ab16f9ee3cae5abaaee473.1212698317.git.vmiklos@frugalware.org> <01dd116d05eedba51578935e39f679a8747380d6.1212698317.git.vmiklos@frugalware.org>
 <514d4184569ab033cad97be9afbd88c767bfb484.1212698317.git.vmiklos@frugalware.org> <2e4b20178405cf993ce9e0f1ffe4ac402a96fd03.1212698317.git.vmiklos@frugalware.org> <cbafb7e632b176658fe84e1eb9926f0a8d3c96b4.1212698317.git.vmiklos@frugalware.org>
 <e13c0c2e9c8b0ebef84ac062bf05c05f729b3b20.1212698317.git.vmiklos@frugalware.org> <7vk5h3xlt9.fsf@gitster.siamese.dyndns.org> <7vmylzw1l4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 14:30:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4b5n-0001qr-M1
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 14:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753863AbYFFM3y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 08:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753814AbYFFM3y
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 08:29:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:40275 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753453AbYFFM3x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 08:29:53 -0400
Received: (qmail invoked by alias); 06 Jun 2008 12:29:51 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp001) with SMTP; 06 Jun 2008 14:29:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+cCiE96sOcVnvJbuqHqCah0LXJN7qLyAp7o2c5GT
	auxeWNs+7Ulzc0
X-X-Sender: gene099@racer
In-Reply-To: <7vmylzw1l4.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84055>

Hi,

On Thu, 5 Jun 2008, Junio C Hamano wrote:

> diff --git a/commit.c b/commit.c
> index 94d5b3d..816eed1 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -531,26 +531,33 @@ static struct commit *interesting(struct commit_list *list)
>  	return NULL;
>  }
>  
> -static struct commit_list *merge_bases(struct commit *one, struct commit *two)
> +static struct commit_list *merge_bases_many(struct commit *one, int n, struct commit **twos)

Clever, but for performance reasons I think it might be better to use a 
commit list here.  This can be a local commit_list in the helper that 
calls merge_bases_many() for the two-head case.

>  {
>  	struct commit_list *list = NULL;
>  	struct commit_list *result = NULL;
> +	int i;
>  
> -	if (one == two)
> -		/* We do not mark this even with RESULT so we do not
> -		 * have to clean it up.
> -		 */
> -		return commit_list_insert(one, &result);
> +	for (i = 0; i < n; i++) {
> +		if (one == twos[i])
> +			/* We do not mark this even with RESULT so we do not
> +			 * have to clean it up.
> +			 */
> +			return commit_list_insert(one, &result);
> +	}
>  
>  	if (parse_commit(one))
>  		return NULL;
> -	if (parse_commit(two))
> -		return NULL;
> +	for (i = 0; i < n; i++) {
> +		if (parse_commit(twos[i]))
> +			return NULL;
> +	}

Distracting curly brackets.

>  	one->object.flags |= PARENT1;
> -	two->object.flags |= PARENT2;
>  	insert_by_date(one, &list);
> -	insert_by_date(two, &list);
> +	for (i = 0; i < n; i++) {
> +		twos[i]->object.flags |= PARENT2;
> +		insert_by_date(twos[i], &list);
> +	}

Ah, now that is clever: I thought we would get into a lot of problems 
because we would need a bit for every initial commit.  But what you are 
basically doing is reusing PARENT2 for all the merge bases that have been 
found for the heads up to, but not including, the current one.

Maybe this should be documented.

But this is not yet enough, right?  You still have to have a loop

merge_bases <- calculate merge bases from the first two heads

foreach head starting from the 3rd one
	merge_bases <- calculate merge_bases_many(this_head, merge_bases)

No?

And these merge_bases are commit_lists, therefore, as mentioned above, the 
signature should not take an array, but the commit_lists.

Ciao,
Dscho

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/11] Fix memory leak in traverse_commit_list
Date: Fri, 09 Nov 2007 14:43:33 -0800
Message-ID: <7vmytnqbu2.fsf@gitster.siamese.dyndns.org>
References: <20071109110610.GA19368@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Nov 09 23:43:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqcZu-00065P-US
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 23:43:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755148AbXKIWnj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 17:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754486AbXKIWnj
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 17:43:39 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:47663 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435AbXKIWni (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 17:43:38 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 5DE182F9;
	Fri,  9 Nov 2007 17:43:59 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id E877B93C1C;
	Fri,  9 Nov 2007 17:43:56 -0500 (EST)
In-Reply-To: <20071109110610.GA19368@spearce.org> (Shawn O. Pearce's message
	of "Fri, 9 Nov 2007 06:06:10 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64269>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> diff --git a/list-objects.c b/list-objects.c
> index e5c88c2..713bef9 100644
> --- a/list-objects.c
> +++ b/list-objects.c
> @@ -170,4 +170,11 @@ void traverse_commit_list(struct rev_info *revs,
>  	}
>  	for (i = 0; i < objects.nr; i++)
>  		show_object(&objects.objects[i]);
> +	free(objects.objects);
> +	if (revs->pending.nr) {
> +		revs->pending.nr = 0;
> +		revs->pending.alloc = 0;
> +		revs->pending.objects = NULL;
> +		free(revs->pending.objects);
> +	}
>  }

It is locally verifiable that objects.objects are no longer
needed after this point, but it made me a bit nervous about
freeing of revs->pending.objects.

I think the existing callers are all Ok, but somebody else
should double check.

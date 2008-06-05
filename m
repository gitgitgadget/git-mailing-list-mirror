From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/10] Introduce commit_list_append() in commit.c
Date: Thu, 05 Jun 2008 16:16:46 -0700
Message-ID: <7v8wxjzd41.fsf@gitster.siamese.dyndns.org>
References: <cover.1212698317.git.vmiklos@frugalware.org>
 <0a2c2130f9fd87e98192ab0fe0d23e16c902997c.1212698317.git.vmiklos@frugalware.org> <9867fa302ce1c28f4bd8534a70bda19786c75971.1212698317.git.vmiklos@frugalware.org> <5aca216074b88d68f97b8223ebf6272dfe6bddeb.1212698317.git.vmiklos@frugalware.org> <3168647573b1325f47ab16f9ee3cae5abaaee473.1212698317.git.vmiklos@frugalware.org> <01dd116d05eedba51578935e39f679a8747380d6.1212698317.git.vmiklos@frugalware.org> <514d4184569ab033cad97be9afbd88c767bfb484.1212698317.git.vmiklos@frugalware.org> <2e4b20178405cf993ce9e0f1ffe4ac402a96fd03.1212698317.git.vmiklos@frugalware.org> <cbafb7e632b176658fe84e1eb9926f0a8d3c96b4.1212698317.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Jun 06 01:17:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4OiI-00020I-BM
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 01:17:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752885AbYFEXQx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 19:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753185AbYFEXQx
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 19:16:53 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40346 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752868AbYFEXQw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 19:16:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7BD093F35;
	Thu,  5 Jun 2008 19:16:51 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A86993F30; Thu,  5 Jun 2008 19:16:48 -0400 (EDT)
In-Reply-To: <cbafb7e632b176658fe84e1eb9926f0a8d3c96b4.1212698317.git.vmiklos@frugalware.org> (Miklos Vajna's message of "Thu, 5 Jun 2008 22:44:34 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7AB5B6C0-3355-11DD-B795-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83998>

Miklos Vajna <vmiklos@frugalware.org> writes:

> This is like commit_list_insert() but it appends the new commit to the
> end of the list, rather than insert to the start of it.
>
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
>  commit.c |   19 +++++++++++++++++++
>  commit.h |    1 +
>  2 files changed, 20 insertions(+), 0 deletions(-)
>
> diff --git a/commit.c b/commit.c
> index b45ec9b..6ba5acb 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -331,6 +331,25 @@ struct commit_list *commit_list_insert(struct commit *item, struct commit_list *
>  	return new_list;
>  }
>  
> +struct commit_list *commit_list_append(struct commit *item,
> +	struct commit_list **list_p)
> +{
> +	struct commit_list *i, *prev = NULL, *list = *list_p;
> +	struct commit_list *new_list = xmalloc(sizeof(struct commit_list));
> +
> +	new_list->item = item;
> +	new_list->next = NULL;
> +
> +	if (!list)
> +		*list_p = new_list;
> +	else {
> +		for (i = list; i; i = i->next)
> +			prev = i;
> +		prev->next = new_list;
> +	}
> +	return list;
> +}

Do you have a caller of this function that keeps a pointer to commit_list
that needs to be appended at the tail or inserted at the beginning
depending on the phase of the moon, or does the caller always append to
that list?

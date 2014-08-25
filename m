From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect: save heap memory. allocate only the required amount
Date: Mon, 25 Aug 2014 14:14:34 -0700
Message-ID: <xmqqd2bol1ad.fsf@gitster.dls.corp.google.com>
References: <1408889844-5407-1-git-send-email-arjun024@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Arjun Sreedharan <arjun024@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 23:14:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XM1bF-0007dK-2i
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 23:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756599AbaHYVOp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 17:14:45 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65449 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755006AbaHYVOo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 17:14:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7D54635E97;
	Mon, 25 Aug 2014 17:14:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tqh4EuTlx0hcMGeR4vFfbjtia8g=; b=os4saB
	68aFQPCMxFlWQkm8GOC1ZgMG9W+7e9iILs4TcsARUJYnXOo2XfkkmzqBqOkuvoTa
	zLktMYL3YzqZZ5eL3xrNpkAhEtBryA0e6DMN8Pdo5LpdIobCyflF5cEUAOZLFfOT
	2OPDTZDTw1h4jgcod+Ol42GnlGUG676RO+YA4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RMQ63AOpfx9M0lw/CnI1koZGr+PJ1sn2
	t+fFPO8wUvvDHOD7vMW9PGb0aBhkkYuyOVg1xpcPLOo2tWIew3TNpZH4h/MqHgqG
	luV8N5zSYR9DKDgd1yxeFX9RGwgKwsksYWrB0+5xt9gqgZJuKXQKK9Fbvt0BIpnu
	saTC0xFeOEs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7441D35E96;
	Mon, 25 Aug 2014 17:14:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3011D35E8F;
	Mon, 25 Aug 2014 17:14:36 -0400 (EDT)
In-Reply-To: <1408889844-5407-1-git-send-email-arjun024@gmail.com> (Arjun
	Sreedharan's message of "Sun, 24 Aug 2014 19:47:24 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D111DB06-2C9C-11E4-A7A8-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255870>

Arjun Sreedharan <arjun024@gmail.com> writes:

> Find and allocate the required amount instead of allocating extra
> 100 bytes
>
> Signed-off-by: Arjun Sreedharan <arjun024@gmail.com>
> ---

Interesting.  How much memory do we typically waste (in other words,
how big did "cnt" grew in your repository where you noticed this)?

>  bisect.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/bisect.c b/bisect.c
> index d6e851d..c96aab0 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -215,10 +215,13 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
>  	}
>  	qsort(array, cnt, sizeof(*array), compare_commit_dist);
>  	for (p = list, i = 0; i < cnt; i++) {
> -		struct name_decoration *r = xmalloc(sizeof(*r) + 100);
> +		char name[100];
> +		sprintf(name, "dist=%d", array[i].distance);
> +		int name_len = strlen(name);

Decl-after-stmt.

You do not have to run a separate strlen() for this.  The return
value from sprintf() should tell you how much you need to allocate,
I think.

> +		struct name_decoration *r = xmalloc(sizeof(*r) + name_len);
>  		struct object *obj = &(array[i].commit->object);
>  
> -		sprintf(r->name, "dist=%d", array[i].distance);
> +		memcpy(r->name, name, name_len + 1);
>  		r->next = add_decoration(&name_decoration, obj, r);
>  		p->item = array[i].commit;
>  		p = p->next;

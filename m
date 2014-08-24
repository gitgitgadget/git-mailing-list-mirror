From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] bisect: save heap memory. allocate only the required
 amount
Date: Sun, 24 Aug 2014 16:32:12 +0100
Message-ID: <53FA057C.3070206@ramsay1.demon.co.uk>
References: <1408889844-5407-1-git-send-email-arjun024@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Arjun Sreedharan <arjun024@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 24 17:32:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLZmG-0008Kr-Tx
	for gcvg-git-2@plane.gmane.org; Sun, 24 Aug 2014 17:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752709AbaHXPcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2014 11:32:17 -0400
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:33964 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752723AbaHXPcR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2014 11:32:17 -0400
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 977676F88D2;
	Sun, 24 Aug 2014 16:31:52 +0100 (BST)
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 50B0F6F88C2;
	Sun, 24 Aug 2014 16:31:52 +0100 (BST)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP;
	Sun, 24 Aug 2014 16:31:51 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <1408889844-5407-1-git-send-email-arjun024@gmail.com>
X-MDF-HostID: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255795>

On 24/08/14 15:17, Arjun Sreedharan wrote:
> Find and allocate the required amount instead of
> allocating extra 100 bytes
> 
> Signed-off-by: Arjun Sreedharan <arjun024@gmail.com>
> ---
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
> +		struct name_decoration *r = xmalloc(sizeof(*r) + name_len);
>  		struct object *obj = &(array[i].commit->object);

declaration(s) after statement.

>  
> -		sprintf(r->name, "dist=%d", array[i].distance);
> +		memcpy(r->name, name, name_len + 1);
>  		r->next = add_decoration(&name_decoration, obj, r);
>  		p->item = array[i].commit;
>  		p = p->next;
> 

HTH

ATB,
Ramsay Jones

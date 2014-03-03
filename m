From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 05/14] diff.c: use ALLOC_GROW()
Date: Mon, 03 Mar 2014 14:48:33 -0800
Message-ID: <xmqq1tyioq4e.fsf@gitster.dls.corp.google.com>
References: <1393885922-21616-1-git-send-email-dmitrys.dolzhenko@yandex.ru>
	<1393885922-21616-6-git-send-email-dmitrys.dolzhenko@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
X-From: git-owner@vger.kernel.org Mon Mar 03 23:48:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKbfC-0004sz-Bk
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 23:48:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755872AbaCCWsj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 17:48:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35850 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755868AbaCCWsi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 17:48:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 534B66B089;
	Mon,  3 Mar 2014 17:48:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ymU1hMQZoCR6GtUpM3vSJPOIjI4=; b=sl8JeQ
	IkJHksOG/Zj+0crjh2s8ThIr4bUuelG4OcJsou6V3egkaeAgrafs87xeY0ATYhRi
	aCL3xFQEd867ufZTVUI4MCSfDYCtytx7wu4nee/xKjSj4FSTGhQXoUPyE7O+fZPS
	xtPx/sJcMAPIMWDuaGUaVpfBPZA3RBZMdbo9E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lfcUhqsJ7BQdzoTn9kkEwwfEcWjYXmHo
	klSD2q5cbEx4MsuqjIAkn3avB+8n7+yGmmgY0rveVb1EYqtOTFrzE+6u/sVU1KAA
	XW1W+y8AFcWschwscInbg0OgydewXX34oVhEzmifY0SYSOi6E0gXcowMqdTMrDHw
	0K1+zJus9jc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 30C026B087;
	Mon,  3 Mar 2014 17:48:37 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2E6D46B083;
	Mon,  3 Mar 2014 17:48:36 -0500 (EST)
In-Reply-To: <1393885922-21616-6-git-send-email-dmitrys.dolzhenko@yandex.ru>
	(Dmitry S. Dolzhenko's message of "Tue, 4 Mar 2014 02:31:53 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F479B2E0-A325-11E3-8DB9-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243296>

"Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru> writes:

> Use ALLOC_GROW() instead inline code in
> diffstat_add() and diff_q()

"...instead of open coding it in..." may read better.

>
> Signed-off-by: Dmitry S. Dolzhenko <dmitrys.dolzhenko@yandex.ru>
> ---
>  diff.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index e800666..aebdfda 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1361,11 +1361,7 @@ static struct diffstat_file *diffstat_add(struct diffstat_t *diffstat,
>  {
>  	struct diffstat_file *x;
>  	x = xcalloc(sizeof (*x), 1);
> -	if (diffstat->nr == diffstat->alloc) {
> -		diffstat->alloc = alloc_nr(diffstat->alloc);
> -		diffstat->files = xrealloc(diffstat->files,
> -				diffstat->alloc * sizeof(x));
> -	}
> +	ALLOC_GROW(diffstat->files, diffstat->nr + 1, diffstat->alloc);
>  	diffstat->files[diffstat->nr++] = x;
>  	if (name_b) {
>  		x->from_name = xstrdup(name_a);
> @@ -3965,11 +3961,7 @@ struct diff_queue_struct diff_queued_diff;
>  
>  void diff_q(struct diff_queue_struct *queue, struct diff_filepair *dp)
>  {
> -	if (queue->alloc <= queue->nr) {
> -		queue->alloc = alloc_nr(queue->alloc);
> -		queue->queue = xrealloc(queue->queue,
> -					sizeof(dp) * queue->alloc);
> -	}
> +	ALLOC_GROW(queue->queue, queue->nr + 1, queue->alloc);
>  	queue->queue[queue->nr++] = dp;
>  }

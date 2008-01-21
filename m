From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: pack-objects: Fix segfault when object count is less than thread
 count
Date: Mon, 21 Jan 2008 16:12:30 +0100
Message-ID: <4794B65E.5000502@viscovery.net>
References: <1200926145-14625-1-git-send-email-vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sergey Vlasov <vsu@altlinux.ru>
X-From: git-owner@vger.kernel.org Mon Jan 21 16:13:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGyKg-0007Jo-BC
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 16:13:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754068AbYAUPMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 10:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753587AbYAUPMf
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 10:12:35 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:46771 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092AbYAUPMf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 10:12:35 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JGyJy-0000hx-IP; Mon, 21 Jan 2008 16:12:22 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id B6F33A33B; Mon, 21 Jan 2008 16:12:30 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1200926145-14625-1-git-send-email-vsu@altlinux.ru>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71285>

Sergey Vlasov schrieb:
> When partitioning the work amongst threads, dividing the number of
> objects by the number of threads may return 0 when there are less
> objects than threads; this will cause the subsequent code to segfault
> when accessing list[sub_size-1].  Fix this by ensuring that sub_size
> is not zero if there is at least one object to process.
> 
> Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
> ---
>  builtin-pack-objects.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> index ec10238..cdf8aae 100644
> --- a/builtin-pack-objects.c
> +++ b/builtin-pack-objects.c
> @@ -1665,6 +1665,9 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
>  	for (i = 0; i < delta_search_threads; i++) {
>  		unsigned sub_size = list_size / (delta_search_threads - i);
>  
> +		if (sub_size == 0 && list_size >= 1)
> +			sub_size = 1;
> +
>  		p[i].window = window;
>  		p[i].depth = depth;
>  		p[i].processed = processed;

I think it fits the logic better to include sub_size > 0 in the while loop
that follows, like so:

		/* try to split chunks on "path" boundaries */
		while (0 < sub_size && sub_size < list_size &&
		       list[sub_size]->hash &&
		       list[sub_size]->hash == list[sub_size-1]->hash)
			sub_size++;

because we explicitly want to allow threads to "work" on zero objects
(i.e. do nothing at all), but if a thread does get assigned some work,
then its chunk is extended past the next path boundary. This way you
collapse two special cases - "zero-sized chunk" and "path boundary" - into
one.

-- Hannes

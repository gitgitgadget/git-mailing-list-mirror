From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/19] tree-diff: simplify tree_entry_pathcmp
Date: Mon, 24 Mar 2014 14:25:04 -0700
Message-ID: <xmqqeh1rp9vz.fsf@gitster.dls.corp.google.com>
References: <cover.1393257006.git.kirr@mns.spb.ru>
	<54aeccfe65926ff00147c3045c5bbae1583d68a7.1393257006.git.kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Mon Mar 24 22:25:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSCMu-0003ol-DS
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 22:25:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbaCXVZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 17:25:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61748 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750806AbaCXVZI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 17:25:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DE2A77D25;
	Mon, 24 Mar 2014 17:25:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HXB+gMjO2TM4da1mBPn5UGQbjA8=; b=T8+gPg
	zuavTm6F5ERSFL0qXocNtxM0Q8jnE29Z2lt7jiSQssBKaWN+HmFwA/8vDJ4U+ghR
	maJejyHrtq5bq8QTFlBuoH09VEipF30xC5lOBy4r0EBUpyU2XNlZAP+bMBqzIaV4
	+YPRaQYHMRT+pCsMxPlY7Jald5I8/cAeNzsIE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lUoWv4/WfCi/vLV9y4zRuLcDn/werIg9
	bN6BT6tbPlP5M2IxKAzeiKlrPCiODgE9IWmcfHn4goxnaOtDKtjCzOxAF2F66Kjc
	YfHqMNgOqkdMyvNSF7qZ2BzyVG/icLsJFglR72WmR3dAuoFncwnU5fC2ysLa/2x6
	NJRN+Ihl9eg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB8E977D23;
	Mon, 24 Mar 2014 17:25:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4220977D22;
	Mon, 24 Mar 2014 17:25:07 -0400 (EDT)
In-Reply-To: <54aeccfe65926ff00147c3045c5bbae1583d68a7.1393257006.git.kirr@mns.spb.ru>
	(Kirill Smelkov's message of "Mon, 24 Feb 2014 20:21:43 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C59A0BE8-B39A-11E3-A989-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244874>

Kirill Smelkov <kirr@mns.spb.ru> writes:

> Since an earlier "Finally switch over tree descriptors to contain a
> pre-parsed entry", we can safely access all tree_desc->entry fields
> directly instead of first "extracting" them through
> tree_entry_extract.
>
> Use it. The code generated stays the same - only it now visually looks
> cleaner.
>
> Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
> ( re-posting without change )

Thanks.

Hopefully I'll be merging the series up to this point to 'next'
soonish.

>
>  tree-diff.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
>
> diff --git a/tree-diff.c b/tree-diff.c
> index 20a4fda..cf96ad7 100644
> --- a/tree-diff.c
> +++ b/tree-diff.c
> @@ -15,18 +15,13 @@
>   */
>  static int tree_entry_pathcmp(struct tree_desc *t1, struct tree_desc *t2)
>  {
> -	unsigned mode1, mode2;
> -	const char *path1, *path2;
> -	const unsigned char *sha1, *sha2;
> -	int cmp, pathlen1, pathlen2;
> +	struct name_entry *e1, *e2;
> +	int cmp;
>  
> -	sha1 = tree_entry_extract(t1, &path1, &mode1);
> -	sha2 = tree_entry_extract(t2, &path2, &mode2);
> -
> -	pathlen1 = tree_entry_len(&t1->entry);
> -	pathlen2 = tree_entry_len(&t2->entry);
> -
> -	cmp = base_name_compare(path1, pathlen1, mode1, path2, pathlen2, mode2);
> +	e1 = &t1->entry;
> +	e2 = &t2->entry;
> +	cmp = base_name_compare(e1->path, tree_entry_len(e1), e1->mode,
> +				e2->path, tree_entry_len(e2), e2->mode);
>  	return cmp;
>  }

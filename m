From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] fast-import: fix segfault in store_tree()
Date: Thu, 28 Aug 2014 16:16:12 -0700
Message-ID: <xmqqwq9s6w8z.fsf@gitster.dls.corp.google.com>
References: <1409237674-74185-1-git-send-email-satori@yandex-team.ru>
	<1409237674-74185-3-git-send-email-satori@yandex-team.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Maxim Bublis <satori@yandex-team.ru>
X-From: git-owner@vger.kernel.org Fri Aug 29 01:16:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XN8vc-0005s1-DX
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 01:16:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151AbaH1XQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 19:16:23 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50450 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751959AbaH1XQW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2014 19:16:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5C322352E5;
	Thu, 28 Aug 2014 19:16:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8OnK9IUvHBFHSQzBzMaMrYV8mVA=; b=oWK3ww
	Rqikq4Z0SFp2O1PKzAdDjVt2gO+C5gk5nFCQc4YTxBIzDi3sVYEp3MDu8KB02h4P
	7f36HrorMFkfOQdFZuepKOYa/dluSAPBloqfXgPTmV+IL52Bpumkdkh2luDCtr1M
	DyjtvWjVv/comrawo8qFBICaZ0/6eEg+X5r4w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C751sMNRd7/gf+W81+8PXNGmDO+HMZK1
	gjDCkFpdRwD3X/SaZGFxYu2OM8sIdYzgnUd02JB/KxxFB6MM7jyFkqLLTY1iLOQO
	ZGBUoiwXZYVGXUOdq7GAU6WosmFzDaShL8Tgx1uhQ2OrnBu7I0C1duUV9Ndxsb4R
	jGW1VmdLgd4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 51E2D352E4;
	Thu, 28 Aug 2014 19:16:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 03C39352CD;
	Thu, 28 Aug 2014 19:16:13 -0400 (EDT)
In-Reply-To: <1409237674-74185-3-git-send-email-satori@yandex-team.ru> (Maxim
	Bublis's message of "Thu, 28 Aug 2014 18:54:34 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4E25B4B4-2F09-11E4-A5E0-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256134>

Maxim Bublis <satori@yandex-team.ru> writes:

> Branch tree is NULLified by filedelete command if we are trying
> to delete root tree. Add sanity check and use load_tree() in that case.
>
> Signed-off-by: Maxim Bublis <satori@yandex-team.ru>
> ---
>  fast-import.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/fast-import.c b/fast-import.c
> index d73f58c..b77f12c 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -1419,7 +1419,7 @@ static void mktree(struct tree_content *t, int v, struct strbuf *b)
>  
>  static void store_tree(struct tree_entry *root)
>  {
> -	struct tree_content *t = root->tree;
> +	struct tree_content *t;
>  	unsigned int i, j, del;
>  	struct last_object lo = { STRBUF_INIT, 0, 0, /* no_swap */ 1 };
>  	struct object_entry *le = NULL;
> @@ -1427,6 +1427,10 @@ static void store_tree(struct tree_entry *root)
>  	if (!is_null_sha1(root->versions[1].sha1))
>  		return;
>  
> +	if (!root->tree)
> +		load_tree(root)

Missing ';'

> +	t = root->tree;
> +
>  	for (i = 0; i < t->entry_count; i++) {
>  		if (t->entries[i]->tree)
>  			store_tree(t->entries[i]);

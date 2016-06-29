Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC41320FCF
	for <e@80x24.org>; Wed, 29 Jun 2016 18:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579AbcF2Sfb (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 14:35:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54217 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751898AbcF2Sfa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 14:35:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1F04C26A09;
	Wed, 29 Jun 2016 14:35:29 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=obCGGbEv9Q9PUN5SDt0cDQHf1eY=; b=LObs8Z
	wtq5ZMw8Ii4WNjDJ7BicMh/6gLDIKskMhY3gA9mZPmiVKuM9nQBHszVBqVLkNYVi
	Dknxkgzeq2fshObjayNF8frbsoCqTIqcqHxO/VlvdpkL4vqPahFPP9nhQz+BaKWv
	eVOhFdm4GmFvBHFJ27pDz0AkZEpRGMC/nZz2s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Hy5xAqmaWFOI1XtJah2l/JdqkIItzzNy
	uZqmcKFh+mB1UYlqNO9BKtgX73CfBVM6LFfewFqg59wpcPejyfxWRiGJ44ofCzFM
	szASgPRqWGVXDW14z3VtIo3RSr1IXICFT4A0CBcsfVB2z5ZQR94hXWKctAFAUEo1
	MT8JPR+sfzM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 15D3726A08;
	Wed, 29 Jun 2016 14:35:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8411F26A06;
	Wed, 29 Jun 2016 14:35:28 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 2/9] merge-recursive: clarify code in was_tracked()
References: <cover.1467199553.git.johannes.schindelin@gmx.de>
	<dd3e2cf842fd5e11e31914aa55b8b995e8d3d75c.1467199553.git.johannes.schindelin@gmx.de>
Date:	Wed, 29 Jun 2016 11:35:26 -0700
In-Reply-To: <dd3e2cf842fd5e11e31914aa55b8b995e8d3d75c.1467199553.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Wed, 29 Jun 2016 13:36:45 +0200
	(CEST)")
Message-ID: <xmqq4m8b4zdd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 40A48812-3E28-11E6-9455-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> It can be puzzling to see that was_tracked() tries to match an index
> entry by name even if cache_name_pos() returned a negative value. Let's
> clarify that cache_name_pos() implicitly looks for stage 0, while we are
> also okay with finding other stages.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  merge-recursive.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 98f4632..bcb53f0 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -658,6 +658,7 @@ static int was_tracked(const char *path)
>  {
>  	int pos = cache_name_pos(path, strlen(path));
>  
> +	/* cache_name_pos() looks for stage == 0, so pos may be < 0 */

It returns >= if found at stage #0, or a negative (counting from -1)
to indicate where the path would be inserted if it were to be added
at stage #0.

The new comment does not explain how "pos may be < 0" leads to
"hence pos = -1 - pos is the right thing to do here".  It is
misleading and we probably are better off without.

>  	if (pos < 0)
>  		pos = -1 - pos;
>  	while (pos < active_nr &&

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: Fix a memory leak in determine_author_info
Date: Mon, 15 Jul 2013 07:42:56 -0700
Message-ID: <7vehazevf3.fsf@alter.siamese.dyndns.org>
References: <1373810463-7144-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 16:43:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyjzU-0000Gd-R0
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 16:43:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757609Ab3GOOnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 10:43:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59861 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757499Ab3GOOm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 10:42:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6EE0E30C66;
	Mon, 15 Jul 2013 14:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FkvH9oJXdsebVMAyQ1uXssG9YA8=; b=CE3/Lt
	RyJBBS8fteg5pShaD56bTkbUI2AeTc5GorDCIugNxq47cmOZFs0Q1NMwovT5C18W
	IqrKxrh1YOVlR8yLbKPESvBwUxrxvvTpE09BNth9d6U+mmvuV4j5tU23BNBCJWDT
	HiXCnq4JXCTBkbvWAzTbQgIBQeQTPpEF4SKdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yYUgO0guu4wVic1CGQrnOW79CdT8deyx
	SvQ7DPfYiZ7dcbGkZ2DW9nQTgHhkH9vlqcvvN+kyvediNDNixy8sjAxm7AvFbG4U
	ncFLXE5LRABeIotcj5di6+n5z1F43Jp6WxhUfbnwtq5LLvfQ8NwRST/8tZ3kyMaR
	pKSAVUYlqw8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 65E9A30C65;
	Mon, 15 Jul 2013 14:42:58 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C321F30C5D;
	Mon, 15 Jul 2013 14:42:57 +0000 (UTC)
In-Reply-To: <1373810463-7144-1-git-send-email-stefanbeller@googlemail.com>
	(Stefan Beller's message of "Sun, 14 Jul 2013 16:01:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D737E1FE-ED5C-11E2-B3EA-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230471>

Stefan Beller <stefanbeller@googlemail.com> writes:

> The date variable is assigned new memory via xmemdupz and 2 lines later
> it is assigned new memory again via xmalloc, but the first assignment
> is never freed nor used.
> ---
>  builtin/commit.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 790e5ab..00da83c 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -534,7 +534,6 @@ static void determine_author_info(struct strbuf *author_ident)
>  					(lb - strlen(" ") -
>  					 (a + strlen("\nauthor "))));
>  		email = xmemdupz(lb + strlen("<"), rb - (lb + strlen("<")));
> -		date = xmemdupz(rb + strlen("> "), eol - (rb + strlen("> ")));
>  		len = eol - (rb + strlen("> "));
>  		date = xmalloc(len + 2);
>  		*date = '@';

Makes sense. I'd assume this is signed-off?

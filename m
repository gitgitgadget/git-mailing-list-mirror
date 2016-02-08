From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rerere: replace strcpy with xsnprintf
Date: Mon, 08 Feb 2016 15:07:31 -0800
Message-ID: <xmqqd1s66bt8.fsf@gitster.mtv.corp.google.com>
References: <20160208222155.GA17395@sigill.intra.peff.net>
	<20160208222501.GA21671@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 09 00:07:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSuuB-00062L-1k
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 00:07:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbcBHXHf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 18:07:35 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50003 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932113AbcBHXHe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 18:07:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7AF1B42B43;
	Mon,  8 Feb 2016 18:07:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SWPnXiOnwr3vEoTwwPE2M2uwOXo=; b=NozOFw
	rB6kCiNf4/Ivw7PbzwxMzrV+jHrblKLJqWf133ok8VSUjNAbADHinTrrrgDUyV63
	48ekNtA1HuY8ME9Fbb+d7sy9xiT5INDcN4wzFvErILUrDbX1tqj5KiFfwdxgfmXq
	nac+tRnXl2at+bj0Vc98NEEzWHHWuQdjZFgJA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V1YZLXnB9IV/E13LQv94jjxWfK44Rz7a
	KNVGEfSS9i5SR/AH8ytkMLeQuFImbsL4vtd55eZi8kSaOYuy4N//DnR1NFrzMkjv
	8H0yQXgwwsE38sluaqr+V8g9llfEn6+PSENvV+0YZgkvSoSScF8Gi//sCzTBrDZk
	VcuxGn6YNas=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6617042B42;
	Mon,  8 Feb 2016 18:07:33 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C97F442B41;
	Mon,  8 Feb 2016 18:07:32 -0500 (EST)
In-Reply-To: <20160208222501.GA21671@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 8 Feb 2016 17:25:01 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BC04592C-CEB8-11E5-A403-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285824>

Jeff King <peff@peff.net> writes:

> This shouldn't overflow, as we are copying a sha1 hex into a
> 41-byte buffer. But it does not hurt to use a bound-checking
> function, which protects us and makes auditing for overflows
> easier.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> These strcpy calls go away in jc/rerere-multi, so I was holding onto
> this to see if that graduated. But since that is stalled, I figured it
> cannot hurt to post (and the conflict resolution is obviously trivial).
>
> With this and the previous patch, it makes our code base strcpy free.
> Yay.

Thanks.  I think jc/rerere-multi can be rerolled on top of this.

>
>  rerere.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/rerere.c b/rerere.c
> index 403c700..587b7e2 100644
> --- a/rerere.c
> +++ b/rerere.c
> @@ -48,7 +48,7 @@ static int has_rerere_resolution(const struct rerere_id *id)
>  static struct rerere_id *new_rerere_id_hex(char *hex)
>  {
>  	struct rerere_id *id = xmalloc(sizeof(*id));
> -	strcpy(id->hex, hex);
> +	xsnprintf(id->hex, sizeof(id->hex), "%s", hex);
>  	return id;
>  }
>  
> @@ -904,7 +904,7 @@ int rerere_forget(struct pathspec *pathspec)
>  static struct rerere_id *dirname_to_id(const char *name)
>  {
>  	static struct rerere_id id;
> -	strcpy(id.hex, name);
> +	xsnprintf(id.hex, sizeof(id.hex), "%s", name);
>  	return &id;
>  }

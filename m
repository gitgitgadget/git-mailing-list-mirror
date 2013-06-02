From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] unpack-trees: plug a memory leak
Date: Sun, 02 Jun 2013 12:33:58 -0700
Message-ID: <7vfvx0nw7t.fsf@alter.siamese.dyndns.org>
References: <1369915136-4248-1-git-send-email-felipe.contreras@gmail.com>
	<1369915136-4248-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Adam Spiers <git@adamspiers.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Stephen Boyd <sboyd@codeaurora.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 02 21:34:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjE2a-0005yf-Cq
	for gcvg-git-2@plane.gmane.org; Sun, 02 Jun 2013 21:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755935Ab3FBTeF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jun 2013 15:34:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62424 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755914Ab3FBTeB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jun 2013 15:34:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18223239FD;
	Sun,  2 Jun 2013 19:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wOam66FMhy4ViQGvZyfrP/jdUzY=; b=pE+SSL
	UjqpC0qX268TxEnIc2wTOgVt4NFsSufMPHB6QHVdnpiQQPRuf7HGfPuptqyPYgSc
	DrT6Vh4ituuKCP7JgdvQO2CcygWk0baGoSu/VF3IYsS2XW1muJKbS5DFQWHk+1bK
	IvwCUfKfRz9n/PO260TiY4WN8Kt1zf2xgJ9e8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pUK6y66tSg4W5nfJKwNe2GixIBAeHxqd
	QlliXEKmnOMOjQLVaHOlseWhfTIOzEpkZWrzP6mHx0RIy3hMpi/fhsKJryXvnbEB
	USpQGCWZlOarBF12rc4rf6kB8Q/vsIYtIj0S6xgaxXEksEZNdhD51KBY8jC/7FHB
	nPS6CHYkkeA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 095A9239FC;
	Sun,  2 Jun 2013 19:34:01 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2E8CE239F8;
	Sun,  2 Jun 2013 19:34:00 +0000 (UTC)
In-Reply-To: <1369915136-4248-4-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Thu, 30 May 2013 06:58:55 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5FE6C04C-CBBB-11E2-A49C-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226176>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Before overwriting the destination index, first let's discard it's
> contents.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  unpack-trees.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index ede4299..eff2944 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1146,8 +1146,10 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>  
>  	o->src_index = NULL;
>  	ret = check_updates(o) ? (-2) : 0;
> -	if (o->dst_index)
> +	if (o->dst_index) {
> +		discard_index(o->dst_index);
>  		*o->dst_index = o->result;
> +	}

I seem to recall that many callers set src_index and dst_index to
the same istate, and expect that the original istate pointed by the
src_index to remain usable.  Is it safe to discard it like this at
this point?

>  
>  done:
>  	clear_exclude_list(&el);

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pack-bitmap: do not core dump
Date: Tue, 22 Apr 2014 16:11:28 -0700
Message-ID: <xmqq7g6h2c4f.fsf@gitster.dls.corp.google.com>
References: <781073ea08e86301f62e708bc0b80fd@74d39fa044aa309eaea14b9f57fe79c>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 01:11:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wcjqn-0007sG-95
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 01:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628AbaDVXLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 19:11:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61336 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751188AbaDVXLe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 19:11:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E1F97F93E;
	Tue, 22 Apr 2014 19:11:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VOFsVXP036y2i971ljqVvSMdzsA=; b=r0hk0E
	Hn40CWbdpPYX3+Kmm3aA32b78vTEvwMKsoI5M7DoBvgXqZAVQsGwmLVO5Ba2F/QD
	KzTZeiOrabpoQjNz4vpPRu0Qp1UDrGxsNlyPFOiB1nVr/xGIZi+thTFfb/5904Hv
	l8Dt+vEk85CAEdoQrMWpnP+kkxqqvXsTBY1/s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AfIElpGrsYD3t/qwnUrJayhgpVZqc5fU
	OAd0rLgdyW/uY+484xmQoFHCcBA+s7Pro40Th63VvY6Lh4oFZJThoRFTpW7mGfE+
	bts+nI0kMqpwt9208SI62xYGLWzTq0/PMhuda72/DiWuxieiK3Y3avKtAyXd4T5v
	edKtkg6ujbk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4CF17F93B;
	Tue, 22 Apr 2014 19:11:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A26407F930;
	Tue, 22 Apr 2014 19:11:30 -0400 (EDT)
In-Reply-To: <781073ea08e86301f62e708bc0b80fd@74d39fa044aa309eaea14b9f57fe79c>
	(Kyle J. McKay's message of "Tue, 22 Apr 2014 15:53:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7066A60A-CA73-11E3-96E1-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246803>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> So I was trying to use pack.writebitmaps=true and all I got was core dumps.
>
> The fix with a real subject line ;) is below.  I think perhaps this should be
> picked up for the 2.0.0 release.  (Patch is against master.)

Of course---a breakage in a new code may be less important than a
regression fix in the sense that there is an option not to use the
new feature, but an obvious fix to such a breakage is certainly very
much welcomed during the -rc period.

Thanks.  I'll try not to forget until tomorrow's integration cycle
(I just finished and pushed the results out for today), which will
also give me a chance to wait for Peff's Ack ;-).

> --Kyle
>
> ---- >8 ----
> Subject: [PATCH] ewah_bitmap.c: do not assume size_t and eword_t are the same size
>
> When buffer_grow changes the size of the buffer using realloc,
> it first computes and saves the rlw pointer's offset into the
> buffer using (uint8_t *) math before the realloc but then
> restores it using (eword_t *) math.
>
> In order to do this it's necessary to convert the (uint8_t *)
> offset into an (eword_t *) offset.  It was doing this by
> dividing by the sizeof(size_t).  Unfortunately sizeof(size_t)
> is not same as sizeof(eword_t) on all platforms.
>
> This causes illegal memory accesses and other bad things to
> happen when attempting to use bitmaps on those platforms.
>
> Fix this by dividing by the sizeof(eword_t) instead which
> will always be correct for all platforms.
>
> Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
> ---
>  ewah/ewah_bitmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
> index 9ced2dad..fccb42b5 100644
> --- a/ewah/ewah_bitmap.c
> +++ b/ewah/ewah_bitmap.c
> @@ -41,7 +41,7 @@ static inline void buffer_grow(struct ewah_bitmap *self, size_t new_size)
>  	self->alloc_size = new_size;
>  	self->buffer = ewah_realloc(self->buffer,
>  		self->alloc_size * sizeof(eword_t));
> -	self->rlw = self->buffer + (rlw_offset / sizeof(size_t));
> +	self->rlw = self->buffer + (rlw_offset / sizeof(eword_t));
>  }
>  
>  static inline void buffer_push(struct ewah_bitmap *self, eword_t value)

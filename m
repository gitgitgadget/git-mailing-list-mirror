From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] stream_to_pack: xread does not guarantee to read all requested bytes
Date: Tue, 20 Aug 2013 08:00:07 -0700
Message-ID: <xmqqsiy476h4.fsf@gitster.dls.corp.google.com>
References: <521333AE.1090506@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Aug 20 17:00:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBnPw-0002gC-AW
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 17:00:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247Ab3HTPAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 11:00:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58714 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751013Ab3HTPAM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 11:00:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 59E703AFA5;
	Tue, 20 Aug 2013 15:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xW7Vl6xy04peZKWpakkYLVyODyc=; b=HVDYvH
	1Tek9qSRl/002SrivMfwkZv7j7jmHN6QLSomIPqUMk0eGVpoR9Hh8m5ljOisXvnO
	TXUy4Zdpj89dNO1t+ayCj4HuKs8/wTvhhG6KXwOAQooRvHi6OVNgvljzQnr6fAEk
	v1X4x35LfGneewK2g9kuPq46MQJOBgKzNWSiI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dsExKCR4XFJX7VeXuau+7Ta0NfrKCdad
	U+CanSrs/oRbXQ9KChNCueMSqoV6R9PM0GELqp761DcV58eJGvKtaX72lu8yBjDr
	1VSPZ8BHxe7NWb5+t6QBGQr/NatT3zYKrJhoPaZh6ioECcuOt/7rZ/tJ4PIrcfkn
	+3Vq9fBT9ZY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E3AD3AFA4;
	Tue, 20 Aug 2013 15:00:11 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A35093AFA2;
	Tue, 20 Aug 2013 15:00:10 +0000 (UTC)
In-Reply-To: <521333AE.1090506@kdbg.org> (Johannes Sixt's message of "Tue, 20
	Aug 2013 11:15:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 35BA9B1E-09A9-11E3-B4FD-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232608>

Johannes Sixt <j6t@kdbg.org> writes:

> The deflate loop in bulk-checkin::stream_to_pack expects to get all bytes
> from a file that it requests to read in a single function call. But it
> used xread(), which does not give that guarantee. Replace it by
> read_in_full().
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  The size is limited to sizeof(ibuf) == 16384 bytes, so that there
>  should not be a problem with the unpatched code on any OS in practice.
>  Nevertheless, this change seems reasonable from a code hygiene POV.
>
>  bulk-checkin.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/bulk-checkin.c b/bulk-checkin.c
> index 6b0b6d4..118c625 100644
> --- a/bulk-checkin.c
> +++ b/bulk-checkin.c
> @@ -114,7 +114,7 @@ static int stream_to_pack(struct bulk_checkin_state *state,
>  
>  		if (size && !s.avail_in) {
>  			ssize_t rsize = size < sizeof(ibuf) ? size : sizeof(ibuf);
> -			if (xread(fd, ibuf, rsize) != rsize)
> +			if (read_in_full(fd, ibuf, rsize) != rsize)

This is the kind of thing i was wondering and worried about with the
other "clipped xread/xwrite" patch.  The original of this caller is
obviously wrong.  Thanks for spotting and fixing.

I wonder if there are more like this broken caller or xread and/or
xwrite.

>  				die("failed to read %d bytes from '%s'",
>  				    (int)rsize, path);
>  			offset += rsize;

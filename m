From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] strbuf: allocate enough space when strbuf_setlen() is
 called first time
Date: Thu, 28 Apr 2011 09:57:58 -0700
Message-ID: <7vtydi48kp.fsf@alter.siamese.dyndns.org>
References: <1303820660-744-1-git-send-email-pclouds@gmail.com>
 <7vaafdexsp.fsf@alter.siamese.dyndns.org> <4DB738A1.8020706@lsrfire.ath.cx>
 <7vhb9kd6kp.fsf@alter.siamese.dyndns.org> <4DB85162.6000204@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Apr 28 18:58:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFUXg-00016m-U2
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 18:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758439Ab1D1Q6L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Apr 2011 12:58:11 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59692 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757291Ab1D1Q6K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2011 12:58:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4DA8458C1;
	Thu, 28 Apr 2011 13:00:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=tVB1rzoFwBEycTwG8YGR0U5vY
	M4=; b=W+eTsScbQlejrdMLR6te12+NbJoXxQ0HcY18dcDuXtHeP0shhrgNlnKx6
	itBuPIGh4V9DjIZGpGndpdB7eQzxpuD6/sHSHyPvWt9jWUitllzXymdg2PxmcKvh
	uUH2N/vdvceM8M3PlMbwAn/Y85lVWZsc4SGroLfBoJcwuqfmQE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=A4dhTgesOtpMidCt/kN
	W3QMFdbKYesaqKBYEamkvqkZsoR3TMuJQAkjiynBdub3DQHEq4K5qOabUWw9Ax4h
	p62AKbU8QcFeHzS6e23PmaVd8RQGWFUkKzkoq6uDZ36lKLJKa2iDg7E6yohNAB5v
	sAVGK5cfrl8b2Fai7sdkp4Ow=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1B4DE58BD;
	Thu, 28 Apr 2011 13:00:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DC54758BC; Thu, 28 Apr 2011
 13:00:03 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F89D182C-71B8-11E0-A84B-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172377>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Subject: strbuf: clarify assertion in strbuf_setlen()
>
> Commit a8f3e2219 introduced the strbuf_grow() call to strbuf_setlen()=
 to
> make ensure that there was at least one byte available to write the
> mandatory trailing NUL, even for previously unallocated strbufs.
>
> Then b315c5c0 added strbuf_slopbuf for the same reason, only globally=
 for
> all uses of strbufs.
>
> Thus the strbuf_grow() call can be removed now.  This avoids readers =
of
> strbuf.h from mistakenly thinking that strbuf_setlen() can be used to
> extend a strbuf.
>
> The following assert() needs to be changed to cope with the fact that
> sb->alloc can now be zero, which is OK as long as len is also zero.  =
As
> suggested by Junio, use the chance to convert it to a die() with a sh=
ort
> explanatory message.  The pattern of 'die("BUG: ...")' is already use=
d in
> strbuf.c.
>
> This was the only assert() in strbuf.[ch], so assert.h doesn't have t=
o be
> included anymore either.
>
> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

Very nicely explained.  I wish everybody wrote his log message as clear=
ly
as this.

Thanks, will queue.

> ---
>  strbuf.h |    7 ++-----
>  1 files changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/strbuf.h b/strbuf.h
> index 07060ce..9e6d9fa 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -3,8 +3,6 @@
> =20
>  /* See Documentation/technical/api-strbuf.txt */
> =20
> -#include <assert.h>
> -
>  extern char strbuf_slopbuf[];
>  struct strbuf {
>  	size_t alloc;
> @@ -33,9 +31,8 @@ static inline size_t strbuf_avail(const struct strb=
uf *sb) {
>  extern void strbuf_grow(struct strbuf *, size_t);
> =20
>  static inline void strbuf_setlen(struct strbuf *sb, size_t len) {
> -	if (!sb->alloc)
> -		strbuf_grow(sb, 0);
> -	assert(len < sb->alloc);
> +	if (len > (sb->alloc ? sb->alloc - 1 : 0))
> +		die("BUG: strbuf_setlen() beyond buffer");
>  	sb->len =3D len;
>  	sb->buf[len] =3D '\0';
>  }

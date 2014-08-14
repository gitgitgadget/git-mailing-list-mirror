From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/6] unpack-objects: continue when fail to malloc due to large objects
Date: Thu, 14 Aug 2014 09:58:05 -0700
Message-ID: <xmqq7g2b2ele.fsf@gitster.dls.corp.google.com>
References: <1403610336-27761-1-git-send-email-pclouds@gmail.com>
	<1407927454-9268-1-git-send-email-pclouds@gmail.com>
	<1407927454-9268-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, worley@alum.mit.edu
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 14 18:58:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHyM0-0001hD-GH
	for gcvg-git-2@plane.gmane.org; Thu, 14 Aug 2014 18:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753130AbaHNQ6Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Aug 2014 12:58:16 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57553 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751750AbaHNQ6Q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Aug 2014 12:58:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7F0482F0F3;
	Thu, 14 Aug 2014 12:58:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=QigTwPzoQ7Pj
	wgenqme4a3L+0jY=; b=Zh4B3ETGyGrfPYLoIeCQg2BkrPa2+/XWFfu5JH85k64m
	5pd3n+BRkW0uv//zMYc3rV1jL6qq/CaInL3+SihWfAnmU090se/Hjn3SPKuYPGsq
	wxjZdbP4FHLEp6ujkA/5tH/UCsLDSrRLZ1PdBzqC9w3qxlMDdlqK3xeUdcZwE1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=AY/JAH
	3Cu9Z/TTITgai/F4j9B7U9wMsYmno0fIBVV7w1uXqH4hSQRjxBJCnw0w/k+mdAQX
	iCKyx8h/fypBYHHtjnSP9HZ5QGKbztIDr9xHerSFUaybZC3jBnmhODjV7FxMmmK3
	nwZKoY1bXDyyUlxRqVf0eTMq1EVm6Nq0eSzwY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6CD7F2F0F2;
	Thu, 14 Aug 2014 12:58:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 858532F0E1;
	Thu, 14 Aug 2014 12:58:07 -0400 (EDT)
In-Reply-To: <1407927454-9268-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 13
 Aug 2014 17:57:31 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2A2CC074-23D4-11E4-BAC6-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255266>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> As a recovery tool, unpack-objects should go on unpacking as many
> objects as it can.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/unpack-objects.c | 42 ++++++++++++++++++++++++++++++++++++++=
+++-
>  t/t1050-large.sh         |  7 +++++++
>  2 files changed, 48 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
> index 99cde45..8b5c67e 100644
> --- a/builtin/unpack-objects.c
> +++ b/builtin/unpack-objects.c
> @@ -88,10 +88,50 @@ static void use(int bytes)
>  	consumed_bytes +=3D bytes;
>  }
> =20
> +static void inflate_and_throw_away(unsigned long size)
> +{
> +	git_zstream stream;
> +	char buf[8192];
> +
> +	memset(&stream, 0, sizeof(stream));
> +	stream.next_out =3D (unsigned char *)buf;
> +	stream.avail_out =3D sizeof(buf);
> +	stream.next_in =3D fill(1);
> +	stream.avail_in =3D len;
> +	git_inflate_init(&stream);
> +
> +	for (;;) {
> +		int ret =3D git_inflate(&stream, 0);
> +		use(len - stream.avail_in);
> +		if (stream.total_out =3D=3D size && ret =3D=3D Z_STREAM_END)
> +			break;
> +		if (ret !=3D Z_OK) {
> +			error("inflate returned %d", ret);
> +			if (!recover)
> +				exit(1);
> +			has_errors =3D 1;
> +			break;
> +		}
> +		stream.next_out =3D (unsigned char *)buf;
> +		stream.avail_out =3D sizeof(buf);
> +		stream.next_in =3D fill(1);
> +		stream.avail_in =3D len;
> +	}
> +	git_inflate_end(&stream);
> +}

This looks wrong in a few ways.

You already know that we saw an error when you get to this function,
whether you will see an out-of-sync stream in this loop or not, so
there is no reason to copy the assignment to has_errors from the
other function.  You also know 'recover' is true---otherwise you
wouldn't be here.

But more importantly, the basic structure of this loop is the same
as the loop we already have in the only caller of this new function,
not just the regular "zlib produced this much that is not yet the
expected size, go on reading more" and "we are at the end of the
stream with Z_STREAM_END, and we are done", but even to "the stream
is corrupt, we need to exit the loop", they are identical.  Is a
copy-and-paste like this the best we can do to add this "skip to the
end of the current stream"?  We would really want to keep the number
of copies of this loop down; we saw a same bug introduced on the
termination condition multiple times to different copies X-<.

>  static void *get_data(unsigned long size)
>  {
>  	git_zstream stream;
> -	void *buf =3D xmalloc(size);
> +	void *buf =3D xmalloc_gentle(size);
> +
> +	if (!buf) {
> +		if (!recover)
> +			exit(1);
> +		has_errors =3D 1;
> +		inflate_and_throw_away(size);
> +		return NULL;
> +	}
> =20
>  	memset(&stream, 0, sizeof(stream));
> =20
> diff --git a/t/t1050-large.sh b/t/t1050-large.sh
> index 5642f84..eec2cca 100755
> --- a/t/t1050-large.sh
> +++ b/t/t1050-large.sh
> @@ -169,4 +169,11 @@ test_expect_success 'fsck' '
>  	test "$n" -gt 1
>  '
> =20
> +test_expect_success 'unpack-objects' '
> +	P=3D`ls .git/objects/pack/*.pack` &&
> +	git unpack-objects -n -r <$P 2>err
> +	test $? =3D 1 &&
> +	grep "error: attempting to allocate .* over limit" err
> +'
> +
>  test_done

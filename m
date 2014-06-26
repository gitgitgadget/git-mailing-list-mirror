From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] fsck: do not die when not enough memory to examine a pack entry
Date: Thu, 26 Jun 2014 11:09:07 -0700
Message-ID: <xmqqa98z5yrg.fsf@gitster.dls.corp.google.com>
References: <1401368227-14469-1-git-send-email-pclouds@gmail.com>
	<1403610336-27761-1-git-send-email-pclouds@gmail.com>
	<1403610336-27761-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, worley@alum.mit.edu
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 20:09:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0E6s-0003kK-7v
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 20:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758102AbaFZSJR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Jun 2014 14:09:17 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53780 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754775AbaFZSJP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jun 2014 14:09:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0189D21C91;
	Thu, 26 Jun 2014 14:09:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=X0cyWXUcz67H
	kZ61xU3sCnRDFf8=; b=sFJhWdrq/MLbXOdssfNgvDtHP31u/oTTi5GMLnoK4cmk
	fmRfd4CgYF3387jnybxosSV4Xmz2PJTulcNLOPdSAW4MQvj8+VNYEL4xk7mwiXi4
	lL604RhNiMlMk5yC4tOuDCR1ESdsgRzKu7iVexO1E96PJ17UjjaojcL2IZGwKOk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=nEc3TM
	UsBf68s7cLt04+CA8URwGPpPwFyhcWSxyqF7DRGHpg500B1BmZIhRR6Y5t5KUtUm
	05nv8l2IHYta597KlCM5CVKLaFvcCScdrEomVhC2Z93cKfDc4IqgEKDaCkoADkUN
	lu2jkwcGOuluoEe4FNVYBJLfX70cqzVubRxfY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E78E521C90;
	Thu, 26 Jun 2014 14:09:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EA1DC21C8C;
	Thu, 26 Jun 2014 14:09:02 -0400 (EDT)
In-Reply-To: <1403610336-27761-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 24
 Jun 2014 18:45:34 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F45BE3C8-FD5C-11E3-BB51-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252513>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> fsck is a tool that error() is more preferred than die(), but many

"more preferred" without justifying why it is "more preferred" is
not quite a justification, is it?  Also, an object failing to load
in-core is not a missing object, so if your aim is to let "fsck"
diagnose a too-large-to-load object as missing and let it continue,
I do not know if it is "more preferred" in the first place.  Adding
a "too large--cannot check" bin of objects may be needed for it to
be useful.  Also, we might need to give at the end "oh by the way,
because we couldn't read some objects to even determine its type,
the unreachable report from this fsck run is totally useless."

The log message tries to justify that this may be a good thing for
"fsck", but the patch actually tries to change the behaviour of all
code paths that try to load an object in-core without considering
the ramifications of such a change.  I _think_ all callers should be
prepared to receive NULL when we encounter a corrupt object (and
otherwise we should fix them), but it is unclear how much audit of
the callers (if any) was done to prepare this change.

Not very excited X-<.

> functions embed die() inside beyond fsck's control.
> unpack_compressed_entry()'s using xmallocz is such a function,
> triggered from verify_packfile() -> unpack_entry(). Make it use
> xmallocz_gentle() instead.
>
> Noticed-by: Dale R. Worley <worley@alum.mit.edu>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  sha1_file.c      | 4 +++-
>  t/t1050-large.sh | 6 ++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index 34d527f..eb69c78 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1925,7 +1925,9 @@ static void *unpack_compressed_entry(struct pac=
ked_git *p,
>  	git_zstream stream;
>  	unsigned char *buffer, *in;
> =20
> -	buffer =3D xmallocz(size);
> +	buffer =3D xmallocz_gentle(size);
> +	if (!buffer)
> +		return NULL;
>  	memset(&stream, 0, sizeof(stream));
>  	stream.next_out =3D buffer;
>  	stream.avail_out =3D size + 1;
> diff --git a/t/t1050-large.sh b/t/t1050-large.sh
> index aea4936..5642f84 100755
> --- a/t/t1050-large.sh
> +++ b/t/t1050-large.sh
> @@ -163,4 +163,10 @@ test_expect_success 'zip achiving, deflate' '
>  	git archive --format=3Dzip HEAD >/dev/null
>  '
> =20
> +test_expect_success 'fsck' '
> +	test_must_fail git fsck 2>err &&
> +	n=3D$(grep "error: attempting to allocate .* over limit" err | wc -=
l) &&
> +	test "$n" -gt 1
> +'
> +
>  test_done

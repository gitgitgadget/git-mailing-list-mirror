From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] fetch-pack: fix deepen shallow over smart http with no-done cap
Date: Thu, 06 Feb 2014 11:16:54 -0800
Message-ID: <xmqqbnykyrtl.fsf@gitster.dls.corp.google.com>
References: <1391699439-22781-1-git-send-email-pclouds@gmail.com>
	<1391699439-22781-7-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 06 20:17:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBURf-0006jN-3Z
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 20:17:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752450AbaBFTRB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Feb 2014 14:17:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43212 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751159AbaBFTRA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Feb 2014 14:17:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B70E86A83B;
	Thu,  6 Feb 2014 14:16:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Z1fo7Nq11lEQ
	o9qRHe1j1Ucs0XI=; b=UuqXjyjTxkYDhd88rNVMuC3b1AZsKf+0skXkYtGhlXtr
	3mxswOISzeZH3IUpgFTAwfukQkXfLmcGc4vIqSbQcigVVXmTQVvXiCupI/MoIyM9
	25tLuJ99p7n3AZmBltUu4SmnrMHSbyOE+r75GFTAyU5SdWpvRzps14vMF6JvYEU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=A/PNX5
	tPm7ISs38juTKMqvlvp9cn/CqKSajCaSaT1zLSxHVeuONLc2+9Zjv2D+AoBIiyCr
	IEcjejVT5qx4CfO6m64J6uQrFKAhSyOOU4RWoTmh3wmXhGlsqp8gzodAQuvGWXOr
	axGcqdwlSlKGlQzfte4SdU23Q6JjDO4UgiN+s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 766AD6A83A;
	Thu,  6 Feb 2014 14:16:59 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D2AF36A832;
	Thu,  6 Feb 2014 14:16:56 -0500 (EST)
In-Reply-To: <1391699439-22781-7-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 6 Feb
 2014 22:10:39 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3EC291FE-8F63-11E3-8D68-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241712>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> In smart http, upload-pack adds new shallow lines at the beginning of
> each rpc response. Only shallow lines from the first rpc call are
> useful. After that they are thrown away. It's designed this way
> because upload-pack is stateless and has no idea when its shallow
> lines are helpful or not.
>
> So after refs are negotiated with multi_ack_detailed and both sides
> happy. The server sends "ACK obj-id ready", terminates the rpc call

Is the above "... and both sides are happy, the server sends ..."?
Lack of a verb makes it hard to guess.

> and waits for the final rpc round. The client sends "done". The serve=
r
> sends another response, which also has shallow lines at the beginning=
,
> and the last "ACK obj-id" line.
>
> When no-done is active, the last round is cut out, the server sends
> "ACK obj-id ready" and "ACK obj-id" in the same rpc
> response. fetch-pack is updated to recognize this and not send
> "done". However it still tries to consume shallow lines, which are
> never sent.
>
> Update the code, make sure to skip consuming shallow lines when
> no-done is enabled.
>
> Reported-by: Jeff King <peff@peff.net>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

Thanks.

Do I understand the situation correctly if I said "The call to
consume-shallow-list has been here from the very beginning, but it
should have been adjusted like this patch when no-done was
introduced."?

>  fetch-pack.c             |  3 ++-
>  t/t5537-fetch-shallow.sh | 24 ++++++++++++++++++++++++
>  2 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 90fdd49..f061f1f 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -439,7 +439,8 @@ done:
>  	}
>  	strbuf_release(&req_buf);
> =20
> -	consume_shallow_list(args, fd[0]);
> +	if (!got_ready || !no_done)
> +		consume_shallow_list(args, fd[0]);
>  	while (flushes || multi_ack) {
>  		int ack =3D get_ack(fd[0], result_sha1);
>  		if (ack) {
> diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
> index b0fa738..fb11073 100755
> --- a/t/t5537-fetch-shallow.sh
> +++ b/t/t5537-fetch-shallow.sh
> @@ -200,5 +200,29 @@ EOF
>  	)
>  '
> =20
> +# This test is tricky. We need large enough "have"s that fetch-pack
> +# will put pkt-flush in between. Then we need a "have" the the serve=
r
> +# does not have, it'll send "ACK %s ready"
> +test_expect_success 'add more commits' '
> +	(
> +	cd shallow &&
> +	for i in $(seq 10); do
> +	git checkout --orphan unrelated$i &&
> +	test_commit unrelated$i >/dev/null &&
> +	git push -q "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" refs/heads/unrelat=
ed$i:refs/heads/unrelated$i
> +	git push -q ../clone/.git refs/heads/unrelated$i:refs/heads/unrelat=
ed$i
> +	done &&
> +	git checkout master &&
> +	test_commit new &&
> +	git push  "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" master
> +	) &&
> +	(
> +	cd clone &&
> +	git checkout --orphan newnew &&
> +	test_commit new-too &&
> +	git fetch --depth=3D2
> +	)
> +'
> +
>  stop_httpd
>  test_done

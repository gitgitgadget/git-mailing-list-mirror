From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Retry HTTP requests on SSL connect failures
Date: Mon, 01 Oct 2012 14:47:58 -0700
Message-ID: <7v626tc19t.fsf@alter.siamese.dyndns.org>
References: <CAJo=hJs=Zm4BPm94-sNWDUNkg2vAReSsTmKnDVw+xOU9NWcfUQ@mail.gmail.com>
 <1349126586-755-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 01 23:48:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TInqY-0007Yd-Ar
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 23:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752576Ab2JAVsE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Oct 2012 17:48:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52474 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751205Ab2JAVsC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Oct 2012 17:48:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 178A38EB2;
	Mon,  1 Oct 2012 17:48:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Is42wGNE817L
	hTNivdItoyIV7HQ=; b=t3/wE1XVgi2fYHSDVExyKi2dlQVkpUeP0dU4QXxcgYik
	adsrUSED3DVPMHCJJm4s0/EB89Hmf8Nx3m8RljDjVTcM4Dg6wdybGZkijDVfqOcI
	yh6i782mvELEbxACtiGE4Qo66ThX/Fpx40AhpVZhvLMckFfdHbgUzl6UlRApjmE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=DNbChG
	wWfku/Ln17HXmNT0jNjYq0L4KCU04NLEWcF7GUzPF9377wZ0IdNzwF/ER9TVxv5i
	gkDpThGzzFvL1mox+836PdpEOsTyNhcOzY82IWJlNh33wCpTxplsKwpa/zfkSMqO
	PPZ7CN8bAMHTHdIJUC2xwpO/fS9Dk/x3W+u00=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 05AE98EB1;
	Mon,  1 Oct 2012 17:48:01 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 519D38EB0; Mon,  1 Oct 2012
 17:48:00 -0400 (EDT)
In-Reply-To: <1349126586-755-1-git-send-email-spearce@spearce.org> (Shawn O.
 Pearce's message of "Mon, 1 Oct 2012 14:23:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AB5BB1A0-0C11-11E2-BB6C-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206771>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Lets assume the site operators (Hi Google!) have a clue and are
> doing everything they already can to ensure secure, successful
> SSL connections from a wide range of HTTP clients. Implementing a
> single level of retry in the client can make it more robust against
> transient failure modes.
> ---

Sign off?

>  http.c        | 19 ++++++++++++-------
>  remote-curl.c |  2 ++
>  2 files changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/http.c b/http.c
> index 345c171..953f2e6 100644
> --- a/http.c
> +++ b/http.c
> @@ -784,7 +784,7 @@ static int http_request(const char *url, void *re=
sult, int target, int options)
>  	struct slot_results results;
>  	struct curl_slist *headers =3D NULL;
>  	struct strbuf buf =3D STRBUF_INIT;
> -	int ret;
> +	int ret, attempts;
> =20
>  	slot =3D get_active_slot();
>  	slot->results =3D &results;
> @@ -820,12 +820,17 @@ static int http_request(const char *url, void *=
result, int target, int options)
>  	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
>  	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "gzip");
> =20
> -	if (start_active_slot(slot)) {
> -		run_active_slot(slot);
> -		ret =3D handle_curl_result(slot);
> -	} else {
> -		error("Unable to start HTTP request for %s", url);
> -		ret =3D HTTP_START_FAILED;
> +	for (attempts =3D 0; attempts < 2; attempts++) {
> +		if (start_active_slot(slot)) {
> +			run_active_slot(slot);
> +			if (slot->results->curl_result =3D=3D CURLE_SSL_CONNECT_ERROR)
> +				continue;
> +			ret =3D handle_curl_result(slot);
> +		} else {
> +			error("Unable to start HTTP request for %s", url);
> +			ret =3D HTTP_START_FAILED;
> +		}
> +		break;
>  	}

Two na=C3=AFve questions, that applies to this and the one in remote-cu=
rl.c::run_slot().

 (1) why only twice?
 (2) no need for "wait a bit and then retry"?

> diff --git a/remote-curl.c b/remote-curl.c
> index a269608..04a379c 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -353,6 +353,8 @@ static int run_slot(struct active_request_slot *s=
lot)
> =20
>  	slot->results =3D &results;
>  	slot->curl_result =3D curl_easy_perform(slot->curl);
> +	if (slot->curl_result =3D=3D CURLE_SSL_CONNECT_ERROR)
> +		slot->curl_result =3D curl_easy_perform(slot->curl);
>  	finish_active_slot(slot);
> =20
>  	err =3D handle_curl_result(slot);

Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E71E27AC41
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 08:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752740562; cv=none; b=XU13705MlaCuZr1pwuBgcqQcjWOUiPAfupGjSbG7DN/g5CfD+N3Gh9Pj++nIoCifRkJAMAMRvy91e42vAlSLwWP/LwH7uJtPqiHAePuC5vqrk5KVs320NfCcsNWwWhmZXXcHTxHkEqnVjk+fw4a1xLHapzBZuTIG8sboJJG2tIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752740562; c=relaxed/simple;
	bh=4U6KoNF1O+yoNy1AeXFt5w8RxqO1kiLOZfc+zixnCsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cfMPVTXZw6fyblPdlfW1lzxhUCkRz4dGylhdvp2py+SdsTYNakoIOe9ygCQdOg8czFw2JXMPAQDgE1cFO9WNhaD2bCwI3OnrjfU9BLREO2N5edzOq8HmsPQPo6POu7xgRR+rw5SKtPlbN7A0kzcfIUdwrUSdY+fqRB88UAjLuZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=q5ONr37X; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="q5ONr37X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752740552; x=1753345352; i=l.s.r@web.de;
	bh=F4O0jGvzVgPqs+IIIWBkuydnQdXYxwrbWdTYZ7hbLuA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=q5ONr37XqDXuKnAO1SPUDN17a3rNDdYa0UypTp6VbVQ8mKsJW/Jq7tO3mMcg2dlX
	 QAZ04cgjfx9v9taqFkaqrampo9U4fHPKzmMK6rCldfaxo8qjIKmlNlZWqo+gcQDo3
	 V0v5/DnF+tJK3hRTpb1FxblrDBAB9Ft0VBw5iqmpR2xCHti4UmACNayTTqnYCiI7e
	 0KA0L7HXEwuRqgiomFMlABRcT5RjaZGyON+9AhQ7SL44hykjpLc082+qnU4V/C2fD
	 LHHLqfx23JJJkBstJwURFFK8XNnVFgBdVWbEQrtJqp1otpP2bUc6raY1uA7XnV8op
	 qJfbhQyEmB26XDHkbg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M6HKG-1uViBT31PU-00Br9k; Thu, 17
 Jul 2025 10:22:31 +0200
Message-ID: <1404fe4a-9b7f-4a7f-905c-e36b2ca45858@web.de>
Date: Thu, 17 Jul 2025 10:22:31 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] commit: convert pop_most_recent_commit() to
 prio_queue
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
References: <bc079b3c-a472-4f5d-95ca-390f9de25196@web.de>
 <bfb0a65d-c9dd-47d9-a88d-9fec43538b0c@web.de> <xmqqtt3b93ls.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqtt3b93ls.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tgBQ+BEqpS8k3yhNTwKWpYUaMTy8j88/HMIQ8ydMZDp/eEyMeEo
 bEspOKFMKt0aiVmi0q1BgUQJeWVtWmGbGVxyZA5LcBzGNfMUMgZuYsNsK3bzE+oGzIYRTp1
 qLdvt1OXwgx/ZNfY5nYGzAix7KhBmXaWson5RY6If1tV4df6q/Th6d2iPtjeoolySHf6QYA
 OBz632O321RsvrZy2dDyA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Kb/WlnFWmyU=;QkYvsT2CYe9NJgLy2UW3Sv0wh/S
 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
 UwSPKjwo+ntRCA=

On 7/17/25 12:23 AM, Junio C Hamano wrote:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>=20
>>  t/perf/p1501-rev-parse-oneline.sh | 55 +++++++++++++++++++++++++++++++
>>  create mode 100755 t/perf/p1501-rev-parse-oneline.sh
>=20
> This unfortunately calls for something like.
>=20
> Tonight's integration cycle I have this on top of your series
> in 'seen'.
>=20
> Subject: [PATCH] fixup! commit: convert pop_most_recent_commit() to prio=
_queue
>=20
>  t/meson.build | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/t/meson.build b/t/meson.build
> index d052fc3e23..b39f6d008d 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -1117,6 +1117,7 @@ benchmarks =3D [
>    'perf/p1450-fsck.sh',
>    'perf/p1451-fsck-skip-list.sh',
>    'perf/p1500-graph-walks.sh',
> +  'perf/p1501-rev-parse-oneline.sh',
>    'perf/p2000-sparse-operations.sh',
>    'perf/p3400-rebase.sh',
>    'perf/p3404-rebase-interactive.sh',

Oh, OK, thanks.  Will include it in v2.

Ren=C3=A9


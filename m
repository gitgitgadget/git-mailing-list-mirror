Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EC117722
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 21:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sDm4lYIS"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D4E0E1E5374;
	Fri, 12 Jan 2024 16:50:05 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Qxt0qA7v6EPj7jIhsxS6FH8YDojBcKE2dMGiKl
	fzG/I=; b=sDm4lYISNueB5buexfPZ4XmT0AP2YKSGM/jMLg1KlIUJB0i3Txu9qL
	nVxO/UdS18X7hpJ/JpI3Qj9NbHu6cY+y/Y+hZhaPEbq4VEAK9vQLO1IIEARxncEO
	FfbmZ03EtRZm1kl/xF7IJTBVc7RFSl7psYfTxoPYaOgodZvCLCFyk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8DF711E5373;
	Fri, 12 Jan 2024 16:50:05 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6B88D1E5371;
	Fri, 12 Jan 2024 16:50:04 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Linus Arver <linusa@google.com>
Cc: Jiang Xin <worldhello.net@gmail.com>,  Git List <git@vger.kernel.org>,
  Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v4 1/4] transport-helper: no connection restriction in
 connect_helper
In-Reply-To: <owlyy1cvhua5.fsf@fine.c.googlers.com> (Linus Arver's message of
	"Thu, 11 Jan 2024 23:42:42 -0800")
References: <cover.1696432593.git.zhiyou.jx@alibaba-inc.com>
	<cover.1702562879.git.zhiyou.jx@alibaba-inc.com>
	<d343585cb5e696f521c2ee1dd6c0f0c2d86de113.1702562879.git.zhiyou.jx@alibaba-inc.com>
	<owlyy1cvhua5.fsf@fine.c.googlers.com>
Date: Fri, 12 Jan 2024 13:50:02 -0800
Message-ID: <xmqqfrz28bn9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8B42318E-B194-11EE-9AA6-25B3960A682E-77302942!pb-smtp2.pobox.com

Linus Arver <linusa@google.com> writes:

> Jiang Xin <worldhello.net@gmail.com> writes:
>
>> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>>
>> When commit b236752a (Support remote archive from all smart transports,
>> 2009-12-09) added "remote archive" support for "smart transports", it
>> was for transport that supports the ".connect" method. The
>> "connect_helper()" function protected itself from getting called for a
>> transport without the method before calling process_connect_service(),
>
> OK.
>
>> which did not work with such a transport.
>
> How about 'which only worked with the ".connect" method.' ?
>
>>
>> Later, commit edc9caf7 (transport-helper: introduce stateless-connect,
>> 2018-03-15) added a way for a transport without the ".connect" method
>> to establish a "stateless" connection in protocol-v2, which
>
> s/which/where
>
>> process_connect_service() was taught to handle the "stateless"
>> connection,
>
> I think using 'the ".stateless_connect" method' is more consistent with
> the rest of this text.
>
>> making the old safety valve in its caller that insisted
>> that ".connect" method must be defined too strict, and forgot to loosen
>> it.
>
> I think just "...making the old protection too strict. But edc9caf7
> forgot to adjust this protection accordingly." is simpler to read.
>
>> Remove the restriction in the "connect_helper()" function and give the
>> function "process_connect_service()" the opportunity to establish a
>> connection using ".connect" or ".stateless_connect" for protocol v2. So
>> we can connect with a stateless-rpc and do something useful. E.g., in a
>> later commit, implements remote archive for a repository over HTTP
>> protocol.
>>
>> Helped-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>> ---
>>  transport-helper.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/transport-helper.c b/transport-helper.c
>> index 49811ef176..2e127d24a5 100644
>> --- a/transport-helper.c
>> +++ b/transport-helper.c
>> @@ -662,8 +662,6 @@ static int connect_helper(struct transport *transport, const char *name,
>>  
>>  	/* Get_helper so connect is inited. */
>>  	get_helper(transport);
>> -	if (!data->connect)
>> -		die(_("operation not supported by protocol"));
>
> Should we still terminate early here if both data->connect and
> data->stateless_connect are not truthy? It would save a few CPU cycles,
> but even better, remain true to the the original intent of the code.
> Maybe there was a really good reason to terminate early here that we're
> not aware of?
>
> But also, what about the case where both are enabled? Should we print an
> error message? (Maybe this concern is outside the scope of this series?)
>
>>  	if (!process_connect_service(transport, name, exec))
>>  		die(_("can't connect to subservice %s"), name);
>> -- 
>> 2.41.0.232.g2f6f0bca4f.agit.8.0.4.dev

Thanks for a review to get the topic that hasn't seen much reviews
unstuck.  Very much appreciated.

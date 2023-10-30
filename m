Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4236B12E65
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 23:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RvJGwd3v"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CB3D3
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 16:11:10 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2DDA2359EA;
	Mon, 30 Oct 2023 19:11:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=WaKuHDTiunGm
	MN6iDh6eu3s2KyLPahdP44KXZ4K5GHU=; b=RvJGwd3vzJErLN5IYWr0W8Rekmvn
	+ET7vRy7UbAt5fMSWqlq07aMs4t3gJj8JWVM9P/6asbCgWRQD3s7rBFcofo09463
	DdgczmREySHnKf+UiAJZ6Ps2a2SNrpP1F7uwJ2EL0MSAtk27xsH7OnzYrCzhVtMD
	kCDK4ju+Izq3EA8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 27268359E9;
	Mon, 30 Oct 2023 19:11:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B871A359E8;
	Mon, 30 Oct 2023 19:11:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] reflog: fix expire --single-worktree
In-Reply-To: <82b832cb-da0b-47cf-9b5d-e8011a222151@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Mon, 30 Oct 2023 17:12:41 +0100")
References: <63eade0e-bf2c-4906-8b4c-689797cff737@web.de>
	<xmqqa5s1hxhh.fsf@gitster.g>
	<82b832cb-da0b-47cf-9b5d-e8011a222151@web.de>
Date: Tue, 31 Oct 2023 08:11:05 +0900
Message-ID: <xmqqlebjbt9y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 9AD8C626-7779-11EE-8378-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 29.10.23 um 23:31 schrieb Junio C Hamano:
>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>
>>> ... and added a non-printable short flag for it, presumably by
>>> accident.
>>
>> Very well spotted.
>>
>> FWIW, with the following patch on top of this patch, all tests pass
>> (and without your fix, of course this notices the "\001" and breaks
>> numerous tests that use "git reflog").  So you seem to have found
>> the only one broken instance (among those that are tested, anyway).
>>
>>  parse-options.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git i/parse-options.c w/parse-options.c
>> index 093eaf2db8..be8bedba29 100644
>> --- i/parse-options.c
>> +++ w/parse-options.c
>> @@ -469,7 +469,8 @@ static void parse_options_check(const struct optio=
n *opts)
>>  			optbug(opts, "uses incompatible flags "
>>  			       "LASTARG_DEFAULT and OPTARG");
>>  		if (opts->short_name) {
>> -			if (0x7F <=3D opts->short_name)
>> +			if (opts->short_name &&
>> +			    (opts->short_name < 0x21 || 0x7F <=3D opts->short_name))
>
> Good idea.  This is equivalent to !isprint(opts->short_name), which I
> find to be more readable here.

Thanks---I didn't think of using !isprint() but you are right.  It
is much shorter.

I am not absolutely certain if it is easier to read, though.  I get
always confused when asking myself if SP, HT, and LF are printables.
(in other words, I cannot immediately answer "does 'printable' mean
'can be sent to a teletype and have it do what is expected to be
done?"---the question I should be asking myself is "is 'printable'
synonym to 'when printed, some ink is consumed'?").

> Seeing why "char short_opts[128];" a
> few lines up is big enough would become a bit harder, though.

Sorry, but I do not quite follow.  We used to allow anything below
0x7e; now we clip that range further to reject anything below 0x21.
If [128] was big enough, it still is big enough, no?

Because the type of .short_name member is "int", we could have had
negative number in there and access to short_opts[] on the next line
would have been out of bounds.  By clipping the lower bound, we get
rid of that risk, no?

>>  				optbug(opts, "invalid short name");
>>  			else if (short_opts[opts->short_name]++)
>>  				optbug(opts, "short name already used");

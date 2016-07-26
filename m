Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4603203E4
	for <e@80x24.org>; Tue, 26 Jul 2016 22:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161274AbcGZWCT (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 18:02:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51940 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753045AbcGZWCS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 18:02:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F26DB30C6F;
	Tue, 26 Jul 2016 18:02:16 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c2xFvoN+Bnjzk315C81J9MhuFAs=; b=aN5TOK
	70dxJ31a3yndWusiSbqTXk4anOTgdokdkzgqzBGsju7NRDgxSudBHEIuA8VMDoZp
	5vblAryOfstM1O0xRiAUsdPN9DS4bqUhxbtxKg9M/V3FHkYTJ5g0sh0o/MV6yD4W
	kl7CsUZjHT3XrQKI6Pw/phMHpEcXnQrL5qPOs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DyJ738I8ajTu2kkxwLckI3Kap7w72EKk
	z21TBwfWAaColXHAvI/G5m+6awJbuT6FrxH4QCcoGoOrpVblZMjQX9e2Qri9mIya
	Dfl2gHnJtwk631tYPtirqDLnXPnldS97xpvQBfNlEX0eYo+fUnNo2zntMhEixRX3
	YyBZCHCRJKo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E563A30C6E;
	Tue, 26 Jul 2016 18:02:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 646DF30C6D;
	Tue, 26 Jul 2016 18:02:16 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	Heiko Voigt <hvoigt@hvoigt.net>, Git List <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 1/2] fix passing a name for config from submodules
References: <578E7A07.8080006@web.de> <20160720082515.GA823@book.hvoigt.net>
	<57911AFF.7030107@web.de> <20160725143706.GA4872@sandbox>
	<xmqq60rt933m.fsf@gitster.mtv.corp.google.com>
	<20160726094913.GA3347@book.hvoigt.net>
	<CAGZ79kaOf3NRAXh+krM=onwswSjAF3yy_zpa1d+9CFOBNke6-w@mail.gmail.com>
Date:	Tue, 26 Jul 2016 15:02:13 -0700
In-Reply-To: <CAGZ79kaOf3NRAXh+krM=onwswSjAF3yy_zpa1d+9CFOBNke6-w@mail.gmail.com>
	(Stefan Beller's message of "Tue, 26 Jul 2016 10:22:07 -0700")
Message-ID: <xmqqmvl4xdlm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9D76D6A8-537C-11E6-8332-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> @@ -425,8 +432,9 @@ static const struct submodule *config_from(struct submodule_cache *cache,
>>         parameter.commit_sha1 = commit_sha1;
>>         parameter.gitmodules_sha1 = sha1;
>>         parameter.overwrite = 0;
>> -       git_config_from_mem(parse_config, "submodule-blob", "",
>> +       git_config_from_mem(parse_config, "submodule-blob", rev.buf,
>>                         config, config_size, &parameter);
>
> Ok, this is the actual fix. Do you want to demonstrate its impact by adding
> one or two tests that failed before and now work?
> (As I was using the submodule config API most of the time with null_sha1
> to indicate we'd be looking at the current .gitmodules file in the worktree,
> the actual bug may have not manifested in the users of this API.
> But still, it would be nice to see what was broken?)

Sounds like a good idea.  I'll keep these two queued on 'pu' and see
if Heiko (or somebody else) can find time to do that, so that we can
replace them with an improved version when it happens.

Thanks.

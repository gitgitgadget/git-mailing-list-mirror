Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01A3B2018E
	for <e@80x24.org>; Fri,  5 Aug 2016 21:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758001AbcHEVHH (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 17:07:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50590 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S2999853AbcHEVG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 17:06:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 089CA31C12;
	Fri,  5 Aug 2016 17:06:36 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g9TKdjbqRv8Mh11gLQfL1lEXMzs=; b=fcI1CA
	aHSnDKvobAU4mBG14KvqCnLGULLWjMCpCcwdKGglRaPlbb0okXCigcCaBQKK+oka
	HK+vUvsBX88V6k0NjcG4cuU1GyUJAE725e2SjUyE7o5413impAzoidmLKrZXwGkm
	ezlno4tQSNrNSywDpC4XnYej41+crgFMn6woU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a12O6syvPyWed7KDcjZ00PVcFn9Kwggf
	D+5az/BvdO0zp1+kzdjxfXZOOJiv8k0FcRx1LjmkDosPTFrBa2Mf+TE5wevYyOOI
	AQJEalj4wrH1Yk84hCkrsTXRljlFjGGO4TEE5buL01wUwWuT5Ug/Jvq24AZ1bOdc
	tIl26QK4ip4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0115931C11;
	Fri,  5 Aug 2016 17:06:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7F59231C10;
	Fri,  5 Aug 2016 17:06:35 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	"git\@vger.kernel.org" <git@vger.kernel.org>, mst@redhat.com,
	Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 4/6] submodule--helper update-clone: allow multiple references
References: <20160804195159.7788-1-sbeller@google.com>
	<20160804195159.7788-5-sbeller@google.com>
	<CAGZ79kY4YxftihTP_cNqLrVTn0wrfNd5_mb40AB-t2beyzvdLA@mail.gmail.com>
Date:	Fri, 05 Aug 2016 14:06:33 -0700
In-Reply-To: <CAGZ79kY4YxftihTP_cNqLrVTn0wrfNd5_mb40AB-t2beyzvdLA@mail.gmail.com>
	(Stefan Beller's message of "Fri, 5 Aug 2016 12:08:46 -0700")
Message-ID: <xmqq60rfvsbq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7E4496C2-5B50-11E6-B7EE-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> -               ${reference:+--reference "$reference"} \
>> +               ${reference:+"$reference"} \
>
> Note how this changed the API of the submodule--helper.
> Currently we pass in --reference $reference
> and $reference consists of the string "--reference" and the actual
> reference. So it looked like '--reference' '--reference=foo'

So this change is a strict bugfix.  The code without this patch
had cmd_update that places "--reference=foo" in $reference, but
the call to "git submodule--helper" it makes added an unnecessary
"--reference" in front of it.

I was wondering why there is no corresponding change to add
"--reference" on the code that calls cmd_update().  Thanks for
saving my time ;-)

Perhaps that needs to go into the log message, though.  Allowing
multiple references is not that interesting from the POV of the
codebase immediately after this step and only deserves a "by the
way" mention.

    Subject: submodule--helper: fix cmd_update()

    cmd_update places "--reference=foo" in $reference, but the call to
    "git submodule--helper" it makes adds an unnecessary "--reference"
    in front of it.  The underlying "git clone" was called with two
    command options "--reference" and "--reference=foo" because of
    this.

    While at it, prepare the code to accept multiple references, as
    the underlying "git clone" can happily take more than one.

or something like that.

Needless to say, "While at it" could become a separate step, and a
pure bugfix part may even want to become a separate and more urgent
topic that can go to 'maint', with a test to prevent regression.

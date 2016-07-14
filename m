Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABB9D203BD
	for <e@80x24.org>; Thu, 14 Jul 2016 22:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752016AbcGNWgl (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 18:36:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63921 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751262AbcGNWgj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 18:36:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 52ADB2BD25;
	Thu, 14 Jul 2016 18:36:38 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FEdt1H+L5zbt0yp7Nay+Q63g99w=; b=uZFa6D
	O3e7ZQYkIiDLEGw6hOKC6+TntY/8EgSG8VN1t61xQ8WPL9qwczpbZge4DEkUWaRQ
	3kBh/4914o0J2Vodq5RqWZgEWclfwbfAE2zyM+Ig0JKhxiIyOBG/vrgbAnP+XZlg
	rEd4WmAU4NPTRfD+eGqwe0b1PNINmqgKh/LSM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AL81vyv4Ko2vPUzTwZGdENmfTjtDUC+i
	IFspdhJ+Pn4jK+GCZ2La3CuZ/0ALni/hgEMNZ2CpWEKoj1jvHtX5xrtEAYlO9OJO
	5+yw90hovwmApTXH6DDU1UUoD0N26BuPdZX4L2dWt5awX9rsfhwEYL9aY9uhJA/B
	1ew0ha7ttLo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4AF062BD24;
	Thu, 14 Jul 2016 18:36:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C1F132BD23;
	Thu, 14 Jul 2016 18:36:37 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 2/2] archive-tar: huge offset and future timestamps would not work on 32-bit
References: <xmqq7fcoot6t.fsf@gitster.mtv.corp.google.com>
	<20160714204357.2628-1-gitster@pobox.com>
	<20160714204357.2628-3-gitster@pobox.com>
	<20160714222047.GA21868@sigill.intra.peff.net>
Date:	Thu, 14 Jul 2016 15:36:35 -0700
In-Reply-To: <20160714222047.GA21868@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 14 Jul 2016 18:20:47 -0400")
Message-ID: <xmqqlh13onik.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6D3938CC-4A13-11E6-AC84-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Jul 14, 2016 at 01:43:57PM -0700, Junio C Hamano wrote:
>
>> As we are not yet moving everything to size_t but still using ulong
>> internally when talking about the size of object, platforms with
>> 32-bit long will not be able to produce tar archive with 4GB+ file,
>> and cannot grok 077777777777UL as a constant.  Disable the extended
>> header feature and do not test it on them.
>
> I tried testing this in a VM with 32-bit Debian. It fixes the build
> problems, but t5000 still fails.

Thanks for testing.  I need to find some time hunting for (or
building) an environment to do that myself.

> I think you need to add the prereq to one more test:
>
> diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
> index 699355b..80b2387 100755
> --- a/t/t5000-tar-tree.sh
> +++ b/t/t5000-tar-tree.sh
> @@ -347,7 +347,7 @@ test_lazy_prereq TAR_HUGE '
>  	test_cmp expect actual
>  '
>  
> -test_expect_success 'set up repository with huge blob' '
> +test_expect_success LONG_IS_64BIT 'set up repository with huge blob' '
>  	obj_d=19 &&
>  	obj_f=f9c8273ec45a8938e6999cb59b3ff66739902a &&
>  	obj=${obj_d}${obj_f} &&
>
> We shouldn't be accessing the blob in update-index, but I think "git
> commit" does so for the diff (and then after seeing the size says
> "whoops, that's binary", but even the size check fails on 32-bit
> systems).
>
> So another solution would be to use "commit -q" at the end of that test.
> I don't think there's much point, though; it's just setting up a state
> for other tests that need LONG_IS_64BIT.
>
> As an aside, it is inadvertently testing that our diff code does not
> bother to read the whole blob in such a case. Which maybe argues for
> using "commit -q", just because that is not a thing we are intending to
> test here.

Thanks.  Let's add a prereq there.

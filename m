Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A46E2018E
	for <e@80x24.org>; Fri,  5 Aug 2016 21:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1950039AbcHEVb2 (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 17:31:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63282 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423720AbcHEVbW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 17:31:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EE41431F1E;
	Fri,  5 Aug 2016 17:31:20 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wwNRkJH7pU+jVyaq4ZCkeaabcIc=; b=Gsu1Gk
	NJj6tNBYRf6PuEKFPsnP/IMQz3wiXbzXUv1GsWJq7tMV9RF4gMCr0qgTrxEwHxvO
	jJBR8LPM0mqK3S7sGU8aAlTrV3Nv494EHgei8Ajcpzbq7OyAGKMdFFkpXEtpivxm
	+GprJxtCX7J1SINBAknfRj8tT4Srnqpyg1Qkw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UoN/fGJMAT51fPsBNGB7nlzbEqPvDZgb
	xz+7nCeMqCa3HNGGSv7o8WyP7V9wSfOFEneh7pV6MpOF8ZnqvxqJxc/4Y+7BV6VL
	i6Mr2XYSqH5PBfuhAsbh9LFVXwPKWxmx01HagDJ12Bah/tAy4r7cjunCOOBAL/Hh
	4atM3eV0UVI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E7C1F31F17;
	Fri,  5 Aug 2016 17:31:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 73A8A31F16;
	Fri,  5 Aug 2016 17:31:20 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	"git\@vger.kernel.org" <git@vger.kernel.org>, mst@redhat.com,
	Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 4/6] submodule--helper update-clone: allow multiple references
References: <20160804195159.7788-1-sbeller@google.com>
	<20160804195159.7788-5-sbeller@google.com>
	<CAGZ79kY4YxftihTP_cNqLrVTn0wrfNd5_mb40AB-t2beyzvdLA@mail.gmail.com>
	<xmqq60rfvsbq.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbTcHN+18z+eXx+QDOCXL9vKeGYKukQJJ+ZnxT55_8htg@mail.gmail.com>
Date:	Fri, 05 Aug 2016 14:31:17 -0700
In-Reply-To: <CAGZ79kbTcHN+18z+eXx+QDOCXL9vKeGYKukQJJ+ZnxT55_8htg@mail.gmail.com>
	(Stefan Beller's message of "Fri, 5 Aug 2016 14:19:40 -0700")
Message-ID: <xmqqwpjuvr6i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F35E4D06-5B53-11E6-8979-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> I thought about rolling it as a strict bugfix; but the bug is shaded by the
> inverse bug in the helper, so the user would never see an issue.

Ahh, OK, because the helper accepts "--reference" "--reference=foo"
as a OPT_STRING whose value happens to be "--reference=foo", and
then uses

	if (suc->reference)
        	argv_array_push(&child->args, suc->reference)

where suc->reference _is_ "--reference=foo" when invoking the
underlying "git clone", it cancels out.

Then it is OK.

In fact there is NO bug.  It just is that update_clone subcommand
used a convention different from others that took the whole
--option=arg as a parameter to --reference option.  It could be
argued that it is an API bug between git-submodule.sh and
git-submodule--helper, but nobody else goes through this "weird"
interface, so it is not worth splitting the patch.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CCDB1FE4D
	for <e@80x24.org>; Thu, 16 Jun 2016 17:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754736AbcFPR1h (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 13:27:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55991 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754020AbcFPR1h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 13:27:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 972C424D8A;
	Thu, 16 Jun 2016 13:27:35 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HoVrPgPD9UUy1wdFP6mF3KMH0Cw=; b=C0fDBo
	kQJjQxmBuV5zQEe1Jhf15Osxz+4B5mxwhTBvhGu5FTBuIxHrBdJYos3DTq7vM+Lm
	05rWPHcQDCZV5lkwOp1JESN4yf1DNTD6A0jgMxZa/ivySMzdr8yem/eK5UAfZpVr
	IWzQzvehWMrIV46ws1ygtq7FOaVtU+hLSO8ZU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fWWA2RaP9q+mCExfmFGiDoFykUwtgy5V
	ddJIhF3bLXOdczlTNOOeKQl3V0R8ikXkbkgX1/M5wAUB6OyS2i+lKuJZFm/OvdMQ
	SMTJ7tiaCZ8/40NYHrj2tpT2dCTnqrSFd9S73+NcsBLXXlElw+dAHEskUofZ+FIt
	UJ/mnSiLokc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9040A24D89;
	Thu, 16 Jun 2016 13:27:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 17F5224D87;
	Thu, 16 Jun 2016 13:27:35 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Michael J Gruber <git@drmicha.warpmail.net>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH] verify-tag: allow to verify signed blob objects
References: <a6557333316c6f7996fa54eebc75abdf988ed9f9.1465991212.git.git@drmicha.warpmail.net>
Date:	Thu, 16 Jun 2016 10:27:33 -0700
In-Reply-To: <a6557333316c6f7996fa54eebc75abdf988ed9f9.1465991212.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Wed, 15 Jun 2016 13:51:54 +0200")
Message-ID: <xmqqk2hp59iy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9D4F7F0E-33E7-11E6-A584-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Currently, there is no easy way to verify push certificates. They have
> the same structure as signed tags: "attached detached signatures", that
> is: the concatenation of the signed material and its detached signature.
>
> Introduce a `--blob` option to verify-tag so that it allows to verify
> tags and blobs.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> The first outcome of my long announced project to describe our signature
> formats in Documentation/technical.... (progress underway)
>
> In fact, that whole area is in need of refactoring: gpg related bits are
> all over the place, including tag.c. The proposed patch neither improves
> nor worsens the situation in that respect. But, since we make it
> unnecessarily hard to verify signatures (git cat-file | gpg --verify fails)
> it's only fair to provide a tool for pre-receive hook writers.


Another (orthogonal) thing to think about is "is it sensible to add
a new feature to verify blob objects that has signature?"

That is, if we are adding one new feature, isn't it more sensible
for it to accept a stream of bytes from the standard input and run
verify-signed-bufter on it?  That way, if you already happen to have
a blob, you can feed it "cat-file blob" output to get the new
feature you added in this patch.

But you cannot go in the other direction without incurring downside.

If you start from "verify signature in blob" interface, and if all
you have is a log of push certificates in a flat text file [1], you
would need to do "hash-objects -w" first only to be able to use that
interface (which in turn means that you would need write access to
the object store of the repository.


[Footnote]

*1* push certificate is first written as a blob in the object store
    only so that we can safely run multiple receive-pack instances
    without them stepping on each others' toes; it is expected that
    they are collected by the server operator in chronological order
    and published in a human readable log form, so that outside
    people can verify honesty of the server operator.

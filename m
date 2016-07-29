Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D60421F955
	for <e@80x24.org>; Fri, 29 Jul 2016 18:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753160AbcG2Scp (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 14:32:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64003 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752283AbcG2Sco (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 14:32:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DA05F32C32;
	Fri, 29 Jul 2016 14:32:42 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AJPWk2IhLXjhDYSIFmp8MKs/2RQ=; b=wMk8ZQ
	01YkEZBrN8tedVD+6M18iMiYn2uDJDsOFRXX4bNDVIATf+74rH/3XgASAnFLaJ/Y
	Gyq/NcRDRepJcgZOKn9B4by+TJaTpgv7Z7UVmqmozOJgFX+NwNXWrkJDORs/LoVh
	ks0AgjwtYcx+O/zC0CXDMoCGTjciSL/aNZ3f4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ll054wkaw56vJTufqoJ57oYMDzQ/DbAZ
	qDCpv4g3X/KvxNuNUG5FMZGMLUXOWr04o/LO4dLDhetYTg27E2sG37HoQAsS722u
	4RwcF/7bO+wmwV9c4rIramxfRiGWTytDpS2iiGJzePrkzZv4ATwPfPjDZhyS/u0i
	EXmF4jq4RvU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D283632C31;
	Fri, 29 Jul 2016 14:32:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5F82F32C30;
	Fri, 29 Jul 2016 14:32:42 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Dakota Hawkins <dakotahawkins@gmail.com>, git@vger.kernel.org
Subject: Re: Issue with global config defaults "user.useConfigOnly = true" + "pull.rebase = preserve" - "user.email"
References: <CAG0BQXnVAYdpk9EM_uiD+=UKSKmK=z1YEar5MresTr5XfDCxHw@mail.gmail.com>
	<xmqqoa5gnxow.fsf@gitster.mtv.corp.google.com>
	<20160729181121.GB14953@sigill.intra.peff.net>
Date:	Fri, 29 Jul 2016 11:32:40 -0700
In-Reply-To: <20160729181121.GB14953@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 29 Jul 2016 14:11:22 -0400")
Message-ID: <xmqq60ronvlj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D601001C-55BA-11E6-A558-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> > Is this a case of rebase trying to make sure it has enough information
>> > for me to be a committer before knowing whether I even need to rewrite
>> > any commits, and could/should that be avoided?  Alternatively (or also)
>> > could/should rebase detect that a fast-forward is possible and prefer
>> > to do that instead?
>> 
>> I think that is a reasonable argument, but to solve this for a more
>> general case, shouldn't we be discussing a solution that would also
>> work when rebase _does_ need to create a new commit?  And when the
>> latter is solved, I would imagine that "this rebase happens to be
>> fast-forward, and not having an ident shouldn't be an issue for this
>> special case" would become moot.
>
> Wouldn't it be wrong to create a commit with non-config ident when
> user.useConfigOnly is set, though?

That is exactly what I was getting at.

> If the user is doing a one-off thing where they do not care if their
> crappy, fake ident makes it into a commit object, then the right thing
> is:
>
>   git -c user.useConfigOnly=false pull --rebase
>
> or even:
>
>   git -c user.email=fake-but-ok@example.com pull --rebase

Hmm, I somehow had an impression that these git commands are not
what the end-user runs from the command line, but wrapper tools like
"go get" has a hardcoded invocation of "git pull".

If a user sets useconfigonly globally, each repository must have
ident the user wants to use in it configured, so I would think that
a solution should be something that makes it easy to do so.


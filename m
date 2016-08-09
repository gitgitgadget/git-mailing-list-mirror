Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E90021F859
	for <e@80x24.org>; Tue,  9 Aug 2016 15:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752564AbcHIPtm (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 11:49:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52984 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752444AbcHIPtl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 11:49:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2F76F349AD;
	Tue,  9 Aug 2016 11:49:35 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hBUejethjQ+JTua9H2dAp5ypK+A=; b=cUJFaH
	+C1ziYYveFi6R25kHEPNH5CaFU1G81Bb8IXk1MXIDYM7Rgok2mHhxmkOQJ6xl3Cz
	zZ8C98JgwsKU5Gda88+V3M1riUNt+KAj30PpIrgOmvQuJIuccCtlCHbfVhEc1cO1
	ikOfhV82qHG6rWDjEC1AgZey060WjiUnlhlt4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x81kXq6c3qcV9yXolZCjD3KvJOxWDBJu
	CaLaQLlgYE4kM61pLvci0A7QtajCGShLdLh2PLVt3brxk2b7b0W8q4gPXRbDzDYU
	MyWIUyaVvrtLdb6iHP3k8HXz1C/cTteteWlJwrQFIpN7cfCn33TvZQ4i6NxoVYP1
	YX5wAhs1LBg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 24148349AC;
	Tue,  9 Aug 2016 11:49:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 929F2349AB;
	Tue,  9 Aug 2016 11:49:34 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	git@vger.kernel.org, Jens.Lehmann@web.de, mst@redhat.com
Subject: Re: [PATCHv2 0/6] git clone: Marry --recursive and --reference
References: <20160809040811.21408-1-sbeller@google.com>
Date:	Tue, 09 Aug 2016 08:49:32 -0700
In-Reply-To: <20160809040811.21408-1-sbeller@google.com> (Stefan Beller's
	message of "Mon, 8 Aug 2016 21:08:00 -0700")
Message-ID: <xmqqk2fqc583.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DE91ED7C-5E48-11E6-97EF-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> v3:
>
> Thanks to Junios critial questions regarding the design, I took a step back
> to look at the bigger picture. 
>
> --super-reference sounds confusing. (what is the super referring to?)
> So drop that approach.
>
> Instead we'll compute where the reference might be in the superproject scope
> and ask the submodule clone operation to consider an optional reference.
> If the referenced alternate is not there, we'll just warn about it and
> carry on.

I like the general direction, but I hope that the warning comes only
when the user said "--reference" on the command line (i.e. "you
asked me to use reference, but for this submodule I couldn't find a
usable one").  If the implementation allows the same mechanism to
help later "submodule init && submodule update" borrow from the
submodule repositories of the superproject the current superproject
borrows from (i.e. no explicit "--reference" on the command line
when doing init/update), I would think the case that needs warning
is "you didn't explicitly ask me to borrow objects, but I found one
we could, so I did it anyway without being asked", and it is not a
warning-worthy condition if we didn't find a cloned submodule in the
repository our superproject borrows from.

Thanks.

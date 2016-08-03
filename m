Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7100A1F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 21:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758410AbcHCVRk (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 17:17:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61306 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755188AbcHCVRi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 17:17:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 13F6631453;
	Wed,  3 Aug 2016 17:16:00 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+frh6MdAPMWxHg4x4sILGejM61I=; b=L61Ma3
	/bWktub4LxOATKTQ5GT67VN/QBxeFK6yEqetHWFRmBk0pSvd58v1y22lYotzk0QM
	leeVZEU+TC8rDid2aVZDTX9ia6xMejVsZUK/nXaep5nAq5tdm1CO/9ZGOeieGc8c
	9qDfNmpYGZLqqRzYqRVrDa12WChTOgMrT6CKg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BhQseg+C7aKjoQFy7+rex/H2w3loLx+e
	l5Lu2rPGl5Q3pEcZpl/oPq3FdKBoOAjRxSu7f6lPLIjn5AeJQwO8cSAdkNVznEhs
	w+RexYWjxdrgpAne8WfmC0kOMfi5COAUyzztYdzLYWCPPF2WA3htf9eQXr5VCp22
	YKuSdY0YL+Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C975E31452;
	Wed,  3 Aug 2016 17:16:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C4B4C31451;
	Wed,  3 Aug 2016 17:15:59 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Eric Wong <e@80x24.org>
Cc:	Jeff King <peff@peff.net>, "Kyle J. McKay" <mackyle@gmail.com>,
	git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH 1/1 v2] pager: move pager-specific setup into the build
References: <20160801214937.4752-1-e@80x24.org>
	<20160801214937.4752-2-e@80x24.org>
	<20160803161911.dxucq7f2pvnoovoc@sigill.intra.peff.net>
	<xmqq4m718tay.fsf@gitster.mtv.corp.google.com>
	<20160803210821.GA17510@whir>
Date:	Wed, 03 Aug 2016 14:15:57 -0700
In-Reply-To: <20160803210821.GA17510@whir> (Eric Wong's message of "Wed, 3 Aug
	2016 21:08:21 +0000")
Message-ID: <xmqqziot7dv6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 79D1ED2A-59BF-11E6-BC18-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> All bugs are from my original, I think.  Here is a proposed squash.
>
> Thanks, I'll take the git-sh-setup changes.
>
> I actually just rewrote setup_pager_env using split_cmdline and
> eliminated all the scary (to me) pointer arithmetic and avoided
> strbuf, too.

I actually do not have much faith in split_cmdline() in that I
cannot quite read and follow the flow of the logic in its
implementation, but it already is used widely so it must be OK, so I
am fine if you use it as a black-box to make this code simpler ;-)

I'll drop the squash then and replace it with your version when it
comes.

Thanks.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F61D2018F
	for <e@80x24.org>; Tue, 19 Jul 2016 21:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbcGSVdO (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 17:33:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57512 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751614AbcGSVdO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 17:33:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CD9672F0D5;
	Tue, 19 Jul 2016 17:33:12 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q08HuDryy01tYxBrR56zMeEvsUs=; b=mAalny
	QJhK3SF7gqzM/cGZK98aJoWeXgLZOMBWTR58rq29wXba5kOngR8eXM6YSGdyYs93
	sdGteLeYkkYq5n2sjErEbX+wXk/kvqr22NkHq03sU7JEt98uEOs8Mx+wcNSljfI1
	9/IW3t7yn3Itqf6Tq2vDY1aroZLK4iXyECUNM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AxTO+nMCN8a0OBOhFWyNA+23J1Xhhgfh
	C3iJPMk3sfs/f/K91U+0QdVK3r1XmUup7pHeUB+ojB3vGiLOHn8meu4lauz3EZ7e
	xRKecT22QqGDDta74mUlsDvWS+Smj/Y6TYMnocHMxl9H2C3j9BbSTFPo4WWCzEvB
	wZmD9wwIc4M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C52562F0D4;
	Tue, 19 Jul 2016 17:33:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3F99A2F0D3;
	Tue, 19 Jul 2016 17:33:12 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>
Subject: Re: Looking for help to understand external filter driver code
References: <67D9AC88-550E-4549-9AFD-2401B70B363B@gmail.com>
	<xmqqbn1th5qn.fsf@gitster.mtv.corp.google.com>
	<xmqqlh0xfoho.fsf@gitster.mtv.corp.google.com>
	<7B44C694-7CB2-411D-9CC6-7334CCBAD20B@gmail.com>
Date:	Tue, 19 Jul 2016 14:33:09 -0700
In-Reply-To: <7B44C694-7CB2-411D-9CC6-7334CCBAD20B@gmail.com> (Lars
	Schneider's message of "Tue, 19 Jul 2016 22:44:53 +0200")
Message-ID: <xmqqr3ape2ju.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 64FA1ABC-4DF8-11E6-B3A9-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> Git writes --> 4 byte filename length
> Git writes --> filename string

Why limit to 32GB?  Perhaps NUL termination is more appropriate
here?

> Git writes --> 4 byte content length
> Git writes --> content string
> Git reads <-- 4 byte filtered content length
> Git reads <-- filtered content

Do you really need to force the sender to know the length in
advance?  Together with the sequential nature of the above exchange,
i.e. the filter is forbidden from producing even a single byte of
its output before reading everything Git feeds it, you are making it
impossible to use filters that perform streaming conversion.

Of course, with the "sequential" thing, you do not have to worry
about deadlocking hence no need for poll/select, but I am not sure
that is a good thing.



Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 778991F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 04:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbfJWEBH (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 00:01:07 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52752 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfJWEBH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 00:01:07 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5EC9A8C13A;
        Wed, 23 Oct 2019 00:01:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=CHAiLUbBijWS
        QMKWe+gGFoQucnE=; b=Lqt57cqBVLmqHqsikqqpSEFOULBCgleP8SorlmA5JQVr
        H+v+pHABNbEKnvstyIngX2E1lp0aGAYDz/jr2lTka0oO57K2WZTTfwFX/ivrrp+x
        oOZb6b4AyC1iPUtWLji7ibgOziFjl6t3ar9DW5lUwfllyUDHc0XrM+HFlBbvuTA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Tqmyow
        2vcXHcD60153x0C26gmzpTpqrlZTMaxkwO0sN3g0+lt+J2YF7WQe0iIIAfUGtK5M
        LSL2T84qazy0ZAy+4SoAMGQBpolX10y42BYtQ+NBQqZgAcTy7orBncChcw48abA3
        +1H6jSsxNeQbJ5C6lhKFqNsWhTdluZ1FLFE2M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 558318C139;
        Wed, 23 Oct 2019 00:01:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 80FE98C138;
        Wed, 23 Oct 2019 00:01:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     David Turner <novalis@novalis.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 5/5] path.c: don't call the match function without value in trie_find()
References: <20191021160043.701-1-szeder.dev@gmail.com>
        <20191021160043.701-6-szeder.dev@gmail.com>
        <20191021205703.GB4348@szeder.dev>
Date:   Wed, 23 Oct 2019 13:01:00 +0900
In-Reply-To: <20191021205703.GB4348@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Mon, 21 Oct 2019 22:57:03 +0200")
Message-ID: <xmqqa79si003.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BAB653F2-F549-11E9-846A-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

>>   - b9317d55a3 added two new keys to the trie: 'logs/refs/rewritten'
>>     and 'logs/refs/worktree', next to the already existing
>>     'logs/refs/bisect'.  This resulted in a trie node with the path
>>     'logs/refs', which didn't exist before, and which doesn't have a
>
> Oops, I missed the trailing slash, that must be 'logs/refs/'!
>
>>     value attached.  A query for 'logs/refs/' finds this node and then
>>     hits that one callsite of the match function which doesn't check
>>     for the value's existence, and thus invokes the match function
>>     with NULL as value.

Given that the trie is maintained by hand in common_list[], I wonder
if we can mechanically catch errors like the one b9317d55a3 added,
by perhaps having a self-test function that a t/helper/ program
calls to perform consistency check after the "git" gets built.

Thanks.




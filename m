Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95CA21F462
	for <e@80x24.org>; Wed, 24 Jul 2019 16:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfGXQJH (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jul 2019 12:09:07 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53264 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfGXQJH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jul 2019 12:09:07 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6763A7E414;
        Wed, 24 Jul 2019 12:09:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=D4aNqUq6qWy03Y9FUZ4svyKQBDM=; b=lBk3eg
        FqYTpDb8JdPBw4xw7FzkvyD+u+l9haSbzsR7W5AufcfkFRqsliSeHsJw9d0hqMHd
        zeuwT0VjjVk0OSj19qNbdfzLN/JMRhcLU2Ejw7zL1IpmhL76x+8Xtn8zJZBb/xZH
        TVahwGzrNawdahpkpKlMQGpwLc95wBYT+Ym18=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kpRtkUuE8/U/BSLKyGkytFSu6hK1lPNj
        yhE1+yXvh0Hn8ZSlcrY5f6dRWycpMn3axdTa8hNF+XBBS0xb1lJHdn62F9wv9SXw
        t/nFDgQ0KVD8U8F+KJnqgIUS2kg4Ae6TMO16UN/QH5tZxJ7CXOEi0Xv6py3ZK7rR
        rn9HkCqeoOM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6018D7E413;
        Wed, 24 Jul 2019 12:09:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 70E7B7E411;
        Wed, 24 Jul 2019 12:09:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH] grep: skip UTF8 checks explicitly
References: <nycvar.QRO.7.76.6.1907221340320.47@tvgsbejvaqbjf.bet>
        <20190722144350.46458-1-carenas@gmail.com>
        <xmqqa7d4rxm9.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1907241248000.21907@tvgsbejvaqbjf.bet>
Date:   Wed, 24 Jul 2019 09:08:59 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1907241248000.21907@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Wed, 24 Jul 2019 12:50:17 +0200
        (CEST)")
Message-ID: <xmqq5znrs9d0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 59CB6D7E-AE2D-11E9-B267-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> My reading of the situation is slightly different. I think
> PCRE_NO_UTF8_CHECK is off by default, but it only makes a difference in
> the non-JIT'ed code path. Since we use PCRE2's JIT when possible
> (because it leads to a quite nice performance improvement), we usually
> don't see those warnings. Carlo's patch makes the non-JIT'ed code path
> behave the same as our preferred code path.

You're right and we do want to make both codepaths behave the same
way.  The case we are having trouble with is without JIT, where the
machinery to look for needle in a non-UTF8 binary haystack barfs and
dies, which is unacceptable (imagine "git log --grep=..."), and we
want the machinery to ignore random binary gunk just like the JIT
codepath does.

Thanks.


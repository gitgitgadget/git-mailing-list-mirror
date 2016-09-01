Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86AEE1F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 22:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752724AbcIAWQo (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 18:16:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62357 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751540AbcIAWQn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 18:16:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 310F239CE9;
        Thu,  1 Sep 2016 18:16:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ekTpUA7raE9LwLF3ES2xNznzqQ4=; b=nXZsGR
        SxC0fMxrVhQ/3IXXEESMhcZ1KIEKLoBQXM/ykIU9klauqmStdP2NqwivhFyii2s4
        /kRpji9vnnv6SXRYYDYWCXWBWZmsE+oGcvL9NEq+t+UzMz58P8dOCiKtLlAIsZbC
        13UDVmEk019nIdSEBlthJdl0cIh7JIdu6/tw8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BRWYPLeaZhmUjO/ha42Ghzfj/+opSU4R
        Me33wlJgdmEavR9OrR9Yw7S7yswusinnbLZ7cbC9WECfFc8uM9RY1iwSSKcLbWcE
        wY0mrAL2HA/tXsi99my5vA6FwStcrd+MA7/yYMYRbHywGfDsX6EuNJXDW7Spv7Jw
        h0Q4kIWf30Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2733139CE8;
        Thu,  1 Sep 2016 18:16:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 95F5A39CE3;
        Thu,  1 Sep 2016 18:16:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Jan Keromnes <janx@linux.com>, git@vger.kernel.org,
        Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>,
        Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: `make profile-install` fails in 2.9.3
References: <CAA6PgK7C18F1WGyZMTEUAWEVsUWqiZND5Ne_0SH-rUEm8u5dNg@mail.gmail.com>
        <20160901200700.GA8254@hank>
        <20160901215810.ez47lqwmfmahyvc7@sigill.intra.peff.net>
Date:   Thu, 01 Sep 2016 15:16:38 -0700
In-Reply-To: <20160901215810.ez47lqwmfmahyvc7@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 1 Sep 2016 17:58:10 -0400")
Message-ID: <xmqqh99zuuyh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C1E49066-7091-11E6-AA38-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yeah, I think we should _always_ act on the --chmod, no matter if the
> file is racy or not, or whether it has a content change or not. I.e.,
> the race is not the problem, but rather the behavior of 4e55ed32. Your
> second proposal there sounds more like the right approach.

Yeah, you two are absolutely right.  The second "git add --chmod=+x"
in

    $ git add .
    $ git add --chmod=+x .

should still find _all_ the non-executable paths and flip their
executable bit in the index, making them all up-to-date in the
index.

Which means that piggybacking this on the "run 'git diff' limited to
the pathspec to find the paths that needs updating" logic usually
done in "git add" can not be reused [*1*].

What was I thinking while reviewing the patch X-<.  Sigh.


[Footnote]

*1* I guess we _could_, by first flipping all the regular file
    blob's executable bit for paths that are inside the pathspec and
    then by running "git diff" against that modified index, limited
    to the pathspec, to find the paths that need to be added.

    It sounds ugly, but may conceptually be cleaner.  We first start
    from an ideal end-result, and then re-hash what needs to be
    updated to match the ideal.



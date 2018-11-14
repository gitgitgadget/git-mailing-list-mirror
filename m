Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 626EA1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 03:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730998AbeKNNZy (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 08:25:54 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52285 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbeKNNZy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 08:25:54 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E63811C3F4;
        Tue, 13 Nov 2018 22:24:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FnxgAUetcf24AGADBYOwjq+zEnw=; b=Uyx1r4
        zU31I3K0YDVC3bfZqn+n5VWXJiGcgEiIk1JyR7Ia5YAehQFDw2fjHPQTGK2jHYaK
        ihlc0rlZJOqo6Su75enS8URRyjMCpUiHp4FvJ0Zcm9myIK4HJKsrawx7RBRo796D
        waY6GexV+NDCABEW+WuZUajsQLmq4bi/wUX7M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eKSgFcbo0GcBdu7/+eh52v/ONeqvcTVY
        WsB+wATtnInQdyXeN5QSul1POKHlpAG9obTb+qUH/Cemo0OC7sbyxLRYYlMaRZOj
        BPcCLKTiDd3SVT1sLcLTQU74OD6U5dU91kEQSnM5IWt4T/u7me9PwFmoCiGnlAg2
        nVyu0PQe+uM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 66D1411C3F3;
        Tue, 13 Nov 2018 22:24:36 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D7CEB11C3F2;
        Tue, 13 Nov 2018 22:24:35 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Ben Peart <peartben@gmail.com>, git@vger.kernel.org,
        pclouds@gmail.com, Ben Peart <benpeart@microsoft.com>
Subject: Re: [PATCH 3/3] index: do not warn about unrecognized extensions
References: <20180823154053.20212-1-benpeart@microsoft.com>
        <20181010155938.20996-1-peartben@gmail.com>
        <20181113003817.GA170017@google.com>
        <20181113004019.GD170017@google.com>
Date:   Wed, 14 Nov 2018 12:24:34 +0900
In-Reply-To: <20181113004019.GD170017@google.com> (Jonathan Nieder's message
        of "Mon, 12 Nov 2018 16:40:19 -0800")
Message-ID: <xmqqh8gkqr2l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CFAE35B8-E7BC-11E8-B492-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> We cannot change the past, but for index extensions of the future,
> there is a straightforward improvement: silence that message except
> when tracing.  This way, the message is still available when
> debugging, but in everyday use it does not show up so (once most Git
> users have this patch) we can turn on new optional extensions right
> away without alarming people.

That argument ignores the "let the users know they are using a stale
version when they did use (either by accident or deliberately) a
more recent one" value, though.

Even if we consider that this is only for debugging, I am not sure
if tracing is the right place to add.  As long as the "optional
extensions can be ignored without affecting the correctness" rule
holds, there is nothing gained by letting these messages shown for
debugging purposes, and if there is such a bug (e.g. we introduced
an optional extension but the code that wrote an index with an
optional extension wrote the non-optional part in such a way that it
cannot be correctly handled without the extension that is supposed
to be optional) we'd probably want to let users notice without
having to explicitly go into a debugging session.  If Googling for
"ignoring FNCY ext" gives "discard your index with 'reset HEAD',
because an index file with FNCY ext cannot be read without
understanding it", that may prevent damages from happening in the
first place.  On the other hand, hiding it behind tracing would mean
the user first need to exprience an unknown breakage first and then
has to enable tracing among other 47 different things to diagnose
and drill down to the root cause.



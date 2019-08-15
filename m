Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12FA51F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 22:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730586AbfHOWKc (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 18:10:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60754 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfHOWKc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 18:10:32 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4185D1605FF;
        Thu, 15 Aug 2019 18:10:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4ijGv2Mu4x09YBSmqN5ijJTAoaQ=; b=sYq5Nm
        qaRy+DNT+vHPseNQYwGHRbrjeWfT0lpEkrkSWgJxxGOPA8ToMmXz26n2scPMSn8y
        CZSmV2e/3pLB981in2KfExwOYwHod44pn/DKZv1I/h7u/R1VXa8uSz798vyhNB2f
        wCcTzgAjWbKDTVpWBBBPuczMJYrckAf9o6M8w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LQ6cbGC33VTvd0NYgCaJa3eDpbYMp+1k
        tr88mKuhT+1ucLIN2in6U0Cf2TZstHyfi3HFysWOKmP6Zm8XakYT8r+XG7SxpMP0
        otWu/lquutUWj5e4y5A5DA/IyLbAPw8kwyZAfrfUPZpHmeL3N9h3Ho8TGqtrkBs6
        OtwB+6BJLcY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 39A941605FE;
        Thu, 15 Aug 2019 18:10:31 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 90FCB1605FD;
        Thu, 15 Aug 2019 18:10:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/2] apply: reload .gitattributes after patching it
References: <20190809100217.427178-1-sandals@crustytoothpaste.net>
        <20190813024307.705016-1-sandals@crustytoothpaste.net>
        <20190813024307.705016-3-sandals@crustytoothpaste.net>
        <xmqq7e7h7xap.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 15 Aug 2019 15:10:29 -0700
In-Reply-To: <xmqq7e7h7xap.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 13 Aug 2019 11:08:46 -0700")
Message-ID: <xmqqftm22i7e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7E9D20F6-BFA9-11E9-B35D-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>> When applying multiple patches with git am, or when rebasing using the
>> am backend, it's possible that one of our patches has updated a
>> gitattributes file. Currently, we cache this information, so if a
>> file in a subsequent patch has attributes applied, the file will be
>> written out with the attributes in place as of the time we started the
>> rebase or am operation, not with the attributes applied by the previous
>> patch. This problem does not occur when using the -m or -i flags to
>> rebase.
> ...
> "rebase -m" and "rebase -i" are not repeated run_command() calls
> that invoke "git cherry-pick" or "git merge" these days, either, so
> I am somewhat curious how they avoid fallilng into the same trap.
>
> Thanks for the fix.  Will queue.

Actually there still is one more thing I wasn't clear about the
change.

> To ensure we write the correct data into the working tree, expire the
> cache after each patch that touches a path ending in ".gitattributes".
> ...
> +			if (!flush_attributes && patch->new_name &&
> +			    ends_with_path_components(patch->new_name, GITATTRIBUTES_FILE))
> +				flush_attributes = 1;

When an attribute file is removed by a patch, we should forget what
we read earlier from the file before it got removed.  Would such a
case, where patch->new_name would be NULL, be handled correctly?

The call to ends_with_path_components() is almost no cost, and I
would suspect that this call is easier to reason about without the
"!flush_attributes &&" in the conditional part, by the way.

Thanks.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA1BE1F859
	for <e@80x24.org>; Thu, 25 Aug 2016 19:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756296AbcHYTui (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 15:50:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62608 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755918AbcHYTuf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 15:50:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5604E36591;
        Thu, 25 Aug 2016 15:43:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Wmx/JAWN8aXWZeynaRpF2kjihUU=; b=AlLRD5
        LLCPZvRFpWSgzmZC5+o9u4xHFAui1BTabEpWgEomskRny6Gpe0R2ZjsbWN7s0IKT
        JkdziCKTXb3AmNG6yMgmqS1CKh8w8cMXY78X/NPqfzhRKtWEZpX8KcTTOPbn84d5
        vnnB9Ah1r/yXfjKSeN5H3lPLOBiokEwjjfqKw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gbPfBnrGrfn8h/fYTSd8yRkPxD5KkofE
        xaHw14jY0/HgtNxrXG6pvunpUSx8FKj1Cjaji+asakpw6oGPN328PSLcUYvsxjSE
        9sFyV5sRb9D/cVvopuHTeiGpI1ZK67WU7Ko3KdAkjONcUM/sJXUamBnKTc3YAAbt
        ziowMmX/cno=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4F75D36590;
        Thu, 25 Aug 2016 15:43:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D17873658E;
        Thu, 25 Aug 2016 15:43:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v14 13/27] bisect--helper: `bisect_start` shell function partially in C
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
        <01020156b73fe6b9-5e500c96-9bc3-4a6b-beb9-b5988dc9ee85-000000@eu-west-1.amazonses.com>
        <xmqqd1kwn035.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 25 Aug 2016 12:43:20 -0700
In-Reply-To: <xmqqd1kwn035.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 25 Aug 2016 12:02:38 -0700")
Message-ID: <xmqq8tvkmy7b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2EABD664-6AFC-11E6-A94F-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +	for (i = 0; i < revs.nr; i++) {
>> +		if (bad_seen)
>> +			string_list_append(&states, terms->term_good.buf);
>> +		else {
>> +			bad_seen = 1;
>> +			string_list_append(&states, terms->term_bad.buf);
>> +		}
>> +	}
>
> This is certainly different from the original.  We used to do one
> "bisect_write" per element in revs in the loop; we no longer do that
> and instead collect them in states list.  Each element in these two
> lists, i.e. revs.item[i] and states.item[i], corresponds to each
> other.
>
> That explains why the variable is renamed to states.  We haven't
> seen enough to say if this behaviour change is a good idea or not.

Ahh, I misread the original.  It accumulates the writes to be
executed in $eval and does so at the end.  So there is no change in
behaviour.

So please ignore that point in the previous message.  That leaves
only the following points:

 * Perhaps 'retval' with 'goto finish' pattern?

 * ref_exists()?  Perhaps use skip_prefix(head, "refs/heads/, &branch)?

 * if (clean-state) { return -1 }?

 * Is comment on trap relevant here?

Sorry, and thanks.

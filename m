Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A30AD2021E
	for <e@80x24.org>; Tue, 15 Nov 2016 21:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933304AbcKOVkJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 16:40:09 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61772 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752604AbcKOVkI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 16:40:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B240F4E94D;
        Tue, 15 Nov 2016 16:40:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KWgJfNkL35Dfk2TIEmWZdUK00N4=; b=Lhed/T
        qgTAwDk3Rk3vV4kNFXoSPiAie8XSXMnxfsIFmnjgJr2ghl1xwg4ttBhrG4iJkG/+
        J+w3cx5fGZ9TpRHLkxRCynFzsNOa/ZHUjGtSWojr6KoIugxL8bkrBk7htox3Qv+7
        781NR5/T76aEox3zpV/onZ4SNWcnY6X031pOM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=j9ISGpHcNBpPK0MKsCnDGqsQupowtAES
        i+Or4OXNnSGsGU6V+vuseJm2cpGtjmUM7RYAGTyzVfa4KrnK6/D1qVzX/pMtZUI4
        izAmlTSpZcRspokpObnFl6NtaEUPyp1oB2P28DFPniwOt3FpSBU1FIGRoSmcmj1u
        6mU2rTfrzWc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A9C2D4E94B;
        Tue, 15 Nov 2016 16:40:07 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1E49D4E94A;
        Tue, 15 Nov 2016 16:40:07 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v15 04/27] bisect--helper: `bisect_clean_state` shell function in C
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
        <01020157c38b1a82-dc1c5b57-3e93-4996-87e7-4a1d83cb5817-000000@eu-west-1.amazonses.com>
        <13aa642a-2272-c5b8-4a30-382ab5e73b98@gmx.net>
Date:   Tue, 15 Nov 2016 13:40:05 -0800
In-Reply-To: <13aa642a-2272-c5b8-4a30-382ab5e73b98@gmx.net> (Stephan Beyer's
        message of "Tue, 15 Nov 2016 22:09:11 +0100")
Message-ID: <xmqq37istoay.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 136A737C-AB7C-11E6-9078-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stephan Beyer <s-beyer@gmx.net> writes:

>> +int bisect_clean_state(void)
>> +{
>> +	int result = 0;
>> +
>> +	/* There may be some refs packed during bisection */
>> +	struct string_list refs_for_removal = STRING_LIST_INIT_NODUP;
>> +	for_each_ref_in("refs/bisect", mark_for_removal, (void *) &refs_for_removal);
>> +	string_list_append(&refs_for_removal, xstrdup("BISECT_HEAD"));
>> +	result = delete_refs(&refs_for_removal, REF_NODEREF);
>> +	refs_for_removal.strdup_strings = 1;
>> +	string_list_clear(&refs_for_removal, 0);
>
> Does it have advantages to populate a list (with duplicated strings),
> hand it to delete_refs(), and clear the list (and strings), instead of
> just doing a single delete_ref() (or whatever name the singular function
> has) in the callback?

Depending on ref backends, removing multiple refs may be a lot more
efficient than calling a single ref removal for the same set of
refs, and the comment upfront I think hints that the code was
written in the way exactly with that in mind.  Removing N refs from
a packed refs file will involve a loop that runs N times, each
iteration loading the file, locating an entry among possibly 100s of
refs to remove, and then rewriting the file.

Besides, it is bad taste to delete each individual item being
iterated over in an interator in general, isn't it?


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90A3E20193
	for <e@80x24.org>; Thu,  1 Sep 2016 21:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753468AbcIAVMs (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 17:12:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60142 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757182AbcIAVKR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 17:10:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 53E6B35EEB;
        Thu,  1 Sep 2016 13:32:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aJ5c5l/dgs2JPGZmipph5aLmuVc=; b=iGoZsC
        zwmwkWHrh7vzDGwLf0X0GKA+/IIcTB5220sjXeFZhsiaTZVYCO4KRgV7bS9/sm/6
        8e8DCNXKt5wNqhacWEeszsYqi5KJ2x5Blp0s3/jF7YgXK4fFCHj+W3bHVVQPecqv
        QzzRU9MHFnzDMjxjSf6QVhRuPu9eT4ug+Ypzw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O4NDHfoqMktgZYrfI0hBdTU9ke+Vfg2q
        LsDpdFtGdmdhX66FSfp197UzwX9GJCaZfj4dJjZudZQktnEG/bIObnfpYVIIU+Tk
        Wowr1LYBcFi9ngvIACcZaQqb5kA5Yls+B30pceqBLKB8nVi5dpG1GVWtxmf1bl+z
        sea64ioPHrw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4D66E35EEA;
        Thu,  1 Sep 2016 13:32:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CE64D35EE7;
        Thu,  1 Sep 2016 13:32:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     "Git List" <git@vger.kernel.org>
Subject: Re: Are --first-parent and --ancestry-path compatible rev-list options?
References: <2FA1998250474E76A386B82AD635E56A@PhilipOakley>
        <xmqqfuprdtwh.fsf@gitster.mtv.corp.google.com>
        <CD6AE25418644EB688D4488F8AB40155@PhilipOakley>
Date:   Thu, 01 Sep 2016 10:32:17 -0700
In-Reply-To: <CD6AE25418644EB688D4488F8AB40155@PhilipOakley> (Philip Oakley's
        message of "Sat, 27 Aug 2016 12:04:08 +0100")
Message-ID: <xmqq8tvby19a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 08D81506-706A-11E6-A712-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "Junio C Hamano" <gitster@pobox.com>
>> "Philip Oakley" <philipoakley@iee.org> writes:
>>
>>> The commit graph. We are looking for F based on knowing J.
>>>
>>> . A - B - C - D -- E -- F -- G - H    <-first parent, --merges (C,F,H)
>>> .  \  |  /    \        /    /
>>> .   ----Z     |       /    /
>>> .     |       |       |   /
>>> .      \       \     /   /
>>> .       I -[J]- K - L - M             <-since J, children of J
>>> .        \         /
>>> .         N - O - P
>>
>> I think these two operations are fundamentally incompatible.
>
> If I run them independently, they both find the desired INTERESTED
> commit, hence the expectation that together they will still find that
> commit as an intersection between the two sets.
>
>>
>> Because the first-parent traversal is what the name says, i.e.,
>> forbids the positive side of revision traversal to stray into side
>> branches, the positive side of a traversal that begins at H will not
>> see M, L and K.
>
> But it does see F the ultimately desired commit.

You are doing --merges --first-parent, right?  Traversing only the
first-parent chain on the positive side, while excluding J's
ancestor by traversing the negative side without being limited to
the first-parent chain, would paint B and its ancestors as
uninteresting on the first-parent chain, so among H, G, F, E, D and
C, which are the survivors on the first-parent chain that are still
not UNINTERESTIN, the last one you would find that is a merge is F.

So I do not see any room for "But" to come in here...

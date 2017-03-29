Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2515D20958
	for <e@80x24.org>; Wed, 29 Mar 2017 20:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932856AbdC2UAY (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 16:00:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65000 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753515AbdC2T72 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 15:59:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5617B82D88;
        Wed, 29 Mar 2017 15:59:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8FbarXPWpmbw4A/VwRjCRRZK8Vk=; b=imvcGR
        k4KB9WPp6G6mbM0ec0pFZmXS12PwJddwF85WSGfz3+H/RzH0AWvLZnMtdjrDqQzl
        1FTzUCLKSJ/RslbGuO+ZO3VCOXXwxSyFL2iqT00SWo0iFpmFQlS/ngGCqJIV+kvQ
        oip7VMAnPqRrHjuVQLivEhO3bm6S4NPf1eE90=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cd2t0+isC+30aA/SPH5k2jiKeHJBlctD
        QP1uH1NG1sffx8VCO47sgWQKRjfoEU3D1KB8yI5bLdZhhVnFyWvISFW5nb2EYC/o
        5CFxejbXvwpv/wk124l9a6aPLNbLbTuyK+KsDAEcriC2NXuEkqUKMo+5WYrwYBL8
        5QZQwEy/OH4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4DF8182D87;
        Wed, 29 Mar 2017 15:59:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B220F82D86;
        Wed, 29 Mar 2017 15:59:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com
Subject: Re: [PATCH v3 0/8] refactor the filter process code into a reusable module
References: <20170329155330.12860-1-benpeart@microsoft.com>
Date:   Wed, 29 Mar 2017 12:59:24 -0700
In-Reply-To: <20170329155330.12860-1-benpeart@microsoft.com> (Ben Peart's
        message of "Wed, 29 Mar 2017 11:53:22 -0400")
Message-ID: <xmqqr31fam77.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 35D060B4-14BA-11E7-A236-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> Ben Peart (8):
>   pkt-line: add packet_writel() and packet_read_line_gently()
>   convert: Update convert to use new packet_writel() function
>   convert: Split start_multi_file_filter into two separate functions
>   convert: Separate generic structures and variables from the filter
>     specific ones
>   convert: Update generic functions to only use generic data structures
>   convert: rename reusable sub-process functions
>   sub-process: move sub-process functions into separate files
>   convert: Update subprocess_read_status to not die on EOF

This presentation is much easier to digest, compared to the large
ball of wax we saw previously.  It highlights the key modification
that cmd2process is now "subclassed" from subprocess_entry which is
a more generic structure by embedding the latter at the beginning,
and have its user start_multi_file_filter_fn() explicitly downcast
the latter to the former around patches 4/8 and 5/8.

If I were doing this series, I would organize the first two slightly
differently, namely:

 * 1/8 just adds packet_read_line_gently().

 * 2/8 moves packet_write_line() from convert.c to pkt-line.c while
   renaming it, with the justification that this function must be
   made more widely available.  It would naturally involves
   adjusting existing callers.

because write and read done in your 1/8 are independent and
orthogonal changes, and doing it that way also avoids needless
temporary duplication of the same function.

I may later have further comments on 3-8/8 after giving them another
read, but I haven't seen anything questionable in them so far.

Thanks.


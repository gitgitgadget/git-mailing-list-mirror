Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A75AE1F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 22:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755294AbcHXWO4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 18:14:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64533 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755218AbcHXWOz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 18:14:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CFC1E39349;
        Wed, 24 Aug 2016 18:13:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OCC4yqDoasO5FzJLpBQzdIWTBaM=; b=rvd19H
        H7WAev1SqFFtuTqe0ROPrgsdyvQ+C6+iPx6fIfq+gsH1Rus7lylPmtw3LIOVUsgY
        suoHwfPgcuYPBD0GpTDKetCVhBIbnfb0lv/ELBOh6JEotaQH9Af11NLvYO/WGHQ3
        NPKCu7oRiWxOIuaKv/DSyqlaI/4RcWw/nfrWo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=N18dprKZjJsu8GLrtMsHfQVQ8xZUXTvw
        LeNW0rvl58ElujR8Lj11ruQFwX/Jgz3N8tFf4W6GM4iXBb2IYtFg2aYz7p9NtEcj
        3OY1dlZFYi0rBQA8Rj+SC/vsSBNKAp1IgPbV5LwlxCNc49tC0mjds4fAbeRNC1mY
        MDydd5ehvCc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C798439348;
        Wed, 24 Aug 2016 18:13:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5351E39347;
        Wed, 24 Aug 2016 18:13:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v14 08/27] bisect--helper: `is_expected_rev` & `check_expected_revs` shell function in C
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
        <01020156b73fe69f-6b734e3c-806c-431d-aa52-c96b3783f248-000000@eu-west-1.amazonses.com>
Date:   Wed, 24 Aug 2016 15:13:57 -0700
In-Reply-To: <01020156b73fe69f-6b734e3c-806c-431d-aa52-c96b3783f248-000000@eu-west-1.amazonses.com>
        (Pranit Bauva's message of "Tue, 23 Aug 2016 11:53:53 +0000")
Message-ID: <xmqqlgzlolwa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0E6BF078-6A48-11E6-A1D5-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

> +static int is_expected_rev(const char *expected_hex)
> +{
> +	struct strbuf actual_hex = STRBUF_INIT;
> +	int res = 0;
> +	if (strbuf_read_file(&actual_hex, git_path_bisect_expected_rev(), 0) >= 0) {
> +		strbuf_trim(&actual_hex);
> +		res = !strcmp(actual_hex.buf, expected_hex);

If it is known to have 40-hex:

 (1) accepting ">= 0" seems way too lenient.  You only expect a
     41-byte file (or 42 if somebody would write CRLF, but I do not
     think anybody other than yourself is expected to write into
     this file, and you do not write CRLF yourself);

 (2) strbuf_trim() is overly loose.  You only want to trim the
     terimnating LF and it is an error to have other trailing
     whitespaces.

I think the latter is not a new problem and it is OK to leave it
as-is; limiting (1) to >= 40 may still be a good change, though,
because it makes the intention of the code clearer.


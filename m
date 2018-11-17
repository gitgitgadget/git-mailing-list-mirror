Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECEF41F87F
	for <e@80x24.org>; Sat, 17 Nov 2018 07:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbeKQSCP (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Nov 2018 13:02:15 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61407 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbeKQSCP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Nov 2018 13:02:15 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 07078113E0E;
        Sat, 17 Nov 2018 02:46:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=K6HrmuSYmbrBf9rSvnXssuVOHus=; b=P7jap/
        qjeoXQIZyeT9tLHxxbpi0mfMqkEpokHmt9rz2bC5EfcJ4Y05LxwSi6Saczcb/fgZ
        CX2ZQZuE1IvYVrWnKI5r/6D+sF1F0YampoSrzpQTR19b3HPkoxcl0CdXZHie/JpJ
        fl1HsWCtsUyLj9XAkCGy/wkA4DXBgMoayyuJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vzemEc4NJD0yXWkKWvBfy74AXf8ea6PD
        K2FTlE3f8eUpwg1h+JObr5QkkNpXBXCsNcg2ptrTS/sahXGptJqyjFV5fjdqZQG9
        3L2LAq1VNc9DUxDF3yfepheuimR3AGUTXIsAYtdD2Xw9HT55GLR90wLZ1tbr+2om
        jSFi7KrY+LI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F2605113E0D;
        Sat, 17 Nov 2018 02:46:23 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 69F62113E0C;
        Sat, 17 Nov 2018 02:46:23 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Borislav Petkov <bp@alien8.de>
Subject: Re: insteadOf and git-request-pull output
References: <20181115182826.GB25806@pure.paranoia.local>
        <20181116115639.GO890086@genre.crustytoothpaste.net>
Date:   Sat, 17 Nov 2018 16:46:22 +0900
In-Reply-To: <20181116115639.GO890086@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Fri, 16 Nov 2018 11:56:39 +0000")
Message-ID: <xmqq7ehci1td.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E1593E02-EA3C-11E8-AFF4-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> $ git request-pull HEAD^ git://foo.example.com/example | grep example
>>   ssh://bar.example.com/example
>> 
>> I think that if we use the "principle of least surprise," insteadOf
>> rules shouldn't be applied for git-request-pull URLs.
>
> I'd like to point out a different use that may change your view.  I have
> an insteadOf alias, gh:, that points to GitHub.  Performing the rewrite
> is definitely the right thing to do, since other users may not have my
> alias available.
>
> I agree that in your case, a rewrite seems less appropriate, but I think
> we should only skip the rewrite if the value already matches a valid
> URL.

It would be tricky to define what a valid URL is, though.  Do we
need some way to say "this is a private URL that should not be
given preference when composing a request-pull message"?  E.g.

    [url "git://git.dev/"]
            insteadOf = https://git.dev/

    [url "https://github.com/"]
            insteadOf = gh:
	    private

The former does not mark https://git.dev/ a private one, so a
"request-pull https://git.dev/$thing" would show the original
"https://git.dev/$thing" without rewriting.  The latter marks gh: a
private one so "request-pull gh:$thing" would be rewritten before
exposed to the public as "https://github.com/$thing"

Or something like that?

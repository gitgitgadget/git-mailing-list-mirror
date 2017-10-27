Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 842F4202A0
	for <e@80x24.org>; Fri, 27 Oct 2017 02:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751520AbdJ0CBM (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 22:01:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57386 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751263AbdJ0CBM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 22:01:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6FD3CAE98F;
        Thu, 26 Oct 2017 22:01:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NVh1GOob/L+fUxht2UbIbTNN8yc=; b=UVfMbQ
        kus5C+2oY8FwL/N+pug7WHtACIZ6KIxL/Xa6EW/4nvZ5c28UYXhLUv7Y0I96zHR2
        JCpWhYUt1LUfbLjYqCbtELAD6mkxFX5gEaIE04M42/k3Ve9CdTs7pa4EUi+nu20p
        0yi+gGDH8yc1iYakn3v/+Qd7NWq0dgdMdtQrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CbK/vrMRCdw2V4uv7Z4bQNA61c+jqggO
        UC/hP2KXDOdwb1dVANaoc2Wu7t03/xGQG0IXibsHpZblwbYP60OLEZVYJL1K8Gkr
        hDldsPz8JAsrs0opcmjIgMPMdO8Ks6P0+bWEKlPg1l49Hz1GC89imfGWbetx+Hwt
        hFv3il0BaoA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 678F0AE98D;
        Thu, 26 Oct 2017 22:01:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D2DCFAE98C;
        Thu, 26 Oct 2017 22:01:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Isabella Stephens <istephens@atlassian.com>
Cc:     szeder.dev@gmail.com, git@vger.kernel.org, sunshine@sunshineco.com,
        peff@peff.net, bturner@atlassian.com, jacob.keller@gmail.com
Subject: Re: [PATCH v3] blame: prevent error if range ends past end of file
References: <20171026153111.21813-1-szeder.dev@gmail.com>
        <20171027005652.7796-1-istephens@atlassian.com>
        <xmqqzi8dcpx1.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 27 Oct 2017 11:01:09 +0900
In-Reply-To: <xmqqzi8dcpx1.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 27 Oct 2017 10:58:34 +0900")
Message-ID: <xmqqvaj1cpsq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B43EF9FA-BABA-11E7-8BC7-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> For example, with an empty file (i.e. lno == 0), you can ask "git
> blame -L1,-4 ("i.e. "at most four lines, ending at line #1") and the
> code silently accepts the input without noticing that the request is
> an utter nonsense; "file X has only 0 lines" error is given a chance

s/is given/is not given/; obviously.  Sorry for a typo coming from
laggy ssh connection.

> to kick in.
>
> There should be an "is the range sensible?" check after all the
> tweaking to bottom and top are done, I think.
>
>>  		bottom--;
>>  		range_set_append_unsafe(&ranges, bottom, top);
>> diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
>> index 661f9d430..728209fa3 100755
>> --- a/t/t8003-blame-corner-cases.sh
>> +++ b/t/t8003-blame-corner-cases.sh
>> @@ -216,14 +216,13 @@ test_expect_success 'blame -L with invalid start' '
>>  '
>>  
>>  test_expect_success 'blame -L with invalid end' '
>> -	test_must_fail git blame -L1,5 tres 2>errors &&
>> -	test_i18ngrep "has only 2 lines" errors
>> +	git blame -L1,5 tres >out &&
>> +	test_line_count = 2 out
>>  '
>>  
>>  test_expect_success 'blame parses <end> part of -L' '
>>  	git blame -L1,1 tres >out &&
>> -	cat out &&
>> -	test $(wc -l < out) -eq 1
>> +	test_line_count = 1 out
>>  '
>>  
>>  test_expect_success 'indent of line numbers, nine lines' '

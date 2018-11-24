Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FF741F97E
	for <e@80x24.org>; Sat, 24 Nov 2018 07:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbeKXSey (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Nov 2018 13:34:54 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57378 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbeKXSey (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Nov 2018 13:34:54 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ED2F4127EBB;
        Sat, 24 Nov 2018 02:47:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=m4uULZ/1RW8V8sytQ1ZlGJRE5mg=; b=KP90TJ
        ubhapnsS6WRA6UEveZztTIamM5vhFZOqJRgduewTHeFrNhnbEfM/M4sruW8DcuRS
        7rUx9Fh+8pZqRZvfXBRYwWTI7JtPOQQTK58pIt5//0cImj0IHtbVvdEyG7y5piWH
        rys+H0nxJWr/FvBfGzftTbrNU4UpLxhbsjN4c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aID5kY30dus2y6h5cNtmor3xZASKybnQ
        tCVKjBzXpiTv5V/jkFEEjdnbQNfSpmAPToALQGX6ndSrn2TZ6XwniBKYPfJ/jB3E
        SlsRuP1MGHb+TFJiz2hqKWQ8U/GK8maFIs5ZsxZVDimPYxXlZj1IULKQIDZxkVSc
        c1m+tpOzk50=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E6494127EBA;
        Sat, 24 Nov 2018 02:47:20 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5E43E127EB8;
        Sat, 24 Nov 2018 02:47:20 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Max Kirillov <max@max630.net>
Cc:     Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org,
        peff@peff.net
Subject: Re: [PATCH] t5562: do not reuse output files
References: <20181124070428.18571-1-max@max630.net>
        <xmqqbm6f2ajn.fsf@gitster-ct.c.googlers.com>
Date:   Sat, 24 Nov 2018 16:47:19 +0900
In-Reply-To: <xmqqbm6f2ajn.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Sat, 24 Nov 2018 16:34:52 +0900")
Message-ID: <xmqq7eh23ojc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2C2FF5B2-EFBD-11E8-A4ED-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Max Kirillov <max@max630.net> writes:
>
>> diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
>> index 90d890d02f..bb53f82c0c 100755
>> --- a/t/t5562-http-backend-content-length.sh
>> +++ b/t/t5562-http-backend-content-length.sh
>> @@ -25,6 +25,8 @@ test_http_env() {
>>  	handler_type="$1"
>>  	request_body="$2"
>>  	shift
>> +	(rm -f act.out || true) &&
>> +	(rm -f act.err || true) &&
>
> Why "||true"?  If the named file doesn't exist, "rm -f" would
> succeed, and if it does exist but somehow we fail to remove, then
> these added lines are not preveting the next part from reusing,
> i.e. they are not doing what they are supposed to be doing,...

Another thing.  The analysis in your log message talks about a stray
process holding open filehandles to these files.  An attempt to remove
them in such a stat would fail on some systems, so "||true" would not
help, would it?  It just hides the failure to remove, and when ||true
is useful in hiding th failure _is_ when such a stray process is still
there, waiting to corrupt the output of the next request and breaking
the test, no?

I do agree that forcing the parent to wait, like you described in
the comment, would be far more preferrable, but until that happens,
a better workaround might be to write into unique output filenames
(act1.out, act2.out, etc.); that way, you do not have to worry about
the output file for the next request getting clobbered by a stale
process handling the previous request.  But at the same time,
wouldn't this suggest that the test or the previous request may see
an incomplete output, as the analysed problem is that such a process
is writing to the output file very late, while we are preparing to
test the enxt request, which meas we have already checked the output
file for the previous request, right?  So even without ||true, I am
not sure how true a "solution" this change is to the issue.


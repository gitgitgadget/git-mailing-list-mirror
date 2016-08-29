Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D4211FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 17:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755086AbcH2Rq4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 13:46:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64440 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751271AbcH2Rqz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 13:46:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B61DE3842D;
        Mon, 29 Aug 2016 13:46:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3fcmUp/vc94LePfbhTdhOlO/Ras=; b=KLfGq2
        BNj0KX+dtuqXowkmUxzbNirJFWV4iMIb7/jaMOm5xL8z3CwqqSmCtsmHcYGNPGkW
        TeEB/5smMdrr2Vwa1/SiZ46QFR3c5Ycy2IJbnsGEgj12yeISUSJndF+g+G4c3c3j
        cw3VlYjTfernX1XjMRXc9cgLGpvBglNdNA2YI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Zuo5J50l7jHhmda+rLIkMtwI48sw37Dh
        LGzWoZ9HAw/QgihWLkR+cVXsjO1FQwYbOPs2QTF5RVNeOrdfc6GosNbdxLkzcZDX
        tz2I0E2L78op23BtdhnSMDZcJxknqt2AwKA9+vx/9H7xHD9cBSXzPV3i+6OdjsB/
        04i0jEUQH3k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AECAE3842C;
        Mon, 29 Aug 2016 13:46:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3A44C3842B;
        Mon, 29 Aug 2016 13:46:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     larsxschneider@gmail.com
Cc:     git@vger.kernel.org, peff@peff.net, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com
Subject: Re: [PATCH v6 10/13] convert: generate large test files only once
References: <20160825110752.31581-1-larsxschneider@gmail.com>
        <20160825110752.31581-11-larsxschneider@gmail.com>
Date:   Mon, 29 Aug 2016 10:46:51 -0700
In-Reply-To: <20160825110752.31581-11-larsxschneider@gmail.com>
        (larsxschneider@gmail.com's message of "Thu, 25 Aug 2016 13:07:49
        +0200")
Message-ID: <xmqq7fazcvsk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9239569A-6E10-11E6-BE92-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

larsxschneider@gmail.com writes:

> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
> index 7b45136..34c8eb9 100755
> --- a/t/t0021-conversion.sh
> +++ b/t/t0021-conversion.sh
> @@ -4,6 +4,15 @@ test_description='blob conversion via gitattributes'
>  
>  . ./test-lib.sh
>  
> +if test_have_prereq EXPENSIVE
> +then
> +	T0021_LARGE_FILE_SIZE=2048
> +	T0021_LARGISH_FILE_SIZE=100
> +else
> +	T0021_LARGE_FILE_SIZE=30
> +	T0021_LARGISH_FILE_SIZE=2
> +fi

Minor: do we need T0021_ prefix?  What are you trying to avoid
collisions with?

> +	git checkout -- test test.t test.i &&
> +
> +	mkdir generated-test-data &&
> +	for i in $(test_seq 1 $T0021_LARGE_FILE_SIZE)
> +	do
> +		RANDOM_STRING="$(test-genrandom end $i | tr -dc "A-Za-z0-9" )"
> +		ROT_RANDOM_STRING="$(echo $RANDOM_STRING | ./rot13.sh )"

In earlier iteration of loop with lower $i, what guarantees that
some bytes survive "tr -dc"?

> +		# Generate 1MB of empty data and 100 bytes of random characters

100 bytes?  It seems to me that you are giving 1MB and then $i-byte
or less (which sometimes can be zero) of random string.

> +		# printf "$(test-genrandom start $i)"
> +		printf "%1048576d" 1 >>generated-test-data/large.file &&
> +		printf "$RANDOM_STRING" >>generated-test-data/large.file &&
> +		printf "%1048576d" 1 >>generated-test-data/large.file.rot13 &&
> +		printf "$ROT_RANDOM_STRING" >>generated-test-data/large.file.rot13 &&
> +
> +		if test $i = $T0021_LARGISH_FILE_SIZE
> +		then
> +			cat generated-test-data/large.file >generated-test-data/largish.file &&
> +			cat generated-test-data/large.file.rot13 >generated-test-data/largish.file.rot13
> +		fi
> +	done

This "now we are done with the loop, so copy them to the second
pair" needs to be in the loop?  Shouldn't it come after 'done'?

I do not quite get the point of this complexity.  You are using
exactly the same seed "end" every time, so in the first round you
have 1M of SP, letter '1', letter 'S' (from the genrandom), then
in the second round you have 1M of SP, letter '1', letter 'S' and
letter 'p' (the last two from the genrandom), and go on.  Is it
significant for the purpose of your test that the cruft inserted
between the repetition of 1M of SP gets longer by one byte but they
all share the same prefix (e.g. "1S", "1Sp", "1SpZ", "1SpZT",
... are what you insert between a large run of spaces)?

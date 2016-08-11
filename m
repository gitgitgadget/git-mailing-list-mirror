Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E32020193
	for <e@80x24.org>; Thu, 11 Aug 2016 20:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184AbcHKUzL (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 16:55:11 -0400
Received: from siwi.pair.com ([209.68.5.199]:16392 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752040AbcHKUzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 16:55:09 -0400
Received: from [10.160.15.137] (unknown [167.220.148.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id 6743F845F5;
	Thu, 11 Aug 2016 16:55:08 -0400 (EDT)
Subject: Re: [PATCH v6 9/9] status: unit tests for --porcelain=v2
To:	Junio C Hamano <gitster@pobox.com>
References: <1470926762-25394-1-git-send-email-git@jeffhostetler.com>
 <1470926762-25394-10-git-send-email-git@jeffhostetler.com>
 <xmqqtwer17b6.fsf@gitster.mtv.corp.google.com>
Cc:	git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
From:	Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <57ACE550.9040501@jeffhostetler.com>
Date:	Thu, 11 Aug 2016 16:51:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqtwer17b6.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On 08/11/2016 02:36 PM, Junio C Hamano wrote:
> Jeff Hostetler <git@jeffhostetler.com> writes:
>
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>> +. ./test-lib.sh
>> +
>> +OID_EMPTY=e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
>
> It seems that test-lib.sh these days has EMPTY_BLOB defined for your
> use.  You can remove this and replace its use (just two lines) with
> $EMPTY_BLOB down in the "add -N" test.

That's a recent addition to test-lib.sh. I'll rebase my series
onto a more recent master to get that.


>> +test_expect_success setup '
>> +	test_tick &&
>> +	git config --local core.autocrlf false &&
>
> I'd suggest removing "--local".
>
> Existing use of "git config" in the test suite, unless their use is
> about testing "git config" itself to validate the operation of the
> --local/--global/--system options, do not seem to explicitly say
> "--local", which is the default anyway.

ok. just being cautious, but if that's the convention, that's fine.


>> +test_expect_success 'after first commit, make dirt, confirm unstaged changes' '
>
> Did you mean s/dirt/dirty/?  "make and confirm unstaged changes"
> would be sufficient.  Because "confirming" is implicit (as these
> are all tests), "after the first commit, modify working tree files"
> might even be better, perhaps?
>
>> +	echo x >>file_x &&
>> +	OID_X1=$(git hash-object -t blob -- file_x) &&
>> +	rm file_z &&
>> +	H0=$(git rev-parse HEAD) &&
>> + ...

got it.


>> +test_expect_success 'after first commit, stage dirt, confirm staged changes' '
>
> What you "git add" is meant to be good changes, so they are no
> longer dirt ;-)  More importantly, because I never heard of "dirt"
> used in Git context, it is unclear if it is an untracked file, a
> modification that is not meant to be committed immediately, or what.
>
> "after the first commit, fully add changes to the index"?

reworded and simplified.


>> +	git add file_x &&
>> +	git rm file_z &&
>> +	H0=$(git rev-parse HEAD) &&
>> +
>> +	cat >expect <<-EOF &&
>> +	# branch.oid $H0
>> +	# branch.head master
>> +	1 M. N... 100644 100644 100644 $OID_X $OID_X1 file_x
>> +	1 D. N... 100644 000000 000000 $OID_Z $_z40 file_z
>> +	? actual
>> +	? expect
>> +	EOF
>
>> +test_expect_success 'after first commit, also stage rename, confirm 2 path line format' '
>> +	git mv file_y renamed_y &&
>> +	H0=$(git rev-parse HEAD) &&
>> +
>> +	q_to_tab >expect <<-EOF &&
>> +	# branch.oid $H0
>> +	# branch.head master
>> +	1 M. N... 100644 100644 100644 $OID_X $OID_X1 file_x
>> +	1 D. N... 100644 000000 000000 $OID_Z $_z40 file_z
>> +	2 R. N... 100644 100644 100644 $OID_Y $OID_Y R100 renamed_yQfile_y
>> +	? actual
>> +	? expect
>> +	EOF
>> +
>> +	git status --porcelain=v2 --branch --untracked-files=all >actual &&
>> +	test_cmp expect actual
>> +'
>
> Do we want to test -z format on this, too?

Sure.


I'll send these up in a v7 series in a few minutes.

Thanks
Jeff


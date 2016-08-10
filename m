Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 797E01FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 21:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbcHJVaH (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 17:30:07 -0400
Received: from siwi.pair.com ([209.68.5.199]:59021 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752395AbcHJVaG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 17:30:06 -0400
Received: from [10.160.15.137] (unknown [167.220.148.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id DE42E845E4;
	Wed, 10 Aug 2016 17:30:03 -0400 (EDT)
Subject: Re: [PATCH v5 9/9] status: unit tests for --porcelain=v2
To:	Junio C Hamano <gitster@pobox.com>
References: <1470434434-64283-1-git-send-email-git@jeffhostetler.com>
 <1470434434-64283-10-git-send-email-git@jeffhostetler.com>
 <xmqq4m6vgpf9.fsf@gitster.mtv.corp.google.com>
Cc:	git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
From:	Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <57AB9C61.5060409@jeffhostetler.com>
Date:	Wed, 10 Aug 2016 17:28:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <xmqq4m6vgpf9.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On 08/08/2016 01:07 PM, Junio C Hamano wrote:
> Jeff Hostetler <git@jeffhostetler.com> writes:
>
>> +test_expect_success pre_initial_commit_0 '
>> +	...
>> +	git status --porcelain=v2 --branch --untracked-files=normal >actual &&
>> +	test_cmp expect actual
>> +'
>> +
>> +
>> +test_expect_success pre_initial_commit_1 '
>> +	git add file_x file_y file_z dir1 &&
>> +	...
>> +	cat >expect <<-EOF &&
>> +	# branch.oid (initial)
>> +	# branch.head master
>> +	1 A. N... 000000 100644 100644 $_z40 $OID_A dir1/file_a
>> +	...
>
> This makes one wonder what would/should be shown on the "A." column
> if one of these files are added with "-N" (intent-to-add).  I do not
> see any test for such entries in this patch, but I think it should.

I must admit that I don't use -N, so I'm open to recommendations here.
In my brief testing, the existing porcelain status reports it as "AM"
(for both a file with content and an empty file).

The V2 code outputs the following:
1 AM N... 000000 100644 100644 0000000000000000000000000000000000000000 
e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 intent.add

Which I think makes sense.  I'll add a test to exercise that.


> "Try -z on the above" can and should be in the test title to help
> ...
> Having said all that, it is OK to fix their titles after the current
> 9-patch series lands on 'next'; incremental refinements are easier
> on reviewers than having to review too many rerolls.

I'll change the test titles to have all that info.


> This is probably a good place to see what happens to these untracked
> files and branch info if we do not ask the command to show them.

I'll add some cases to cycle thru the options and confirm
there's no output when not requested.


>> +##################################################################
>> +## Ignore a file
>> +##################################################################
>> +
>> +test_expect_success ignore_file_0 '
>> +	echo x.ign >.gitignore &&
>> +	echo "ignore me" >x.ign &&
>> +	H1=$(git rev-parse HEAD) &&
>> +
>> +	## ignored file SHOULD NOT appear in output when --ignored is not used.
>> + ...
>> +	git status --porcelain=v2 --branch --untracked-files=all >actual &&
>> +	test_cmp expect actual &&
>> + ...
>> +	git status --porcelain=v2 --branch --ignored --untracked-files=all >actual &&
>> +	rm x.ign &&
>> +	rm .gitignore &&
>
> Arrange these files to be cleaned before you create them by having
>
> 	test_when_finished "rm -f x.ign .gitignore" &&
>
> at the very beginning of this test before they are created.
> Otherwise, if any step before these removal fail, later test that
> assume they are gone will be affected.  You already do so correctly
> in the upstream_fields_0 test below.

Missed a few.  Got it.  Thanks!


>> +
>> +	cat >expect <<-EOF &&
>> +	# branch.oid $HM
>> +	# branch.head AA_M
>> +	u AA N... 000000 100644 100644 100644 $_z40 $OID_AA_B $OID_AA_A conflict.txt
>> +	EOF
>
> This is a small point, but doesn't the lowercase 'u' somehow look
> ugly, especially because the status letters that immediately follow
> it are all uppercase?
>

Since we are inventing a new format and my column 1 is completely new
I didn't think it mattered.  And I used a lowercase 'u' to distinguish 
it from the "U" in the X and Y columns since they mean different things.

But we can change it if you'd prefer.


>> +	git status --porcelain=v2 --branch --untracked-files=all >actual &&
>> +	git reset --hard &&
>
> This "reset" also may be a candidate for test_when_finished clean-up
> (I won't repeat the comment but there probably are many others).

Got it. And I hopefully caught the rest.


>> +test_expect_success 'upstream_fields_0' '
>> +	git checkout master &&
>> +	test_when_finished rm -rf sub_repo &&
>
> The "when-finished" argument are usually quoted like this, I think:
>
> 	test_when_finished "rm -rf sub_repo" &&

Got it. Thanks.


I have the test changes ready.  As suggested, I'll send a single commit
patch after my 9-patch series lands on 'next'.

Thanks,
Jeff





Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 637DF2018E
	for <e@80x24.org>; Fri,  5 Aug 2016 18:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbcHESds (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 14:33:48 -0400
Received: from siwi.pair.com ([209.68.5.199]:35936 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946591AbcHESdp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 14:33:45 -0400
Received: from [10.160.15.137] (unknown [167.220.148.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id 0AE69845F7;
	Fri,  5 Aug 2016 14:33:43 -0400 (EDT)
Subject: Re: [PATCH v4 8/8] status: tests for --porcelain=v2
To:	Junio C Hamano <gitster@pobox.com>
References: <1470147137-17498-1-git-send-email-git@jeffhostetler.com>
 <1470147137-17498-9-git-send-email-git@jeffhostetler.com>
 <xmqq1t23xeyb.fsf@gitster.mtv.corp.google.com>
Cc:	git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	Jeff Hostetler <jeffhost@microsoft.com>
From:	Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <57A4DB8A.6020407@jeffhostetler.com>
Date:	Fri, 5 Aug 2016 14:31:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <xmqq1t23xeyb.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On 08/05/2016 02:12 PM, Junio C Hamano wrote:
> Jeff Hostetler <git@jeffhostetler.com> writes:
>
>> +##################################################################
>> +## Confirm output prior to initial commit.
>> +##################################################################
>> +
>> +test_expect_success pre_initial_commit_0 '
>
> Bikeshedding, but our codebase seems to prefer "expect" vs "actual".
>
>      $ git grep -e 'test_cmp expect ' t/ | wc -l
>      1882
>      $ git grep -e 'test_cmp expected ' t/ | wc -l
>      888
>
>> +	cat >expected <<-EOF &&
>> +	# branch.oid (initial)
>> +	# branch.head master
>> +	? actual
>> +	? dir1/
>> +	? expected
>> +	? file_x
>> +	? file_y
>> +	? file_z
>> +	EOF
>
> Perhaps throw these two entries to .gitignore to allow new tests in
> the future could also use expect.1 vs actual.1 and somesuch?
>
> 	cat >.gitignore <<-\EOF &&
> 	expect*
>          actual*
>          EOF
>
>> +test_expect_success pre_initial_commit_1 '
>> +	git add file_x file_y file_z dir1 &&
>> +	SHA_A=`git hash-object -t blob -- dir1/file_a` &&
>> +	SHA_B=`git hash-object -t blob -- dir1/file_b` &&
>> +	SHA_X=`git hash-object -t blob -- file_x` &&
>> +	SHA_Y=`git hash-object -t blob -- file_y` &&
>> +	SHA_Z=`git hash-object -t blob -- file_z` &&
>
> Please use $(commannd) instead of `command`.  Also "SHA" is probably
> a bad prefix; either use "SHA_1" to be technically correct, or
> better yet use "OID", as we are moving towards abstracting the exact
> hash function name away.
>
>> +	SHA_ZERO=0000000000000000000000000000000000000000 &&
>
> I think we made $_z40 available to you from t/test-lib.sh.
>
>> +## Try -z on the above
>> +test_expect_success pre_initial_commit_2 '
>> +	cat >expected.lf <<-EOF &&
>> +	# branch.oid (initial)
>> +	# branch.head master
>> +	1 A. N... 000000 100644 100644 $SHA_ZERO $SHA_A dir1/file_a
>> +	1 A. N... 000000 100644 100644 $SHA_ZERO $SHA_B dir1/file_b
>> +	1 A. N... 000000 100644 100644 $SHA_ZERO $SHA_X file_x
>> +	1 A. N... 000000 100644 100644 $SHA_ZERO $SHA_Y file_y
>> +	1 A. N... 000000 100644 100644 $SHA_ZERO $SHA_Z file_z
>> +	? actual
>> +	? expected
>> +	EOF
>> +	perl -pe y/\\012/\\000/ <expected.lf >expected &&
>> +	rm expected.lf &&
>
> As you immediately remove expected.lf, the first "cat" process is
> rather pointless.  You can redirect here text <<-EOF directly into
> perl instead.  Also it would probably help to add a new helper
> "lf_to_nul" in t/test-lib-functions.sh around the place where
> nul_to_q, ..., tz_to_tab_space helpers are defined, which would
> allow us to say
>
> 	lf_to_nul >expect <<-EOF &&
> 	...
>          EOF
>
>> +test_expect_success initial_commit_3 '
>> +	git mv file_y renamed_y &&
>> +	H0=`git rev-parse HEAD` &&
>> +
>> +	cat >expected.q <<-EOF &&
>> +	# branch.oid $H0
>> +	# branch.head master
>> +	1 M. N... 100644 100644 100644 $SHA_X $SHA_X1 file_x
>> +	1 D. N... 100644 000000 000000 $SHA_Z $SHA_ZERO file_z
>> +	2 R. N... 100644 100644 100644 $SHA_Y $SHA_Y R100 renamed_yQfile_y
>> +	? actual
>> +	? expected
>> +	EOF
>> +	q_to_tab <expected.q >expected &&
>> +	rm expected.q &&
>
> The same comment applies (redirect directly into q_to_tab).
>
>> +##################################################################
>> +## Ignore a file
>> +##################################################################
>> +
>> +test_expect_success ignore_file_0 '
>> +	echo x.ign >.gitignore &&
>> +	echo "ignore me" >x.ign &&
>> +	H1=`git rev-parse HEAD` &&
>> +
>> +	cat >expected <<-EOF &&
>> +	# branch.oid $H1
>> +	# branch.head master
>> +	? .gitignore
>> +	? actual
>> +	? expected
>> +	! x.ign
>> +	EOF
>> +
>> +	git status --porcelain=v2 --branch --ignored --untracked-files=all >actual &&
>> +	rm x.ign &&
>> +	rm .gitignore &&
>> +	test_cmp expected actual
>> +'
>
> You do not seem to be checking a feature is not triggered when not
> asked throughout this test, e.g. making sure the output does not
> have the "# branch.*" lines when --branch is not given, "! x.ign"
> is not shown when --ignored is not given, etc.
>
>> +##################################################################
>> +## Test upstream fields in branch header
>> +##################################################################
>> +
>> +test_expect_success 'upstream_fields_0' '
>> +	git checkout master &&
>> +	git clone . sub_repo &&
>> +	(
>> +		## Confirm local master tracks remote master.
>> +		cd sub_repo &&
>> +		HUF=`git rev-parse HEAD` &&
>> + ...
>> +		git status --porcelain=v2 --branch --ignored --untracked-files=all >actual &&
>> +		test_cmp expected actual
>> +	) &&
>> +	rm -rf sub_repo
>
> It probably is a good idea to use test_when_finished immediately
> before "git clone . sub_repo" to arrange this to happen even when
> any test in the subshell fails.
>


Lots of good points here (and on the earlier commits in this
series).  I'll address and send up a new version shortly.

Thanks!
Jeff

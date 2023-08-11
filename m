Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC30CC001DE
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 16:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbjHKQ7i (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 12:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHKQ7h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 12:59:37 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8EB1FE3
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 09:59:36 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BEBFF18D0E1;
        Fri, 11 Aug 2023 12:59:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VCMwYm/sT/PqyXyoraY59eymydteiSxCeY/qJf
        BKEkM=; b=KyCBcCv+TZfDXD1ZT6bTIoeNT+HVpHF6qlMg1Pmvg2h4tXExxwCH9W
        Q3ukiZs3SO8tceeBw2QsEWkbAWbt5oBdE8KfO/li5bCDR+mC1ITu270DO9nzyTh0
        6tr7vp3xHdN7fQgI4HOlDpO4KKJXMLFMZ3IjCzK9eVM7zi/TBkBuk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B665518D0E0;
        Fri, 11 Aug 2023 12:59:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2260F18D0DF;
        Fri, 11 Aug 2023 12:59:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH v3 1/2] sequencer: beautify subject of reverts of reverts
References: <20230428083528.1699221-1-oswald.buddenhagen@gmx.de>
        <20230809171531.2564807-1-oswald.buddenhagen@gmx.de>
        <dba3f15a-3575-e4f9-2291-c5a342cfed43@gmail.com>
Date:   Fri, 11 Aug 2023 09:59:34 -0700
In-Reply-To: <dba3f15a-3575-e4f9-2291-c5a342cfed43@gmail.com> (Phillip Wood's
        message of "Fri, 11 Aug 2023 16:05:03 +0100")
Message-ID: <xmqq1qg9v7k9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 72F652FE-3868-11EE-B4B8-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Oswald
>
> On 09/08/2023 18:15, Oswald Buddenhagen wrote:
>> Instead of generating a silly-looking `Revert "Revert "foo""`, make it
>> a more humane `Reapply "foo"`.
>> This is done for two reasons:
>> - To cover the actually common case of just a double revert.
>> - To encourage people to rewrite summaries of recursive reverts by
>>    setting an example (a subsequent commit will also do this explicitly
>>    in the documentation).
>> To achieve these goals, the mechanism does not need to be
>> particularly
>> sophisticated. Therefore, more complicated alternatives which would
>> "compress more efficiently" have not been implemented.
>
> This all looks good to me, it seems quite sensible just to bail out if
> we see an existing recursive reversion.

Yes, explicitly refraining from becoming overly cute is a good
design decision.

>> diff --git a/sequencer.c b/sequencer.c
>> index cc9821ece2..12ec158922 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -2249,13 +2249,24 @@ static int do_pick_commit(struct repository *r,
>>   	 */
>>     	if (command == TODO_REVERT) {
>> +		const char *orig_subject;
>> +
>>   		base = commit;
>>   		base_label = msg.label;
>>   		next = parent;
>>   		next_label = msg.parent_label;
>>   		if (opts->commit_use_reference) {
>>   			strbuf_addstr(&msgbuf,
>>   				"# *** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
>> +		} else if (skip_prefix(msg.subject, "Revert \"", &orig_subject) &&
>> +			   /*
>> +			    * We don't touch pre-existing repeated reverts, because
>> +			    * theoretically these can be nested arbitrarily deeply,
>> +			    * thus requiring excessive complexity to deal with.
>> +			    */
>> +			   !starts_with(orig_subject, "Revert \"")) {
>> +			strbuf_addstr(&msgbuf, "Reapply \"");
>> +			strbuf_addstr(&msgbuf, orig_subject);

Being simple-and-stupid to deal only with the most common case, and
documenting that it is deliberate that we do not deal with more
complex cases in the in-code comment and in the log message, are
very good in this case.

>> diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
>> index e2ef619323..7011e3a421 100755
>> --- a/t/t3501-revert-cherry-pick.sh
>> +++ b/t/t3501-revert-cherry-pick.sh
>> @@ -176,6 +176,31 @@ test_expect_success 'advice from failed revert' '
>>   	test_cmp expected actual
>>   '
>>   +test_expect_success 'title of fresh reverts' '
>> +	test_commit --no-tag A file1 &&
>> +	test_commit --no-tag B file1 &&
>> +	git revert --no-edit HEAD &&
>> +	echo "Revert \"B\"" >expect &&
>> +	git log -1 --pretty=%s >actual &&
>> +	test_cmp expect actual &&
>> +	git revert --no-edit HEAD &&
>> +	echo "Reapply \"B\"" >expect &&
>> +	git log -1 --pretty=%s >actual &&
>> +	test_cmp expect actual &&
>> +	git revert --no-edit HEAD &&
>> +	echo "Revert \"Reapply \"B\"\"" >expect &&
>> +	git log -1 --pretty=%s >actual &&
>> +	test_cmp expect actual
>> +'

Presumably the next time this gets reverted we will see a doubled
reapply?  Isn't that something we care about documenting as a part
of this test?  i.e. another four-line block after the above?

	git revert --no-edit HEAD &&
	echo "Reapply \"Reapply \"B\"\"" >expect &&
	git log -1 --pretty=%s >actual &&
	test_cmp expect actual

>> +test_expect_success 'title of legacy double revert' '
>> +	test_commit --no-tag "Revert \"Revert \"B\"\"" file1 &&
>> +	git revert --no-edit HEAD &&
>> +	echo "Revert \"Revert \"Revert \"B\"\"\"" >expect &&
>> +	git log -1 --pretty=%s >actual &&
>> +	test_cmp expect actual
>> +'

Good.

>>   test_expect_success 'identification of reverted commit (default)' '
>>   	test_commit to-ident &&
>>   	test_when_finished "git reset --hard to-ident" &&

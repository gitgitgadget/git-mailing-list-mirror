Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF5C61F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 04:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbfJKE1Q (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 00:27:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52645 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfJKE1P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 00:27:15 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ACAA3253BA;
        Fri, 11 Oct 2019 00:27:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wjPu1RqJWyBKYZnRsiPL+CaPJxk=; b=OO2ju6
        L0kfrR4mlvIzxC7Jd3sroJGaJtgM48s+2u+U5F4NbVZXyo1kzJx3OW8ZYsIBdmAQ
        q9Duk3J/SUfTlMtBTC1GVxVfuGK6D3Exlyk+/KZ98rVYJOOfSWVJxKvd05Ca99eo
        uMrYqK+teyJJmMAlXHYjGBENj+xbHcsDrQyPw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kQgWD5NI9u1wfRueR2fVUhv3BMzZyN0/
        Cxo5/R/4MIzve0iWM+jy4YwVheriivgFDaYCED5qdWFsVXci77uMZhSK4zeEmd/7
        PhQT5xc7QVWhpiaYYhY6YYKkXQJ6YpzymjxhaZvD2LMyFweZvYYjxCGnHS0wuf9z
        4DqqyTkyEIw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A3AA3253B9;
        Fri, 11 Oct 2019 00:27:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 150F1253B8;
        Fri, 11 Oct 2019 00:27:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 3/3] sequencer: run post-commit hook
References: <pull.388.git.gitgitgadget@gmail.com>
        <acaa086a4860b6853bc0f35dae7fcf07d3aa59e7.1570732608.git.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.1910102324140.46@tvgsbejvaqbjf.bet>
Date:   Fri, 11 Oct 2019 13:27:09 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1910102324140.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 10 Oct 2019 23:31:38 +0200 (CEST)")
Message-ID: <xmqqftjzj49u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 641785CA-EBDF-11E9-995E-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> diff --git a/builtin/commit.c b/builtin/commit.c
>> index d898a57f5d..adb8c89c60 100644
>> --- a/builtin/commit.c
>> +++ b/builtin/commit.c
>> @@ -1653,7 +1653,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>>
>>  	repo_rerere(the_repository, 0);
>>  	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
>> -	run_commit_hook(use_editor, get_index_file(), "post-commit", NULL);
>> +	run_post_commit_hook(use_editor, get_index_file());
>
> Does it really make sense to abstract the hook name away? It adds a lot
> of churn for just two callers...

After looking at the three patches, I do not think so.

>> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
>> index d2f1d5bd23..d9217235b6 100755
>> --- a/t/t3404-rebase-interactive.sh
>> +++ b/t/t3404-rebase-interactive.sh
>> @@ -1467,4 +1467,21 @@ test_expect_success 'valid author header when author contains single quote' '
>>  	test_cmp expected actual
>>  '
>>
>> +test_expect_success 'post-commit hook is called' '
>> +	test_when_finished "rm -f .git/hooks/post-commit commits" &&
>> +	mkdir -p .git/hooks &&
>> +	write_script .git/hooks/post-commit <<-\EOS &&
>> +	git rev-parse HEAD >>commits
>
> Should `commits` be initialized before this script is written, e.g.
> using
>
> 	>commits &&

Yes.

>> +	git rev-list --no-walk=unsorted HEAD@{5} HEAD@{4} HEAD@{3} HEAD@{2} \
>> +		HEAD@{1} HEAD >expected &&
>
> Wouldn't this be better as:
>
> 	git rev-parse HEAD@{5} HEAD@{4} HEAD@{3} HEAD@{2} HEAD@{1} HEAD \
> 		>expect &&
>

Yes.

>> +	test_cmp expected commits
>
> We usually use the name `expect` instead of `expected` in the test
> suite.

And the actual output file is called 'actual'.

Thanks.

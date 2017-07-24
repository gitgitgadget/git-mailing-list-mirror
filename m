Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F699203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 21:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755920AbdGXVeF (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 17:34:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61571 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751969AbdGXVeD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 17:34:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6695893C7D;
        Mon, 24 Jul 2017 17:33:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qO0v3vM+C/OzXP4FbGyhwztiOCM=; b=mPUsGQ
        +KcS1NRzgyTX3pEC0QmvkQv9YALyYxEI4kj56wvFl5FIlSp4aiBh1bcsMMePbKYf
        1UrDxr5GNo6jBAneBeanomJPIYBN1cyY1nLi6BB9bcqREZGv0r/XIUG4neJMFfec
        bECGA/q1KNLcY9t80/ZKuYk9N4hKfmr0/4scE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yknYaLM7Z7Xae+hoPb8kP2hlPf4ocXwU
        XVMCq6QuVTLybvqFeky5wZccfCSrCxBNHCjd2Fjmec7Cfy6m64atinQn4tzmYsCR
        bTe1WDr7rirxQK1LUCGMbcLKu7ORQJOyAKzZN5WX+BKR1PDKe0wfLAhkO/8R0aWQ
        oNq2CDleLDk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5FC7093C7C;
        Mon, 24 Jul 2017 17:33:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C78ED93C7B;
        Mon, 24 Jul 2017 17:33:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] recursive submodules: detach HEAD from new state
References: <20170724173601.19921-1-sbeller@google.com>
        <20170724180312.GE13924@aiede.mtv.corp.google.com>
Date:   Mon, 24 Jul 2017 14:33:54 -0700
In-Reply-To: <20170724180312.GE13924@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Mon, 24 Jul 2017 11:03:12 -0700")
Message-ID: <xmqq8tjdcyf1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CBC7CDC4-70B7-11E7-B91C-61520C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Yikes.  Yes, this bug looks problematic.  Thanks for working on it.
>
>> I improved the commit message laying out the current state of affairs,
>> arguing that any future plan should not weigh in as much as the current
>> possible data loss.
>
> Can you elaborate on what you mean about data loss?  At first glance
> it would seem to me that detaching HEAD could lead to data loss since
> there isn't a branch to keep track of the user's work.  Are you saying
> the current behavior of updating whatever branch HEAD is on (which,
> don't get me wrong, is a wrong behavior that needs fixing) bypassed
> the reflog?

Also, while I do agree with you that the problem exists, it is
unclear why this patch is a solution and not a hack that sweeps a
problem under the rug.  

It is unclear why this "silently detach HEAD without telling the
user" is a better solution than erroring out, for example [*1*].


[Footnote]

*1* For example, I would imagine that the problem can also be
    "fixed" by detecting that the HEAD is on a branch, and noticing
    that it will force rewinding of that branch if we did update-ref
    in this codepath, and signal the failure to the caller of
    submodule_move_head() without making the damage larger.  And
    tell the user what is going on, and perhaps suggest to detach
    HEAD to avoid clobbering their branch.

>
> Thanks, Jonathan
>
>> [1] https://public-inbox.org/git/20170630003851.17288-1-sbeller@google.com/
> [...]
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -1653,7 +1653,8 @@ int submodule_move_head(const char *path,
>>  			cp.dir = path;
>>  
>>  			prepare_submodule_repo_env(&cp.env_array);
>> -			argv_array_pushl(&cp.args, "update-ref", "HEAD", new, NULL);
>> +			argv_array_pushl(&cp.args, "update-ref", "HEAD",
>> +					 "--no-deref", new, NULL);
>>  
>>  			if (run_command(&cp)) {
>>  				ret = -1;

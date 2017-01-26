Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAEFA1F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 14:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752419AbdAZOGs convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 26 Jan 2017 09:06:48 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:59977 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752322AbdAZOGq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 09:06:46 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 053391E2FA7;
        Thu, 26 Jan 2017 15:06:42 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id i9hW6KtBZNRm; Thu, 26 Jan 2017 15:06:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 873EF1E2FAF;
        Thu, 26 Jan 2017 15:06:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lbMAf5gQVjor; Thu, 26 Jan 2017 15:06:41 +0100 (CET)
Received: from [192.168.178.64] (46.128.140.114.dynamic.cablesurf.de [46.128.140.114])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id 2466F1E2FA7;
        Thu, 26 Jan 2017 15:06:41 +0100 (CET)
Subject: Re: [PATCH] refs: add option core.logAllRefUpdates = always
To:     Jeff King <peff@peff.net>
References: <20170125213328.meehgxvzuajjgvag@sigill.intra.peff.net>
 <20170126011654.21729-1-cornelius.weig@tngtech.com>
 <20170126011654.21729-2-cornelius.weig@tngtech.com>
 <20170126033547.7bszipvkpi2jb4ad@sigill.intra.peff.net>
Cc:     gitster@pobox.com, git@vger.kernel.org, novalis@novalis.org,
        pclouds@gmail.com
From:   Cornelius Weig <cornelius.weig@tngtech.com>
Message-ID: <4faf836a-40b6-da9a-877a-3b2ce7c863df@tngtech.com>
Date:   Thu, 26 Jan 2017 15:06:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170126033547.7bszipvkpi2jb4ad@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

 thanks for your thoughts.

> I tried to read this patch with fresh eyes. But given the history, you
> may take my review with a grain of salt. :)

Does it mean another reviewer is needed?

> I don't think my original had tests for this, but it might be worth
> adding a test for this last bit (i.e., that an update of ORIG_HEAD does
> not write a reflog when logallrefupdates is set to "always").

Good point. I blindly copied your commit message without thinking too
much about it.

> I guess the backtick fixups came from my original. It might be easier to
> see the change if they were pulled into their own patch, but it's
> probably not that big a deal.

If it's best practice to break out such changes, I'll revise it.

>> @@ -2835,8 +2835,8 @@ static int log_ref_write_1(const char *refname, const unsigned char *old_sha1,
>>  {
>>  	int logfd, result, oflags = O_APPEND | O_WRONLY;
>>  
>> -	if (log_all_ref_updates < 0)
>> -		log_all_ref_updates = !is_bare_repository();
>> +	if (log_all_ref_updates == LOG_REFS_UNSET)
>> +		log_all_ref_updates = is_bare_repository() ? LOG_REFS_NONE : LOG_REFS_NORMAL;
> 
> This hunk is new, I think. The enum values are set in such a way that
> the original code would have continued to work, but I think using the
> symbolic names is an improvement.

Yes it's new.

> I assume you grepped for log_all_ref_updates to find this. I see only
> one spot that now doesn't use the symbolic names. In builtin/checkout.c,
> update_refs_for_switch() checks:
> 
>   if (opts->new_branch_log && !log_all_ref_updates)
> 
> That looks buggy, as it would treat LOG_REFS_NORMAL and LOG_REFS_UNSET
> the same, and I do not see us resolving the UNSET case to a true/false
> value. But I don't think the bug is new in your patch; the default value
> was "-1" already.
>
> I doubt it can be triggered in practice, because either:
> 
>   - the config value is set in the config file, and we pick up that
>     value, whether it's "true" or "false"
> 
>   - it's unset, in which case our default would be to enable reflogs in
>     a non-bare repo. And since git-checkout would refuse to run in a
>     bare repo, we must be non-bare, and thus enabling reflogs does the
>     right thing.

That far I can follow.

> But it works quite by accident. I wonder if we should this
> "is_bare_repository" check into a function that can be called instead of
> accessing log_all_ref_updates() directly.

Are you saying that we should move the `!log_all_ref_updates` check into
its own function where we should also check `is_bare_repository`? I
don't see that this would win much, because as you said: checkouts in a
bare repo are forbidden anyway.

Other than that, I guess it should better read `log_all_ref_update !=
LOG_REFS_NONE` instead of `!log_all_ref_updates`.


>> +test_expect_success 'update-ref does not create reflog with --no-create-reflog if core.logAllRefUpdates=always' '
> 
> This test title is _really_ long, and will wrap in the output on
> reasonable-sized terminals. Maybe '--no-create-reflog overrides
> core.logAllRefUpdates=always' would be shorter?

Yes, I agree.

>> +test_expect_success 'stdin does not create reflog when core.logAllRefUpdates=true' '
> 
> I don't mind these extra stdin tests, but IMHO they are just redundant.
> The "--stdin --create-reflog" one makes sure the option is propagated
> down via the --stdin machinery. But we know the config option is handled
> at a low level anyway.
> 
> I guess it depends on how black-box we want the testing to be. It just
> seems unlikely for a regression to be found here and not in the tests
> above.

Since these other stdin tests were around, I added this variant. But
you're right: this test breaks along with the other and doesn't add add
more safety. I'll remove it.

However, I realized that I have not written tests about ref updates in a
bare repository. Do you think it's worthwile?

Cheers,
  Cornelius


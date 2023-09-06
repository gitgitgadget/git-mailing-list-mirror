Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D7FCCF9E9
	for <git@archiver.kernel.org>; Wed,  6 Sep 2023 00:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243586AbjIFAD6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Sep 2023 20:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbjIFAD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2023 20:03:57 -0400
Received: from forward100c.mail.yandex.net (forward100c.mail.yandex.net [178.154.239.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3FD1AB
        for <git@vger.kernel.org>; Tue,  5 Sep 2023 17:03:53 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:47a7:0:640:b27a:0])
        by forward100c.mail.yandex.net (Yandex) with ESMTP id B241D600B9;
        Wed,  6 Sep 2023 03:03:49 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id l3LJme2DeGk0-lBxpCihu;
        Wed, 06 Sep 2023 03:03:48 +0300
X-Yandex-Fwd: 1
Authentication-Results: mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net; dkim=pass
Message-ID: <55aff183-c514-498d-89ce-93654d3cde97@perk11.info>
Date:   Tue, 5 Sep 2023 19:03:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] advice: improve hint for diverging branches.
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Konstantin Pereiaslov via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1570.git.git.1693861162353.gitgitgadget@gmail.com>
 <xmqqh6o8p5pl.fsf@gitster.g>
From:   Konstantin Pereiaslov <perk11@perk11.info>
In-Reply-To: <xmqqh6o8p5pl.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you, all good points. I will work on the wording
improvements based on your suggestions.

"Consider the following options:" should be on a new line and
get a "hint:" prefix, I will fix that.


As far as the danger to the user, I was talking about the fact that
the user doing "git reset --hard" is going to lose any uncommitted
work as well as any commits currently in the branch.

 > "But more importantly, what guarantees your recomputation using
 > '*refspecs' here will match the result of the logic that computed
 > 'divergent', which certainly would have already known what commit we
 > tried to fast-forward our branch to, and where that commit came
 > from?  We shouldn't be computing the same thing twice, and in
 > different ways; that is a sure way to introduce inconsistent
 > results.

This makes sens, I did it this way because I wanted to get a remote and
branch name, not just hash id and it was difficult to get this information.
I will try to rework it so that it shares the code with the logic that 
determines
the divergence status.
Any tips on what's the best way to do that would be highly appreciated.

On 9/5/23 18:20, Junio C Hamano wrote:
> "Konstantin Pereiaslov via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
>> From: Konstantin Pereiaslov <perk11@perk11.info>
>>
>> Added a description of what the offered options will do and for pull
>> also offered a 3rd option during a pull - a hard reset.
>> This option should be helpful for the new users that accidentally
>> committed into the wrong branch which is a scenario I saw very
>> often.
> cf. Documentation/SubmittingPatches:[[describe-changes]]
>
>> The resulting tooltip looks like this for pull:
>>
>> hint: Diverging branches can't be fast-forwarded.
>> Consider the following options:
> We do not give "hint:" prefix to this line???
>
>> hint:
>> hint: To merge remote changes into your branch:
>> hint:   git merge --no-ff
>> hint:
>> hint: To apply your changes on top of remote changes:
>> hint:   git rebase
> Hmph, "apply" -> "replay" perhaps?
>
>> hint: To discard your local changes and apply the remote changes:
> Here "apply" is definitely a misnomer.  Nothing is applied; you just
> discard your work and adopt (or "accept") the state of the remote as
> a whole.
>
>> hint:   git reset --hard refs/remotes/upstream/branch-name
>> hint:
>> hint: Disable this message with "git config advice.diverging false"
> OK.
>
> Overall, "... looks like this" should be shown a bit indented so
> that the example stands out from the text that explains the example.
>
>> There is some danger because it's semi-destructive, but so are
>> other options offered if user doesn't know the commands to
>> revert back.
> Sorry, but I do not quite understand what you want to say here.
>
>> @@ -1112,8 +1126,10 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>>   
>>   	/* ff-only takes precedence over rebase */
>>   	if (opt_ff && !strcmp(opt_ff, "--ff-only")) {
>> -		if (divergent)
>> -			die_ff_impossible();
>> +		if (divergent) {
>> +			const char* pull_branch_spec = get_pull_branch(repo, *refspecs);
> In this codebase, asterisk sticks to the variable/function
> identifier, not types.
>
> But more importantly, what guarantees your recomputation using
> '*refspecs' here will match the result of the logic that computed
> 'divergent', which certainly would have already known what commit we
> tried to fast-forward our branch to, and where that commit came
> from?  We shouldn't be computing the same thing twice, and in
> different ways; that is a sure way to introduce inconsistent
> results.
>
>> +			die_ff_impossible_during_pull(pull_branch_spec);
>> +		}
>>   		opt_rebase = REBASE_FALSE;
>>   	}
>>   	/* If no action specified and we can't fast forward, then warn. */
>>
>> base-commit: d814540bb75bbd2257f9a6bf59661a84fe8cf3cf
> Thanks.
>

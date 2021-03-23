Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB644C433C1
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 21:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 905F6619B3
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 21:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbhCWVt0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 17:49:26 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62830 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbhCWVs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 17:48:58 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7BE28122AE4;
        Tue, 23 Mar 2021 17:48:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1Z4HEBkNIb1+s36v4U/BLPcSdwg=; b=TeEGJ1
        4J0j5RLX8dQv8Qh+EZ++0NFsCq9nKsEG7FzHG8Ao3l4KYb96ZO0fukhatmbW+74T
        ZaKPLxStTmOsVA9h1gFhRKJHcRO2bUWL64hC6Yj+Pvz19dn6pXjo7r4yjCKJlL+G
        YU7tnC2rmmCEEAI3CpYxSErwcxsRCJwIH6ZCE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JaFKdC0Lx/VIhtg/j/44qtyrfR5Ay7b1
        iuvGZtU+6B38PZNb0DD8p7TcNRDHXFBQ0PN/7aHIM4TbPvaW+7z0+PDOxjYyL66d
        d3tYhm6OhyslBMaoR/K3iQ+vQW4PhYdQsvpOZNKiDQWiry1EoRCxRAhUWBMEIfG5
        5WI1h4iZqaQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7532E122AE3;
        Tue, 23 Mar 2021 17:48:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BD9AF122AE2;
        Tue, 23 Mar 2021 17:48:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: Re: Pass or not to pass config environment down...
References: <xmqqk0px3dfu.fsf@gitster.g>
        <CA+P7+xokjz-2nC5+F9HG0tBqS948uZcuq-1eY9uGuNyzbFGbZQ@mail.gmail.com>
Date:   Tue, 23 Mar 2021 14:48:52 -0700
In-Reply-To: <CA+P7+xokjz-2nC5+F9HG0tBqS948uZcuq-1eY9uGuNyzbFGbZQ@mail.gmail.com>
        (Jacob Keller's message of "Tue, 23 Mar 2021 13:52:31 -0700")
Message-ID: <xmqqmtut1qyj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8FB7C990-8C21-11EB-9294-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> On Tue, Mar 23, 2021 at 11:58 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> I was grepping around and found this piece of code today:
>>
>>         static void prepare_submodule_repo_env_no_git_dir(struct strvec *out)
>>         {
>>                 const char * const *var;
>>
>>                 for (var = local_repo_env; *var; var++) {
>>                         if (strcmp(*var, CONFIG_DATA_ENVIRONMENT))
>>                                 strvec_push(out, *var);
>>                 }
>>         }
>>
>> which tries to "unsetenv" the environment variables that pertain to
>> the current repository listed in loocal_repo_env[], but makes
>> exception for GIT_CONFIG_PARAMETERS.
>
> Right. We need to unset some parameters, but not everything...
>
>>
>> It originally came from 14111fc4 (git: submodule honor -c
>> credential.* from command line, 2016-02-29) and later simplified by
>> 89044baa (submodule: stop sanitizing config options, 2016-05-04).
>>
>> Now after d8d77153 (config: allow specifying config entries via
>> envvar pairs, 2021-01-12), we have yet another way to pass a set of
>> custom one-shot configuration via the environment variable, using
>> GIT_CONFIG_COUNT (which is in local_repo_env[] and will be removed
>> from the environment by this helper function), GIT_CONFIG_KEY_$n and
>> GIT_CONFIG_VALUE_$n (which are unbound set and naturally not in
>> local_repo_env[]).  Leaving the latter two exported will not hurt if
>> we do intend to hide the custom configuration from the subprocess by
>> unsetting GIT_CONFIG_COUNT, but should we be doing so?
>>
>
> I think it's a difficult question because if I recall, there was some
> question/concern about what values need to stay for the submodule vs
> which ones do not..?
>
>> There are many run_command() users that just pass local_repo_env[]
>> to the child.env when running a subprocess.  Given that the code
>> that works in a submodule, which presumably is THE primary target
>> of the "we do not want to pass environment variables that pertain to
>> the current repository but not to the repository the child process
>> works in" consideration that the local_repo_env[] is about, does *not*
>> want the GIT_CONFIG_PARAMETERS cleansed, I have to wonder if the
>> environment variables (the original GIT_CONFIG_PARAMETERS as well as
>> Patrick's GIT_CONFIG_{COUNT,KEY_$n,VALUE_$n}) should be in that
>> local_repo_env[] array in the first place.  If we remove them, the
>> above helper function can just go away and be replaced with the
>> usual child.env = local_repo_env assignment like everybody else.
>>
>
> I think that makes a reasonable amount of sense. So if I understand
> right, this change makes it so that CONFIG_DATA_ENVIRONMENT and
> CONFIG_COUNT_ENVIRONMENT will no longer be forwarded? I guess I am a
> bit confused about the current status vs what we want here.

Many callers do child.env = local_repo_env when spawning a
subprocess.  The elements of child.env is treated as if each of them
were passed to setenv() (if there is '=') or unsetenv (otherwise),
and because local_repo_env[] spells only the variable names, the
effect is to unexport them.  The helper function shown at the
beginning of the message you are responding to, which you wrote more
than 5 years ago, is to exclude GIT_CONFIG_PARAMETERS from that
treatment.  I.e. the code wants run_command() not to drop that
particular environment variable when running a subprocess.

Removing GIT_CONFIG_PARAMETERS from local_repo_env[] should have the
same effect, without the helper to special case it in its loop.
We have been passing GIT_CONFIG_PARAMETERS, and we will keep passing
it even if we make such a change to remove it from local_repo_env[].

The configuration parameters passed via the newer GIT_CONFIG_COUNT
mechanism, because local_repo_env[] has it but the above helper does
not special case it, are dropped and not seen by the subprocess.
Assuming that it is a bug and we would want to pass them to the
subprocess the same way as GIT_CONFIG_PARAMETERS environment
variable, we could tweak the helper function to make it special case
GIT_CONFIG_COUNT the same way as we've done GIT_CONFIG_PARAMETERS
for the past 5 years.  But if we suspect that other codepaths (not
the ones that use the above helper) may be doing it wrong and they
too should pass the configuration parameters to the subprocess, a
simpler way would be to remove them from local_repo_env[].

That is the summary of the current status and what would happen if
we did the attached patch.

>> Comments?
>>
>>  environment.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git c/environment.c w/environment.c
>> index 2f27008424..6dcee6a9c5 100644
>> --- c/environment.c
>> +++ w/environment.c
>> @@ -116,8 +116,6 @@ static char *super_prefix;
>>  const char * const local_repo_env[] = {
>>         ALTERNATE_DB_ENVIRONMENT,
>>         CONFIG_ENVIRONMENT,
>> -       CONFIG_DATA_ENVIRONMENT,
>> -       CONFIG_COUNT_ENVIRONMENT,
>>         DB_ENVIRONMENT,
>>         GIT_DIR_ENVIRONMENT,
>>         GIT_WORK_TREE_ENVIRONMENT,

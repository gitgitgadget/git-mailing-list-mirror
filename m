Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED680C433EF
	for <git@archiver.kernel.org>; Sat, 20 Nov 2021 02:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235970AbhKTCfx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 21:35:53 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:43944 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233605AbhKTCfx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 21:35:53 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D5F38212BC;
        Sat, 20 Nov 2021 02:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637375569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4YEWgNBM3Sr1Vsc3+Za11ZV2nzJ8bn+q2Qwv9HvQD2k=;
        b=jZte8b+RtEcFh8ehijJIbWhhC/SkZ6gRIfgyEfjRzuckS8S/jbQ+1Qg4pBdzFv5YVadjhP
        YN/p+hWqzIfEinMtCJGP89smR2atnquI6fHurkIRC9E0VkmWA0OXDjnxhswPKeLswTiLUv
        GUADGeXdPC6/HYjKwL78OflAx2jAkjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637375569;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4YEWgNBM3Sr1Vsc3+Za11ZV2nzJ8bn+q2Qwv9HvQD2k=;
        b=FK4cRjtKfrO/Up8svXGslvLmNydLC5pdHvBiKtfSPhlHnfLXmbb1E0HR3iMu6F4uMaWZzK
        CqpEFi0TJ7jO1LAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4D8FF13B16;
        Sat, 20 Nov 2021 02:32:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 81lNBFFemGESdwAAMHmgww
        (envelope-from <ematsumiya@suse.de>); Sat, 20 Nov 2021 02:32:49 +0000
Date:   Fri, 19 Nov 2021 23:32:46 -0300
From:   Enzo Matsumiya <ematsumiya@suse.de>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] pager: fix crash when pager program doesn't exist
Message-ID: <20211120023246.7ynehp5v3iypfr6w@cyberdelia>
References: <20211119234745.26605-1-ematsumiya@suse.de>
 <YZhVA8DOjHu90gzs@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YZhVA8DOjHu90gzs@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Thanks for the detailed reply. Please see my replies below.

On 11/19, Jeff King wrote:
>On Fri, Nov 19, 2021 at 08:47:45PM -0300, Enzo Matsumiya wrote:
>
>> setup_pager() doesn't properly free pager_process.argv if
>> start_command() fails, nor finish_command() is ever called.
>
>Hmm. It shouldn't need to. It sets up the args using
>prepare_pager_args(), which pushes onto the pager_process->args strvec.
>If start_command fails, then it takes care of freeing that strvec.
>
>In fact, it would be wrong to free that pointer, because it is usually
>just pointing to the strvec's "v" array, which will already be freed by
>strvec_clear().

Agreed, the memory is freed, but argv still points to the old args.v
location.
You can easily check this by adding a breakpoint at start_command and
run my reproducer.

On the first run, argv is NULL, then assigned args.v location.
On the second run, argv points to the old args.v, and args.v has a new
location. That's when strvec_push() will try to use whatever garbage is
at argv.

>> setup_pager() is called twice, once from commit_pager_choice(), and then
>> from cmd_log_init_finish(). On the first run, it runs fine because
>> start_command() assigns cmd->args.v to cmd->argv, and upon command
>> failure, child_process_clear() clears cmd->args.
>
>When pager setup succeeds, the second run is a noop, because isatty(1)
>is no longer true. But for the case you're interested in, the first one
>fails, so we do try again. And I can reproduce your problem with:

No, it's not a noop such as that it's clear that things are different on
the second call.

> GIT_PAGER=no-such-command git -p log
>
>I had to run it with ASan to trigger a failure, as use-after-free bugs
>aren't always deterministic.

Please use my reproducer as it's 100% reliable and consistent (same
memory regions are affected).

I couldn't reproduce the issue with yours.

>> On the second run, though, argv is no longer NULL, but .args has been
>> cleared, so any strvec_push() operation will crash.
>
>Right. So we want to make sure that argv is NULL, but we don't need to
>free it. I think the bug is not in failing to clean up, though. It's in
>assuming that the child_process has been properly initialized. The first
>call works because of the initialization in the declaration, but the
>second call can't rely on that.
>
>So one solution is more like this:
>
>diff --git a/pager.c b/pager.c
>index 52f27a6765..27877f8ebb 100644
>--- a/pager.c
>+++ b/pager.c
>@@ -8,7 +8,7 @@
> #define DEFAULT_PAGER "less"
> #endif
>
>-static struct child_process pager_process = CHILD_PROCESS_INIT;
>+static struct child_process pager_process;
> static const char *pager_program;
>
> /* Is the value coming back from term_columns() just a guess? */
>@@ -124,6 +124,8 @@ void setup_pager(void)
>
> 	setenv("GIT_PAGER_IN_USE", "true", 1);
>
>+	child_process_init(&pager_process);
>+
> 	/* spawn the pager */
> 	prepare_pager_args(&pager_process, pager);
> 	pager_process.in = -1;
>
>which is enough to fix the use-after-free.

This worked for my case.

>> While at it, I implemented a fallback to the DEFAULT_PAGER, so it tries
>> at least one more time when the configured pager fails.
>
>I think this is probably a bad idea. If the user told us to use a
>different pager, then we should not unexpectedly use the default one. At
>any rate, it's unrelated to this patch; if we were to do it, it should
>be separate from the bugfix.

Got it. I was a bit skeptical about this one. Idea discarded.

>> diff --git a/pager.c b/pager.c
>> index 52f27a6765c8..79a47db55d63 100644
>> --- a/pager.c
>> +++ b/pager.c
>> @@ -97,6 +97,9 @@ static void setup_pager_env(struct strvec *env)
>>
>>  void prepare_pager_args(struct child_process *pager_process, const char *pager)
>>  {
>> +	child_process_clear(pager_process);
>> +	if (pager_process->argv)
>> +		free(pager_process->argv);
>
>As noted above, this would be double-freeing the strvec's array. Except
>that your free() here never runs, because you added a memset() to
>child_process_clear() which will always set pager_process->argv to NULL.

Ok.

>> @@ -105,11 +108,14 @@ void prepare_pager_args(struct child_process *pager_process, const char *pager)
>>
>>  void setup_pager(void)
>>  {
>> -	const char *pager = git_pager(isatty(1));
>> +	const char *tmp_pager = git_pager(isatty(1));
>> +	char *pager;
>>
>> -	if (!pager)
>> +	if (!tmp_pager)
>>  		return;
>>
>> +	pager = xstrdup(tmp_pager);
>> +
>
>Why are we making a copy of the pager string? When it's pushed into the
>strvec, that will take ownership of it. Your patch creates a leak (in
>the case that we start_command() doesn't fail, and we miss the new
>free() calls you added).

Right, thanks.

>> diff --git a/run-command.c b/run-command.c
>> index f329391154ae..d2b7647afdd8 100644
>> --- a/run-command.c
>> +++ b/run-command.c
>> @@ -19,6 +19,7 @@ void child_process_clear(struct child_process *child)
>>  {
>>  	strvec_clear(&child->args);
>>  	strvec_clear(&child->env_array);
>> +	memset(child, 0, sizeof(*child));
>>  }
>
>This doesn't set up a child_process to be correctly reused, as the
>initialized state for a strvec is not all-bits-zero (though it often
>works in practice).

Noted, thanks.

>The patch I showed above fixes the use-after-free by making sure the
>child_process struct is initialized before we use it. But we could also
>change the semantics of _clear() to make sure it is ready for reuse. To
>do that, you'd want to just call child_process_init() here.
>
>There's some precedent in that with other APIs (e.g., strvec_clear()
>makes the struct ready for reuse immediately). Plus it's harder for the
>callers to get wrong (after adding such a line, setup_pager() does not
>have to do anything else at all).
>
>So this single-line change also fixes the use-after-free, without any of
>the other stuff:
>
>diff --git a/run-command.c b/run-command.c
>index f40df01c77..92e00d9455 100644
>--- a/run-command.c
>+++ b/run-command.c
>@@ -21,6 +21,7 @@ void child_process_clear(struct child_process *child)
> {
> 	strvec_clear(&child->args);
> 	strvec_clear(&child->env_array);
>+	child_process_init(child);
> }
>
> struct child_to_clean {

Of course this one works as well. And is more elegant IMHO.

Again, thanks a lot for the feedback.

Should I submit a v2 or will you?


>-Peff

Cheers,

Enzo

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2106C433EF
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 21:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8CE26113D
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 21:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbhJTVqQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 17:46:16 -0400
Received: from siwi.pair.com ([209.68.5.199]:21488 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230229AbhJTVqP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 17:46:15 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id EB2D93F413A;
        Wed, 20 Oct 2021 17:43:59 -0400 (EDT)
Received: from WIN10-A.eucom.mil (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id C104A3F40F5;
        Wed, 20 Oct 2021 17:43:59 -0400 (EDT)
Subject: Re: [PATCH v3 0/5] Builtin FSMonitor Part 2
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1041.v2.git.1633614772.gitgitgadget@gmail.com>
 <pull.1041.v3.git.1634157107.gitgitgadget@gmail.com>
 <87lf2ueafl.fsf@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <bfe8089a-1cc0-17b3-e80c-a3539ced6742@jeffhostetler.com>
Date:   Wed, 20 Oct 2021 17:43:59 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87lf2ueafl.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/15/21 8:03 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Oct 13 2021, Jeff Hostetler via GitGitGadget wrote:
> 
>> Here is V3 of Part 2 of my Builtin FSMonitor series. Like V2, it is built
>> upon "next" because it requires "ab/repo-settings-cleanup" and
>> "jh/builtin-fsmonitor-part1" series.
> 
> FYI: Both of those have landed, so a next iteration of this can be built
> on "master".
> 
>> V3 removes the explicit initialization of r->repo_settings->fsmonitor in
>> repo-settings.c as requested. It also includes a more detailed commit
>> message for the 3 commit to explain the rationale for putting fsmonitor
>> settings in its own source file rather than adding it repo-settings.c
> 
> This series breaks with the "make check-docs" target, which as an aside
> is broken because of recent changes of mine, so CI didn't catch this
> (I'll submit a series to fix it):
> 
>      config/core.txt:95: error: git-fsmonitor--daemon[1]: link outside of our own docs, shown with 'HERE' below:
>      config/core.txt:95:     'daemon for this working directory (linkgit:git-fsmonitor--daemon[1]' <-- HERE
>      git-update-index.txt:502: error: git-fsmonitor--daemon[1]: link outside of our own docs, shown with 'HERE' below:
>      git-update-index.txt:502:       'linkgit:git-fsmonitor--daemon[1]' <-- HERE
> 
> But that broken-ness points to a more general issue, which is that it's
> not just a broken link, but that docs in this series are referring to a
> manpage that doesn't exist yet.
> 
> I was going to check out some of the semantics of
> core.useBuiltinfsMonitor that I commented on in earlier rounds, but I
> see that there's no tests for it, probably for similar reasons as there
> not being a git-fsmonitor--daemon yet: It's all (hopefully) in some
> yet-to-come series.
> 
> I'm all for this being split up in steps from the 30-something patches
> it was before, but if we're making forward-references to docs that don't
> exist yet, adding ~100 line *.c files that seemingly aren't used at all
> yet etc., the split-up seems to be a bit too aggressive.
> 
> E.g. the below diff seems to have all tests passing, so
> core.usebuiltinfsmonitor is unused still? There's also large amounts of
> code ifdef'd away under HAVE_FSMONITOR_DAEMON_BACKEND, but no other
> in-tree reference to it?
> 
> AFAICT that's going to be used in the future. So seemingly something
> that'll only be used in the series after this? I.e. this seems to have
> stopped at around part 7/28 of a previous submission, but digging in the
> archive e.g. HAVE_FSMONITOR_DAEMON_BACKEND semes to be first used in
> step 11/28 of that[1].
> 
> Sorry to be party pooper again, I really did try to review this, but
> just found that I couldn't, since so much of it seems to be a
> forward-reference to some future state.
> 
> Isn't there a way to re-arrange this so that the "teach daemon XYZ
> command" around steps 13-14/28 of your previous series comes before
> references in the docs to the daemon that doesn't exist yet (5/5 here),
> or there's perhaps some of the config scaffolding, but
> e.g. "core.usebuiltinfsmonitor" comes along with the later change that
> uses it?
> 
> Or just make this "part 2" series larger than 5 patches, so that it
> manages to tell some holistic story, and the various bits are used at
> the end?
> 
> Even so it would be a lot easier to follow if e.g. a patch using a new
> "core.usebuiltinfsmonitor" variable doesn't come at say step 11/20, with
> that variable having been added at a 3/20. I.e. maybe 3/20 can have the
> scaffolding, but the part that adds the "core.usebuiltinfsmonitor"
> support either immediately precedes its use, or is squashed into the
> relevant commit that needs it. Ditto docs for so-far-not-existing things
> etc.
> 
> Thanks! And hopefully this helps.
> 
> 1. https://lore.kernel.org/git/49f9e2e3d49ce6e7b56839bf44535f271216abeb.1621691828.git.gitgitgadget@gmail.com/
> 
> diff --git a/fsmonitor-settings.c b/fsmonitor-settings.c
> index 2770266f5ee..2c479d4f36b 100644
> --- a/fsmonitor-settings.c
> +++ b/fsmonitor-settings.c
> @@ -35,19 +35,6 @@ void fsm_settings__set_disabled(struct repository *r)
>   	FREE_AND_NULL(s->hook_path);
>   }
>   
> -static int check_for_ipc(struct repository *r)
> -{
> -	int value;
> -
> -	if (!repo_config_get_bool(r, "core.usebuiltinfsmonitor", &value) &&
> -	    value) {
> -		fsm_settings__set_ipc(r);
> -		return 1;
> -	}
> -
> -	return 0;
> -}
> -
>   static int check_for_hook(struct repository *r)
>   {
>   	const char *const_str;
> @@ -71,9 +58,6 @@ static void lookup_fsmonitor_settings(struct repository *r)
>   
>   	r->settings.fsmonitor = s;
>   
> -	if (check_for_ipc(r))
> -		return;
> -
>   	if (check_for_hook(r))
>   		return;
>   
> 

Because of the size -- I'm up to ~60 commits now -- I was trying
to break it up into logical pieces.  And yes, there's a bit of a
chicken-n-egg problem with introducing pieces.  I was trying to make
Part 2 be the client side -- everything needed to talk to a daemon
(even if it doesn't exist yet) and then have Part 3 be the daemon
proper (and build it up without worrying about when the corresponding
client peer code appears because the client side is already present).
The daemon in Part 3 would be a little rough around the edges, but
sufficient to do end-to-end testing with both t/ and t/perf tests.
Then Part 4 would clean up some of the details and add more tests.

That was the idea anyway.

I'll take a stab at refactoring this and send a new Part 2 that
contains both the client and MVP daemon parts.  This will let
let basic end-to-end testing happen, fix the doc breakage, and
hopefully make it easier to see the big picture in a single patch
series.  This should be about 30 commits.  Once that has settled
a bit, I'll followup with a new Part 3 that contains the refinements
and additional tests.


Thanks,
Jeff



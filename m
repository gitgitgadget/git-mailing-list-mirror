Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD81C77B78
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 15:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241212AbjDZPek (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 11:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240786AbjDZPej (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 11:34:39 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A3B94
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 08:34:37 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 18AC823EE2;
        Wed, 26 Apr 2023 11:34:35 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1prhAA-gqa-00; Wed, 26 Apr 2023 17:34:34 +0200
Date:   Wed, 26 Apr 2023 17:34:34 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 8/8] rebase: improve resumption from incorrect initial
 todo list
Message-ID: <ZElEis+PLDYR+Jvr@ugly>
Mail-Followup-To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
References: <20230323162235.995574-1-oswald.buddenhagen@gmx.de>
 <20230323162235.995574-9-oswald.buddenhagen@gmx.de>
 <8a188876-c456-7269-28de-9ff406204030@dunelm.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <8a188876-c456-7269-28de-9ff406204030@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 26, 2023 at 03:28:01PM +0100, Phillip Wood wrote:
>On 23/03/2023 16:22, Oswald Buddenhagen wrote:
>> When the user butchers the todo file during rebase -i setup, the
>> --continue which would follow --edit-todo would have skipped the last
>> steps of the setup. Notably, this would bypass the fast-forward over
>> untouched picks (though the actual picking loop would still fast-forward
>> the commits, one by one).
>> 
>> Fix this by splitting off the tail of complete_action() to a new
>> start_rebase() function and call that from sequencer_continue() when no
>> commands have been executed yet.
>> 
>> More or less as a side effect, we no longer checkout `onto` before exiting
>> when the todo file is bad. 
>
>I think the implications of this change deserve to be discussed in the 
>commit message. Three things spring to mind but there may be others I 
>haven't thought of
>
>  - Previously when rebase stopped and handed control back to the user
>    HEAD would have already been detached. This patch changes that
>    meaning we can have an active rebase of a branch while that branch is
>    checked out. What does "git status" show in this case? What does the
>    shell prompt show? Will it confuse users?
>
the failed state is identical to the "still editing the initial todo" 
state as far as "git status" and the shell prompt are concerned. this 
seems reasonable. i'll add it to the commit message.

>  - Previously if the user created a commit before running "rebase
>    --continue" we'd rebase on to that commit. Now that commit will be
>    silently dropped.
>
this is arguably a problem, but not much different from the pre-existing 
behavior of changes to HEAD done during the initial todo edit being 
lost.
to avoid that, we'd need to lock HEAD while editing the todo. is that 
realistic at all?
on top of that, i should verify HEAD against orig-head in 
start_rebase(). though the only way for the user to get out of that 
situation is saving the todo contents and --abort'ing (and we must take 
care not the touch HEAD).

this is somewhat similar to the abysmal situation of the final 
update-ref failing if the target ref has been modified while being 
rebased. we'd need to lock that ref for the entire duration of the 
rebase to avoid that.

>  - Previously if the user checkout out another commit before running
>    "rebase --continue" we'd rebase on to that commit. Now we we rebase
>    on to the original "onto" commit.
>
this can be subsumed into the above case.

> > This makes aborting cheaper and will simplify
> > things in a later change.
>
>Given that we're stopping so the user can fix the problem and continue 
>the rebase I don't think optimizing for aborting is a convincing reason 
>for this change on its own.
>
this is all part of the "More or less as a side effect" paragraph, so 
this isn't a relevant objection.

>> diff --git a/builtin/revert.c b/builtin/revert.c
>> index 62986a7b1b..00d3e19c62 100644
>> --- a/builtin/revert.c
>> +++ b/builtin/revert.c
>> @@ -231,7 +231,8 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
>>   		return ret;
>>   	}
>>   	if (cmd == 'c')
>> -		return sequencer_continue(the_repository, opts);
>> +		return sequencer_continue(the_repository, opts,
>> +					  0, NULL, NULL, NULL);
>
>It's a bit unfortunate that we have to start passing all these extra 
>parameters, could the sequencer read them itself in read_populate_opts()?
>
that wouldn't help in this case, as these are dummy values which aren't 
going to be used.

but more broadly, the whole state management is a total mess. i have 
this notes-to-self patch on top of my local branch:

--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -476,6 +476,7 @@ static const char *state_dir_path(const char *filename, struct rebase_options *o
  }

  /* Initialize the rebase options from the state directory. */
+// FIXME: this is partly redundant with the sequencer's read_populate_opts().
  static int read_basic_state(struct rebase_options *opts)
  {
         struct strbuf head_name = STRBUF_INIT;
@@ -552,6 +553,7 @@ static int read_basic_state(struct rebase_options *opts)
         return 0;
  }

+// This is written only by the apply backend
  static int rebase_write_basic_state(struct rebase_options *opts)
  {
         write_file(state_dir_path("head-name", opts), "%s",


>> -int sequencer_continue(struct repository *r, struct replay_opts *opts)
>> +static int start_rebase(struct repository *r, struct replay_opts *opts, unsigned flags,
>> +			const char *onto_name, const struct object_id *onto,
>> +			const struct object_id *orig_head, struct todo_list *todo_list);
>
>It would be nice to avoid this forward declaration. I think you could do 
>that by adding a preparatory patch that moves either checkout_onto() or 
>sequencer_continue()
>
i went for the "minimal churn" approach.

but more broadly, the code distribution between rebase.c and sequencer.c 
needs a *major* re-think. moving these functions into place could be 
part of that effort.

>> +	git reflog expire --expire=all HEAD &&
>
>Is this really necessary, can you pass -n to "git reflog" below?
>
starting from a clean slate makes it more straight-forward to make it
reliable. i don't see any real downsides to the approach.

>> +	git reflog > reflog &&
>> +	test $(grep -c fast-forward reflog) = 1 &&
>
>Using test_line_count would make test failures easier to debug.
>
that's calling for a new test_filtered_line_count function which would 
have quite some users.
for the time being, both grep + test_line_count and grep -c are rather 
prevalent, in this file the latter in particular.

>> +	test_cmp_rev HEAD~1 primary~1 &&
>> +	test "$(git log -1 --format=%B)" = "E_reworded"
>
>It is slightly more work, but please use test_cmp for things like this 
>as it makes it so much easier to debug test failures.
>
fair enough, but the precedents again speak a different language.

regards

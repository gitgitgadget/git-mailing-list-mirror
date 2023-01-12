Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D68CC54EBC
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 12:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjALMsG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 07:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjALMrn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 07:47:43 -0500
Received: from 7of9.schinagl.nl (7of9.connected.by.freedominter.net [185.238.129.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D428D49144
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 04:47:25 -0800 (PST)
Received: from [10.2.11.242] (unknown [10.2.11.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by 7of9.schinagl.nl (Postfix) with ESMTPSA id 0FB61189D276;
        Thu, 12 Jan 2023 13:47:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
        t=1673527644; bh=TXksixMdPqcP7eK0PbrpE/XIQuIBop3hUbpgvjb3Yqg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=L3CzpA+HY+f0AIDOhQMbspIsCQCVytHNJ5r/pSZ3zp0vC4ft+PGI+B8P6Qs2YcRBF
         FZ1ShJYGssAjO7aYAeIxDhgdG+kPLMkc5IFu0WR6nyLG5ZEVTMI5lASXAM+WHQBHDX
         FHjfIym1m4dXrdUNOqpkAkaGcmA8ZCcUEXcDa3oE=
Message-ID: <1d1becbc-5f4b-fb28-961c-112755e0c58e@schinagl.nl>
Date:   Thu, 12 Jan 2023 13:47:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] rebase -i: allow a comment after a "break" command
Content-Language: nl
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1460.git.1673519809510.gitgitgadget@gmail.com>
 <230112.86pmbk0vvj.gmgdl@evledraar.gmail.com>
From:   Olliver Schinagl <oliver@schinagl.nl>
In-Reply-To: <230112.86pmbk0vvj.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12-01-2023 13:25, Ævar Arnfjörð Bjarmason wrote:
> On Thu, Jan 12 2023, Phillip Wood via GitGitGadget wrote:
>
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> When adding a "break" command to a rebase todo list it can be helpful to
>> add a comment as a reminder as to what the user was planning to do when
>> the rebase stopped. Anything following the command is interpreted as an
>> argument to the command and results in an error. Change this so that a
>> "break command may be followed by "# <comment>" in the same way as
>> a "merge" command. Requiring the comment to begin with "# " allows the
>> break command to start taking an argument in the future if that turns
>> out to be useful.
>>
>> Reported-by: Olliver Schinagl <oliver@schinagl.nl>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>      rebase -i: allow a comment after a "break" command
>>      
>>      I'm open to suggestions for other ways to handle comments but copying
>>      what we do to separate merge parents from the merge commit subject
>>      seemed simplest.
>>      
>>      Should this print the comment when stopping for a break command?
>>
>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1460%2Fphillipwood%2Fsequencer-allow-comment-after-break-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1460/phillipwood/sequencer-allow-comment-after-break-v1
>> Pull-Request: https://github.com/gitgitgadget/git/pull/1460
>>
>>   Documentation/git-rebase.txt |  4 +++-
>>   sequencer.c                  |  7 +++++--
>>   t/lib-rebase.sh              |  2 +-
>>   t/t3418-rebase-continue.sh   | 16 ++++++++++++++++
>>   4 files changed, 25 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
>> index f9675bd24e6..511ace43db0 100644
>> --- a/Documentation/git-rebase.txt
>> +++ b/Documentation/git-rebase.txt
>> @@ -869,7 +869,9 @@ the files and/or the commit message, amend the commit, and continue
>>   rebasing.
>>   
>>   To interrupt the rebase (just like an "edit" command would do, but without
>> -cherry-picking any commit first), use the "break" command.
>> +cherry-picking any commit first), use the "break" command. A "break"
>> +command may be followed by a comment beginning with `#` followed by a
>> +space.
> You're missing a corresponding edit here to the help string in
> append_todo_help(), as you note you're making "break" support what
> "merge" does, and that help string documents that "merge" accepts a
> comment, after this we don't do that for "break", but should one way or
> the other (see below).
>
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -2509,7 +2509,9 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
>>   	padding = strspn(bol, " \t");
>>   	bol += padding;
>>   
>> -	if (item->command == TODO_NOOP || item->command == TODO_BREAK) {
>> +	if (item->command == TODO_NOOP ||
>> +	    (item->command == TODO_BREAK &&
>> +	     (bol[0] != '#' || (bol[1] && !isspace (bol[1]))))) {
>>   		if (bol != eol)
>>   			return error(_("%s does not accept arguments: '%s'"),
>>   				     command_to_string(item->command), bol);
>> @@ -2524,7 +2526,8 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
>>   			     command_to_string(item->command));
>>   
>>   	if (item->command == TODO_EXEC || item->command == TODO_LABEL ||
>> -	    item->command == TODO_RESET || item->command == TODO_UPDATE_REF) {
>> +	    item->command == TODO_RESET || item->command == TODO_UPDATE_REF ||
>> +	    item->command == TODO_BREAK) {
>>   		item->commit = NULL;
>>   		item->arg_offset = bol - buf;
>>   		item->arg_len = (int)(eol - bol);
>> diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
>> index b57541356bd..a648013f299 100644
>> --- a/t/lib-rebase.sh
>> +++ b/t/lib-rebase.sh
>> @@ -51,7 +51,7 @@ set_fake_editor () {
>>   		case $line in
>>   		pick|p|squash|s|fixup|f|edit|e|reword|r|drop|d|label|l|reset|r|merge|m)
>>   			action="$line";;
>> -		exec_*|x_*|break|b)
>> +		exec_*|x_*|break_*|b_*|break|b)
>>   			echo "$line" | sed 's/_/ /g' >> "$1";;
>>   		merge_*|fixup_*)
>>   			action=$(echo "$line" | sed 's/_/ /g');;
>> diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
>> index 130e2f9b553..18d82869b38 100755
>> --- a/t/t3418-rebase-continue.sh
>> +++ b/t/t3418-rebase-continue.sh
>> @@ -266,6 +266,22 @@ test_expect_success 'the todo command "break" works' '
>>   	test_path_is_file execed
>>   '
>>   
>> +test_expect_success 'the todo command "break" accepts a comment' '
>> +	rm -f execed &&
>> +	test_write_lines "break # comment" "break #" "exec >execed" >expect &&
>> +	write_script cat-todo.sh <<-\EOS &&
>> +	GIT_SEQUENCE_EDITOR="grep ^\[^#\]" git rebase --edit-todo >actual
>> +	EOS
>> +	FAKE_LINES="exec_./cat-todo.sh break_#_comment b_# exec_>execed" \
>> +		git rebase -i HEAD &&
>> +	test_cmp expect actual &&
>> +	test_path_is_missing execed &&
>> +	git rebase --continue &&
>> +	test_path_is_missing execed &&
>> +	git rebase --continue &&
>> +	test_path_is_file execed
>> +'
>> +
>>   test_expect_success '--reschedule-failed-exec' '
>>   	test_when_finished "git rebase --abort" &&
>>   	test_must_fail git rebase -x false --reschedule-failed-exec HEAD^ &&
>>
>> base-commit: 8a4e8f6a67e7fc97048d4666eec38399b88e0e3b
> I like this direction, but I don't see why we need to continue this
> special-snowflakeness of only allowing specific commands to accept these
> #-comments.

Oh, yes! That please :) I often want to put comments during a rebase.

Also retrieving it becomes an issue at that point though. E.g. print it 
during status/etc. E.g. if I do 'edit' on a rebase and I add a comment, 
for example:

'edit/reword <hash> [original title]#Fix typo in title/commit message'

I obviouslly also need to be reminded. e.g. what about commands that pop 
up the editor to 'amend' the commit message (as rebase --continue would 
do for an edit) also add the comment (using git commitChar) in the 
commit message. Kind of like how squash/fixup do "this is a commit based 
on two ..." with comments splattered around. (also kind of like git 
fixup -m <msg> does without a rebase?).

Feature creep, sorry though :)

>
> Why not just have them all support it? It started with "merge", which as
> 4c68e7ddb59 (sequencer: introduce the `merge` command, 2018-04-25) note
> can be used for:
>
> 	merge -C baaabaaa abc # Merge the branch 'abc' into master
>
> As Olliver points out we should probably support "#" without the
> following " ", which seems to be an accident of history &
> over-strictness.

:+1:


Olliver

>
> But in this commit you extend it to "break", but we're going out of or
> way to e.g. extend this to "noop".
>
> So I'd expect that just like the first for-loop in "parse_insn_line()"
> we'd check if strchr(bol, '#') returns non-NULL, and if so set eol to
> that result.
>
> The "just like" being that we may want to explicitly forbid this or
> handle it specially for some, e.g. I didn't check but do the "label" and
> "reset" perhaps support arbitrary non-'\n' (probably by accident, and we
> could support commments there too).
>
> For "pick" we probably need to explicitly exclude it, although I can't
> remember if we do anything useful with the part of the line after the
> OID (maybe not...).



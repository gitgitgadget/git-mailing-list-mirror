Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB0FC433FE
	for <git@archiver.kernel.org>; Mon,  3 Oct 2022 15:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJCPMH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Oct 2022 11:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiJCPME (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2022 11:12:04 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007C06315
        for <git@vger.kernel.org>; Mon,  3 Oct 2022 08:12:02 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 5E63C240026
        for <git@vger.kernel.org>; Mon,  3 Oct 2022 17:12:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1664809921; bh=qb70iE1IGoXTfRMqEvgnfGTGN8Dq3hqOsqNDRxfRFo0=;
        h=From:To:CC:Date:Subject:From;
        b=fAhN/Hn0UlzRBZmQbA4Vmysedk+VaIOoDrUxFplGg0SPF7eLbOktvDh/dBp+FL20a
         AdRvmVYcV/Mr5f39zXIgProD6f3hMdkeFnEu4VEKOZPLEHE2zOnApMURu6BPMEpl2j
         puCi1lDjwiTnQ9pl+kJIttS9bPnWrm+lzam2+8CKEVDydf3tvoY6RiPKkCrieCS7B7
         3yCU2fcpaMshGm2TlZXQAzE6fIDRuR6vgJscnA/RiqHR61Jg6wtz5Hr+E88lGU8JIW
         vLmHfU1bpzSR6A59BEQ6ka+v6/I/VOGlGGkrA3bxUdCxhghgQFaoR9tILIiKQgKXdD
         b39XHFYiqe/Mw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Mh47N4bbmz9rxd;
        Mon,  3 Oct 2022 17:12:00 +0200 (CEST)
From:   Tim Jaacks <timjaacks@posteo.de>
To:     =?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder.dev@gmail.com>
CC:     <git@vger.kernel.org>
Date:   Mon, 03 Oct 2022 15:11:59 +0000
Message-ID: <1839e676218.285a.8a94aeaa49923dfb9a7d55a303990d0a@posteo.de>
In-Reply-To: <1839e62f930.285a.8a94aeaa49923dfb9a7d55a303990d0a@posteo.de>
References: <em8d7ca854-51a3-4cb5-aaf9-30ed37b4194b@acer-switch-tim>
 <20221003142437.GB7659@szeder.dev>
 <1839e62f930.285a.8a94aeaa49923dfb9a7d55a303990d0a@posteo.de>
Subject: Re: Bash completion for git aliases containing nested subcommands
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Gabor,

thanks a lot for your detailed reply! I tried that and it works, thank you.

Just another small follow-up question, out of curiosity: I noticed that zsh 
handles the alias completion correctly out of the box (using the exact same 
gitconfig file). I don't have any dedicated zsh completion file, just 
installed zsh via apt. Do you know why and how zsh handles this differently?

Kind regards,
Tim

Am 3. Oktober 2022 16:24:41 schrieb SZEDER Gábor <szeder.dev@gmail.com>:

> On Mon, Oct 03, 2022 at 11:45:51AM +0000, Tim Jaacks wrote:
>> Hello everyone,
>>
>> I have set up the following alias in my .gitconfig file:
>>
>> [alias]
>> ss = stash show
>>
>> Unfortunately bash completion does not work correctly on this alias. When I
>> type "git ss <TAB>", I get:
>>
>> $ git ss <TAB>
>> apply clear drop pop show
>> branch create list push
>>
>> Which is obviously the completion for "git stash" instead of "git stash
>> show".
>>
>> With the original command I get the list of available stashes:
>>
>> $ git stash show <TAB>
>> stash@{0} stash@{1}
>>
>> Is there a way to get the completion on the alias behave like on the
>> original command?
>
> In general: no.  Our Bash completion script is organized as one
> _git_cmd() function for each git supported command.  If a command has
> subcommands, then its completion function looks for any of its
> subcommands amond the words on the command line, and takes the
> appropriate action, which is usually executing a particular arm of a
> case statement.  The two main issues are that in case of such an alias
> there is no subcommand ("show") on the command line, and there is no
> dedicated function to handle only the completion for 'git stash show'.
>
> However, it is possible to make completion work for your particular
> alias by using our completion script's extension mechanism that allows
> users to specify completion functions to their own git commands.  If
> you type 'git foo <TAB>' and there is a _git_foo() function in your
> shell's environment, then the completion script will invoke that
> function to perform completion; this works not only for commands but
> for aliases as well.  So for your alias you only need to "borrow" all
> the "show"-subcommand-specific case arms from _git_stash() and place
> them in a _git_ss() function, e.g. like this:
>
> _git_ss () {
> case "$cur" in
> --*)
> __gitcomp_builtin stash_show "$__git_diff_common_options"
> ;;
> *)
> __gitcomp_nl "$(__git stash list | sed -n -e 's/:.*//p')"
> ;;
> esac
> }
>
> Add it to your ~/.bashrc, or to a separate file that you source from
> your .bashrc;  If you use bash-completion, then you don't even have to
> touch you .bashrc: save that function to a file 'git-ss' (dash, not
> underscore!) in one of the directories scanned by bash-completion
> ($BASH_COMPLETION_USER_DIR, ~/.local/share/bash-completion/completions
> or its XDG_DATA_HOME-equivalent) and it will be auto-loaded as needed.
>
> This approach should work just as well for any other similar "command
> subcommand" alias that you might have; with the downside that you'll
> have to write all these functions yourself.
>
>> I am on Ubuntu 20.04 and using the distro's default git completions.
>>
>> Kind regards,
>> Tim




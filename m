Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08A0A1F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 18:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752761AbdARSvo (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 13:51:44 -0500
Received: from smtp130.dfw.emailsrvr.com ([67.192.241.130]:54662 "EHLO
        smtp130.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751281AbdARSvl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 13:51:41 -0500
Received: from smtp29.relay.dfw1a.emailsrvr.com (localhost [127.0.0.1])
        by smtp29.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTP id 30792404BA;
        Wed, 18 Jan 2017 13:44:09 -0500 (EST)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp29.relay.dfw1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id D2B284016C;
        Wed, 18 Jan 2017 13:44:08 -0500 (EST)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Wed, 18 Jan 2017 13:44:09 -0500
Subject: Re: [RFC] stash --continue
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cd784a4e-ee99-564e-81de-9f7f6cc26c67@gmx.net>
 <alpine.DEB.2.20.1701161153340.3469@virtualbox>
 <d5456165-bdf2-e9e7-117f-aeab0ff4b417@xiplink.com>
 <alpine.DEB.2.20.1701181725130.3469@virtualbox>
Cc:     Stephan Beyer <s-beyer@gmx.net>, git <git@vger.kernel.org>
From:   Marc Branchaud <marcnarc@xiplink.com>
Message-ID: <38d592b8-975c-1fd9-4c42-877e34a4ab70@xiplink.com>
Date:   Wed, 18 Jan 2017 13:44:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1701181725130.3469@virtualbox>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-01-18 11:34 AM, Johannes Schindelin wrote:
> Hi Marc,
>
> On Wed, 18 Jan 2017, Marc Branchaud wrote:
>
>> On 2017-01-16 05:54 AM, Johannes Schindelin wrote:
>>
>>> On Mon, 16 Jan 2017, Stephan Beyer wrote:
>>>
>>>> a git-newbie-ish co-worker uses git-stash sometimes. Last time he
>>>> used "git stash pop", he got into a merge conflict. After he
>>>> resolved the conflict, he did not know what to do to get the
>>>> repository into the wanted state. In his case, it was only "git add
>>>> <resolved files>" followed by a "git reset" and a "git stash drop",
>>>> but there may be more involved cases when your index is not clean
>>>> before "git stash pop" and you want to have your index as before.
>>>>
>>>> This led to the idea to have something like "git stash
>>>> --continue"[1]
>>>
>>> More like "git stash pop --continue". Without the "pop" command, it
>>> does not make too much sense.
>>
>> Why not?  git should be able to remember what stash command created the
>> conflict.  Why should I have to?  Maybe the fire alarm goes off right when I
>> run the stash command, and by the time I get back to it I can't remember
>> which operation I did.  It would be nice to be able to tell git to "just
>> finish off (or abort) the stash operation, whatever it was".
>
> That reeks of a big potential for confusion.
>
> Imagine for example a total Git noob who calls `git stash list`, scrolls
> two pages down, then hits `q` by mistake. How would you explain to that
> user that `git stash --continue` does not continue showing the list at the
> third page?

Sorry, but I have trouble taking that example seriously.  It assumes 
such a level of "noobness" that the user doesn't even understand how 
standard command output paging works, not just with git but with any 
shell command.

> Even worse: `git stash` (without arguments) defaults to the `save`
> operation, so any user who does not read the documentation (and who does?)
> would assume that `git stash --continue` *also* implies `save`.

Like the first example, your user is trying to "continue" a command that 
is already complete.  It's like try to do "git rebase --continue" when 
there's no rebase operation underway.

Now, maybe there is some way for "git stash save" (implied or explicit) 
to stop partway through the operation.  I can't imagine such a situation 
(out of disk space, maybe?), particularly where the user would expect 
"git stash save" to leave things in a half-finished state.  To me "git 
stash save" should be essentially all-or-nothing.

However, if there were such a partial-failure scenario, then I think it 
would be perfectly reasonable for "git stash --continue" to finish the 
save operation, assuming that the failure condition has been resolved.

> If that was not enough, there would still be the overall design of Git's
> user interface. You can call it confusing, inconsistent, with a lot of
> room for improvement, and you would be correct. But none of Git's commands
> has a `--continue` option that remembers the latest subcommand and
> continues that. To introduce that behavior in `git stash` would disimprove
> the situation.

I think it's more the case that none of the current continuable commands 
have subcommands (though I can't think of all the continuable or 
abortable operations offhand, so maybe I'm wrong).  I think we're 
discussing new UI ground here.

And since the pattern is already "git foo --continue", it seems more 
consistent to me for it to be "git stash --continue" as well. 
Especially since there can be only one partially-complete stash 
sub-operation at one time (per workdir, at least).  So there's no reason 
to change the pattern just for the stash command.

Think of it this way:  All the currently continuable/abortable commands 
put the repository in a shaky state, where performing certain other 
operations would be ill advised.  Attempting to start a rebase while a 
merge conflict is unresolved, for example.  IIRC, git actually tries to 
stop users from shooting their feet in this way.

And so it should be for the stash operation:  If applying a stash yields 
a conflict, it has to be resolved or aborted before something like a 
rebase or merge is attempted.  It doesn't matter which stash subcommand 
created the shaky situation.

In the long run, I think there's even the possibility of generic "git 
continue" and "git abort" commands, that simply continue or abort the 
current partially-complete operation, whatever it is.  (Isn't that the 
ultimate goal of all the "sequencer" work?  I admit I have not been 
following that effort.)

> With every new feature, it is not enough to consider its benefits. You
> always have to take the potential fallout into account, too.

Agreed.

> At least `git stash pop --continue` would be consistent with all other
> `--continue` options in Git that I can think of...

Alas, I disagree!

		M.


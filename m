Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33DF31F453
	for <e@80x24.org>; Thu, 27 Sep 2018 15:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbeI0Vub (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 17:50:31 -0400
Received: from smtp66.ord1c.emailsrvr.com ([108.166.43.66]:56665 "EHLO
        smtp66.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727262AbeI0Vub (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 27 Sep 2018 17:50:31 -0400
X-Greylist: delayed 443 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Sep 2018 17:50:30 EDT
Received: from smtp25.relay.ord1c.emailsrvr.com (localhost [127.0.0.1])
        by smtp25.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id B453F204C9;
        Thu, 27 Sep 2018 11:24:21 -0400 (EDT)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp25.relay.ord1c.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 6B162204A4;
        Thu, 27 Sep 2018 11:24:21 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Thu, 27 Sep 2018 11:24:21 -0400
Subject: Wherefor worktrees?
To:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <20180923170438.23610-1-pclouds@gmail.com>
 <xmqqtvmdnuab.fsf@gitster-ct.c.googlers.com>
 <CACsJy8Bux0iiOp+zjELM4DuZwiQMA6EDaL0M71Jkp_qPACD8og@mail.gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
From:   Marc Branchaud <marcnarc@xiplink.com>
Message-ID: <e7f63c0f-90dd-0e53-9721-35d2b827e101@xiplink.com>
Date:   Thu, 27 Sep 2018 11:24:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8Bux0iiOp+zjELM4DuZwiQMA6EDaL0M71Jkp_qPACD8og@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-09-26 11:48 AM, Duy Nguyen wrote:
> 
> I believe the main selling point of multiple worktrees is sharing
> refs. You could easily avoid expensive clones with --local, but
> synchronizing between different clones is not very convenient. Other
> than that, different worktrees tend to behave like separate clones.

Sharing hooks is also useful, but yes mainly the refs.

I love being able to work in more than one branch at a time.  I often 
have a couple of ongoing big, messy topics, and being able to easily 
jump onto some release branch for a quick bugfix, without having to 
first stash things or finish an interactive rebase or fix a conflicting 
merge, is a godsend.

And the reason I use worktrees for this, instead of clones, is for the 
shared refs.  It makes sense to me that I'm working with different 
checkouts from a single repo, with all my local branches and local tags. 
  "git fetch" updates the remote refs regardless of which worktree I'm 
in when I run it.  The setup is lightweight and efficient; it's just how 
I want to work.

Having used git-new-workdir for a long time, it's main deficiency for me 
is submodules (the shared bisection state didn't bother me much).  It 
would be nice if all my worktrees' submodules also shared refs.  That's 
"nice", but not "essential".  Mainly it would be convenient if a 
recursive-submodule fetch performed in one worktree updated the 
submodule refs in my other worktrees.  Similarly, if I create a local 
branch in a submodule in one worktree, it would be nice to see that 
branch in the submodule in other worktrees.  Again, "nice", but probably 
just because I've lived with git-new-workdir's limitations for so long 
that I'm used to them.

That said, I really appreciate Duy's work here -- thanks!  Git deserves 
to have a cool feature like worktrees be part of its standard toolkit.

		M.


> This leaves a gray area where other things should be shared or not. I
> think the preference (or default mode) is still _not_ shared (*).
> Sharing more things (besides refs and object database) is just a new
> opportunity popping up when we implement multiple worktrees. Since
> multiple worktrees (or clones before its time) are grouped together,
> sometimes you would like to share common configuration. We could sort
> of achieve this already with includeIf but again not as convenient.
> 
> (*) real life is not that simple. Since refs are shared, including
> _remotes_ refs, so configuration related to remotes should also be
> shared, or it will be a maintenance nightmare. Which is why
> $GIT_DIR/config so far has been shared besides the two exceptions that
> are core.bare and core.worktree. And I really like to get rid of these
> exceptions.
> 
>> Is there a better way to achieve that without the
>> downside of multiple worktrees (e.g. configuration need to be
>> uniform)?
> 
> Is there a better way to achieve sharing refs between clones? I gave
> it a minute but couldn't come up with a good answer :(
> 
>>> (*) "git config --worktree" points back to "config" file when this
>>>      extension is not present so that it works in any setup.
>>
>> Shouldn't it barf and error out instead?
> 
> The intention is a uniform interface/api that works with both single
> and multiple worktrees configurations. Otherwise in your scripts you
> would need to write "if single worktree, do this, else do that". If
> "git config --worktree" works with both, the existing scripts can be
> audited and updated just a bit, adding "--worktree" where the config
> should not be shared, and we're done.
> 
>> A user who hasn't enabled
>> the extension uses --worktree option and misled to believe that the
>> setting affects only a single worktree, even though the change is
>> made globally---that does not sound like a great end-user experience.
> 
> I was talking about a single worktree. But I think here you meant the
> user has multiple worktrees, but the extension is not enabled. I'm
> probably not clear in the commit message, but "git config" can detect
> that the extension has not been enabled, automatically enable it (and
> move core.bare and core.worktree (if present) to the main worktree's
> private config), so "git config --worktree" will never share the
> change.
> 
> But perhaps the user should be made aware of this situation and asked
> to explicitly enable the extension instead? It's certainly a more
> conservative approach.
> 

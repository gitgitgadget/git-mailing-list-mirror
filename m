Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76B361F461
	for <e@80x24.org>; Mon, 19 Aug 2019 09:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfHSJHn (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 05:07:43 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:20596 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726211AbfHSJHn (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Aug 2019 05:07:43 -0400
X-IronPort-AV: E=Sophos;i="5.64,403,1559512800"; 
   d="scan'208";a="395728617"
Received: from dhcp-13-233.lip.ens-lyon.fr (HELO moylip) ([140.77.13.233])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES256-GCM-SHA384; 19 Aug 2019 11:07:40 +0200
From:   Matthieu Moy <Matthieu.Moy@matthieu-moy.fr>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matthieu Moy <git@matthieu-moy.fr>, git@vger.kernel.org,
        corentin.bompard@etu.univ-lyon1.fr,
        nathan.berbezier@etu.univ-lyon1.fr,
        pablo.chabanne@etu.univ-lyon1.fr
Subject: Re: [PATCH] pull, fetch: add --set-upstream option
References: <86zhoil3yw.fsf@univ-lyon1.fr>
        <20190814134629.21096-1-git@matthieu-moy.fr>
        <xmqqlfvv6417.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 19 Aug 2019 11:07:40 +0200
In-Reply-To: <xmqqlfvv6417.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 14 Aug 2019 10:38:28 -0700")
Message-ID: <86blwlcylf.fsf@matthieu-moy.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <git@matthieu-moy.fr> writes:
>
>> From: Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>
>>
>> Add the --set-upstream option to git pull/fetch
>> which lets the user set the upstream configuration
>> (branch.<current-branch-name>.merge and
>> branch.<current-branch-name>.remote) for the current branch.
>>
>> A typical use-case is:
>>
>>     git clone http://example.com/my-public-fork
>>     git remote add main http://example.com/project-main-repo
>>     git pull --set-upstream main master
>>
>> or, instead of the last line:
>>
>>     git fetch --set-upstream main master
>>     git merge # or git rebase
>>
>> This functionality is analog to push --set-upstream.
>
> I was writing a one-paragraph summary for this topic, for the
> "What's cooking" report, and here is what I have:
>
>  "git fetch" learned "--set-upstream" option to help those who first
>  clone from a forked repository they intend to push to, add the true
>  upstream via "git remote add" and then "git fetch" from it.
>
> After describing it like so, I cannot shake the feeling that the
> workflow this intends to support feels somewhat backwards and
> suboptimal.
>
>  - Unless you rely on server-side "fork" like GitHub does,

Note that these days, this is not a very restrictive statement ;-).

And when you make a fork on GitHub or GitLab from the web UI, the next
thing you see is the page of your fork with a button "clone or download"
pointing to your local copy's URL. So even though there are arguments to
clone upstream first, it's also quite natural from the UI point of view
to clone the local copy, and add upstream when needed.

>    you would first clone from the upstream, and then push to your
>    "fork". The flow whose first step is to clone from your "fork", not
>    from the true upstream, feels backwards (cloning from upstream then
>    adding your fork as a secondary may be more natural, without need for
>    the complexity of --set-upstream to pull/fetch/push, no?).

To me, it depends on the involvement in the project. If I plan to send
several contributions to a project, I'd usually clone the upstream and
add my fork. But I also often do:

- Find a project on GitHub/GitLab/...
- Think about a minor contribution I can make
- Fork from the web UI
- clone my fork
- code, commit, push
- make a PR

Only if my PR takes time to get accepted, I'll add upstream as a remote
and pull from there to rebase my PR.

>  - The second step adds the true upstream using "git remote", and at
>    that point, in your mind you are quite clear that you want to
>    pull from there (and push to your own fork).  Not having the "I
>    am adding this new remote; from now on, it is my upstream"

Note that you can also group "remote add" and "pull" by saying just

  git pull --set-upstream http://example.com/project-main-repo master

(I still tend to prefer the "remote add" + "pull" flow to name the
remote, though).

>    feature at this step, and instead having to say that with your
>    first "git pull", feels backwards.  If this feature were instead
>    added to "git remote", then the last step in your example does
>    not even have to say "main" (and no need for this new option),
>    does it?

There's already "git remote add --track <branch> <remote> <url>", but it
does something different: it does not set the upstream information but
only sets the glob refspec to fetch only one branch from the remote.

We could add a new option like

  git remote --set-upstream <branch> <remote> <url>

That would do

  git remote add <remote> <url>
  git branch --set-upstream-to=<branch>

That wouldn't make the commands really easier to type IMHO, as you would
still have to pull at some point, so it's:

  git remote add main http://example.com/project-main-repo
  git pull --set-upstream main master
  
Vs

  git remote add --set-upstream master main http://example.com/project-main-repo
  git pull

The second is a bit shorter (saves the second instance of "master"), but
I tend to prefer the first to avoid the overly long "git remote add"
command.

Also, if one has several local branches, one may run just one "git
remote add" and several "git pull --set-upstream".

Note that there are other possible use-cases, like "upstream was using a
flow where 'master' was the main branch, but now commits to 'develop'
branch and only merges to 'master' for releases", where you can just

  git pull --set-upstream origin develop

Actually, since "--set-upstream" means "next time, *pull* from this
branch", it felt weird to have it in "git *push*" and not in "git pull".
Certainly, not having "git pull --set-upstream" it "git pull" wasn't
that much bothering (otherwise, someone would have implemented it long
ago), but I still find it a nice-to-have shortcut.

Cheers,

-- 
Matthieu Moy
https://matthieu-moy.fr/

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D48C4332F
	for <git@archiver.kernel.org>; Wed, 21 Dec 2022 00:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbiLUARd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 19:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbiLUARV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 19:17:21 -0500
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5915201AB
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 16:17:16 -0800 (PST)
Date:   Wed, 21 Dec 2022 00:17:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1671581834; x=1671841034;
        bh=/df7jqOfiPcy5vB5PkcuYRSUSH0HtKtwe9zL4HDAxk8=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=BNdOP3F6N4RUiICgbAAPuTwhLU+ZIw249sZKh/fqamX5WoVlMvlfYruOWnH6MGtPe
         9qp9Hm1Sv6DF9rImS/Odg9P225o7L/pEyulozrZVv4ovoHLactJYjcSWrwcTwYSGr1
         e5ok+1/qIdtCKimGxd0bSQ7J/x3imwW+tayJOchaVsXu56UNikvnuOdfOrEDww6UTI
         znFPYCYkKKulBR3FLTPhcFsTjPpzUQT5RQQ9lEImUaixKC9SXNIjFucO0GY7Fv62D6
         LqCLGO/2LllAkQGIHiQX8Vmn0MxDabLE4ZRl4LYItUGyI3JsXH8EIgHwhgDI6NEYOp
         o1N4ankG3do/A==
To:     Junio C Hamano <gitster@pobox.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v5 3/4] worktree add: add --orphan flag
Message-ID: <20221221001658.4yd34zyl3yavrjhq@phi>
In-Reply-To: <xmqqlen2wvtn.fsf@gitster.g>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev> <20221110233137.10414-1-jacobabel@nullpo.dev> <20221212014003.20290-1-jacobabel@nullpo.dev> <20221220023637.29042-1-jacobabel@nullpo.dev> <20221220023637.29042-4-jacobabel@nullpo.dev> <xmqqlen2wvtn.fsf@gitster.g>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/12/20 01:19PM, Junio C Hamano wrote:
> Jacob Abel <jacobabel@nullpo.dev> writes:
>
> > Adds support for creating an orphan branch when adding a new worktree.
> > This functionality is equivalent to git switch's --orphan flag.
> >
> > The original reason this feature was implemented was to allow a user
> > to initialise a new repository using solely the worktree oriented
> > workflow.
> >
> > Current Behavior:
> >
> > % git init --bare foo.git
> > Initialized empty Git repository in /path/to/foo.git/
> > % git -C foo.git worktree add main/
> > Preparing worktree (new branch 'main')
> > fatal: not a valid object name: 'HEAD'
> > %
> >
> > New Behavior:
> >
> > % git init --bare foo.git
> > Initialized empty Git repository in /path/to/foo.git/
> > % git -C foo.git worktree add --orphan main main/
> > Preparing worktree (new branch 'main')
> > %
>
> Hmph, I suspect that in reviews for the previous rounds someboddy
> must have brought this up, but I wonder if we can detect the case
> automatically and behave as if "--orphan" were given.  In other
> words, shouldn't the desired outcome (i.e. "worktree add" can be run
> to create an orphan branch even when the original were on an unborn
> branch) become the new behaviour WITHOUT having the user learn new
> option?

Yes. Other reviewers have suggested trying to DWYM with the `--orphan` beha=
vior.
I have been hesitant to add that functionality as in my opinion it can lead=
 to
confusing behavior. This is largely because in many cases, where we could w=
ant
`--orphan` to DWYM would overlap with a user making a mistake with the more
common uses of `git worktree add`.

I'm not opposed to adding this DWYM behavior in another patch but I think i=
t
might be worth waiting to do so. I'm looking at working on another patchset
after this one which would better illustrate what decisions `git worktree a=
dd`
makes when it tries to DWYM. In my opinion, after that patchset would proba=
bly
be the best time to try and integrate `--orphan` behavior into DWYM.

>
> If the point of "--orphan" is to create a worktree that checks out a
> yet-to-be-bork branch, whether the original is an empty repository
> or a populated one, then the user may need "--orphan" option, but
> the above illustration is very misleading if that is the intention.
>
> Rather, you should start from a populated repository and explain
> that "worktree add" without "--orphan" (i.e. the current behaviour)
> does not give you an empty tree with empty history, so run an extra
> "switch --orphan" after that.  Then illustrate that you can lose the
> last step with the new option "--orphan".
>
> Or something like that.

Understood. I've updated the commit message.

>
> > Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
> > Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
>
> This e-mail coming from you and not from =C3=86var, with you apparently
> being the author of the patch, makes these two S-o-b lines
> questionable.  What's the chain of custody of the change?  If =C3=86var
> showed some code changes, and you swallowed that into a larger piece
> of work (i.e. this patch), then the above two lines are swapped.
>

Ah, yes. They provided a fairly substantial fixup patch against this patch
during an earlier revision[1]. I integrated it into 3/4 and added that S-o-=
b as
requested here[2].

I've swapped the S-o-b lines in the commit message.

The diff on the commit message is below. Apologies about the formatting. I
wasn't sure how to get the commit text diff with `git diff` so I used norma=
l
`diff` instead.

--- 3-of-4-v5   2022-12-20 18:49:43.007548775 -0500
+++ 3-of-4-v6   2022-12-20 19:14:38.296292361 -0500
@@ -1,28 +1,48 @@
 worktree add: add --orphan flag

 Adds support for creating an orphan branch when adding a new worktree.
 This functionality is equivalent to git switch's --orphan flag.

 The original reason this feature was implemented was to allow a user
 to initialise a new repository using solely the worktree oriented
 workflow.

 Current Behavior:
-
-% git init --bare foo.git
-Initialized empty Git repository in /path/to/foo.git/
+% git -C foo.git --no-pager branch -l
++ main
 % git -C foo.git worktree add main/
 Preparing worktree (new branch 'main')
+HEAD is now at 6c93a75 a commit
+%
+
+% git init bar.git
+Initialized empty Git repository in /path/to/bar.git/
+% git -C bar.git --no-pager branch -l
+
+% git -C bar.git worktree add main/
+Preparing worktree (new branch 'main')
 fatal: not a valid object name: 'HEAD'
 %

 New Behavior:

-% git init --bare foo.git
-Initialized empty Git repository in /path/to/foo.git/
-% git -C foo.git worktree add --orphan main main/
+% git -C foo.git --no-pager branch -l
++ main
+% git -C foo.git worktree add main/
+Preparing worktree (new branch 'main')
+HEAD is now at 6c93a75 a commit
+%
+
+% git init --bare bar.git
+Initialized empty Git repository in /path/to/bar.git/
+% git -C bar.git --no-pager branch -l
+
+% git -C bar.git worktree add main/
+Preparing worktree (new branch 'main')
+fatal: invalid reference: HEAD
+% git -C bar.git worktree add --orphan main main/
 Preparing worktree (new branch 'main')
 %

-Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
 Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
+Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>

1. https://lore.kernel.org/git/221115.86edu3kfqz.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/221119.861qpzf9ey.gmgdl@evledraar.gmail.com/


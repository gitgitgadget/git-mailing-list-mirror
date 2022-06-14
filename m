Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96F4C433EF
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 05:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237038AbiFNFNq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 01:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiFNFNo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 01:13:44 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB8617E24
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 22:13:43 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id u12so14903976eja.8
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 22:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UmmbKPuDDlecYObsowBs8U5R5SbqgbB10OMeZtjZcMc=;
        b=WVpAuL5cL9sYRgrKh8NykUeZU8FBU9pYgdkmqOG5SF8AI07dAPmMZ8FtJ5ukVqCxqQ
         UUx5JCVPT8n/lnvhJn7X6xXDq4/Ljj3SQR6BYTPGswlRQDEv+adGaLKT1zBgAVHtSIEv
         OXMFV1ZE+Qi1B1JGc3N5U3Y8xa/MQM9dFPpCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UmmbKPuDDlecYObsowBs8U5R5SbqgbB10OMeZtjZcMc=;
        b=m/rR0giAOXyJ0qwOV0U1PyWUspTaws2qaeH93OTWLAhItD+9AuBoPaqxGj3Wr/cUlH
         XirHTgPQ72Av/k+7drukYYEer61JYMvGrQvBMm/ut31Ftyy2FFvnPn84/jtveLMGCtVi
         Sh45cjXklP+O9EvocHAOVdBQVm/XnTH7uDvUuL80aemo1Ena7g9ljSpLjdN1pioDNt0l
         Tmr3MtJ5sJyA9kVHDy+DS+wrldi++5NayarwHGpeuFtoNa03hycqtyeYTQ+GSF5XmCZ+
         0Me3RIiXWMMODR0OOjRoL2/1wV6aCiHW8UuagX47bZIa6CrV/k1c9H+TN5TdL6a+emJU
         yStA==
X-Gm-Message-State: AJIora+oT8OT4kVtzcXWrNDFcIBpSoOWKkUZZO7xq2vmUtcJ63/Blttx
        YZzDr3xeaW2UG1nugBZb4p7ZdxZVpkuB04cHgCPSikIzDlmwe4Ie
X-Google-Smtp-Source: ABdhPJx85eIZ4pgEvaVh8sqKn5t2af0XyEvF2O93FW9nqHpnti9ytYRFM5Mko1BOW0vTLTB2VXTtd7Q8IPrqBG5mhQc=
X-Received: by 2002:a17:906:2b5a:b0:707:ce7b:94eb with SMTP id
 b26-20020a1709062b5a00b00707ce7b94ebmr2558783ejg.335.1655183621959; Mon, 13
 Jun 2022 22:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1257.git.1654967038802.gitgitgadget@gmail.com> <xmqqleu3au2n.fsf@gitster.g>
In-Reply-To: <xmqqleu3au2n.fsf@gitster.g>
From:   Tao Klerks <tao@klerks.biz>
Date:   Tue, 14 Jun 2022 07:13:31 +0200
Message-ID: <CAPMMpojdnAMnczJAevqL8GSOb8gvddcSiYfbz0c51oPpn4U0wA@mail.gmail.com>
Subject: Re: [PATCH] apply: support case-only renames in case-insensitive filesystems
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 11, 2022 at 9:17 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Tao Klerks <tao@klerks.biz>
> >
> > "git apply" checks, when validating a patch, to ensure that any files
> > being added aren't already in the worktree.
> >
> > When this check runs on a case-only rename, in a case-insensitive
> > filesystem, this leads to a false positive - the command fails with an
> > error like:
> > error: File1: already exists in working directory
> >
> > Fix this existence check to allow the file to exist, for a case-only
> > rename when config core.ignorecase is set.
>
> Hmph, close, but the patch as-posted may be fatally buggy, I think.
>

Yes indeed, very much so.

> At the beginning of the function there is this block:
>
>         const char *old_name =3D patch->old_name;
>         const char *new_name =3D patch->new_name;
>         const char *name =3D old_name ? old_name : new_name;
>
> which makes us realize that old_name CAN legitimately be NULL.  That
> is true for a creation patch.  new_name can also be NULL for a
> deletion patch.
>

Yep, I was aware of the nulls, but I was unaware that passing nulls
into "strcasecmp()" was a bad thing to do. I just assumed a non-zero
comparison result would ensue.

> >       if ((tpatch =3D in_fn_table(state, new_name)) &&
> >           (was_deleted(tpatch) || to_be_deleted(tpatch)))
> >               ok_if_exists =3D 1;
> > +     else if (ignore_case && !strcasecmp(old_name, new_name))
> > +             ok_if_exists =3D 1;
>
> You'd get a segfault when the patch is creating a file at new_name,
> or deleting a file at old_name, wouldn't you?
>

Indeed you do (when ignorecase is true of course).

> We need a new test or two to see if a straight creation or deletion
> patch does work correctly with icase set, before we even dream of
> handling rename patches.  Not having tests for such basic cases is
> quite surprising, but apparently the above line passed the CI.
>

This is where I made some very bad assumptions: I only manually ran
the new "t4141-apply-case-insensitive-rename.sh" test, and assumed
that the test suite ran against linux, windows, and OSX, with the
latter two running on case-insensitive filesystems. I assumed that
both case-sensitive and case-insensitive code paths would be tested by
the complete CI suite.

The OSX tests were not running for me at all in GitGitGadget (seems to
be an ongoing struggle), but I assumed that everything was still
tested in case-insensitive mode because of the windows suite. It looks
like that was wrong, although I still don=C2=B4t know how/why.

Had I run "t4114-apply-typechange.sh" (or probably some others in the
41XX range) on the OSX environment where I happen to have developed
this weekend, I would have seen the failures immediately.

> >       else
> >               ok_if_exists =3D 0;
>
> Having said that, I wonder what the existing check before the new
> condition is doing?  Especially, what is in_fn_table() for and how
> does it try to do its work?
>
> Reading the big comment before it, it seems that it tries to deal
> with tricky delete/create case already.  With a typechange patch
> that first removes a regular file "hello.txt" and then creates a
> symbolic link "hello.txt" is exempted from the "what you are
> creating should not exist already" rule by using in_fn_table()
> check.  If it tries to create a symlink "Hello.txt" instead,
> shouldn't we allow it the same way on case-insensitive systems?  I
> do not think in_fn_table() pays attention to "ignore_case" option,
> so there may be an existing bug there already, regardless of the
> problem you are trying to address with your patch.
>
> And I wonder if doing case-insensitive match in in_fn_table() lets
> us cover this new case as well as "fixing" the existing issue.
>

Yep, I confirmed that as you expect, it does fix the issue I set out
to fix, and as you noted also fixes other (slightly more obscure?)
existing issues with "git apply" on case-insensitive filesystems.

This time I tested all of t41XX on a case-insensitive system, and the
CI process ran in GitLab, presumably on case-sensitive filesystems
only.

I'm not sure what more to look out for, and will note as much in the
patch v2 comments.

> In any case, here are such two tests to make sure creation and
> deletion patches on icase systems are not broken by careless
> mistakes like the one in this patch.

I have a question related to this:

*Do* we expect to run the full test suite on case-insensitive systems
in gitlab, or do we expect to need to add explicit "-C
core.ignorecase" tests as you have done here? The latter seems risky
both because the behavior is not representatively tested (because it's
still actually running in a case-sensitive filesystem), and because
it's hard to predict all the things that should be explicitly retested
in this way.

I don't think these specific tests were necessary, and I guess they
are replaced by later ones in this thread, so I will ignore this bit
specifically.

Thanks for the careful review, my apologies for the careless patch.

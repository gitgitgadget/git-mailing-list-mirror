Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F5FC433EF
	for <git@archiver.kernel.org>; Sat,  5 Feb 2022 07:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379162AbiBEHRt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Feb 2022 02:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiBEHRt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Feb 2022 02:17:49 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2F6C061346
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 23:17:46 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id j14so11676325lja.3
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 23:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2titlv46GjTRofF0zvZlnEZ+pe5LXfidC0WG2lsjREU=;
        b=dDRTiIly+eJazuQF5YuRMnBP7BqJMRHD6WiWZ2FZaswXBl1MU2SSxhxnZJydeKnCt2
         Cjy5MattcIn8JLwTm6ysWFR2LHroctlIx4LMIlFuXsj/PT5ty92u+9yZji05Pa/ReuAw
         +UcjYZOQgKj5Y4qGGL9wdvkYfnxUaWUBbQhU6TLTJfr3z1nwJRvcGlvZOoCV5mNf6ct2
         aWVbqaSn4Oj35ik7qjJ67RGAbzEeai4j0We9UKbw7LQUfgXkBKA5STXVIZqZFBekriEV
         FiUX8qIXdsKy8MxzaBhI8xAloVgINvZeF8S8LbJBdaW7mmdHEyrKnS4DcuelwAyWRvhq
         SONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2titlv46GjTRofF0zvZlnEZ+pe5LXfidC0WG2lsjREU=;
        b=iklushi1lyzp8LGFZmzSLIwooHDneTNJ/yEJH8xEGsDQo3e5iZ3JXqGfDbx+fc99DC
         uIv3+nBgbsQghATccBX5dAn8DAB+0x3o4Boq/4ZdH1vAqAKE1BSpuBLcZW56W6kSfarN
         nanP1S1qu9odVQ29iIIwaUCtEqITFvAq9Ck86MbRDUVA0uCKSbSSu7JXLJFVZSkHx3R4
         zGml3Bgli8MaAMKqF4d5aX+ZTVzL500FeCwCej0qmdNc/CA8DeUeoofUc9TSMXZ2Towf
         fLOC9JrxDS8MMIq6oLzbBoNZCNwIagMJtKLneSZ0ZwnhONmxKTk2RcSUIKAmipgOS4on
         Qq3A==
X-Gm-Message-State: AOAM530DCQdJbYOUi2N0ifyAaYm/jisKacCsjSXJQgi6I9xl0UrFcqyx
        AXVlv+F0pnxsvnHpl2bfUPtwGb3p3R2DVcIsaGE=
X-Google-Smtp-Source: ABdhPJzmdnlZpL8S3Isdd53S92YzjdlqQMs3qfDo4gXkIrabg/zb3AUOBu2Vtv8+T2aZadwnFkBeoqca21dEAUaq3h4=
X-Received: by 2002:a2e:8648:: with SMTP id i8mr1795549ljj.335.1644045464405;
 Fri, 04 Feb 2022 23:17:44 -0800 (PST)
MIME-Version: 1.0
References: <pull.1124.git.1642987616372.gitgitgadget@gmail.com>
 <20220129063538.24038-1-bojun.cbj@gmail.com> <xmqqczk6b3pt.fsf@gitster.g>
In-Reply-To: <xmqqczk6b3pt.fsf@gitster.g>
From:   Bojun Chen <bojun.cbj@gmail.com>
Date:   Sat, 5 Feb 2022 15:17:32 +0800
Message-ID: <CADuS7AoAbtbC3RKrXR=SGvfs7C-n57Y9zkaGne_XrfyJh46zXg@mail.gmail.com>
Subject: Re: [PATCH v2] receive-pack: purge temporary data if no command is
 ready to run
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Chen Bojun <bojun.cbj@alibaba-inc.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Teng Long <dyroneteng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2022=E5=B9=B42=E6=9C=882=E6=97=
=A5=E5=91=A8=E4=B8=89 06:51=E5=86=99=E9=81=93=EF=BC=9A
>
> Chen BoJun <bojun.cbj@gmail.com> writes:
>
> > From: Chen Bojun <bojun.cbj@alibaba-inc.com>
> >
> > When pushing a hidden ref, e.g.:
> >
> >     $ git push origin HEAD:refs/hidden/foo
> >
> > "receive-pack" will reject our request with an error message like this:
> >
> >     ! [remote rejected] HEAD -> refs/hidden/foo (deny updating a hidden=
 ref)
> >
> > The remote side ("git-receive-pack") will not create the hidden ref as
> > expected, but the pack file sent by "git-send-pack" is left inside the
> > remote repository. I.e. the quarantine directory is not purged as it
> > should be.
>
> I was puzzled by the reference to "pushing a hidden ref" at the
> beginning of the proposed log message, as it wasn't quite clear that
> it was merely an easy-to-reproduce recipe to fall into such a
> situation where all ref updates are rejected.
>

Thanks for the suggestion. Do I have to rewrite this commit message on the =
v3?

> But the code change makes the function leave before the object
> migration out of the quarantine when no ref updates are done for any
> reason, andit makes perfect sense.  The title reflects it very well.
>
> > Add a checkpoint before calling "tmp_objdir_migrate()" and after callin=
g
> > the "pre-receive" hook to purge that temporary data in the quarantine
> > area when there is no command ready to run.
>
> OK.
>
> I wondered how this should interact with the "proc_receive_ref"
> stuff, but existing code makes proc_receive_ref ignored when
> pre-receive rejects, so doing the same would be OK.
>
> > index 9f4a0b816c..a0b193ab3f 100644
> > --- a/builtin/receive-pack.c
> > +++ b/builtin/receive-pack.c
> > @@ -1971,6 +1971,15 @@ static void execute_commands(struct command *com=
mands,
> >               return;
> >       }
>
> With the new logic, "return;" we see above becomes unnecessary.  I
> wonder if it is a good idea to keep it or remove it.
>
> > +     /*
> > +      * If there is no command ready to run, should return directly to=
 destroy
> > +      * temporary data in the quarantine area.
> > +      */
> > +     for (cmd =3D commands; cmd && cmd->error_string; cmd =3D cmd->nex=
t)
> > +             ; /* nothing */
> > +     if (!cmd)
> > +             return;
> > +
> >       /*
> >        * Now we'll start writing out refs, which means the objects need
> >        * to be in their final positions so that other processes can see=
 them.
> > diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> > index 2f04cf9a1c..da70c45857 100755
> > --- a/t/t5516-fetch-push.sh
> > +++ b/t/t5516-fetch-push.sh
> > @@ -1809,4 +1809,12 @@ test_expect_success 'refuse fetch to current bra=
nch of bare repository worktree'
> >       git -C bare.git fetch -u .. HEAD:wt
> >  '
> >
> > +test_expect_success 'refuse to push a hidden ref, and make sure do not=
 pollute the repository' '
> > +     mk_empty testrepo &&
> > +     git -C testrepo config receive.hiderefs refs/hidden &&
> > +     git -C testrepo config receive.unpackLimit 1 &&
> > +     test_must_fail git push testrepo HEAD:refs/hidden/foo &&
> > +     test_dir_is_empty testrepo/.git/objects/pack
> > +'
> > +
> >  test_done

Thanks for your thorough comments. It's really helpful.

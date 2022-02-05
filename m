Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAE2C433EF
	for <git@archiver.kernel.org>; Sat,  5 Feb 2022 07:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379401AbiBEHTi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Feb 2022 02:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiBEHTh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Feb 2022 02:19:37 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01ECDC061346
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 23:19:34 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id z7so11659449ljj.4
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 23:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GUjbe/eWcEFL+kLVZGgDfYDD1eC/U4Vs65br7ABXeoE=;
        b=bGW5KvrpqXf1DC702DUix4rUxZDDb6W7D9n7c9TAXYBAvqhdk6mI/IEAD9RLmXEp6T
         K44tAlqNIlO6PT6yvC0u1+QSxbDPhI9PtFePHeJJoIvuJUNK7nO8UFXtniI6SfaafxAO
         JJm/Gtd07SCIQbYVph5unBgf/8eSRQbyEAdAVd12+Kz+D/T0RAMZa5asKGjUqW2E3MQl
         NgR0FMYgMVa08arKhFRwu1FfL3eHq5r3womgmDZIa9LkCnoMg9l6CO3oOYftKSTDoLsM
         jOVnuna8F9UBeT3bAUCssLRP+Ip5hvGJfbqyJwfGMOwtBav+Yb4TxLK0uASjzRisdOXa
         1r3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GUjbe/eWcEFL+kLVZGgDfYDD1eC/U4Vs65br7ABXeoE=;
        b=v5XAL7E7Qi78ojuA2HKihj+pXWy8Eokr3ME9onwN4d/WG+KvB1+uHZcuxDPo6uKRwI
         JF0UYUtZVmkSAstkTb7m1WPsFj+kD8FpkADv2p7SHuOB+ATKrE7XvDJChKmmaRhw+Qw3
         QS1wM2Gj0mSXNbMyVPtBry8LpJWEnpGyQQmT73jbGhIFCFXUM0w8JP/Wfh5XLdZ0CTwD
         HITWKSKyt5GMk8YCL+W1bq7+C3PNMNiDvAK3nEDYs7S7FQITnX7sIUmp/QzD5FO2UeJE
         8b99UKEB4Z6VEHELzzb+VONYi3Et9BFb3Hxx+k2grCCzdKI2TrbXAvKZYYkJQWrG3Bkr
         2vRA==
X-Gm-Message-State: AOAM530KeP9+oH3rjroJPvKBbO8sq8Nhd1zsffPD+Pao+HT+i+cE1qGs
        9ysEwrXO2NIXSXgnuLb9i4DUHgQmKaNyi69TQZA=
X-Google-Smtp-Source: ABdhPJx09Br6/pMA0UPoC/gVqh0PwCV9UGOra4uDj+KPwvvGhGk/6bnPrGpORxvErADC/R/U1mmg3ugRMuENNHfs+u0=
X-Received: by 2002:a05:651c:1213:: with SMTP id i19mr1772160lja.116.1644045573356;
 Fri, 04 Feb 2022 23:19:33 -0800 (PST)
MIME-Version: 1.0
References: <pull.1124.git.1642987616372.gitgitgadget@gmail.com>
 <20220129063538.24038-1-bojun.cbj@gmail.com> <xmqq5ypvpgzr.fsf@gitster.g>
In-Reply-To: <xmqq5ypvpgzr.fsf@gitster.g>
From:   Bojun Chen <bojun.cbj@gmail.com>
Date:   Sat, 5 Feb 2022 15:19:22 +0800
Message-ID: <CADuS7Apcr0r6F1UQf1WKmVuW+SM_wD1MBPA9Szvd1pF9zJjsUw@mail.gmail.com>
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

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2022=E5=B9=B42=E6=9C=884=E6=97=
=A5=E5=91=A8=E4=BA=94 09:17=E5=86=99=E9=81=93=EF=BC=9A
>
> Chen BoJun <bojun.cbj@gmail.com> writes:
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
>
> One thing I notice is that the first thing we do, after making the
> new objects available to us, is to check if we are making any
> conflicting update, e.g.
>
>     git push origin master:master next:master
>
> would try to update the same ref with different objects, and will be
> rejected.
>
> This check can _almost_ be doable without being able to access the
> new objects, and as a follow-on work, it might not be a bad little
> project to see how we can move the call to check_aliased_updates()
> before this loop we are adding in this patch (#leftoverbits).
>
> Thanks.

Thanks for your suggestion, I agree with you. But I'm confused should
I continue in this patch or start a new patch.

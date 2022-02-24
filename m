Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CF5C433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 18:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbiBXSOO convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 24 Feb 2022 13:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbiBXSON (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 13:14:13 -0500
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A18225580
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 10:13:42 -0800 (PST)
Received: by mail-pj1-f52.google.com with SMTP id gb21so2685213pjb.5
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 10:13:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Oe3jP0j/3MmXvWgWlpP4eSOV8UhiI7KB8G/u64N5kxA=;
        b=BcaqTM8W931PpELLvVjIpVC966fbBzCyFjqMpltdepbNWxUEGXrZ3ukwGgXZbnwu+k
         1PGRpPL6u5Y9l/LZOpvF5WWdEkMCFmy2z5tR1BNezPgjSorcdMWSA61opBs0EijbR4Ij
         w2GP8pTv8UUSYthLQVOxnY37Py/w3+47oPQ+5ebGS7u5nmpICq7sosoMdCBiX/DyZOMf
         chFaluHwKFx0yvzmsqZMZ8IsEejozgabBLwlKFw+WtRY/qS6oVx7zVSjuDj4EZJbtJMw
         /2mD/SayTvDhycnnG6JQOo67J7xl7mpXTRBtjRWzgpWGl+hAU6tJeVmrxICs0XbAf2lN
         mHbQ==
X-Gm-Message-State: AOAM533byv21cGJkhCJ9jBm5zyHDM/73AgvjXBhTRUlspfT8upRwDEKV
        YB6D9j9CwgVhGH+8Zl8/4Y396H4nDHg9PDKLl1Q=
X-Google-Smtp-Source: ABdhPJx0OLrlv0YgpAVsBXhaGP6SYzGBvyWjflAEigCiOFSQSJskuYSSbf36MJh8xAfYMRuH09NZCW5vfqcZvnoZUOg=
X-Received: by 2002:a17:90a:d190:b0:1bc:b44c:7933 with SMTP id
 fu16-20020a17090ad19000b001bcb44c7933mr3996862pjb.104.1645726422235; Thu, 24
 Feb 2022 10:13:42 -0800 (PST)
MIME-Version: 1.0
References: <20220215172318.73533-1-chooglen@google.com> <20220224100842.95827-1-chooglen@google.com>
 <20220224100842.95827-3-chooglen@google.com> <220224.8635k8a36n.gmgdl@evledraar.gmail.com>
 <kl6lpmnc44wu.fsf@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <kl6lpmnc44wu.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 24 Feb 2022 13:13:31 -0500
Message-ID: <CAPig+cS3F8=dncj0rPeSWUibm2=4_L2VonCtPYUQ2V36OpUOPw@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] t5526: stop asserting on stderr literally
To:     Glen Choo <chooglen@google.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 24, 2022 at 11:46 AM Glen Choo <chooglen@google.com> wrote:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> > On Thu, Feb 24 2022, Glen Choo wrote:
> >> +    sed -E 's/[0-9a-f]+\.\./OLD_HEAD\.\./' $ACTUAL_ERR >actual.err.cmp &&
> >
> > I think this is unportable per check-non-portable-shell.pl:
> >
> >         /\bsed\s+-[^efn]\s+/ and err 'sed option not portable (use only -n, -e, -f)';
>
> I used that because I wanted +, but I found what I needed from the sed
> manpage i.e. that + is equivalent to \{1,\}).

This isn't necessarily going to be portable either for older sed
implementations. Most portable would be:

    [0-9a-f][0-9a-f]*

(Whether or not we need to worry about those older sed impmenetations
is a different question...)

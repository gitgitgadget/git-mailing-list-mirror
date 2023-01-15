Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F044FC46467
	for <git@archiver.kernel.org>; Sun, 15 Jan 2023 21:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjAOVLI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Jan 2023 16:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjAOVLC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2023 16:11:02 -0500
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA4D5581
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 13:11:01 -0800 (PST)
Received: by mail-pj1-f44.google.com with SMTP id bj3so24087485pjb.0
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 13:11:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/huAnoDEMeTCEuuN1eknqMKLH5SN0LSR43LDcxDzHYc=;
        b=bnmavVHbufFuwOShuVvGvIRNP6Q+qASY5jzdfKkhlH2j4AGL18TPC4QEhteT/EeKA0
         i5/04vjItW6zugC5VahS3JjRvNttO55zOYer7+prQ8SMC8F6IRV/nUG1u5/u6R7mGS3u
         enEEyYxY7COrwOdWL1GzY1ibAG7Q6iKwhJBiUg4IXKfc8b4PnyjvXiI+YqOIRgy4GrCO
         s+soAvKgbEy8YTuROkpmTnHj2p4KeBteGIquz5kwDV2vkYupSDcMg4rBCOb+yImL6b2u
         D6Wi1wwpV1Xz4nVDfKZ6OsQhDZO0Wohfh9KDIvf6ox8YeKhfumGKAnPmVqPHx+vWK3G7
         eMaQ==
X-Gm-Message-State: AFqh2kr7Rd62UF8L5rDfUg0BGfNBSs2w8hMGGH/BxeEFVDegzPqaxlpA
        16pDmKgc8TV4U1ih6NY1eGBr3l/9v2EM8N62dno=
X-Google-Smtp-Source: AMrXdXuysEJbBH9BSl3qKh81bdV1VhDZFJvAMlRCmzkoLpkYIvs5dQFXOSEDAUTjoVAVfaJLxAyW6VVh0BXnAb5oLvM=
X-Received: by 2002:a17:90a:9b8c:b0:227:22a6:eff0 with SMTP id
 g12-20020a17090a9b8c00b0022722a6eff0mr2241667pjp.64.1673817061383; Sun, 15
 Jan 2023 13:11:01 -0800 (PST)
MIME-Version: 1.0
References: <cover.1673490953.git.dyroneteng@gmail.com> <7b756b4c605e148f6938fee74882091661382173.1673490953.git.dyroneteng@gmail.com>
 <CAPig+cR5s3XzmY+L_jDW2g_PEgi5E791x0GuV+VPkxFA_6sB7A@mail.gmail.com>
In-Reply-To: <CAPig+cR5s3XzmY+L_jDW2g_PEgi5E791x0GuV+VPkxFA_6sB7A@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 15 Jan 2023 16:10:50 -0500
Message-ID: <CAPig+cTZ4af4YyuyogdKqMwGxyNanKejLX4Fw8Nar83gQ==WuA@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] notes.c: drop unreachable code in 'append_edit()'
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 15, 2023 at 3:59 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Jan 11, 2023 at 9:48 PM Teng Long <dyroneteng@gmail.com> wrote:
> > -       } else {
> > -               fprintf(stderr, _("Removing note for object %s\n"),
> > -                       oid_to_hex(&object));
> > -               remove_note(t, object.hash);
> > -               logmsg = xstrfmt("Notes removed by 'git notes %s'", argv[0]);
> > +               commit_notes(the_repository, t, logmsg);
> >         }
> > -       commit_notes(the_repository, t, logmsg);
>
> This change breaks removal of notes using "git notes edit". Prior to
> this change, if you delete the content of a note using "git notes
> edit", then the note is removed. Following this change, the note
> remains, which contradicts documented[1] behavior.

Aside from suggesting that this patch ought to be dropped, implicit in
the above comment is that test coverage is not as thorough as it
should be, otherwise this regression would have been caught early.
This suggests that the test coverage, at least for "git notes edit",
needs some beefing up, though doing so is probably outside the scope
of this series; it's something which could/should be done separately,
and it doesn't necessarily need to be done by you.

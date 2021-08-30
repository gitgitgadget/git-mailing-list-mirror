Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C9DC4320A
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 17:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C25460240
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 17:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238232AbhH3RmK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 13:42:10 -0400
Received: from mail-ej1-f53.google.com ([209.85.218.53]:34515 "EHLO
        mail-ej1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238161AbhH3RmJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 13:42:09 -0400
Received: by mail-ej1-f53.google.com with SMTP id u3so32756522ejz.1
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 10:41:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OLt29Z6UM6/Zf23Wiwyl2dHP9Xx6PJ7Kru6j8szoF2M=;
        b=YqIxfuCksItpKJp27BYqq0wDCfc2p6CIfmDH/UXPCfPTGJEfAn7JHmubVEJyweoBIz
         HQIykCnHUCmPX2nrcTKPavPdTB2Zk/zEt+4pKhyLX//Iefibpv3/BYV94W0qRBUITVtc
         l82tiKT5zHIMWRlnSlPEiZwIjX8fESWJ6o8o3ldMUaZXjKQ53z5zXWXigqVuhp1PPA6z
         G9+tKndTgqYmhBvfjJDDIzb97E55qaFUwQv29rclWANabkJNards9R4g8BK6IxR44Q7O
         iiLv8dbxCnx0zA51P9PupTRsVtjCY8Aq75wCX1AI+P7J+YQI25v0mi613kZvpaz3ELtP
         pSPA==
X-Gm-Message-State: AOAM530WE5+zdRzzC+HSyASR3Wuhp8eZcTaxEPKmB/LaTOieppn7ExDE
        qdGtrBOhXn3UHZnK2fh0CkFCcrY+8ueNrahtWQk=
X-Google-Smtp-Source: ABdhPJzPWcOBo/mkX46h/snZ7O42xA2v9wo7NyZDgM3PQNXlBSulfpRV1utfL0U1Ec0xHgUZg1QLK9im6EhCyU8hi9A=
X-Received: by 2002:a17:906:6808:: with SMTP id k8mr26833742ejr.138.1630345274930;
 Mon, 30 Aug 2021 10:41:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210830072118.91921-1-sunshine@sunshineco.com>
 <20210830072118.91921-4-sunshine@sunshineco.com> <xmqqwno2505w.fsf@gitster.g>
In-Reply-To: <xmqqwno2505w.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 30 Aug 2021 13:41:03 -0400
Message-ID: <CAPig+cQ6FA0rUnkkTDRUD5vAD3cDXW9vtR1oX0pUJK5eJB9CHg@mail.gmail.com>
Subject: Re: [PATCH 3/3] notes: don't indent empty lines
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 30, 2021 at 1:10 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > Like other Git commands, `git notes` takes care to call `stripspace` on
> > the user-supplied note content, thereby ensuring that it has no trailing
> > whitespace, among other cleanups. However, when notes are inserted into
> > a patch via `git format-patch --notes`, all lines of the note are
> > indented unconditionally, including empty lines, which leaves trailing
> > whitespace on lines which previously were empty, thus negating the
> > normalization done earlier. Fix this shortcoming.
>
> Playing the devil's advocate, it can be argued that using the same
> leading whitespace on a paragraph break line is actually a good
> thing.  Leaving them in would give the consumer an easy way to see
> which part was inserted from a note.

The, um, angel's response: `git format-patch --notes` is a convenience
for the _submitter_ of a series. It is difficult to imagine a
scenario[1] in which the _consumer_ of a series would care or need to
know whether patch commentary was written by hand, inserted
mechanically (by `--notes`), or inserted mechanically and then
hand-edited.

The trailing whitespace is unusual within the Git sphere, as well as
unsightly if you happen to have your editor configured to highlight
trailing whitespace, and just "feels" sloppy.

[1]: I suppose mechanical extraction of notes may be one such
scenario, allowing for simple-minded (not necessarily robust)
extraction mechanics; i.e. start extracting after the /^Notes:$/ line
and stop at the first line not indented with four blanks.

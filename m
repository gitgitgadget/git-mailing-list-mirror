Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5347C1F454
	for <e@80x24.org>; Wed, 24 Oct 2018 09:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbeJXSQm (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 14:16:42 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35162 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbeJXSQm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 14:16:42 -0400
Received: by mail-ot1-f66.google.com with SMTP id 14so4389586oth.2
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 02:49:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zrR+7QoAkMzSbJeifq15aeFNocEGH8EJHSKrFzJKoZA=;
        b=OJvdzW3bBMOIofmd4EcREJ6Aoc8kKzC5qgZjOVXOq61v5PSTU8N8cxIJRN6KUUOazj
         vyFTappv2Dvd/j7S8NzsgG0ixC9nz8+We/HF6YnKyw/Iyi1ShX+h+iDoE+P4kYwYDiRd
         EHKuVh5UI5IHgyedovRNctrQv6NO15p3viGMppuoWFJxGMFPHGuqcuuTjX1i85gur31T
         N1PHVnOi1dDwGt/w5Hgs+qiERmMUkfNtCDAJzLAaPybMiNXbp7YEFIJWdPSjksRjDcjn
         zrW66iNUTg0uUITvQJ8s1QAs5II1y7xp8Qyov1QOm270Y37wG+iBAnAKpUz8G9LcTB3W
         18fg==
X-Gm-Message-State: AGRZ1gL8H3RBS/0jHyVjNGtLOwwclbOFyifRszL8mppnVz/zzuDSM8/d
        m5uDXUQiqBfG/rxYnpe3kIjRLgNZmJXsn6A/d989PLacsU4=
X-Google-Smtp-Source: AJdET5eC6L1Q49v7+34lIVf9hD4OPlk9D93KQ6hRlWtq2oPnmPQakPO5aadaaQR8xAiKq0vNyroH9hEfP1aHrLcmXck=
X-Received: by 2002:a9d:44d7:: with SMTP id p23mr1160111otg.316.1540374557399;
 Wed, 24 Oct 2018 02:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <20181023191758.15138-1-agruenba@redhat.com> <xmqqefcgotbk.fsf@gitster-ct.c.googlers.com>
 <CAHc6FU6YLeTBU02k-Md7+H5kJDq2RXZmAXMaq8ZkiuSmZFXbwQ@mail.gmail.com> <xmqqr2gfn1cy.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqr2gfn1cy.fsf@gitster-ct.c.googlers.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 24 Oct 2018 11:49:06 +0200
Message-ID: <CAHc6FU5CpBNpzfPs0hkNm9Hw1iYnALvUY4WL1z=sPVT10fq+zw@mail.gmail.com>
Subject: Re: [PATCH] Clear --exclude list after 'git rev-parse --all'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 24 Oct 2018 at 11:24, Junio C Hamano <gitster@pobox.com> wrote:
> Andreas Gruenbacher <agruenba@redhat.com> writes:
> >> All other glob options do show_reference with for_each_ref_in() and
> >> then calls clear_ref_exclusion(), and logically the patch makes
> >> sense.
> >>
> >> What is the "problem" this patch fixes, though?  Is it easy to add a
> >> new test to t/6018-rev-list-glob.sh to demonstrate that "--glob" (or
> >> whatever that clears exclusion list without this patch) works
> >> correctly but "--all" misbehaves without this change?
> >
> > The test suite doesn't cover clearing the exclusion list for any of
> > those rev-parse options and I also didn't write such a test case. I
> > ran into this inconsistency during code review.
>
> That is why I asked what "problem" this patch fixes.  Without
> answering that question, it is unclear if the patch is completing
> missing coverage for "--all", or it is cargo culting an useless
> clearing done for "--glob" and friends to code for "--all" that did
> not do the same useless clearing.

This is how the --exclude option is described:

       --exclude=<glob-pattern>
           Do not include refs matching <glob-pattern> that the next
--all, --branches,
           --tags, --remotes, or --glob would otherwise consider.
Repetitions of this
           option accumulate exclusion patterns up to the next --all,
--branches, --tags,
           --remotes, or --glob option (other options or arguments do not clear
           accumulated patterns).

I'm assuming that some thought has gone into making the options behave
in this particular way. The implementation in revision.c follows this
pattern, but the implementation in builtin/rev-parse.c only almost
does.

Andreas

Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2A2C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 22:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05AA2206E0
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 22:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfLIWJY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 17:09:24 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53482 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfLIWJX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 17:09:23 -0500
Received: by mail-wm1-f66.google.com with SMTP id n9so1019982wmd.3
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 14:09:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AAGT6qyg72oNYfSzwuIbWXhwJ9gNNeXIylkQeY/UPEY=;
        b=Bygy6X1Q9ovam10MkXd83Znd2YUILcLO3DzPw2B7VCfB+hKecGFakcftmNrzb+3LM9
         y9aELuxpw1rjQaC18dRg4/euUW+M6p6aYSNBoR4IA9242yy4Nu6MpTrp9yAm6Y6hE74/
         DBA4/2zxlLI5kuDrmoGZKQ0ULzSU4lOyRjZYFyQVRww4DwrnOqPw/D2cj8h1fpWlARGU
         o4hFVQVNhnZ7cCr28lSh4hfCOnfFKCnS5c4N+FBkT73H6cZFCZAvihPF6xQkiaPFqJck
         NKz63NC4wNPqvxlYtQi2bfIqZQgbbNzvbmlgqLEEFC0dSFjh+Jc74m5v4L279FhWTxbr
         7qsQ==
X-Gm-Message-State: APjAAAXx0/qix9LOHJTnuBaPQNVc/XrNzyW6Wefhy+vP+NvrKklxhnlL
        LLvRx7vs4Gh1qdJoabTLSUUJDc2OyIS37aDS5Hk=
X-Google-Smtp-Source: APXvYqzCrnOA7rz2kRs1iJGbcDboBGmzRLJe9D0OUA0Aeswzyp9H7fAkDhSXWkN0ZhJD2rPEojoMpzLL0TiXJfMv3oU=
X-Received: by 2002:a1c:2dc8:: with SMTP id t191mr1259021wmt.75.1575929361833;
 Mon, 09 Dec 2019 14:09:21 -0800 (PST)
MIME-Version: 1.0
References: <pull.676.git.git.1575924465.gitgitgadget@gmail.com>
 <bfaf7592ee611f7e9f6fbcf7b1e4ae32f8307548.1575924465.git.gitgitgadget@gmail.com>
 <20191209213246.GA41680@generichostname>
In-Reply-To: <20191209213246.GA41680@generichostname>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 9 Dec 2019 17:09:10 -0500
Message-ID: <CAPig+cTfnNRPzYm+TnZ4GJPi52MdOLb3VhH-Sgmu=aA_Mq7fzA@mail.gmail.com>
Subject: Re: [PATCH 2/8] Revert "dir.c: make 'git-status --ignored' work
 within leading directories"
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 9, 2019 at 4:32 PM Denton Liu <liu.denton@gmail.com> wrote:
> On Mon, Dec 09, 2019 at 08:47:39PM +0000, Elijah Newren via GitGitGadget wrote:
> > +test_expect_failure 'status of untracked directory with --ignored works with or without prefix' '
> > +     git status --porcelain --ignored | grep untracked/ >actual &&
>
> Can we break this pipe up into two invocations so that we don't have a
> git command in the upstream of a pipe?
>
> P.S. Perhaps in the future, we (I) could try to extend chainlint so that
> it catches this and git commands in non-assignment command
> substitutions... I think that would be pretty nice.

Rather than getting mired down in chainlint (which could make your
eyeballs melt), an easier way to catch this sort of thing would be to
introduce a new script which checks test scripts for Git
best-practices non-conformity, similar to how
t/check-non-portable-shell.pl checks for non-portable shell
constructs. (You could even extend check-non-portable-shell.pl with
the functionality, but then the script would no longer be specific to
"non-portable shell", so either renaming it or making a new new script
is warranted.)

By the way, I have considered adding a best-practices linting script
like this, but it (at least at first) would need to have some sort of
opt-in or opt-out feature since there (likely) are still so many
instances of tests which don't follow best-practices, and it could
take a while to "fix" them all (and eat up a lot of reviewer time, so
it should be done in small batches).

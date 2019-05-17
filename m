Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A32A81F461
	for <e@80x24.org>; Fri, 17 May 2019 10:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbfEQK2Y (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 06:28:24 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:43595 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbfEQK2Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 06:28:24 -0400
Received: by mail-lj1-f174.google.com with SMTP id z5so5799354lji.10
        for <git@vger.kernel.org>; Fri, 17 May 2019 03:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=U1rxucPJ3nRd1vwnWfRJNKBcH2j9IYjdaNtqH52RiOI=;
        b=mz0n/W8wrHwd6eJHa0OcWQzqF+ss+dYEgYUDDMxlJgenxWSksM9x7m/9jDX6imxqEY
         dQxlvOBhblj7NwatbNlWLh3SPtZj9g/zu7p7M5n2rpssKi3qVkTTDwU/qXrw3a2230e/
         XE7q7EDU/vFeFY8uANhG4vZtVu2/s09lR9DD8Hg1B3HEHC/e0fcyiPewH9swBelBl9Nm
         xkPOvfc5BOr1FlMABBBjsryfjyQfuZIki+MAqmA7nnboEACE1RaU2htwY3Ab4ti5GOQl
         SifEYSEHcawsxllJCknHWnkEoJXeFGnhDebXZuGaQFwOEaoUTIeuZsLbtz53MIcCuW5P
         TFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=U1rxucPJ3nRd1vwnWfRJNKBcH2j9IYjdaNtqH52RiOI=;
        b=k6r4QSGOy/0dE+c2w9xKli8xIHQJ+Y1Vj49IUl+rX/6msCrmfb10vAoIUoQfXIX8cx
         vpq4H5pt6kPfOy5OGXNtAjPUSnKfjDkT5kNn/F0zSeW1Iuqrd3LJOf/2ryOW8dm6AdiW
         AFLEnTNLFCIdSfAh61tinsuBOuAfOs7KimH0Ai7GY8V7BAZzIE2Xi5Wavpv13wwO7V00
         4et++36u5Af1CEJ460VWVPzGOi6YiA6XxKGFPKaCu3yE+PKWBrwIXldMtOnp+jI2j+Dp
         LXCRxLgEiFl8am4SzJewoyW7JyNKS4gnzfIQwIkM48ZmdX7xsd8stJ3wqffUaTbGJTBL
         xggw==
X-Gm-Message-State: APjAAAVJbNOxks+C0zZiY3v4Ruhuc4iYSDDytKtkji8+RwZRqUyEVu1Y
        0ywO2wXBRH+B0ljFsMKSVt3cCHVpNxVFPDRFVTkkRLQu
X-Google-Smtp-Source: APXvYqzvRN8uve+Ws9bgWKpn+fp5vu3p9koO2no6F1/kVZ5AVCvNJMiUy1ALijwV/0ynn+L+avB5PLk1UayXi0HuKPU=
X-Received: by 2002:a2e:99cd:: with SMTP id l13mr1662520ljj.110.1558088902640;
 Fri, 17 May 2019 03:28:22 -0700 (PDT)
MIME-Version: 1.0
From:   Thijs ter Horst <gmterhorst@gmail.com>
Date:   Fri, 17 May 2019 12:28:11 +0200
Message-ID: <CAK1=Op7qo3xVo3h=GJRxxw8q68ahtis-bAPa0eTD9eJeFF8TCg@mail.gmail.com>
Subject: Resetting files during a merge causes loss of resetted change,
 invisible in commit logs.
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear all,

Disclaimer: I have never done a bug report / worked with mailing lists
before, so if I'm doing things wrong I'd gladly hear.

As the title describes, git can change files without logging the
change. I'm not sure how to describe it shortly, so I've made a
minimal reproduction at 'https://github.com/gmth/git_test', along with
a shell script (git_debug.sh) that reproduces what I think is a
problem. In that repo "text1.txt" changes back when according to
commit logs it shouldnt have.

I ran into this when I lost some changes in my codebase that I could
not find in the commit logs, and a merge commit ('feature' into
'master') showed that that commit reverted a file to an earlier state,
while that change was not visible in any commits in 'feature'. The
cause in my case was probably that I accidentally clicked the
"Discard" button on a file in SmartGit, but the shell script shows how
to reproduce it with commandline git. Therefore I do not think this
has to do with SmartGit.

I am unsure if I'm allowed to attach the reproducing shell script to
this email, so that's why I haven't (spam filters etc).

Kind regards,

Thijs ter Horst

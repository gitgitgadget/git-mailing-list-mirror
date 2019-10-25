Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0D471F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 03:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391605AbfJYDFY (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 23:05:24 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:41876 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391593AbfJYDFX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 23:05:23 -0400
Received: by mail-ed1-f50.google.com with SMTP id a21so639819edj.8
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 20:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=mime-version:from:date:message-id:subject:to;
        bh=1LvQdOJX15CNX86n56ih2BUyDNLYm+hWkQsi8xeaEHk=;
        b=kmQYmPVMklETgsCJIR0kBYqdpxUyntuMuiHF78ovzFBmdv5u57IU7Lq99mOjU3inQW
         1zCbX2d9ccpiIz0uy8ZVojTAdKmBY5fLIdvGOnLronoCMGexxXh8BHSqz2tHHUbIrqAk
         t5pdzccRD0CDkoHO21U+1ugbPzWLyzG42X/K0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=1LvQdOJX15CNX86n56ih2BUyDNLYm+hWkQsi8xeaEHk=;
        b=iiDOvHpbPFRS2BIujR0RpkhEUrstC6PRW1d7wjl5+WGV//C70/dZ8anXKXe95bnRk3
         ytYP6C2DYHw/6TMO67KKDLFXuUD8MnqLjLkTd0T/tfBoFaXmeF3Ui/QPplA+v6kNzmM1
         RJVvLt31eGiBLx4z1+KLKN53dSVsVYTB8DX5Wu/1gsC72EhPkSFFthicYs6gyboKK3in
         pwIyz8TTY95nqo5a10qNVME3s9j1n8iC9IMh9yH3OKZLVsC9yBwKVgq4Y+C3efacdMqs
         biVX9L2MNQOYD928ObL3/lAnJEwy1m8mCLjq2IBErd1XOoVxYHY95EKvR0BRw7XUzLsw
         00yA==
X-Gm-Message-State: APjAAAWp6JwG/p8EuhPYMIVcwB+DVoR4bUboQxbbgIBIVmcL0JzFyoxe
        fNUqUU2x0dw42MUTSTISMR7S8fNXLkVxFKHvrDVKqmAFtBYbnA==
X-Google-Smtp-Source: APXvYqzKZ3UiJsf+YBaR2Rhgueie+CKy4qB+wZwlZiWWP3E0FhfixXps+7nSVGH5DS3ijFmPEoSDLnHWCsDRO+CsLC0=
X-Received: by 2002:a17:906:743:: with SMTP id z3mr1276315ejb.142.1571972722049;
 Thu, 24 Oct 2019 20:05:22 -0700 (PDT)
MIME-Version: 1.0
From:   Utsav Shah <utsav@dropbox.com>
Date:   Thu, 24 Oct 2019 20:05:11 -0700
Message-ID: <CAPYzU3OEjjFgRrzAM04O3Dmg78FLo=n1X+EU-D_SoThKmiZtsA@mail.gmail.com>
Subject: Speeding up git stash - help needed
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's been some work to improve the performance of commands using
fsmonitor to skip unnecessary lstats. This has worked wonderfully for
git status on our repository, and I'm trying to see if we can extend
that to more commands.

A profile of git stash on our repository shows a fair bit of time is
spent in the "git reset --hard" that happens at the end. Most of the
time there is spent running lstat in unpack-trees.c -> traverse_trees
-> oneway_merge, which is a fairly generic function and used in a few
places.

Is there a sane way to try skipping those lstats? Does anyone have an
approach they'd recommend? Or is it possible to skip the git reset
--hard in some way? Any suggestions would be welcome.

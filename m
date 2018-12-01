Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFEEB211B3
	for <e@80x24.org>; Sat,  1 Dec 2018 22:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725743AbeLBKE6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Dec 2018 05:04:58 -0500
Received: from mail-lj1-f182.google.com ([209.85.208.182]:33626 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725729AbeLBKE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Dec 2018 05:04:58 -0500
Received: by mail-lj1-f182.google.com with SMTP id v1-v6so8136677ljd.0
        for <git@vger.kernel.org>; Sat, 01 Dec 2018 14:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=c6eZwsvk/HW+OoMnO5J7G2gWEf8LQK+Z/D9/6DVeLwE=;
        b=Ea0IlmQP0Uis4thlc+gTtnwragl5yeL/8WHtOtp27mwnRe1trnObcIw4p4e/my3ZFg
         bJKlEI/6xEE+yJsEVri+OKG3LgQ4OwlydWY6l0Zvu7T1Z5l9jMTGanI2MJ6r6PUbM8fH
         +7q22xoiMRmZGs0nJeV6tfOmdC+lPZ5Ko6+yweozP57c7GBpCL2rwXgUJeIJw6uxvMet
         9lq7063rljG+Y0d/HQh9JgKJU+tujClHcRcG6CKZR4P2aw0+sjBHgncIMqpPSyvYudPi
         2dIT74UenKcy/M9ftWzwX5Rs/RUee7BNuP0LSH3ozEwmBaEQ1v6xaxtuI2Km2AZolR/y
         +n5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=c6eZwsvk/HW+OoMnO5J7G2gWEf8LQK+Z/D9/6DVeLwE=;
        b=N7CmhyN5IeNA9p8RzLz1VdEe8O1XTXWCHM8YPk5z0JY5Y9blU75K59d2wwOrRodru9
         N3qY+h9wifBlHolqwq489iI3UJ65ptO5upXQkwtwzAox4O88MwUHmD5zKmSvsTRIQFKX
         yzlgLFqjj+kz45yf498FGbhfJvMRbON2VKDesK9N5hqM4XhCcrhw+QvoMAg0gzwCM7ux
         nMtGT4FY4do5K5WJUSeOm+0Nekk5n63EGavd1avKoi5sQWN1zxG32TrW0BBdinBsY0Vu
         SrPXYeDjdKvmlzxhuPdMUtAQNg68MDKyQQ0S0rmBu62YR3j/iPqRSfJVo8f9MrmGFUs9
         UFpg==
X-Gm-Message-State: AA+aEWZLlcD4uWTEtrYEZ0XTalQiGOtA2Aqlj/qKM7WBmsNvI6QIYheX
        RQe6uEVxF47i330V6vSrDDlZssINKDGoNqpOCe/Ofd6I
X-Google-Smtp-Source: AFSGD/XN4WKrz11umiNe3ljFBVGpLeBPXC+Rkar9SB/JjwffNy6rYk8ebZkNfMqUXkym63ZZQMZwKMTj7SskTE/a13M=
X-Received: by 2002:a2e:2b11:: with SMTP id q17-v6mr6679680lje.25.1543704681530;
 Sat, 01 Dec 2018 14:51:21 -0800 (PST)
MIME-Version: 1.0
From:   Cameron Boehmer <cameron.boehmer@gmail.com>
Date:   Sat, 1 Dec 2018 14:51:10 -0800
Message-ID: <CAM+q9MeVS1e11vzu+-RP-i5NhSsnRz=x21q3gcGy8L62yceiMw@mail.gmail.com>
Subject: [RFC] git clean --local
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-x and -X are great, but they remove files that are ignored via my
~/.gitignore that I'd rather keep (personal toolchain dotfiles). If
others also would like to see this addressed and we settle on a
specific solution, I'd be happy to submit a patch. Some ideas:

1) add a new flag
-l, --local
    Do not consult git config --global core.excludesFile in
determining what files git ignores. This is useful in conjunction with
-x/-X to preserve user files while removing build artifacts.

2) change the behavior of -x/-X
While it would be inconsistent with git's behavior elsewhere to NOT
consult the global excludesFile, the intent behind -x/-X seems to have
everything to do with the contents of current project's .gitignores,
and nothing to do with the global excludes. However, even if this is
palatable, it's not backwards compatible, and I'm not sure this meets
the threshold of significance for breaking changes.

Of course, I'm open to suggestions.

Thanks to all for their contributions,
Cameron

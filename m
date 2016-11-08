Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F8AA2022A
	for <e@80x24.org>; Tue,  8 Nov 2016 15:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753378AbcKHPWx (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 10:22:53 -0500
Received: from mail-vk0-f42.google.com ([209.85.213.42]:33609 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753174AbcKHPWw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 10:22:52 -0500
Received: by mail-vk0-f42.google.com with SMTP id 137so103740345vkl.0
        for <git@vger.kernel.org>; Tue, 08 Nov 2016 07:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=argoday-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=X4G3Ddjf9UyQVy1zthNT3Em/pPW4MW22vRa0+F28UG0=;
        b=Ddg2y6Vz06B398cj4RzsycSNEJO7QhVf4Ht6PhEBqclb0PtjsyaH7LmZIOT4nxp54E
         AAW6aaIOK6K7+EFhDcKd/DGYrFPpkBxXlaBw0HgeRFUfSFa7fsy3bO/UWf7tp7rxEK2D
         +/puHac0OThbJCvF6FloYnxEnqcDR2HvBvjG1NuwDrWRvBQvQ7S+TJ2JBX3fZfT2kFBQ
         nOmtgHgcINkPmM55aI0SnkL4cFFa+IYofbV6PPf5UnUCfIM45J9W/mm5KexvI9YtrFpf
         BWY6WfDoOCmD2pufB2Gn9cG3DGMHwS0/hUeimUA+aK/Ci54VvOXmFDmu0qisaMcTB6G1
         C5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=X4G3Ddjf9UyQVy1zthNT3Em/pPW4MW22vRa0+F28UG0=;
        b=LhgX9aalORPoSIHjjnEcI+TX/zzRl1QKL/DlZfqS2nnLTSymHEeF7diFKFVM3umTtv
         jfbdweH46yj8bOxjmbIF6xKsLbV/w71NZdZAp0DShGUFWvfQvv9NcyCCF6IWMZX5w2Hw
         dDaQs7WVvKuRXFrvwe6SGd6xUDeV6nedv3hWCuI0ONQZx2n8F1BPedp2EzqRKtA7FYSs
         cmvcRd1baA4YEin4mch/Znz6FTH0aaJMSBDp6D8xyOUeewoGIIIEXH234BYlIvLOdm4m
         T4YlvXAwVqqW9EibRFrDgVUhvnzziobC/hvdNhjkq6XC83UUTIWwsBMNqu3TZsZ8sfSH
         6igw==
X-Gm-Message-State: ABUngvcP9Y2GiGiiLswn5a2tElA4P6WcKgjQEBt5cqINFToZsret+zzM8UwHBmjDmZ622eXb1i5ty9rZuDEA9Q==
X-Received: by 10.31.58.84 with SMTP id h81mr8748490vka.15.1478618555067; Tue,
 08 Nov 2016 07:22:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.103.128.70 with HTTP; Tue, 8 Nov 2016 07:22:14 -0800 (PST)
From:   Jonathan Word <argoday@argoday.com>
Date:   Tue, 8 Nov 2016 10:22:14 -0500
Message-ID: <CAD9aWChH14eviop=0_Ma_2Pa-2OyWJp9KjimH8dyqy-XDn9Rhw@mail.gmail.com>
Subject: Bug: git config does not respect read-only .gitconfig file
To:     git@vger.kernel.org
Cc:     jword@bloomberg.net
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All,

I recently discovered that `git config` does not respect read-only files.

This caused unexpected difficulty in managing the global .gitconfig
for a system account shared by a large team. A team member was able to
execute a `git config --global` command without any notice or warning
that the underlying config file had been marked read-only in an
attempt to prevent unintentional changes. If instead git had raised a
warning saying that the "gitconfig is read-only" this would have
prevented that team member from accidentally breaking our git config.


Bug detail:

Due to the implementation strategy of
config::git_config_set_multivar_in_file_gently (
https://github.com/git/git/blob/5b33cb1fd733f581da07ae8afa7e9547eafd248e/config.c#L2074
) the file permissions of the target .gitconfig file are not
respected.


Proposal:

Part 1) Add a .gitconfig variable to respect a read-only gitconfig
file and optional "--force" override option for the `git config`
command

Such a gitconfig variable could be defined as:
config.respectFileMode: [ "never", "allow-override", "always" ]

Where:
* never - read-only file mode of config files are ignored (aka:
existing behavior)
* allow-override - read-only file mode of config files is respected
unless the user provides a "--force" option to `git config`
* always - read-only file mode of config files is respected (and the
"--force" option does not work)

Part 2) Change config::git_config_set_multivar_in_file_gently (
https://github.com/git/git/blob/5b33cb1fd733f581da07ae8afa7e9547eafd248e/config.c#L2077
) to verify write permissions on the destination depending on the
specified config.respectFileMode variable and "--force" option.



I think that this is a reasonably sized change that enables users to
opt-in to a 'strict mode' while preserving current behavior.


Thoughts?


Tested with:
OS: Linux
Version: 2.9.0 (issue exists in current master branch)

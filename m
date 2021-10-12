Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFCDC433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 14:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3086461074
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 14:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237324AbhJLO6F (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 10:58:05 -0400
Received: from gourmet.spamgourmet.com ([216.75.62.102]:42107 "EHLO
        gourmet8.spamgourmet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230195AbhJLO6E (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 Oct 2021 10:58:04 -0400
Received: from spamgourmet by gourmet7.spamgourmet.com with local (Exim 4.94.2)
        (envelope-from <git.mexon@spamgourmet.com>)
        id 1maJCE-0000xj-Dp
        for git@vger.kernel.org; Tue, 12 Oct 2021 14:56:02 +0000
Received: from exon.name ([209.97.141.204] helo=mail.exon.name)
        by gourmet7.spamgourmet.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <git.mexon@spamgourmet.com>)
        id 1maJCE-0000xM-4J
        for git@vger.kernel.org; Tue, 12 Oct 2021 14:56:02 +0000
Received: from [IPv6:2003:fb:ef0e:7b00:99a9:5743:1a42:383] (p200300fbef0e7b0099a957431a420383.dip0.t-ipconnect.de [IPv6:2003:fb:ef0e:7b00:99a9:5743:1a42:383])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mat)
        by mail.exon.name (Postfix) with ESMTPSA id A757F3F872
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 15:56:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=exon.name; s=mail;
        t=1634050560; bh=MMJWPLmRzCAgC8HVUIfd5liQ8nCMBqZx82jY02IPUIc=;
        h=To:From:Subject:Date:From;
        b=Nkl7XkZS/JoGee1nntDmEYfhcH/N/IQfMtOzjIwRfxuHIRknrVqcn2H+7AoKCbKAR
         O/cYFjIPvpVaUDj8BukOKuYcVybmZXuheaMaVFrFx9CJ+8JweeYmu0vUxuCsGvYu65
         F+Grt+2KEr+nY9hNOGJoD/FzUuLdwnIq0r3S0/imt3gSZzwGkt95TwwnhLubA269sW
         P81YkF4chYxR4QL8txBnGRDi1Qgz+EhJqdDOwnLqLPVc0mkS5PZCf9PHuT1oFBuUlI
         ixQDvDMTuhx5QCzCECu2hwA7eGa7Vp++3mq79nDkf2oaeLklujJgTAuDEZneyhp7+l
         Cb425F9n0fY0A==
To:     git@vger.kernel.org
From:   git.mexon@spamgourmet.com
Subject: [BUG] git add -A --dry-run adds files to .git directory
Message-ID: <a2c0deed-fff3-6c1c-633f-af9dffea1e02@exon.name>
Date:   Tue, 12 Oct 2021 16:55:59 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

mat@charly:~$ git init repo
mat@charly:~$ cat /dev/random | head -c 100000000 > repo/randomfile
mat@charly:~$ git -C repo add -A -n
mat@charly:~$ du -hs repo/.git

What did you expect to happen? (Expected behavior)

  76K    repo/.git

What happened instead? (Actual behavior)

  97M    repo/.git

What's different between what you expected and what actually happened?

Even though I specified -n on the command line to make a dry run, it 
still added the large file as an object.

Anything else you want to add:

This is counter-intuitive behaviour.  When the documentation says "Don't 
actually add the file(s)", it's reasonable to expect that this command 
will leave the repository state as it found it.  If there's a good 
reason why these files should be added to the .git directory, that 
behaviour should be made clear in the documentation, probably including 
the reason why that counter-intuitive behaviour is necessary.

This bit me due to a script that was using git add -A -n to detect if a 
repository had been locally modified.  While I do have alternative 
(actually better) ways to get this information, it wasn't an 
unreasonable command to use in the first place, and it caused a real 
issue in a production system.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.30.1 (Apple Git-130)
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Darwin 20.6.0 Darwin Kernel Version 20.6.0: Mon Aug 30 06:12:21 
PDT 2021; root:xnu-7195.141.6~3/RELEASE_X86_64 x86_64
compiler info: clang: 13.0.0 (clang-1300.0.29.3)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]



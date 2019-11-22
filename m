Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6605C432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 12:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8054D20706
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 12:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfKVMpW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 07:45:22 -0500
Received: from mx.unixadm.org ([176.9.96.198]:39252 "EHLO mx.unixadm.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfKVMpW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 07:45:22 -0500
X-Greylist: delayed 467 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Nov 2019 07:45:20 EST
Received: from blobfish.decix.local (unknown [46.31.123.137])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "phil", Issuer "Unixadm CA" (verified OK))
        by mx.unixadm.org (Postfix) with ESMTPS id B328D28658
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 13:37:32 +0100 (CET)
To:     Git mailing list <git@vger.kernel.org>
From:   Philippe <bqobctqyemmeacqxbrsaury3l4ka@quarantine.de>
Subject: difftool fails with dangling symlinks, writes to targets outside of
 the repository
Message-ID: <7e04799d-c03c-ac28-604d-ec4d30029d44@quarantine.de>
Date:   Fri, 22 Nov 2019 13:37:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=quarantine.de;
        s=itchy; t=1574426252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=tTCXV8m4rCT+YtkRBHObu2wxLcy/9JkgM6iKAdH3miI=;
        b=aIs3cY/hdXg+x4KhORkR71VYowFlEkFO7MncF4TmeYKna2v2xDnYAjPN2E4RR3qHnYAmTn
        jQ4AxIrNEvnibg3h5qLw1Ye6jNspiLClUvbj4NU/DhN/OA+mz3KHvcEgnVvkec0pS8QwOA
        5aAoN6zkdsiKfasynYHjT0xw0KjrABT4FVJnewmw78G19vtY1XN8YMI6LQYXszW3pfVnLz
        Ol12jerb3TXMj/+ltbPiRSB6f9FUKAhb1mASpCWP1ItoKYiKZFipxlq/T8Pfgpcwd0293r
        lEeNcI+7aubJLQeeL6qo3HjVq/FnDuffvmHVnLyV5qtDz/dS0n+nuYpezrPn6w==
ARC-Seal: i=1; s=itchy; d=quarantine.de; t=1574426252; a=rsa-sha256;
        cv=none;
        b=dVa0leyLR7ccXhzZebEOWJTFHZWZ/uHSSid1MA4CHyWOiuZfWgaomLACHU5fhvu7IEOEX4
        Ju5Z8KbnrWssp/hLbxuVZ3Og4cUhr8AGBT/Csvu6j1IG1GZtqyfzdvGlD0pQA77aq4b6ju
        yEYoRl2++1Ci3xcC0ABwvGha31Aydod/BejOwnYqaRKDv9xLDNAWzh1w2n1RpCOTxSSOVC
        5zIZJvU8skjzINFv6DrRdaoQ+aM3gqX4T0NfXJEvhm5m99tLbSeUpLzI/gh0XUNJUzj75s
        mguKHcoochKy/Oh7TDOEOJbvuJI4DuAjCLmbkTehjkgWQBWWQ+xpFMjrK/5drg==
ARC-Authentication-Results: i=1;
        mx.unixadm.org;
        auth=pass smtp.auth=phil smtp.mailfrom=bqobctqyemmeacqxbrsaury3l4ka@quarantine.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,


I'm using a git repository for configuration management which contains
several dangling symlinks (which only make sense on the to be deployed
system, fwiw). Now, using git 2.23, I ran into a problem regarding the
difftool, which fails when such a symlink is involved in a changeset.

The best way to describe that problem is probably to provide an example.

> #!/bin/bash
> tmp=$(mktemp -d)
> trap "rm -rf ${tmp}" 0 1 2 15
> 
> set -x
> 
> cd ${tmp}
> git init
> ln -s ../doesnot/exist myfile
> git add myfile ; git commit -m "initial checkin" myfile
> 
> git checkout -b mybranch
> rm -f myfile ; echo "foo" > myfile
> git commit -am "typechange"
> 
> git difftool -d master..mybranch

The last call fails with:

> fatal: could not open '/tmp/git-difftool.2wHaR9/left/myfile' for writing: No such file or directory

Neither specifying "--symlinks" nor "--no-symlinks" resolves that.

Playing around with this issue lead me to another strange behaviour.
Difftool might overwrite symlink targets that are not part of the
repository. Please take a look at the following script:

> #!/bin/bash
> tmp=$(mktemp -d)
> trap "rm -rf ${tmp}" 0 1 2 15
> 
> set -x
> 
> echo "hello world" > /tmp/testfile
> cat /tmp/testfile
> 
> cd ${tmp}
> git init
> ln -s /tmp/testfile myfile
> git add myfile ; git commit -m "initial checkin" myfile
> 
> git checkout -b mybranch
> rm -f myfile ; echo "foo" > myfile
> git commit -am "typechange"
> 
> git difftool -d master..mybranch
> 
> cat /tmp/testfile

Here, difftool overwrites the /tmp/testfile's content "hello world" with
"/tmp/testfile".

Did I run into a bug or is it a layer 8 problem?


Regards,

Philippe

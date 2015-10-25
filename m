From: Fredrik Medley <fredrik.medley@gmail.com>
Subject: Re: [RFC] t5516 "75 - deny fetch unreachable SHA1,
 allowtipsha1inwant=true" flaky?
Date: Sun, 25 Oct 2015 08:18:49 +0100
Message-ID: <CABA5-z=1N5=8huSr=BLmjj_KHLbMMiXdo0qok7Mc_ZOeB=J9jA@mail.gmail.com>
References: <9A3BCDA2-5915-4287-A385-95A3ACCBB850@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 25 08:19:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqFaF-0005s0-0f
	for gcvg-git-2@plane.gmane.org; Sun, 25 Oct 2015 08:19:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbbJYHTK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2015 03:19:10 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:35808 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963AbbJYHTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2015 03:19:09 -0400
Received: by oifu63 with SMTP id u63so43016805oif.2
        for <git@vger.kernel.org>; Sun, 25 Oct 2015 00:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=36OgAYRs3n8T20OdpD1d8+n+ShjGvlZ1nznMzGIFCOQ=;
        b=Gi8pDv0NSHS39Ism8qs63K2zB8Mh17JYOKxe6R2kCs1MULQafRzEp1RzETBwNyPECL
         ijg84cTTlsxPf+RtBpFSVU1UnEvC17mAFKIFVqpKll3m8D3PKo5/XCRhU3fxpGn53Z46
         YWSRow2qSOdJ/6KmNr2rB+UPufzXIbpseSalpjNFSw7VgShD24YIU2tlosalvP8x7M5G
         R6iOPcawukwDnhFBA28ixFdv9MqZo7WUUmkdmdEMMZ4TPXHVENS6eRxIlYBkCGiK6bh3
         mbiEtxck2HdiQOYMZiZPVeDBCSwWYJEndk+q1qfnFGYk0XiaRiPf1FXquMW48ehKpesN
         UfXw==
X-Received: by 10.202.195.208 with SMTP id t199mr19352500oif.117.1445757548883;
 Sun, 25 Oct 2015 00:19:08 -0700 (PDT)
Received: by 10.202.83.140 with HTTP; Sun, 25 Oct 2015 00:18:49 -0700 (PDT)
In-Reply-To: <9A3BCDA2-5915-4287-A385-95A3ACCBB850@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280139>

I think the following happens:
1. The remote upload-pack finds out "not our ref"
2. The remote send a response and close the pipe
3. fetch-pack still tries to write commands to the remote upload-pack
4. Because the connection has already been closed, writing will fail
with EPIPE which is detected by write_or_die() -> check_pipe()
resulting in die(141)

The reason for the test to succeed, i.e. git-fetch fails with 128 (or
1?), in most cases must be because it manages to write everything
before the context switch to the remote upload-pack occurs.

What is actually the wanted outcome? Should git-fetch try to continue
to see if the already received response is enough to continue as
normal?

Best regards,
Fredrik

2015-10-24 15:08 GMT+02:00 Lars Schneider <larsxschneider@gmail.com>:
> Hi,
>
> while working on the Git CI integration I noticed that t5516 "75 - deny fetch
> unreachable SHA1, allowtipsha1inwant=true" (introduced in 68ee628) seems to be
> flaky on TravisCI. I get the following output in verbose mode:
>
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> expecting success:
>         mk_empty testrepo &&
>         (
>             cd testrepo &&
>             git config uploadpack.allowtipsha1inwant $configallowtipsha1inwant &&
>             git commit --allow-empty -m foo &&
>             git commit --allow-empty -m bar &&
>             git commit --allow-empty -m xyz
>         ) &&
>         SHA1_1=$(git --git-dir=testrepo/.git rev-parse HEAD^^) &&
>         SHA1_2=$(git --git-dir=testrepo/.git rev-parse HEAD^) &&
>         SHA1_3=$(git --git-dir=testrepo/.git rev-parse HEAD) &&
>         (
>             cd testrepo &&
>             git reset --hard $SHA1_2 &&
>             git cat-file commit $SHA1_1 &&
>             git cat-file commit $SHA1_3
>         ) &&
>         mk_empty shallow &&
>         (
>             cd shallow &&
>             test_must_fail git fetch ../testrepo/.git $SHA1_3 &&
>             test_must_fail git fetch ../testrepo/.git $SHA1_1 &&
>             git --git-dir=../testrepo/.git config uploadpack.allowreachablesha1inwant true &&
>             git fetch ../testrepo/.git $SHA1_1 &&
>             git cat-file commit $SHA1_1 &&
>             test_must_fail git cat-file commit $SHA1_2 &&
>             git fetch ../testrepo/.git $SHA1_2 &&
>             git cat-file commit $SHA1_2 &&
>             test_must_fail git fetch ../testrepo/.git $SHA1_3
>         )
>
> Initialized empty Git repository in /home/travis/build/larsxschneider/git/t/trash directory.t5516-fetch-push/testrepo/.git/
> [master (root-commit) a6b22ca] foo
>  Author: A U Thor <author@example.com>
> [master 5e26403] bar
>  Author: A U Thor <author@example.com>
> [master 64ea4c1] xyz
>  Author: A U Thor <author@example.com>
> HEAD is now at 5e26403 bar
> tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
> author A U Thor <author@example.com> 1112912053 -0700
> committer C O Mitter <committer@example.com> 1112912053 -0700
> foo
> tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
> parent 5e26403b4485d7a44fd8b65dc3f71e21c0dd6fad
> author A U Thor <author@example.com> 1112912053 -0700
> committer C O Mitter <committer@example.com> 1112912053 -0700
> xyz
> Initialized empty Git repository in /home/travis/build/larsxschneider/git/t/trash directory.t5516-fetch-push/shallow/.git/
> fatal: git upload-pack: not our ref 64ea4c133d59fa98e86a771eda009872d6ab2886
> test_must_fail: died by signal: git fetch ../testrepo/.git 64ea4c133d59fa98e86a771eda009872d6ab2886
> not ok 75 - deny fetch unreachable SHA1, allowtipsha1inwant=true
> <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
>
> "git fetch ../testrepo/.git $SHA1_3" seems to die as follows:
> 1. fetch-pack.c:408 goto done;
> 2. fetch-pack.c:447 done:
> 3. fetch-pack.c:229 static void send_request... (send "0009done\n" --> 9 bytes)
> 4. write_or_die.c:74 write_or_die
> 5. wrapper.c:331 write_in_full
> 6. wrapper.c:281 xwrite
> 7. wrapper.c:287 write --> just dies with exit code 141?!
> (use 4688abf to match the line numbers)
>
> You can find the full logs about the CI run here:
> https://travis-ci.org/larsxschneider/git/jobs/86984110
>
> I repeatedly executed this test to demonstrate the flakiness:
> failed after 100 attempts: https://travis-ci.org/larsxschneider/git/jobs/87181753
> failed after 1876 attempts: https://travis-ci.org/larsxschneider/git/jobs/87181754
> (all executed on bbd2929 from https://github.com/larsxschneider/git)
>
> Unfortunately I was not able to make it fail on my local machine (OS X 10.9)
> nor on my VM (Ubuntu 14.10). Travis CI uses Ubuntu 12.04 LTS Server Edition 64
> bit with a AUFS file system.
>
> Has anyone an idea what might causes these failures or can give me pointers how
> to investigate it?
>
> Thank you,
> Lars

From: Lars Schneider <larsxschneider@gmail.com>
Subject: [RFC] t5516 "75 - deny fetch  unreachable SHA1, allowtipsha1inwant=true" flaky?
Date: Sat, 24 Oct 2015 15:08:39 +0200
Message-ID: <9A3BCDA2-5915-4287-A385-95A3ACCBB850@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: fredrik.medley@gmail.com
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 24 15:08:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpyZ4-0000dZ-Ad
	for gcvg-git-2@plane.gmane.org; Sat, 24 Oct 2015 15:08:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752156AbbJXNIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2015 09:08:44 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:35677 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095AbbJXNIm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Oct 2015 09:08:42 -0400
Received: by wicll6 with SMTP id ll6so61863165wic.0
        for <git@vger.kernel.org>; Sat, 24 Oct 2015 06:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :cc:to:mime-version;
        bh=VRvHbqbI9BaN+aeyFLyzz8sOREpHmaZ+6qz38HQN234=;
        b=x4pg9NbIo8NdGZrCgALyzb/CCFk9hBqL3rcbIrK4Es/P8MMAi1XhwFfAyUV7ZbLgpT
         XBkBAv9hEbRwF0NP+Mp/GAoAdrTpCLF5UqGjvCGylj5NBOXzfCOUxs7s5ZCxY/zYYMz+
         7qewiMULv3Y0XqXvXNdIq+zZoA6P5cF1LvzdiEQylKqECJ1+JrkmI7aNi2VCp9U0Rd/H
         PrBr+CrWYif9S+M7s4ETO2VoRx9vRtPYY4gbsoA6v4dxtAkhsyOWm29jc/WmT0Xxk6nS
         UyRuBsHg+CvJeo4SF2OFVDL3Dl31it+YsyFrd/DC2JJJx9nDDHcdBTAhJ6iZFkSfKObp
         myJg==
X-Received: by 10.180.189.102 with SMTP id gh6mr9198604wic.95.1445692120895;
        Sat, 24 Oct 2015 06:08:40 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB60EA.dip0.t-ipconnect.de. [93.219.96.234])
        by smtp.gmail.com with ESMTPSA id j3sm3007835wib.13.2015.10.24.06.08.39
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Oct 2015 06:08:40 -0700 (PDT)
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280120>

Hi,

while working on the Git CI integration I noticed that t5516 "75 - deny fetch 
unreachable SHA1, allowtipsha1inwant=true" (introduced in 68ee628) seems to be 
flaky on TravisCI. I get the following output in verbose mode:

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
expecting success: 
        mk_empty testrepo &&
        (
            cd testrepo &&
            git config uploadpack.allowtipsha1inwant $configallowtipsha1inwant &&
            git commit --allow-empty -m foo &&
            git commit --allow-empty -m bar &&
            git commit --allow-empty -m xyz
        ) &&
        SHA1_1=$(git --git-dir=testrepo/.git rev-parse HEAD^^) &&
        SHA1_2=$(git --git-dir=testrepo/.git rev-parse HEAD^) &&
        SHA1_3=$(git --git-dir=testrepo/.git rev-parse HEAD) &&
        (
            cd testrepo &&
            git reset --hard $SHA1_2 &&
            git cat-file commit $SHA1_1 &&
            git cat-file commit $SHA1_3
        ) &&
        mk_empty shallow &&
        (
            cd shallow &&
            test_must_fail git fetch ../testrepo/.git $SHA1_3 &&
            test_must_fail git fetch ../testrepo/.git $SHA1_1 &&
            git --git-dir=../testrepo/.git config uploadpack.allowreachablesha1inwant true &&
            git fetch ../testrepo/.git $SHA1_1 &&
            git cat-file commit $SHA1_1 &&
            test_must_fail git cat-file commit $SHA1_2 &&
            git fetch ../testrepo/.git $SHA1_2 &&
            git cat-file commit $SHA1_2 &&
            test_must_fail git fetch ../testrepo/.git $SHA1_3
        )
    
Initialized empty Git repository in /home/travis/build/larsxschneider/git/t/trash directory.t5516-fetch-push/testrepo/.git/
[master (root-commit) a6b22ca] foo
 Author: A U Thor <author@example.com>
[master 5e26403] bar
 Author: A U Thor <author@example.com>
[master 64ea4c1] xyz
 Author: A U Thor <author@example.com>
HEAD is now at 5e26403 bar
tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
author A U Thor <author@example.com> 1112912053 -0700
committer C O Mitter <committer@example.com> 1112912053 -0700
foo
tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
parent 5e26403b4485d7a44fd8b65dc3f71e21c0dd6fad
author A U Thor <author@example.com> 1112912053 -0700
committer C O Mitter <committer@example.com> 1112912053 -0700
xyz
Initialized empty Git repository in /home/travis/build/larsxschneider/git/t/trash directory.t5516-fetch-push/shallow/.git/
fatal: git upload-pack: not our ref 64ea4c133d59fa98e86a771eda009872d6ab2886
test_must_fail: died by signal: git fetch ../testrepo/.git 64ea4c133d59fa98e86a771eda009872d6ab2886
not ok 75 - deny fetch unreachable SHA1, allowtipsha1inwant=true 
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

"git fetch ../testrepo/.git $SHA1_3" seems to die as follows:
1. fetch-pack.c:408 goto done;
2. fetch-pack.c:447 done:
3. fetch-pack.c:229 static void send_request... (send "0009done\n" --> 9 bytes)
4. write_or_die.c:74 write_or_die
5. wrapper.c:331 write_in_full
6. wrapper.c:281 xwrite
7. wrapper.c:287 write --> just dies with exit code 141?!
(use 4688abf to match the line numbers)

You can find the full logs about the CI run here:
https://travis-ci.org/larsxschneider/git/jobs/86984110

I repeatedly executed this test to demonstrate the flakiness:
failed after 100 attempts: https://travis-ci.org/larsxschneider/git/jobs/87181753
failed after 1876 attempts: https://travis-ci.org/larsxschneider/git/jobs/87181754
(all executed on bbd2929 from https://github.com/larsxschneider/git)

Unfortunately I was not able to make it fail on my local machine (OS X 10.9) 
nor on my VM (Ubuntu 14.10). Travis CI uses Ubuntu 12.04 LTS Server Edition 64 
bit with a AUFS file system.

Has anyone an idea what might causes these failures or can give me pointers how
to investigate it?

Thank you,
Lars
From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [RFC] t5516 "75 - deny fetch unreachable SHA1, allowtipsha1inwant=true" flaky?
Date: Sun, 25 Oct 2015 14:47:58 +0100
Message-ID: <CFEB6E3F-48A0-41D8-A8FD-D48B806461DB@gmail.com>
References: <9A3BCDA2-5915-4287-A385-95A3ACCBB850@gmail.com> <CABA5-z=1N5=8huSr=BLmjj_KHLbMMiXdo0qok7Mc_ZOeB=J9jA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git Users <git@vger.kernel.org>
To: Fredrik Medley <fredrik.medley@gmail.com>, peff@peff.net,
	patrick.reynolds@github.com
X-From: git-owner@vger.kernel.org Sun Oct 25 14:48:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqLec-0006uo-1W
	for gcvg-git-2@plane.gmane.org; Sun, 25 Oct 2015 14:48:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbbJYNsE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2015 09:48:04 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:34031 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762AbbJYNsD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Oct 2015 09:48:03 -0400
Received: by wikq8 with SMTP id q8so131501622wik.1
        for <git@vger.kernel.org>; Sun, 25 Oct 2015 06:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tccV6ByfqJRybiDLizO27VxGvRUUiuLudaRQFB0iKH8=;
        b=yhRop63QhhJSGYrAjt5gWAK3Vaxh9MstHMSCVE+9JoZlVB7E/Pzik40ycsAkWlS3OF
         pq/4OI1Pc+RWz2gLfGbkOtWjTfgeGR13rHMaTiz/OT2zNbuzjC5S6l/awh0kJFV4MaVQ
         N9k3OAV5SzXxXKQTqbgGnz0zmD3eWOpOtlqIfso2VSt5A0Ap25Qhwyb6HxsCWfBUU4lL
         3R6FJaFyQeH+CdgIfoa9DiW20J01pOmyXLHHxDmooi+xJxSCqwO3S+9V796hO38vya43
         7QrJZhBkzTIcX+79X1vfnubr9Rbs4q4tDDyY5nbP4KhBTSKiPvArbGZ+UPw4seDoJ52f
         5jSA==
X-Received: by 10.180.39.234 with SMTP id s10mr15665538wik.32.1445780881101;
        Sun, 25 Oct 2015 06:48:01 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB6D4C.dip0.t-ipconnect.de. [93.219.109.76])
        by smtp.gmail.com with ESMTPSA id bo7sm8294324wjb.46.2015.10.25.06.47.59
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 25 Oct 2015 06:48:00 -0700 (PDT)
In-Reply-To: <CABA5-z=1N5=8huSr=BLmjj_KHLbMMiXdo0qok7Mc_ZOeB=J9jA@mail.gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280148>

Thanks for your explanation Fredrik! However, I believe your 4. step is not what happens in the current implementation as the write call in wrapper.c dies directly. I see three ways to fix the problem:

(1) Make upload-pack wait for a response (with timeout) before it closes the pipe. However, I believe this would not be in line with the general Git philosophy stated in "git.c" (added in 7559a1be):
"Many parts of Git have subprograms communicate via pipe, expect the upstream of a pipe to die with SIGPIPE when the downstream of a pipe does not need to read all that is written."

(2) Ignore SIGPIPE errors when "fetch-pack" sends a "done" using "sigchain_push(SIGPIPE, SIG_IGN)" / "sigchain_pop(SIGPIPE)". However, then the check_pipe function (added in 756e676c) kicks in and we would need to work around that as well.

(3) Add a method "test_must_fail_or_die" to "test-lib-functions.sh". This method accepts exit codes 129<x<192, too. Use the new method in t5516.

All this code is fairly new to me and I don't understand all the ramifications. That being said I prefer solution (3) as it is the simplest solution.

Thanks,
Lars

On 25 Oct 2015, at 08:18, Fredrik Medley <fredrik.medley@gmail.com> wrote:

> I think the following happens:
> 1. The remote upload-pack finds out "not our ref"
> 2. The remote send a response and close the pipe
> 3. fetch-pack still tries to write commands to the remote upload-pack
> 4. Because the connection has already been closed, writing will fail
> with EPIPE which is detected by write_or_die() -> check_pipe()
> resulting in die(141)
> 
> The reason for the test to succeed, i.e. git-fetch fails with 128 (or
> 1?), in most cases must be because it manages to write everything
> before the context switch to the remote upload-pack occurs.
> 
> What is actually the wanted outcome? Should git-fetch try to continue
> to see if the already received response is enough to continue as
> normal?
> 
> Best regards,
> Fredrik
> 
> 2015-10-24 15:08 GMT+02:00 Lars Schneider <larsxschneider@gmail.com>:
>> Hi,
>> 
>> while working on the Git CI integration I noticed that t5516 "75 - deny fetch
>> unreachable SHA1, allowtipsha1inwant=true" (introduced in 68ee628) seems to be
>> flaky on TravisCI. I get the following output in verbose mode:
>> 
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 
>> expecting success:
>>        mk_empty testrepo &&
>>        (
>>            cd testrepo &&
>>            git config uploadpack.allowtipsha1inwant $configallowtipsha1inwant &&
>>            git commit --allow-empty -m foo &&
>>            git commit --allow-empty -m bar &&
>>            git commit --allow-empty -m xyz
>>        ) &&
>>        SHA1_1=$(git --git-dir=testrepo/.git rev-parse HEAD^^) &&
>>        SHA1_2=$(git --git-dir=testrepo/.git rev-parse HEAD^) &&
>>        SHA1_3=$(git --git-dir=testrepo/.git rev-parse HEAD) &&
>>        (
>>            cd testrepo &&
>>            git reset --hard $SHA1_2 &&
>>            git cat-file commit $SHA1_1 &&
>>            git cat-file commit $SHA1_3
>>        ) &&
>>        mk_empty shallow &&
>>        (
>>            cd shallow &&
>>            test_must_fail git fetch ../testrepo/.git $SHA1_3 &&
>>            test_must_fail git fetch ../testrepo/.git $SHA1_1 &&
>>            git --git-dir=../testrepo/.git config uploadpack.allowreachablesha1inwant true &&
>>            git fetch ../testrepo/.git $SHA1_1 &&
>>            git cat-file commit $SHA1_1 &&
>>            test_must_fail git cat-file commit $SHA1_2 &&
>>            git fetch ../testrepo/.git $SHA1_2 &&
>>            git cat-file commit $SHA1_2 &&
>>            test_must_fail git fetch ../testrepo/.git $SHA1_3
>>        )
>> 
>> Initialized empty Git repository in /home/travis/build/larsxschneider/git/t/trash directory.t5516-fetch-push/testrepo/.git/
>> [master (root-commit) a6b22ca] foo
>> Author: A U Thor <author@example.com>
>> [master 5e26403] bar
>> Author: A U Thor <author@example.com>
>> [master 64ea4c1] xyz
>> Author: A U Thor <author@example.com>
>> HEAD is now at 5e26403 bar
>> tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
>> author A U Thor <author@example.com> 1112912053 -0700
>> committer C O Mitter <committer@example.com> 1112912053 -0700
>> foo
>> tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
>> parent 5e26403b4485d7a44fd8b65dc3f71e21c0dd6fad
>> author A U Thor <author@example.com> 1112912053 -0700
>> committer C O Mitter <committer@example.com> 1112912053 -0700
>> xyz
>> Initialized empty Git repository in /home/travis/build/larsxschneider/git/t/trash directory.t5516-fetch-push/shallow/.git/
>> fatal: git upload-pack: not our ref 64ea4c133d59fa98e86a771eda009872d6ab2886
>> test_must_fail: died by signal: git fetch ../testrepo/.git 64ea4c133d59fa98e86a771eda009872d6ab2886
>> not ok 75 - deny fetch unreachable SHA1, allowtipsha1inwant=true
>> <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
>> 
>> "git fetch ../testrepo/.git $SHA1_3" seems to die as follows:
>> 1. fetch-pack.c:408 goto done;
>> 2. fetch-pack.c:447 done:
>> 3. fetch-pack.c:229 static void send_request... (send "0009done\n" --> 9 bytes)
>> 4. write_or_die.c:74 write_or_die
>> 5. wrapper.c:331 write_in_full
>> 6. wrapper.c:281 xwrite
>> 7. wrapper.c:287 write --> just dies with exit code 141?!
>> (use 4688abf to match the line numbers)
>> 
>> You can find the full logs about the CI run here:
>> https://travis-ci.org/larsxschneider/git/jobs/86984110
>> 
>> I repeatedly executed this test to demonstrate the flakiness:
>> failed after 100 attempts: https://travis-ci.org/larsxschneider/git/jobs/87181753
>> failed after 1876 attempts: https://travis-ci.org/larsxschneider/git/jobs/87181754
>> (all executed on bbd2929 from https://github.com/larsxschneider/git)
>> 
>> Unfortunately I was not able to make it fail on my local machine (OS X 10.9)
>> nor on my VM (Ubuntu 14.10). Travis CI uses Ubuntu 12.04 LTS Server Edition 64
>> bit with a AUFS file system.
>> 
>> Has anyone an idea what might causes these failures or can give me pointers how
>> to investigate it?
>> 
>> Thank you,
>> Lars

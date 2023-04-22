Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D72C7618E
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 22:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjDVWJQ convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 22 Apr 2023 18:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjDVWJP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 18:09:15 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFC0268B
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 15:09:12 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 33MM89VU1001063
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Apr 2023 22:08:09 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Jeremy Morton'" <admin@game-point.net>, <git@vger.kernel.org>
References: <8fe188a9-c01f-9fb5-5877-8ff508094b22@game-point.net> <01cd01d9754b$f12326b0$d3697410$@nexbridge.com> <fbe77ad2-ce65-e6a6-254e-01bf6446d582@game-point.net> <01ce01d97553$4361f990$ca25ecb0$@nexbridge.com> <3ac19159-7314-c299-5112-b0f7aa2cc409@game-point.net>
In-Reply-To: <3ac19159-7314-c299-5112-b0f7aa2cc409@game-point.net>
Subject: RE: Proposal: tell git a file has been renamed
Date:   Sat, 22 Apr 2023 18:09:01 -0400
Organization: Nexbridge Inc.
Message-ID: <01d301d97567$0e9bc0b0$2bd34210$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLKSEVgGV7VqNVq5ZPBoEDYjfkU8wGiEiwXAbdj3K0C3aT/WQIICEvLrRRC7IA=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Saturday, April 22, 2023 3:54 PM, Jeremy Morton wrote:
>Subject: Re: Proposal: tell git a file has been renamed
>
>https://stackoverflow.com/a/1094392/178757
>
>says:
>
>git mv oldname newname
>
>is just shorthand for:
>
>mv oldname newname
>git add newname
>git rm oldname

The above stackoverflow topic is from 2009. A lot has changed since then. My test follows. Please note the status and git log contents indicating the rename.

$ mkdir test2
$ cd test2
$ git init
$ echo "Initial" > file1
$ git add file1
$ commit -m "Commit 1"
$ git mv file1 file2
$ git status
On branch master
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        renamed:    file1 -> file2
$ git commit -m "Rename"
$ git log --patch
commit 014068fcedaf361f45c356046cf513b79537f53f (HEAD -> master)
Author: Randall S. Becker <rsbecker@nexbridge.com>
Date:   Sat Apr 22 18:02:07 2023 -0400

    Rename

diff --git a/file1 b/file2
similarity index 100%
rename from file1
rename to file2

commit 235a33801b82eac67e25c57e512ca428f2d49cea
Author: Randall S. Becker <rsbecker@nexbridge.com>
Date:   Sat Apr 22 18:01:48 2023 -0400

    Commit 1

diff --git a/file1 b/file1
new file mode 100644
index 0000000..a77fa51
--- /dev/null
+++ b/file1
@@ -0,0 +1 @@
+Initial

>
>On 22/04/2023 20:47, rsbecker@nexbridge.com wrote:
>> No, history is preserved in the rename.
>>
>>> -----Original Message-----
>>> From: Jeremy Morton <admin@game-point.net>
>>> Sent: Saturday, April 22, 2023 3:45 PM
>>> To: rsbecker@nexbridge.com; git@vger.kernel.org
>>> Subject: Re: Proposal: tell git a file has been renamed
>>>
>>> I read that git mv is basically the equivalent to deleting the old
>>> file, creating the new file, and adding the changes.  Isn't it?  If
>>> so it's gonna have the same problem as I have now.
>>>
>>> --
>>> Best regards,
>>> Jeremy Morton (Jez)
>>>
>>> On 22/04/2023 19:54, rsbecker@nexbridge.com wrote:
>>>> On Saturday, April 22, 2023 2:02 PM, Jeremy Morton wrote:
>>>>> Yes, I know Linus specifically doesn't store file rename info in Git.
>>>>> The trouble is, every now and then, I'll come across a situation
>>>>> where Git doesn't successfully detect that I've renamed a file
>>>>> because I'm doing something like renaming a class at the same time.
>>>>> So I'll have a file OldClassNameTests.cs and a NewClassNameTests.cs
>>>>> but a bunch of lines in that file have also changed from
>>>>> OldClassName.DoThing() to NewClassName.DoThing().  I can clearly
>>>>> see that this is a rename, but Git sees enough changed content that
>>>>> it doesn't realize it, and puts it in as a delete/add, losing the content history.
>>>>>
>>>>> The standard answer for this is to rename the file in one commit,
>>>>> then make the changes.  That's fine if you know ahead of time
>>>>> you'll want to do this.  However it's a total PITA if you have a
>>>>> bunch of changes and you realize that a rename has caused this
>>>>> problem.  You now have to back out your changes to the renamed
>>>>> file, add the rename, commit
>>> it, then re-apply the changes.
>>>>>
>>>>> Could a command be added to git that means you tell Git that counts
>>>>> as a file rename?  Git would add a marker to the staging area that
>>>>> the file has been renamed, and upon commit, would first generate an
>>>>> additional commit for each rename before generating the main
>>>>> commit, ensuring the rename operation counts as an actual rename,
>>>>> and the content's
>>> history is maintained.
>>>>
>>>> Would git mv work in your situation? You can stage changes to the
>>>> original file,
>>> then use git mv. Or use git mv first. The rename shows as staged in any event.
>>>> --Randall
>>>>
>>>>
>>
>>


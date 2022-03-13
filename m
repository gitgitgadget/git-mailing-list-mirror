Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68028C433F5
	for <git@archiver.kernel.org>; Sun, 13 Mar 2022 12:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbiCMMbQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Mar 2022 08:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiCMMbO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Mar 2022 08:31:14 -0400
X-Greylist: delayed 556 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 13 Mar 2022 05:30:06 PDT
Received: from mailgateway.gmoserver.jp (smtp-gateway2-static220.gmoserver.jp [163.44.89.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBA74614C
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 05:30:06 -0700 (PDT)
Received: from smtp17.gmoserver.jp (unknown [172.17.50.220])
        by mailgateway.gmoserver.jp (Postfix) with ESMTP id E3BB912F4BE
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 21:20:48 +0900 (JST)
Received: from localhost (localhost [127.0.0.1])
        by smtp17.gmoserver.jp (Postfix) with ESMTP id DB2AC79954;
        Sun, 13 Mar 2022 21:20:46 +0900 (JST)
X-Virus-Scanned: amavisd-new at gmoserver.jp
Received: from smtp17.gmoserver.jp ([127.0.0.1])
        by localhost (smtp17.gmoserver.jp [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Q5fPGLOJZLVu; Sun, 13 Mar 2022 21:20:46 +0900 (JST)
Received: from sd-webmail17.rentalserver.jp (smtp2162.gmoserver.jp [150.95.254.23])
        by smtp17.gmoserver.jp (Postfix) with ESMTPA id CBF437994E;
        Sun, 13 Mar 2022 21:20:46 +0900 (JST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 13 Mar 2022 21:20:46 +0900
From:   contact@your-diary.io
To:     git@vger.kernel.org
Subject: Bug report for git stash push.
Message-ID: <aa8c4afddad08838584a5f9ec5c8e7ab@your-diary.io>
X-Sender: contact@your-diary.io
User-Agent: Roundcube Webmail/1.3.6
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear, Git team

Hi.
I, ynn, am contacting you to report a counter-intuitive behavior of `git 
stash push -- <file(s)>`.
I believe this is a (at least documentation) bug.

Prior to this email, I've discussed this problem on Stack Overflow:
https://stackoverflow.com/questions/71411369/git-stash-push-file-doesnt-only-save-the-specified-file

---------------------------------------------------

# tl;dr

`git stash push -- <file(s)>` is expected to save only the specified 
`<file(s)>` and let the other files intact.
However, it doesn't.

---------------------------------------------------

# Expected Behavior

According to `man git-stash`, `git stash push` is explained as below.

```
push [-p|--patch] [-S|--staged] [-k|--[no-]keep-index] 
[-u|--include-untracked] [-a|--all]
[-q|--quiet] [-m|--message <message>] [--pathspec-from-file=<file> 
[--pathspec-file-nul]] [--]
[<pathspec>...]
     Save your local modifications to a new stash entry and roll them 
back to HEAD (in the working
     tree and in the index). The <message> part is optional and gives the 
description along with
     the stashed state.
```

where `<pathspec>` is defined as

```
<pathspec>...

     This option is only valid for push command.

     The new stash entry records the modified states only for the files 
that match the pathspec.
     The index entries and working tree files are then rolled back to the 
state in HEAD only for
     these files, too, leaving files that do not match the pathspec 
intact.
```

This definition of `<pathspec>` says two things:

(A) The new stash entry records the modified states only for the files 
that match the pathspec.

(B) The index entries and working tree files are then rolled back to the 
state in HEAD only for these files, too, leaving files that do not match 
the pathspec intact.

Let's confirm these two in the next section.

---------------------------------------------------

# Actual Behavior

## Preparations

```
$ git init test1
$ cd test1
$ echo aaa > a.txt
$ echo bbb > b.txt
$ git add .
$ git commit -m 'H'
$ cd ..
$ cp -r test1 test2
```

## Pattern1

When files are not staged, both (A) and (B) are satisfied.

```
$ cd test1

$ echo aaa >> a.txt

$ echo bbb >> b.txt

$ git status
On branch master
Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git restore <file>..." to discard changes in working directory)
     modified:   a.txt
     modified:   b.txt

no changes added to commit (use "git add" and/or "git commit -a")

$ git stash push -- a.txt
Saved working directory and index state WIP on master: 9806f0c H

$ git status # (B) is satisfied
On branch master
Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git restore <file>..." to discard changes in working directory)
     modified:   b.txt

no changes added to commit (use "git add" and/or "git commit -a")

$ git stash show # (A) is satisfied
  a.txt | 1 +
  1 file changed, 1 insertion(+)

$ cd ..
```

## Pattern2

When files are staged, only (B) is satisfied.

```
$ cd test2

$ echo aaa >> a.txt

$ echo bbb >> b.txt

$ git add . # stages them

$ git status
On branch master
Changes to be committed:
   (use "git restore --staged <file>..." to unstage)
     modified:   a.txt
     modified:   b.txt

$ git stash push -- a.txt
Saved working directory and index state WIP on master: 9806f0c H

$ git status # (B) is satisfied
On branch master
Changes to be committed:
   (use "git restore --staged <file>..." to unstage)
     modified:   b.txt

$ git stash show # (A) is NOT satisfied.
  a.txt | 1 +
  b.txt | 1 +
  2 files changed, 2 insertions(+)
```

Let's cite the explanation (A) again.

(A) The new stash entry records the modified states only for the files 
that match the pathspec.

However, in the example above, the modified states of `a.txt` AND 
`b.txt` are saved in the newly created stash entry.

---------------------------------------------------

# Conclusion

- Though I don't tell if the behavior is what the author of `git stash` 
intended to be, it seems counter-intuitive. Whilst I specify the 
pathspec `-- a.txt`, not only `a.txt` but also `b.txt` are saved.

- The behavior seems to contradict with the documentation, meaning at 
least the documentation should be fixed.

Thank you.

---------------------------------------------------

# Environments

Information from `git bugreport`:

```
[System Info]
git version:
git version 2.35.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.16.11-arch1-1 #1 SMP PREEMPT Thu, 24 Feb 2022 02:18:20 
+0000 x86_64
compiler info: gnuc: 11.1
libc info: glibc: 2.35
$SHELL (typically, interactive shell): <unset>

[Enabled Hooks]
```

---------------------------------------------------

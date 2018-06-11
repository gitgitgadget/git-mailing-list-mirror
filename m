Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02E371F403
	for <e@80x24.org>; Mon, 11 Jun 2018 16:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752801AbeFKQFV (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 12:05:21 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:47081 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752128AbeFKQFV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 12:05:21 -0400
Received: from [192.168.100.119] ([80.150.130.51]) by mrelayeu.kundenserver.de
 (mreue007 [212.227.15.167]) with ESMTPSA (Nemesis) id
 0MUyXA-1flBAp37Yy-00Y6rF for <git@vger.kernel.org>; Mon, 11 Jun 2018 18:05:19
 +0200
From:   ch <cr@onlinehome.de>
Subject: [BUG] git-rebase: reword squashes commits in case of merge-conflicts
To:     git@vger.kernel.org
Message-ID: <8e28202a-8646-53e8-8c22-389d61791c70@onlinehome.de>
Date:   Mon, 11 Jun 2018 18:06:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:l1xGqOpWNxvL6eGvb/afcP33x8fjD/ocwus0azkiU5SoWwaAlXf
 JPeFOrMjpIhVCUApzylMPCIg6W+YKGVD9kLABAB+mRnsEXUoCLTL40HQuUumQ8Kg5sMj5Up
 aCtQmdYtINrwvQ4dhXpgMfnr4lk5koMk4/c4QGQeCZVI2znkBJGyliO7e1iPZWI0sFrrMTS
 0M5c2SVnOZsT8gK/DaZFA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IFOPjVVhJNc=:3X7T+8icJFJ6ZiKjXJA4jI
 DQ7LkgRmeo8j2MDI0rnBzgOMasPpn4vwEPKnLY0UF9kngITjSYWMAfq8kTn4lNa2RcdTkREel
 Ku94+RThkoPR9XYoJmSEmDoQlHoeH+4S7Vkc7qhoeDv/kt7lUH+EClvhgzkR6fA4EFIF11JaX
 MegJYDJ9UullpZRmjr0DQgBcZEzMVRs7g5WjjypCMvSQZ5Ka2Los8lvA0UQ7zThrBX58tHd76
 0bHg5+SppoO46yh++yT3KHlUc1KCjmOFDhd2mzvPbLApMCwdFWPRhME0vi6Y7kTCmz+UoSaBM
 xMI77QZH5jxPL0/YKCcSdcZT7tznms7aDkhL+YjuWeFgKqjm4M69cTPw6memvcVVCrjXegx3y
 tsFVdx8+hciNPIdShp9LBoT8CvVEI8TaBx4PGrU2oXBJ9G97y2ZFoEDDaXGDimnQ4EFvAl+nX
 tUSngk44HL5oAa3et9mjmSlF4J422sb9hS75PwqEkCGf9eSIMouoK9SfXc/OweMMEABYz7CHE
 WFyzWe+jsyQPhgqYliWKbgK1XfYEANMvD5p3dFuoVS1cKXShKFVh2pdp77LgP3NNHegnTK8jT
 G7SOU+Xx2S2V3q4UtyufNzPecrrE0+ADDo5wuSVksdTSZM9vCewbZlTQInLBYDoikNxc4ItW+
 5PCAQu5eqBzxKehSRNAiKme2pII1K8UR5K6MtH4AugYuaz5Mg/FOljyPJf7DEpqxpEFG5zYRl
 dzfSEybMB4xr9NAG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all!

During a recent rebase operation on one of my repositories a number of commits
unexpectedly ended up getting squashed into other commits. After some
experiments it turned out that the 'reword' instruction seems to squash the
referenced commit into the preceding commit if there's a merge-conflict.

Here's a small reproduction recipe to illustrate the behavior:

   1. Create a small test repository using the following Bash script:

----
function add_file()
{
     echo "$1" > "$2"
     git add "$2"
     git commit -m "$3"
}

git init .

add_file "test" "file-1" "master"

git checkout -b stuff

add_file "aaa" "file-2" "feature_a"
add_file "bbb" "file-2" "fixup! feature_a"
add_file "ccc" "file-2" "fixup! feature_a"

add_file "ddd" "file-2" "feature_b"
add_file "eee" "file-2" "fixup! feature_b"
add_file "fff" "file-2" "fixup! feature_b"
----

   2. Run

        $ git rebase --autosquash --interactive --onto master master stuff

      to interactively rebase 'stuff' onto 'master'. This should generate the
      following todo-stream:

----
pick ... feature_a
fixup ... fixup! feature_a
fixup <hash_1> fixup! feature_a
pick <hash_2> feature_b
fixup ... fixup! feature_b
fixup ... fixup! feature_b
----

   3. Remove the fixup line right before the second pick (i.e. 'fixup <hash_1>')
      in order to enforce a merge-conflict later when applying commit <hash_2>.

   4. Replace the second pick instruction (i.e. 'pick <hash_2>') with a reword.

   5. Launch the rebase operation. It should fail at the 'reword <hash_2>'
      instruction due to a merge-conflict.

   6. Resolve the conflict by taking the remote-side (i.e. 'ddd'), add the
      change to the index with git-add and run

        $ git rebase --continue

      This should spawn the commit message editor and after saving and quitting
      the rebase should finish cleanly.

After the rebase the 'stuff' branch only has a single commit even though I'd
expect there to be two according to the instructions that were passed to
git-rebase. It works as expected if there's either no merge-conflict at the
reword or if the conflicting commit is applied as 'pick'.

I'm running git version 2.17.1.windows.2. I also tried native git version 2.7.4
via WSL (running Ubuntu 16.04.4 LTS) and this version does not exhibit this
behavior.

- ch

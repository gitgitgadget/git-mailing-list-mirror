Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C9DB1F453
	for <e@80x24.org>; Fri,  3 May 2019 10:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfECKCi (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 May 2019 06:02:38 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:48409 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfECKCi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 May 2019 06:02:38 -0400
Received: from [192.168.2.106] ([87.135.183.222]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MOV26-1h6cKI225m-00PuF6 for <git@vger.kernel.org>; Fri, 03 May 2019 12:02:36
 +0200
To:     git@vger.kernel.org
From:   Christian Spanier <cspanier@boxie.eu>
Subject: bug: git pull may delete untracked files in submodule without notice
Message-ID: <2e321dbe-42a3-7516-52aa-4bc50a3c403e@boxie.eu>
Date:   Fri, 3 May 2019 10:02:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:RO45EBWEn6TC24W4wuaOl0oJKLZxLquohRm8zH5HN8UZoq0a0NW
 muqG7NmEUVz5p+FBqd9rFqiGAIFsP9/b2I3lFNQOf+cw18UNJ7uJEGkKCqLOvRKD+GXycqB
 KAb4JOvjqYOymTQhR2dhDvD6elF3J2Y4Vgomvoo53AaNp0DB/Zf1ql1dthHxiNUbNqsIucM
 69WpSIY0Oxh27kNUlEWgA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+jsTDTRxjxE=:OnpqpTAr6zaIyyWURhzCVa
 FKj+AJHQ+c8MVcRVeQQ+PgopcOtVL8lFqSREtFUUznqo9x5yMZgFLu2HTg+2pAyEexz5Z/CZj
 0Q6muSjCrWsH1A2fBD9eu7oEkQmlG63x2rXU2cU91O99WQb/HkNQe+Dw0t6oLLFyIq3Ugid8J
 RgTmqUH+/HIOYw9P4KfNbeanN4CXqx7/aO5sn8Zc7DRHzp9rSOEbkR3ECGdSAT2lQRyUXoZZd
 DR/TR96Ele09YVuwBdGRRRjiNSScHlrFPnGrjIcAgJ31JZWJon3zbNvdoIX/8EDQTKku9UNPz
 4cQY85rFHCXp+tPGlM6sPeUmp3FkZVeZqHQh9Zu4VGg0kRMWI7FpcSJpAJIeQ/6lBKX9o8WXE
 EwIFxf1ETqtGzZlHD32S8RmZJrEGBVXEpHmaKO+s4MQMGMfZ3kGW6xQoE9voileqQmkpnLHNc
 AGxy6LzJxoEjF8D520obW+5t9476sHTIU+eeowet8qFWIJxjv5Jb1qdXXkK+2tZWGekbdwIrT
 E1kNtbVVzA/ApKebuALCZdjAu0zSqiBbzjoesLRMenV4ILZAmMy8eEEgO4dBO2t2X/aL3vA8A
 egEb9nI+Qvry2sipZzXi/KcWYWL5l8J2ZaiMS+FATjvUe1oLGkKk1upkSQVYaZPVqcQ+qpJ0m
 iWvfz9f9TcAEKul2BhDsI3kSFxsqnCH0ZcPeirkUD9jtCLNRo/NbGMGrZPeVvEkxCzTtjeVl2
 NCyTJYhKS8hO2M7HczS8DX3LuP3uyt+opz9vQcyquC8gSpwlBBKwveKW4Wc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I found a bug where Git may delete untracked files without notice in 
certain situations. This bug effects Git 2.21.0 both on Linux and Windows.
In summary this happens when git pull merges a commit that replaces a 
submodule folder with a symlink. Any files within the folder are deleted 
without notice.
Check out the script below for details.

This happend on some developer's machine and deleted a repository 
containing about 200GiB of files and tons of uncommited local scripts, 
log files and whatever, just because some other dev accidentally 
commited a temporary change.

Greetings,
Christian Spanier

##### PREPARATION #####

# New empty repository #1
mkdir rep1
cd rep1
git init --bare .
cd ..

# New empty repository #2
mkdir rep2
cd rep2
git init --bare .
cd ..

# Clone repository #1 and create initial commit
git clone rep1 clone_rep1_user1
cd clone_rep1_user1
touch README
git add README
git commit -m "initial commit"
git push
cd ..

# Clone repository #2 and create initial commit
git clone rep2 clone_rep2
cd clone_rep2
touch README
git add README
git commit -m "initial commit"
git push
cd ..

# Add repository #2 as a submodule to repository #1
cd clone_rep1_user1
git submodule add ../rep2
git commit -m "add submodule"
git push
cd ..

# User 2 also clones repository #1 and #2 recursively
git clone --recursive rep1 clone_rep1_user2

# User 2 starts working in his folder and adds an important local file 
which is
# not yet committed inside the submodule folder.
cd clone_rep1_user2/rep2
echo "important work" > uncommitted_file
cd ../../

# Meanwhile, user 1 temporarily switch out folder /clone_rep1_user1/rep2 
with a
# symbolic link to a different folder (for whatever reason, maybe a copy 
of an
# older version or anything).
mkdir rep2_alternative
cd clone_rep1_user1
mv rep2 ../rep2_backup
ln -s ../rep2_alternative rep2
# On Windows this can be done with 'mklink /D rep2 ../rep2_alternative',
# which requires admin privileges. The bug is not reproducible when
# using a directory junction with 'mklink /D /J ...'.

# He does some work on rep1 but then accidently adds the symbolic link 
to his
# next commit and pushes the changes. Notice the typechange of rep2.
echo "some" > work
git status
# On branch master
# Your branch is up to date with 'origin/master'.
#
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working 
directory)
#
#         typechange: rep2
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#         work
#
# no changes added to commit (use "git add" and/or "git commit -a")
git add .
git commit -m "do some work"
git push
cd ..

# NOW THE BUG:

# User 2 pulls the changes and loses his important work in
# rep2/uncommitted_file because Git replaces the folder with a symlink
# without checking for modified or uncommited files!
# He should get an error in this case!
cd clone_rep1_user2
git pull
cat rep2/uncommitted_file
# cat: rep2/uncommitted_file: Not a directory
# "important work" in rep2/uncommitted_file is gone :(

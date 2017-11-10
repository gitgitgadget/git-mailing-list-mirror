Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F0D01F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 16:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753381AbdKJQlR (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 11:41:17 -0500
Received: from bran.ispras.ru ([83.149.199.196]:21361 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751426AbdKJQlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 11:41:16 -0500
Received: from [10.10.14.117] (real.intra.ispras.ru [10.10.14.117])
        by smtp.ispras.ru (Postfix) with ESMTP id 65936203C7
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 19:41:15 +0300 (MSK)
To:     git@vger.kernel.org
From:   =?UTF-8?B?0JXRhNC40LzQvtCyINCS0LDRgdC40LvQuNC5?= <real@ispras.ru>
Subject: Bug: cherry-pick & submodule
Message-ID: <743acc29-85bb-3773-b6a0-68d4a0b8fd63@ispras.ru>
Date:   Fri, 10 Nov 2017 19:41:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I faced an unexpected behaviour during cherry-picking
a commit to a branch with a submodule.

Git graph:

A -- B [master]
  \
   `- C -- D [test]

Both branches have a file with name `a_file`.
It has been added by commit A.
Commits B and C add a folder with name `a_submodule` to the respective 
branches.
Commit C does it regularly by adding a file with name `a_submodule/content`.
Commit B adds a submodule with name `a_submodule`.
Commit D only modifies `a_file`.
Note that `a_file` and `a_submodule` are not related.

[repo]
   |- a_file
   `- a_submodule

When I trying to cherry pick commit D on commit B, I got
a conflict with `a_submodule`. Changes of `a_file` are
successfully cherry-picked.

I expected, that there would be no conflicts.

A bash script reproducing the bug is listed below.

Vasily.

====
rm -rf a_submodule a_repo

mkdir a_submodule
cd a_submodule
git init
touch a_file_in_a_submodule
git add a_file_in_a_submodule
git commit -m "add a file in a submodule"
cd ..

mkdir a_repo
cd a_repo
git init

touch a_file
git add a_file
git commit -m "add a file"

git branch test
git checkout test

mkdir a_submodule
touch a_submodule/content
git add a_submodule/content
git commit -m "add a regular folder with name a_submodule"

echo "123" > a_file
git add a_file
git commit -m "modify a file"

git checkout master

git submodule add ../a_submodule a_submodule
git submodule update a_submodule
git commit -m "add a submodule info folder with name a_submodule"

# Trying to cherry-pick modification of a file from test branch.
git cherry-pick test

# some debug
git status
====

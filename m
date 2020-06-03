Return-Path: <SRS0=EE6k=7Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC7EC433DF
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 16:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23F44206A2
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 16:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgFCQrf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Jun 2020 12:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgFCQre (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jun 2020 12:47:34 -0400
X-Greylist: delayed 2303 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 03 Jun 2020 09:47:34 PDT
Received: from wp156.webpack.hosteurope.de (wp156.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:84a3::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7435EC08C5C0
        for <git@vger.kernel.org>; Wed,  3 Jun 2020 09:47:34 -0700 (PDT)
Received: from p5099125b.dip0.t-ipconnect.de ([80.153.18.91] helo=[192.168.100.43]); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1jgVwz-0002G7-Ag; Wed, 03 Jun 2020 18:09:09 +0200
Subject: Re: [BUG?] 'git rebase --abort' couldn't abort aborted rebase
To:     Elijah Newren <newren@gmail.com>, Md Naeim <naeim249@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <CADhmr77EbC+3f=Oa+bm18Z_SSEMK8vCjNHQniuvkdfaZdRT_5A@mail.gmail.com>
 <CABPp-BGh0T1xio-pRb=JVNbJDK1PWpo+v877nDfjcm6khn6NDg@mail.gmail.com>
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
Message-ID: <63139842-8548-6c64-1214-5469eedb8d4f@virtuell-zuhause.de>
Date:   Wed, 3 Jun 2020 18:09:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CABPp-BGh0T1xio-pRb=JVNbJDK1PWpo+v877nDfjcm6khn6NDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1591202854;d04e36e8;
X-HE-SMSGID: 1jgVwz-0002G7-Ag
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30.05.2020 18:24, Elijah Newren wrote:
> On Sat, May 30, 2020 at 3:52 AM Md Naeim <naeim249@gmail.com> wrote:

[...]

> Could you provide any details beyond the subject, such as the output
> from 'git rebase --abort', your git version, the output of `git
> status`, whether there are any untracked files with special status
> (e.g. ignored but a submodule in the way of something?), any special
> file permissions (does root own some files and prevent git from
> updating things?), operating system you are on, link to a repository
> people can use to reproduce?  Without more details, this report is
> unactionable.
> 

I don't know the OPs details but I can reproduce with the following
clumsy snippet:

#!/bin/sh

git init
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
git config rebase.autostash true
git config core.autocrlf false
echo "*.abcd !eol" > .gitattributes
git add .gitattributes
git commit -m "Add attributes"
echo -e "1\r\n" > test.abcd
git add test.abcd
git commit --no-verify -m "Added test.abcd" test.abcd
echo "*.abcd eol=lf" > .gitattributes
git add .gitattributes
git commit -m "Add attributes (LF)"
git rebase --root --interactive
git rebase --abort
which gives

 ./run.sh
Initialized empty Git repository in E:/projekte/test-init/.git/
[master (root-commit) 7169943] Add attributes
 1 file changed, 1 insertion(+)
 create mode 100644 .gitattributes
[master 61f0599] Added test.abcd
 1 file changed, 2 insertions(+)
 create mode 100644 test.abcd
[master 0acd46a] Add attributes (LF)
 1 file changed, 1 insertion(+), 1 deletion(-)
warning: CRLF will be replaced by LF in test.abcd.
The file will have its original line endings in your working directory
Created autostash: 310f745
error: cannot rebase: You have unstaged changes.
error: Please commit or stash them.
error: could not read '.git/rebase-merge/head-name': No such file or
directory

and

$ ls -la .git/rebase-merge/
total 5
drwxr-xr-x 1 thomas 197121  0 Jun  3 17:57 ./
drwxr-xr-x 1 thomas 197121  0 Jun  3 17:57 ../
-rw-r--r-- 1 thomas 197121 41 Jun  3 17:57 autostash

I'm running on Windows, both 2.27.0.windows.1 and 2.26.2.windows.1 show
the problem. And I'm pretty sure it is not Windows specific.

Although my test case uses EOL normalization, I think the real issue is
that autostashing for the rebase fails (in the sense that the working
tree is clean afterwards) and that is unexpected.

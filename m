Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B0BC38BE1
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 18:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE3320838
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 18:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbgBXSgu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 13:36:50 -0500
Received: from ikke.info ([178.21.113.177]:35368 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbgBXSgu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 13:36:50 -0500
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id A9E054400E1; Mon, 24 Feb 2020 19:36:48 +0100 (CET)
Date:   Mon, 24 Feb 2020 19:36:48 +0100
From:   Kevin Daudt <me@ikke.info>
To:     Robin Moussu <moussu.robin@pm.me>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Inconsistancy with `git rebase --preserve-merges`
Message-ID: <20200224183648.GF1247035@alpha>
Mail-Followup-To: Kevin Daudt <me@ikke.info>,
        Robin Moussu <moussu.robin@pm.me>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <v9k9hyJjfgQYYIczd9NqrjSdyOyxwqEB0iWyQ_TZCnobCZZoZ8_v6WB4KcWyW5xxRPdDUyEqEYfXylOnGI57CtK9KegMgp_0bz_5RrIIhHY=@pm.me>
 <tmm3ViXf1QO5dCCNgDCHCHSZeUKUfiYvNoI9RMvdLlnOLk0oUt_w2SKgYu3LPh6no-wHhq1gXbVlBKgLcnGCR5HaTgWMx5se9KmJOKITUHk=@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tmm3ViXf1QO5dCCNgDCHCHSZeUKUfiYvNoI9RMvdLlnOLk0oUt_w2SKgYu3LPh6no-wHhq1gXbVlBKgLcnGCR5HaTgWMx5se9KmJOKITUHk=@pm.me>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 24, 2020 at 02:10:07PM +0000, Robin Moussu wrote:
> Hi. I noticed that the position of the `--preserve-merges` option of
> `git rebase` is significant (I think it shouldn't).
> 
> The following snippet doesn't preserve the merges:
> ```
> $ git rebase --preserve-merges -i 412f07a~
> pick 412f07a Work on dev branch
> pick c6efccd Work on master branch
> pick 71c8c37 Some work after the merge
> ```
> 
> Whereas this one does what I expect:
> ```
> $ git rebase -i 412f07a~ --preserve-merges
> pick 412f07a Work on dev branch
> pick 616064c Merge branch 'master' into dev
> pick 71c8c37 Some work after the merge
> ```
> 
> For reference:
> ```
> $ git log --graph --oneline
> * 71c8c37      (HEAD -> dev) Some work after the merge
> *   616064c    Merge branch 'master' into dev
> |\
> | *   c6efccd  Work on master branch
> | *   ... (more work on master)
> * |   412f07a  Work on dev branch
> * |   ... (more work on dev)
> |/
> * 4ee50cb Common ancestor
> ```
> 
> Step to reproduce:
> ```
> mkdir temp
> cd temp
> git init
> git commit --allow-empty -m 'Common ancestor'
> git checkout -b dev
> git commit --allow-empty -m 'Work on dev branch'
> git tag some_commit
> git checkout master
> git commit --allow-empty -m 'Work on master branch'
> git checkout dev
> git merge master -m 'Merge branch 'master' into dev'
> git commit --allow-empty -m 'Some work after the merge'
> ```
> Then you will see that
>     git rebase -i some_commit --preserve-merges
> and
>     git rebase --preserve-merges  -i some_commit
> don't have the same output.
> 
> I am using git version 2.21.1 on Fedora 30.
> 
> Robin.
> 

Can you try `--rebase-merges` instead? Since v2.22.0 `--preseve-merges`
is officially deprecated, but even before that it was already known to
have flaws.

Kevin

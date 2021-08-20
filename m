Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C96DC432BE
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 17:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2215E6113B
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 17:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbhHTRDP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 13:03:15 -0400
Received: from mail.ispras.ru ([83.149.199.84]:43100 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234045AbhHTRDI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 13:03:08 -0400
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 124D640755F6
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 17:02:25 +0000 (UTC)
MIME-Version: 1.0
Date:   Fri, 20 Aug 2021 20:02:25 +0300
From:   Alexey Izbyshev <izbyshev@ispras.ru>
To:     git@vger.kernel.org
Subject: [BUG] git commit -a doesn't ignore inactive/ignore-all submodules
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <1be1e064559578a190f32dddb8ad39a0@ispras.ru>
X-Sender: izbyshev@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I've been surprised to discover that "git commit -a" stages submodules 
that have been explicitly made inactive via 
"submodule.NAME.active=false" and/or hidden from status/diff via 
"submodule.NAME.ignore=all":

git init repo
git -C repo commit --allow-empty -m "initial"
git -C repo submodule add "$PWD"/repo
git -C repo commit -m "add sm"
git -C repo config submodule.repo.ignore all
git -C repo config submodule.repo.active false
git -C repo/repo pull

After executing the above commands, "git -C repo commit -a" will show 
"repo" in "Changes to be committed" list. I think this behavior is 
dangerous because it makes it easy to accidentally "update" the 
submodule commit in the main repo while committing other changes. Does 
this qualify as a bug?

Reproduced on 2.33 and 2.17.1. Does not reproduce on 2.7.4 (Ubuntu 
16.04). This discussion[1] and this question[2] also indicate that "git 
commit -a" honored at least "ignore all" setting in older git.

Alexey

[1] 
https://public-inbox.org/git/CABxC_L92v=cV=+e_DNa0L6f21LB0BRP5duai2h_heGJN_PRoUQ@mail.gmail.com/#t
[2] 
https://superuser.com/questions/1301581/get-git-commit-a-to-ignore-submodules


Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D950C388F9
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 13:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C90C620773
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 13:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751666AbgJ0NDw convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 27 Oct 2020 09:03:52 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:35220 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751642AbgJ0NDw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 09:03:52 -0400
Received: from relay8-d.mail.gandi.net (unknown [217.70.183.201])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 3BF873A1475
        for <git@vger.kernel.org>; Tue, 27 Oct 2020 12:39:38 +0000 (UTC)
X-Originating-IP: 82.66.241.80
Received: from [192.168.1.27] (unknown [82.66.241.80])
        (Authenticated sender: b@ptistefontaine.fr)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id A2B6E1BF215
        for <git@vger.kernel.org>; Tue, 27 Oct 2020 12:39:16 +0000 (UTC)
From:   Baptiste Fontaine <b@ptistefontaine.fr>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: No warning when checking-out a branch with a file that already exists
 but is not indexed in the current branch
Message-Id: <ED4DFC77-2135-476E-AA22-7E887B25565D@ptistefontaine.fr>
Date:   Tue, 27 Oct 2020 13:39:16 +0100
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I’m not sure if this is a bug or expected behavior:

1. Create a sample repo:

  % git init
  % touch a.txt
  % git add a.txt
  % git commit -m "add a.txt"

2. Create a new branch, in which you add foo.txt:

  % git checkout -b devel
  % echo "Something" > foo.txt
  % git add foo.txt
  % git commit -m "Write something in foo.txt"

3. Go back to the first branch and create an ignored file with the
   same name:

  % git checkout master
  % echo foo.txt > .gitignore
  % git add .gitignore
  % git commit -m "ignore foo.txt"
  % echo "Something else" > foo.txt
  % cat foo.txt
  Something else

4. Check-out the branch with the indexed file:

  % git checkout devel # <-- no warning here
  % cat foo.txt
  Something

5. Check-out again the branch without the indexed file:

  % git checkout master
  % cat foo.txt
  cat: foo.txt: No such file or directory

The non-indexed file is now gone, and there was no warning when git
“took over it” in step 4. As far as I know there’s no way to retrieve
the "Something else" content.

I’m using git version 2.28.0.

I came to this situation on a repository in which I had a ROADMAP.md
file on master, which I `git rm --cached` and added to .gitignore on
devel. I later modified this file, but it was removed when I switched
on master.


Regards,

Baptiste Fontaine

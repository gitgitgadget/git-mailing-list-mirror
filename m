Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4C9A1FC43
	for <e@80x24.org>; Fri, 10 Mar 2017 21:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755176AbdCJVHC (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 16:07:02 -0500
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:52489 "EHLO
        homiemail-a20.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750897AbdCJVHB (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Mar 2017 16:07:01 -0500
Received: from homiemail-a20.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a20.g.dreamhost.com (Postfix) with ESMTP id E290C7EC069
        for <git@vger.kernel.org>; Fri, 10 Mar 2017 13:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
        :subject:from:to:date:content-type:mime-version:
        content-transfer-encoding; s=novalis.org; bh=PqiAo48+NlMnUnmV2dF
        cGFI3Q0c=; b=mTYU4YgwHJYwN3yRbVM9NIMtlweS1HD5VcQrlXyZDd44mlGou8t
        bzt8BVY2TbNKFEUew1xlpvofqy4dICiCwlwC8y6cFTwcjfw3/3zrFZjYfa+AePHt
        uVheNHvshA3lO89eB4NYfUvOunH1R2MDOBfkrfAbULGEQ1+bPmZbyoXU=
Received: from corey (gzac12-mdf2-1.aoa.twosigma.com [208.77.215.155])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a20.g.dreamhost.com (Postfix) with ESMTPSA id 9BBCD7EC072
        for <git@vger.kernel.org>; Fri, 10 Mar 2017 13:06:59 -0800 (PST)
Message-ID: <1489180018.10192.45.camel@novalis.org>
Subject: bug?: git reset --mixed ignores deinitialized submodules
From:   David Turner <novalis@novalis.org>
To:     git@vger.kernel.org
Date:   Fri, 10 Mar 2017 16:06:58 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.4-1 
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git reset --mixed ignores submodules which are not initialized.  I've
attached a demo script.=C2=A0=C2=A0

On one hand, this matches the documentation ("Resets the index but not
the working tree").  But on the other hand, it kind of doesn't: "(i.e.,
the changed files are preserved but not marked for commit)".

It's hard to figure out what a mixed reset should do.  It would be
weird for it to initialize the submodule.  Maybe it should just refuse
to run?  Maybe there should be an option for it to initialize the
submodule for you?  Maybe it should drop a special-purpose file that
git understands to be a submodule change?  For instance (and this is
insane, but, like, maybe worth considering) it could use extended
filesystem attributes, where available.

#!/bin/bash
mkdir demo
cd demo

git init main

(
	git init sub1 &&
	cd sub1 &&
	dd if=3D/dev/urandom of=3Df bs=3D40 count=3D1 &&
	git add f &&
	git commit -m f
) &&

(
	cd main &&
	git submodule add ../sub1 sub1 &&
	git commit -m 'add submodule' &&
	git tag start
) &&

# add a commit on sub1
(
	cd main/sub1 &&
	echo morx > f &&
	git add f &&
	git commit -m 'a commit'
) &&

# commit that change on main,=C2=A0=C2=A0deinit the submodule and do a mi=
xed
reset
(
	cd main &&
	git add sub1 &&
	git commit -m 'update sub1' &&
	git submodule deinit sub1 &&
	git reset --mixed HEAD^ &&
	git status # change to sub1 is lost
)


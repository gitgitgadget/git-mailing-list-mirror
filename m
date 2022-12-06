Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E392DC352A1
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 11:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbiLFLYg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 06:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbiLFLYH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 06:24:07 -0500
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F2C20BD4
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 03:24:02 -0800 (PST)
DKIM-Signature: a=rsa-sha256; b=1eDuPs1scdq+g9CcJCkRZBCZKb8epDo58On1CKFT+ipbAJD7n5rGriL0AXN8tzVWl4dbz1LjOOtSey3PI2ncO5iAw+PanY6QkMaawYaqgObWpkFDmZF466ftej5/GNXu6wTWkfBDvnCV3J/KRoCatSfpb5xoAIKkoRWYMTWXObG2Hrc4lzrPzdJ2ZJVb+xC2UTdaOlP6suYSz/Xak/pl318U9vIinV9wV5vMSUCpK+b3S0U2AIDj7mGU3hc+h6XG8VuxZP2mu5KtYMcKC81ksfG6sjjNLiIEKjk7YYqiMpOjmhzIfmMmSbmUVsP+O1r8VJPArnQyVPTjjqtp2NpTdQ==; s=purelymail3; d=tionis.dev; v=1; bh=hzV+g2cUp3O746WUU/DGwM7+nJu8ArbHL77okKCZfZ8=; h=Received:Subject:From:To;
DKIM-Signature: a=rsa-sha256; b=tOAlidOslAsj3oaABNove15Rg0GHGmftQLx9PQtV4O+wUU/gsYfa0rzF/veZbOezfS26akDcFbf6/xnoQmpr5M4r4lHduOjDEuchA0HBp2qXmooB0FvLf3pegkD/PmVrxBx+Ql5Zs1ONLRVmtxEPVLlAyMDOv42xSK4lfGvF1y1MG1X1Lsn55M9o7iT3euU8kGszHANe1VoOaaLEsassgLrfT8bMflCu2JsF0RYRVY0h5CNM/aaw6ZYFD/5CkdeQRvECEPzjn8baDAIze61r0EXdy+S7J0cREf6JsphzqpzhAcEN4rkJppkSen7XSeXkCD0jl837ImPmhVEEdWCy5A==; s=purelymail3; d=purelymail.com; v=1; bh=hzV+g2cUp3O746WUU/DGwM7+nJu8ArbHL77okKCZfZ8=; h=Feedback-ID:Received:Subject:From:To;
Feedback-ID: 2034:545:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -776242641;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 06 Dec 2022 11:23:51 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 06 Dec 2022 12:23:49 +0100
Message-Id: <COUP3909LNS6.YZG9S8YIV3SQ@tempest>
Cc:     <git@vger.kernel.org>
Subject: Re: bug report: git push fails in worktree
From:   "tionis" <out@tionis.dev>
To:     "Junio C Hamano" <gitster@pobox.com>
X-Mailer: aerc 0.13.0
References: <COUBW3AG192J.1UCDLVUZ38VJA@tempest>
 <xmqqr0xdnw88.fsf@gitster.g>
In-Reply-To: <xmqqr0xdnw88.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry, you're right I totally forgot some steps.=20
I tried to reproduce the error in a Docker Container using the
Dockerfile below:

FROM alpine:latest
RUN apk add git
RUN git clone https://tasadar.net/tionis/test.git /root/test
WORKDIR /root/test
RUN git remote add other-test https://tasadar.net/tionis/other-test.git
RUN git fetch other-test main:other-test
RUN git branch --set-upstream-to=3Dother-test/main other-test
RUN git worktree add /root/other-test other-test
WORKDIR /root/other-test
RUN touch this-is-a-test-file
RUN git config --global user.email "person@example.com"
RUN git config --global user.name "Name"
RUN git add .
RUN git commit -m "commit this-is-a-test-file"
CMD ["sh"]

This time git showed me following error message when trying to push:

fatal: The upstream branch of your current branch does not match
the name of your current branch.  To push to the upstream branch
on the remote, use

    git push other-test HEAD:main

To push to the branch of the same name on the remote, use

    git push other-test HEAD

To choose either option permanently, see push.default in 'git help config'.

Following this reference I could resolve my issue by changing the config
using:=20
git config push.default upstream

I'm sorry to have wasted your time with this and wish you a nice day.

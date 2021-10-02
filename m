Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61253C433EF
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 20:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38661611EF
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 20:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbhJBUnW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Oct 2021 16:43:22 -0400
Received: from smtpout2.vodafonemail.de ([145.253.239.133]:37102 "EHLO
        smtpout2.vodafonemail.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbhJBUnV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Oct 2021 16:43:21 -0400
Received: from mailbackend01 (balancer6.mediabeam.com [10.110.254.6])
        by smtpout2.vodafonemail.de (Postfix) with ESMTP id 144C8613BB
        for <git@vger.kernel.org>; Sat,  2 Oct 2021 22:41:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vodafonemail.de;
        s=vfde-smtpout-mb-15sep; t=1633207294;
        bh=1dWhjAWVQIdEUyc1j3AXm6cSLootpIPJfdWYlZmD7gE=;
        h=From:To:Date:Subject;
        b=HRMQDECSiXxFkJZb576UdW2W9/1x0lnMLc9HQkOiUvlGGsfc6+Jdz/VosHiRe7sYP
         +k6LtNflC8xInVVpKRXyMuVxgly3YgtP2+UdGFjxIiXNqTyr2fxmJDECB3fSO7QU01
         i1VtYI/j0fru1qOJM00ttiHlk9EhHSJhvDlzRSck=
From:   some-java-user-99206970363698485155@vodafonemail.de
To:     git@vger.kernel.org
Message-ID: <07ae9b61a42346a0b49744586d4496bd@vodafonemail.de>
Date:   Sat, 02 Oct 2021 22:41:32 +0200
X-Priority: 3
Subject: Bug: Failed checkout causes index to be in incorrect state
MIME-Version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

this originally occurred with Git for Windows (see https://github=2Ecom=
/git-for-windows/git/issues/3411)
but it appears the underlying issue is within Git itself, see Johannes =
Schindelin's comment
(https://github=2Ecom/git-for-windows/git/issues/3411#issuecomment-9141=
88040)=2E

## Description
When Git fails to check out files (during `git clone`) the index seems =
to be in an incomplete state afterwards=2E
The files which could not be checked out are erroneously staged as "del=
eted", and files which were checked out
successfully are marked as untracked=2E This renders the suggested `git=
 restore --source=3DHEAD :/` command to retry
the checkout ineffective=2E

## Reproduction steps (Windows)
Preconditions:
- Long Windows file paths are not enabled
  (https://docs=2Emicrosoft=2Ecom/en-us/windows/win32/fileio/maximum-fi=
le-path-limitation?tabs=3Dcmd#enable-long-paths-in-windows-10-version-1=
607-and-later)
- `git config core=2Elongpaths` is not set

1=2E `git clone https://github=2Ecom/dependabot/dependabot-core --depth=
=3D1 file-name-test`
   (should fail due to too long file names)
2=2E `cd file-name-test`
3=2E `git status`
   (should claim that files for which checkout failed are staged as "de=
leted")
4=2E `git config core=2Elongpaths true`
5=2E Run the command suggested by the error message from step 1: `git r=
estore --source=3DHEAD :/`
6=2E `git status`
   (you should see that `git restore` had no effect)

## System information
Microsoft Windows [Version 10=2E0=2E19043=2E1237]
git version 2=2E33=2E0=2Ewindows=2E2

All reproduction steps up to, including, step 3 can also be reproduced =
with WSL 2=2E
You might need to use a different Git repository with longer files name=
s though, such as
https://github=2Ecom/Marcono1234/git-file-length-test
WSL 2: 5=2E4=2E72-microsoft-standard-WSL2
git version 2=2E25=2E1



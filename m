Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE223C433F5
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 22:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D9696115B
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 22:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhJSWnO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 18:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhJSWnO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 18:43:14 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FAEC06161C
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 15:41:00 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id a25so18425393edx.8
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 15:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=CxHxDSzSEkkJN8PL8cSsUeZr23ysbZT4LV3np7zURy8=;
        b=V692DjJZHHh7RFERw2mDScpjn7V/TiegBO7DE0KfHgN7rRPP2FUNlSqcnaXMu3xY3/
         TuHxl8gWRsYDFbVnxbyqomahjxXVkV1X3lSNMRWBO4bpEOFp9KhZlm/92n2Cts4kg3fZ
         FpgWluqqPPAjhW+YyW6ycKt8G8CO15bMMf1t+BUnSqDFyVNYuuLpa/xkJ3rqomaCTCUJ
         lqbykEPYoi453tRu8NpnLJr/sU4K18UJI7IbNGF/KBErZqXwBKNkmGT4cprflrVkoPNm
         01BkQJLzmPljDETW7VJTBRAOkDGQ9iYLm27VAn7JENHw9RiimD4dUZOspICVf4HG8BRe
         ilvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=CxHxDSzSEkkJN8PL8cSsUeZr23ysbZT4LV3np7zURy8=;
        b=YHQq57f5gSuRtTIQ0rZ1DcGxjBT27mkdtRa+jRsdLNX5hM1VC/yYJYTy3AwGmEH36R
         4EhSecGF2NTN3Hu3X8iOdCE9bWgfAovgWvruOxEDlupX5BgveJq1clBQDKxMom3YhMGI
         jSs2llXgyajivJ5jSnq4HbkQ+BdPAO5XDTg9Jsa8GI5Fn0c8xLY3Jk+MJwVNfuvIKWd0
         HIXVmDiNC1o0ZmwVqrwAPSPgiu/rhMS2cH4ScweyCSBqRhXNPG7I7BT6vhr2zLAON1st
         RVVMBvirH22yv9fYH8uxtiRHSO7BmWa4NNYwBgjadc/4UXqsURAk6ad9bdeXxXK1SFaW
         8U7Q==
X-Gm-Message-State: AOAM533jH8qHeowTBv0tcwxPMFU9/0WsfVFDWjfs0kjA9/KpMlCy/76M
        NgkimcNLph/pL+uUFA62vNS46CQj+wSJqqvg0ADNFnbfKG+4Jw==
X-Google-Smtp-Source: ABdhPJzakYx9sDxT4WFfKOnn66NYRGa32m6+cY1lyP5DI0HMhfGwt4m0E4dL342ipjO7/ESS1Z4FXCoLI0Bd51h7Vz4=
X-Received: by 2002:a17:906:2412:: with SMTP id z18mr40509417eja.56.1634683259125;
 Tue, 19 Oct 2021 15:40:59 -0700 (PDT)
MIME-Version: 1.0
From:   Tao Klerks <tao@klerks.biz>
Date:   Wed, 20 Oct 2021 00:40:48 +0200
Message-ID: <CAPMMpojsNQuHe9iSUGyu_q2M4VObjDPj4c0QrFPsHdYypQ3aog@mail.gmail.com>
Subject: Unexpected conflict with ort merge strategy?
To:     git <git@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000fb2aa205cebc5a93"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--000000000000fb2aa205cebc5a93
Content-Type: text/plain; charset="UTF-8"

Hi folks,

I just came across a situation where the ort merge strategy chooses a
"worse" rename mapping than the recursive strategy - worse in the
sense of having a lower similarity score, worse in the sense of having
been a change in another commit (but I guess this is just a limitation
of git merge? It doesn't look for renames "iteratively" through
history when merging?), and finally worse in the sense of causing a
merge conflict that, given the previous two points, is unnecessary and
does not occur with recursive.

I've prepared a reproduction script, attached. It's probably a little
convoluted because I didn't know exactly what to look out for. This is
an extreme simplification of a real-life incident:

One file (folder1/firstfile.txt) is deleted independently in two
branches, and another somewhat-similar file (folder2/secondfile.txt)
is renamed (to folder2/secondfile_renamed.txt) and slightly modified
in one of them (in another commit).

When the branch with the rename gets merged in to the branch that just
had the delete, "ort" sees the rename as having been of
"folder1/firstfile.txt" to "folder2/secondfile_renamed.txt", despite
this being of a lower similarity than the real rename that happened,
and a conflict ensues.

Is ort supposed to choose the "best" rename choice, for a given set of
trees, and failing to do so here? Or is this a case of recursive
*accidentally* doing a better thing?

Thanks,
Tao

--000000000000fb2aa205cebc5a93
Content-Type: text/plain; charset="US-ASCII"; name="ort-testing.txt"
Content-Disposition: attachment; filename="ort-testing.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_kuynypio0>
X-Attachment-Id: f_kuynypio0

Z2l0IGluaXQKZ2l0IGNvbmZpZyBjb21taXQuZ3Bnc2lnbiBmYWxzZQpnaXQgY29uZmlnIHVzZXIu
bmFtZSBUYW8KZ2l0IGNvbmZpZyB1c2VyLmVtYWlsIHRhb0BrbGVya3MuYml6CnRvdWNoIGZpcnN0
ZmlsZQpnaXQgYWRkIGZpcnN0ZmlsZQpnaXQgY29tbWl0IC1tICJGaXJzdCBjb21taXQiCm1rZGly
IGZvbGRlcjEKbWtkaXIgZm9sZGVyMgoKY2F0ID4+IGZvbGRlcjEvZmlyc3RmaWxlLnR4dCA8PCAi
RU9GIgpGaXJzdExpbmUKU2Vjb25kIExpbmUKTGluZSBOdW1iZXIgMwpGb3VydGggTGluZQpUaGVy
ZSBjYW4gQWx3YXlzIGJlIG1vcmUgTGluZXMKClRoYXQgd2FzIGFuIEVtcHR5IExpbmUKU29tZSBV
bmlxdWUgU3R1ZmYKQnV0IE5vdCB0b28gTXVjaApFT0YKCmNhdCA+PiBmb2xkZXIyL3NlY29uZGZp
bGUudHh0IDw8ICJFT0YiCkZpcnN0TGluZQpTZWNvbmQgTGluZQpMaW5lIE51bWJlciAzClRoZXJl
IGNhbiBBbHdheXMgYmUgbW9yZSBMaW5lcwpCdXQgbm90IHRvbyBtYW55IQoKVGhhdCB3YXMgYW4g
RW1wdHkgTGluZQpPdGhlcndpc2UgVW5pcXVlIFN0dWZmCkJ1dCBOb3QgdG9vIE11Y2gKRU9GCgpn
aXQgYWRkIC4KZ2l0IGNvbW1pdCAtbSAiU3RhcnRpbmcgU3RhdGUiCgpnaXQgY2hlY2tvdXQgLWIg
ZmVhdHVyZWJyYW5jaAp0b3VjaCBuZXd3b3JraW5nZmlsZQpnaXQgYWRkIG5ld3dvcmtpbmdmaWxl
CmdpdCBjb21taXQgLW0gIk5ldyB3b3JraW5nIGZpbGUiCmdpdCBybSBmb2xkZXIxL2ZpcnN0Zmls
ZS50eHQKZ2l0IGFkZCAuCmdpdCBjb21taXQgLW0gIkRlbGV0ZWQgaW4gd29ya2luZyBicmFuY2gi
CnRvdWNoIGFub3RoZXJuZXd3b3JraW5nZmlsZQpnaXQgYWRkIGFub3RoZXJuZXd3b3JraW5nZmls
ZQpnaXQgY29tbWl0IC1tICJNb3JlIHJlZ3VsYXIgaGlzdG9yeSIKCgpnaXQgY2hlY2tvdXQgbWFz
dGVyCnJtIGZvbGRlcjEvZmlyc3RmaWxlLnR4dApnaXQgYWRkIC4KZ2l0IGNvbW1pdCAtbSAiYWxz
byBkZWxldGVkIGhlcmUiCgpybSBmb2xkZXIyL3NlY29uZGZpbGUudHh0CgpjYXQgPj4gZm9sZGVy
Mi9zZWNvbmRmaWxlX3JlbmFtZWQudHh0IDw8ICJFT0YiCkZpcnN0TGluZQpTZWNvbmQgTGluZQpM
aW5lIE51bWJlciAzClRoZXJlIGNhbiBBbHdheXMgYmUgbW9yZSBMaW5lcwpCdXQgbm90IHRvbyBt
YW55IQoKVGhhdCB3YXMgYW4gRW1wdHkgTGluZQpPdGhlcndpc2UgQWxtb3N0IFVuaXF1ZSBTdHVm
ZgpCdXQgTm90IHRvbyBNdWNoCkVPRgoKZ2l0IGFkZCAuCmdpdCBjb21taXQgLW0gImEgaGlnaC1w
ZXJjZW50YWdlIHJlbmFtZSIKCnRvdWNoIGFtYXN0ZXJmaWxlCmdpdCBhZGQgYW1hc3RlcmZpbGUK
Z2l0IGNvbW1pdCAtbSAiTW9yZSByZWd1bGFyIGhpc3RvcnkgaW4gbWFzdGVyIgoKZ2l0IGNoZWNr
b3V0IC1iIHJlZ3VsYXJtZXJnZSBmZWF0dXJlYnJhbmNoCmdpdCBtZXJnZSBtYXN0ZXIgLXMgcmVj
dXJzaXZlCgpnaXQgY2hlY2tvdXQgLWIgb3J0bWVyZ2UgZmVhdHVyZWJyYW5jaApnaXQgbWVyZ2Ug
bWFzdGVyIC1zIG9ydAo=
--000000000000fb2aa205cebc5a93--

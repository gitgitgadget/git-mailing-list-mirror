Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72177C2D0A3
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 23:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8D62206D8
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 23:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mutual.io header.i=@mutual.io header.b="VQ3SBQTy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgJ2Xxj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 19:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJ2Xxj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 19:53:39 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BB4C0613CF
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 16:53:39 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id p9so6219335eji.4
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 16:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mutual.io; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=MCLwnkPSu75ORCaG0hfb+A9DNSsRXuH+156Q/hBq8W0=;
        b=VQ3SBQTy81vPH2UyxGjC85AhNhRL9UxpgXj/xCxWRLCoFfO1J6Y0gxsBrvCdr1ZpAr
         a2oScOV/T80RlTizJ6e6gdJ7BwtoHF4ptZoK372M6+cYNBpEeyI5quymZks8Tvq3ITEL
         XZJlnF50ZY/z0whHukS5/RtjVhpaMNNrjSgLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=MCLwnkPSu75ORCaG0hfb+A9DNSsRXuH+156Q/hBq8W0=;
        b=AgPc7OH90eRMT1tJI6wowLbNUX4lBYnozEX69qgqDtb+O5pbx5zOeaul+eEdDfd6+T
         6euleo6OQe/RJ2ZnbV3hyJUvl7uVXrFTcTCDBTW0OmpWjKweaY9AqrVS42/9IoYSovs0
         n0WDmmzNV+KBfWudT/Ne6Pzus9SVcjou9ejWecIizCQsUoD7qyQvxQgyxvtpKeSCuCsE
         KdqTCgDf3sBAMbGLX/yHXiJOWc9PjWj+MdqvOPNdXx6jNk01WCIGmsSrUuDauDWlIExI
         XUkGMHA/MnmlC5kCbis/6R4m0jUxcaAjT6+FiKGKAVsXVWewDUpu/44rVma8lTu4U9DU
         fy6w==
X-Gm-Message-State: AOAM532ZC3o9fHdwTOBP7qrHolOwi9dIhm2dMNizu6hvzyJP87t/+pFb
        JQdOlHbx3FlvmoO5r2fCtESOW8xCAC/oaa+PrOgwRttII0Emsc3w
X-Google-Smtp-Source: ABdhPJy/qGWkL/ca+ZgC0OjucbFy2hoxN+rBkkDkwGNf0Vd4ycNCjx1MZuJbtFLDAAKWe2VVp7Rs+9xZ+OtW6k12kl8=
X-Received: by 2002:a17:906:4bc4:: with SMTP id x4mr6559557ejv.66.1604015617491;
 Thu, 29 Oct 2020 16:53:37 -0700 (PDT)
MIME-Version: 1.0
From:   Daniel Duvall <dan@mutual.io>
Date:   Thu, 29 Oct 2020 16:53:26 -0700
Message-ID: <CANo+1gtVRj30-JNPFpqc_m3BSEFzcb8-T+-uJTFvnNuBZYYxQQ@mail.gmail.com>
Subject: [PATCH] Fix upload-pack EOF death in normal stateless negotiation
To:     git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000001894b205b2d7fd0a"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--0000000000001894b205b2d7fd0a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi there,

I noticed while debugging an issue in Phabricator where shallow git
fetches over HTTP were failing with 500 errors that `git-http-backend`
seemed to exit abnormally after the first request even though the
response was otherwise correct=E2=80=94and when the error is not surfaced t=
o
the client, the packfile negotiation via `git-remote-curl` seems to
continue normally.[1]

I think this patch fixes the issue by having `upload-pack` gently
handle EOFs at a specific point in negotiation=E2=80=94after shallow/unshal=
low
lines have been returned to the client (followed by flush) but before
the client sends its haves.

This is my first contribution here so hopefully I'm understanding the
packfile negotiation protocol correctly and included my test in the
right place.

Kindly,
Daniel

[1] https://discourse.phabricator-community.org/t/git-fetches-with-depth-ov=
er-http-results-in-500-errors/4317

--0000000000001894b205b2d7fd0a
Content-Type: application/octet-stream; 
	name="0001-upload-pack-allow-stateless-client-EOF-just-prior-to.patch"
Content-Disposition: attachment; 
	filename="0001-upload-pack-allow-stateless-client-EOF-just-prior-to.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kgvhczhx0>
X-Attachment-Id: f_kgvhczhx0

RnJvbSBkZjczOGUxNDZmZGUzNjhjYTg5MzVkNDFiNTg2MDkzZGQxNjRjYzJhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgRHV2YWxsIDxkYW5AbXV0dWFsLmlvPgpEYXRlOiBU
aHUsIDI5IE9jdCAyMDIwIDE0OjMyOjI3IC0wNzAwClN1YmplY3Q6IFtQQVRDSF0gdXBsb2FkLXBh
Y2s6IGFsbG93IHN0YXRlbGVzcyBjbGllbnQgRU9GIGp1c3QgcHJpb3IgdG8gaGF2ZXMKCkR1cmlu
ZyBzdGF0ZWxlc3MgcGFja2ZpbGUgbmVnb3RpYXRpb24sIGl0IGlzIG5vcm1hbCBiZWhhdmlvciBm
b3IKc3RhdGVsZXNzIFJQQyBjbGllbnRzIChlLmcuIGdpdC1yZW1vdGUtY3VybCkgdG8gc2VuZCBt
dWx0aXBsZQp1cGxvYWQtcGFjayByZXF1ZXN0cyB3aXRoIHRoZSBmaXJzdCBjb250YWluaW5nIG9u
bHkgdGhlCndhbnRzL3NoYWxsb3dzL2RlZXBlbnMvZmlsdGVycyBmb2xsb3dlZCBieSBhIGZsdXNo
LgoKV2hlbiBydW4gaW4gc3RhdGVsZXNzIG1vZGUsIGNvbnRpbnVpbmcgb24gd2l0aG91dCBmaXJz
dCBjaGVja2luZyB0aGF0CnRoZSBjbGllbnQgcmVxdWVzdCBoYXMgcmVhY2hlZCBFT0YgY2FuIHJl
c3VsdCBpbiBhIGJhZCBmaWxlIGRlc2NyaXB0b3IKZHVyaW5nIGdldF9jb21tb25fY29tbWl0cy4K
Ckluc3RlYWQsIHVwbG9hZC1wYWNrIHNob3VsZCBnZW50bHkgcGVlayBmb3IgYW4gRU9GIGJldHdl
ZW4gdGhlIHNlbmRpbmcKb2Ygc2hhbGxvdy91bnNoYWxsb3cgbGluZXMgKGZvbGxvd2VkIGJ5IGZs
dXNoKSBhbmQgdGhlIHJlYWRpbmcgb2YgY2xpZW50CmhhdmVzLiBJZiB0aGUgY2xpZW50IGhhcyBo
dW5nIHVwIGF0IHRoaXMgcG9pbnQsIGV4aXQgbm9ybWFsbHkuCi0tLQogdC90OTkwNC11cGxvYWQt
cGFjay1zdGF0ZWxlc3MtdGltZWx5LWVvZi5zaCB8IDI0ICsrKysrKysrKysrKysrKysrKysrKysr
KwogdXBsb2FkLXBhY2suYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDEzICsrKysr
KysrKysrKy0KIDIgZmlsZXMgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQogY3JlYXRlIG1vZGUgMTAwNzU1IHQvdDk5MDQtdXBsb2FkLXBhY2stc3RhdGVsZXNzLXRpbWVs
eS1lb2Yuc2gKCmRpZmYgLS1naXQgYS90L3Q5OTA0LXVwbG9hZC1wYWNrLXN0YXRlbGVzcy10aW1l
bHktZW9mLnNoIGIvdC90OTkwNC11cGxvYWQtcGFjay1zdGF0ZWxlc3MtdGltZWx5LWVvZi5zaApu
ZXcgZmlsZSBtb2RlIDEwMDc1NQppbmRleCAwMDAwMDAwLi5mODM4NWE3Ci0tLSAvZGV2L251bGwK
KysrIGIvdC90OTkwNC11cGxvYWQtcGFjay1zdGF0ZWxlc3MtdGltZWx5LWVvZi5zaApAQCAtMCww
ICsxLDI0IEBACisjIS9iaW4vc2gKKwordGVzdF9kZXNjcmlwdGlvbj0nc3RhdGVsZXNzIHVwbG9h
ZC1wYWNrIGdlbnRseSBoYW5kbGVzIEVPRiBqdXN0IGFmdGVyIHdhbnQvc2hhbGxvdy9kZXB0aC9m
bHVzaCcKKworLiAuL3Rlc3QtbGliLnNoCisKK0Q9JChwd2QpCisKK3Rlc3RfZXhwZWN0X3N1Y2Nl
c3MgJ3VwbG9hZC1wYWNrIG91dHB1dHMgZmx1c2ggYW5kIGV4aXRzIG9rJyAnCisJdGVzdF9jb21t
aXQgaW5pdGlhbCAmJgorCWhlYWQ9JChnaXQgcmV2LXBhcnNlIEhFQUQpICYmCisJaGV4c3o9JCh0
ZXN0X29pZCBoZXhzeikgJiYKKworCXByaW50ZiAiJTA0eHdhbnQgJXNcbiUwNHhzaGFsbG93ICVz
XG4wMDBkZGVlcGVuIDFcbjAwMDAiIFwKKwkJJCgoJGhleHN6ICsgMTApKSAkaGVhZCAkKCgkaGV4
c3ogKyAxMykpICRoZWFkID5yZXF1ZXN0ICYmCisKKwlnaXQgdXBsb2FkLXBhY2sgLS1zdGF0ZWxl
c3MtcnBjICIkKHB3ZCkiIDxyZXF1ZXN0ID5hY3R1YWwgJiYKKworCXByaW50ZiAiMDAwMCIgPmV4
cGVjdCAmJgorCisJdGVzdF9jbXAgZXhwZWN0IGFjdHVhbAorJworCit0ZXN0X2RvbmUKZGlmZiAt
LWdpdCBhL3VwbG9hZC1wYWNrLmMgYi91cGxvYWQtcGFjay5jCmluZGV4IDNiODU4ZWIuLjJiMTI4
ZTQgMTAwNjQ0Ci0tLSBhL3VwbG9hZC1wYWNrLmMKKysrIGIvdXBsb2FkLXBhY2suYwpAQCAtMTM0
NCw3ICsxMzQ0LDE4IEBAIHZvaWQgdXBsb2FkX3BhY2soc3RydWN0IHVwbG9hZF9wYWNrX29wdGlv
bnMgKm9wdGlvbnMpCiAJCQkJICAgUEFDS0VUX1JFQURfRElFX09OX0VSUl9QQUNLRVQpOwogCiAJ
CXJlY2VpdmVfbmVlZHMoJmRhdGEsICZyZWFkZXIpOwotCQlpZiAoZGF0YS53YW50X29iai5ucikg
eworCisJCS8qCisJCSAqIEFuIEVPRiBhdCB0aGlzIGV4YWN0IHBvaW50IGluIG5lZ290aWF0aW9u
IHNob3VsZCBiZQorCQkgKiBhY2NlcHRhYmxlIGZyb20gc3RhdGVsZXNzIGNsaWVudHMgYXMgdGhl
eSB3aWxsIGNvbnN1bWUgdGhlCisJCSAqIHNoYWxsb3cgbGlzdCBiZWZvcmUgZG9pbmcgc3Vic2Vx
dWVudCBycGMgd2l0aCBoYXZlcy9ldGMuCisJCSAqLworCQlpZiAoZGF0YS5zdGF0ZWxlc3NfcnBj
KQorCQkJcmVhZGVyLm9wdGlvbnMgfD0gUEFDS0VUX1JFQURfR0VOVExFX09OX0VPRjsKKworCQlp
ZiAoZGF0YS53YW50X29iai5uciAmJgorCQkgICAgcGFja2V0X3JlYWRlcl9wZWVrKCZyZWFkZXIp
ICE9IFBBQ0tFVF9SRUFEX0VPRikgeworCQkJcmVhZGVyLm9wdGlvbnMgXj0gUEFDS0VUX1JFQURf
R0VOVExFX09OX0VPRjsKIAkJCWdldF9jb21tb25fY29tbWl0cygmZGF0YSwgJnJlYWRlcik7CiAJ
CQljcmVhdGVfcGFja19maWxlKCZkYXRhLCBOVUxMKTsKIAkJfQotLSAKMi42LjEKCg==
--0000000000001894b205b2d7fd0a--

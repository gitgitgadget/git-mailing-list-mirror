Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF4801FAFB
	for <e@80x24.org>; Sat,  1 Apr 2017 00:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754930AbdDAAYw (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 20:24:52 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:35322 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754132AbdDAAYv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 20:24:51 -0400
Received: by mail-io0-f177.google.com with SMTP id z13so49272685iof.2
        for <git@vger.kernel.org>; Fri, 31 Mar 2017 17:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to:cc;
        bh=Pg/c17XI82RPQpC4wHGe7EoAjzqu5+elkO8rptT+Iqo=;
        b=QdmYI4Fj/NBmZmiFM8QmhXJH9awV77k6uIuHq2IRHX0OTvFBwg5OAdEh21UmyTPek4
         /R2h1r/s8rCB0MqFgWBQ3aTXzNG8ju6ovRSDGUrZYHcJz1jDvdZcmCIUilRYazqPo+qA
         1vnfAzUn3MOQ4cP0WGFu3SOy7MUSjyRrRgDWP+Nr9hr2N8LkBE2TB5UeihdSVwOvOJVU
         5cCVtLEKzox1SpndrlaQkjnSRe3uP/FHSlKSyDl7URQ+n4lIddA70lQhJuI9hF2R002Q
         +YoPCmxyzO79rM4LBQ84HGh3QKjYpvV5EmZ4sw0VvWYhKu2VhDIS1TQvNzTA/ulSVJUm
         /3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:cc;
        bh=Pg/c17XI82RPQpC4wHGe7EoAjzqu5+elkO8rptT+Iqo=;
        b=p7HoXVI9eLVdvcFovx2pmIb4FLT8qoD4K7MlpbEdgRP1+ph5In8fZMHOWmhFhXsagO
         5BzoD/iuMDtdr2wzu2qHqpahJRXiN414cKaXOt3qhiGC8ClvEevjIpWlPuaC0HC+iODB
         xNeq1K4OTb7VMFpHf/AWPAOT5UvXpLMWMCEEtlf0kKfdRJ0S5QNEHu0dRZWb01XxZumR
         6NosHCOwFznQXB+iNiWbO21cYPbfTE5P1BCbFNDLVIgyfVDuF9yBCWWCoWnZp/yBUF6h
         fpViR+NHRhJfl1mWZAT2wRSy39InaoQ8CxVFa7rcSZakjKi+NtmmQR3jg8CoFdzeEO9J
         1P/g==
X-Gm-Message-State: AFeK/H19rxO5EmktTK8XIODtV8vV3/B1FC10m0Zfa/uR9cYW5+I3n3FIEjiTuXwcAaUQhNEo2oxRySij8O+2Ug==
X-Received: by 10.107.136.93 with SMTP id k90mr6584519iod.224.1491006290496;
 Fri, 31 Mar 2017 17:24:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.136.102 with HTTP; Fri, 31 Mar 2017 17:24:49 -0700 (PDT)
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 31 Mar 2017 17:24:49 -0700
X-Google-Sender-Auth: 32jE5DMKEAYrDnyuIVcZaerYRB4
Message-ID: <CA+55aFypmFkc4gOEea-AF1kKYb3K=6nosXvYS4AMGFOQHw0ZxA@mail.gmail.com>
Subject: Bug in "git am" when the body starts with spaces
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: multipart/mixed; boundary=001a113ed5124ddccb054c0ff44c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--001a113ed5124ddccb054c0ff44c
Content-Type: text/plain; charset=UTF-8

Try applying the attached patch with

   git am 0001-Test-patch.patch

in the git repository.

At least for me, it results in a very odd commit that has one single
line in the commit message:

    Test patch This should go in the body not in the subject line

which is obviously bogus.

I think the reason is that the "header continuation line" logic kicks
in because the lines in the body start with spaces, but that's
entirely incorrect, since

 (a) we're not in an email header

 (b) there's an empty line in between anyway, so no way are those body
lines continuation lines.

I didn't check how far back this goes, I guess I'll do that next. But
I thought I'd report it here first in case somebody else goes "ahhh".

                Linus

--001a113ed5124ddccb054c0ff44c
Content-Type: text/x-patch; charset=US-ASCII; name="0001-Test-patch.patch"
Content-Disposition: attachment; filename="0001-Test-patch.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_j0yilk360

RnJvbSBhZDY1Y2Y3YmE5N2FjMDcxZGExZjg0NWVjODU0MTY1ZTdiZjFlZmRmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IEZyaSwgMzEgTWFyIDIwMTcgMTc6MTg6MTYgLTA3MDAKU3ViamVjdDog
W1BBVENIXSBUZXN0IHBhdGNoIGV4YW1wbGUKClN1YmplY3Q6IFtQQVRDSF0gVGVzdCBwYXRjaAoK
ICBUaGlzIHNob3VsZCBnbyBpbiB0aGUgYm9keQogIG5vdCBpbiB0aGUgc3ViamVjdCBsaW5lCi0t
LQogTWFrZWZpbGUgfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAt
LWdpdCBhL01ha2VmaWxlIGIvTWFrZWZpbGUKaW5kZXggOWIzNjA2OGFjLi45ZjM2YzE0OWIgMTAw
NjQ0Ci0tLSBhL01ha2VmaWxlCisrKyBiL01ha2VmaWxlCkBAIC0xLDMgKzEsNCBAQAorCiAjIFRo
ZSBkZWZhdWx0IHRhcmdldCBvZiB0aGlzIE1ha2VmaWxlIGlzLi4uCiBhbGw6OgogCi0tIAoyLjEy
LjIuNDAxLmc1ZDQyMzRhNDkKCg==
--001a113ed5124ddccb054c0ff44c--

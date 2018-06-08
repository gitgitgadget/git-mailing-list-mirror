Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 084C11F403
	for <e@80x24.org>; Fri,  8 Jun 2018 18:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752662AbeFHS0H (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 14:26:07 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:34867 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752609AbeFHS0G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 14:26:06 -0400
Received: by mail-lf0-f45.google.com with SMTP id i15-v6so11122598lfc.2
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 11:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=EMA6flwOYnQ88Egkj8iaLvNA54K3OvFGNpLuZWQtS7A=;
        b=NCbVuji2vvOQZAPvLmgYALV1byhw9Zoh+zaOQ42wXELBhDBHx2UCzHzsg1ip86hbxs
         FjF0tbh5AMcdZOdronRUlqCMkbExyrjnPKBK1SlBbhWFL+zLMKBc2YjDsoYmmj/STRhb
         US34OtPryWwjh+aQcy8aUTLjO1fQ/7utcAjnGrAsb9f/5EEi68FLq/l0oF+ms1cxvluR
         wkqkT4Ye/mWACPAO1Hc7CpzIkWPbIoQxs0KFs1vUohz9PgjA9buEnu5t5GuLNFjFGTNk
         ylM/dVD3YH42SDZ7oJrJvvYx4rVAz5MtJjgEJGhK9uVHJFaNGs1hayvQIHa00/nTbQam
         5Hcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=EMA6flwOYnQ88Egkj8iaLvNA54K3OvFGNpLuZWQtS7A=;
        b=OSfBrXI6iCWb3MZEzEdyU1fW7JYOWjhrCUjjXyOJDfxWkkdAl6ZT2W6uzReixYPYEv
         PjZDR594rVOVDR3SPLUabE8gtJkkglGOSNv/MWVOOCS7x++HpgfknKjnLIknx5RkWPgd
         pL1Uru6Wsbw7aaJesgPt8xNm7WsrCkThriB/+5EaZIwM9frWIZI4y4b2S7E1CaJ6eadq
         2SdqRckOhJ1mxQmMGrbvDIc5h0BowLLhdRN3HBgxqoxauha8xc5MEwoDjiVOi+HoGdOH
         D0aYaubLepEu814D3gqH4GSMtjHIe9jFeTDwi4Le07/kfullWVhxtBFHhYgYsBIPspKu
         SdhQ==
X-Gm-Message-State: APt69E3Fa/dH/ex5ywzTPISGb9I9z0GtpGT7qRcgUF8FsmF0GQSvI3Z0
        QTACTst6ijorXqxuwoWHY65H9en8AtWlmGT3Bwt1gj5y
X-Google-Smtp-Source: ADUXVKJ4/Qa+Phu9/HX5NTVG8yzZTHSKzRXxYLxquqqE7/7157Da9y6W0VOphXhRZLbP5RQ+lL2b/eUEdai5OO4IAlw=
X-Received: by 2002:a19:5ad4:: with SMTP id y81-v6mr4773776lfk.82.1528482364562;
 Fri, 08 Jun 2018 11:26:04 -0700 (PDT)
MIME-Version: 1.0
From:   Vitaly Potyarkin <sio.wtf@gmail.com>
Date:   Fri, 8 Jun 2018 21:25:29 +0300
Message-ID: <CA+v=Qh7eiLoN4YcnSdtjL4-wp8rTjCpA85BkQD2fRoG7u=9_Fw@mail.gmail.com>
Subject: Truncating file names with Unicode characters
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

# Truncating file names with Unicode characters

When shortening file names that contain Unicode characters, git performs
truncation without awareness of two-byte characters. That often leads to
splitting a character in half and displaying a garbage byte that's left.

Unawareness of Unicode also means that filename length is calculated incorr=
ectly
and some output gets misaligned.

I have tested this with git 2.14.1 on Windows and with git 2.11.0 on Linux.=
 My
configuration includes setting `core.quotepath =3D off` to display Unicode =
paths.

# Example: `git log --stat`

## Bad output: half-characters and wrong text alignment

The last file name gets truncated in the middle of the character (`=CB=86` =
is
what's left of it). Text alignment is off because string lengths are calcul=
ated
in bytes instead of characters.

    Extension/README.md                                |  28 +++++++++
    .../Catalog.=D0=9D=D0=BE=D0=BC=D0=B5=D0=BD=D0=BA=D0=BB=D0=B0=D1=82=D1=
=83=D1=80=D0=B0.xml           |  32 ++++++++++
    .../Configuration.xml                              |   5 +-
    ...=D0=B5=D1=82=D0=9F=D0=B5=D1=80=D0=B5=D1=80=D0=B0=D0=B1=D0=BE=D1=82=
=D1=87=D0=B8=D0=BA=D0=B0.ObjectModule.txt |  39 ++++++++++++
    ...cument.=D0=9E=D1=82=D1=87=D0=B5=D1=82=D0=9F=D0=B5=D1=80=D0=B5=D1=80=
=D0=B0=D0=B1=D0=BE=D1=82=D1=87=D0=B8=D0=BA=D0=B0.xml |  68 ++++++++++++++++=
+++++
    .../Enum.=D0=A1=D1=82=D0=B0=D0=B2=D0=BA=D0=B8=D0=9D=D0=94=D0=A1.xml    =
                |  24 ++++++++
    ...=CB=86=D0=B8=D1=80=D0=B5=D0=BD=D0=B8=D0=B5ERP=D0=9F=D0=BE=D1=82=D1=
=8F=D1=80=D0=BA=D0=B8=D0=BD_2018-06-05.cfe | Bin 0 -> 22018 bytes
    7 files changed, 195 insertions(+), 1 deletion(-)

## Good output with ASCII file names

Truncation and alignment are done right because each character is represent=
ed
by a single byte.

    .../index.html                                             | 14
++++++++++++++
    docs/posts/2017/loops-in-power-query-m-language/index.html | 14
++++++++++++++
    .../index.html                                             |  7 +++++++
    .../temporary-virtual-environment-for-python/index.html    | 14
++++++++++++++
    .../index.html                                             | 14
++++++++++++++
    docs/posts/2018/getting-started-with-libpq/index.html      | 14
++++++++++++++
    .../index.html                                             | 14
++++++++++++++
    .../2018/unit-testing-in-power-query-m-language/index.html |  7 +++++++
    8 files changed, 98 insertions(+)

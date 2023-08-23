Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A43BEE4993
	for <git@archiver.kernel.org>; Wed, 23 Aug 2023 09:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbjHWJAR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Aug 2023 05:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbjHWI6T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2023 04:58:19 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F334212A
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 01:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692780910; x=1693385710; i=johannes.schindelin@gmx.de;
 bh=mXy6RDOBo5pgryDR9CKXdJo0t6vbTgp9GdPTu4/N5Jc=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=dpw+LgIPKbsKgDTRiVyNoyCryR2MwfMoE18IQGNp2TBqMf7ED+5/aivNsFCZJeZmaH26IcV
 xOgAtJH/9FynVR8Hbi2yM3pIEKg5fT3Qx8j3QrCHz6JdjXnL0n+YfuO2VpQvFYDTOhrVRNILa
 YVzRraaqBCP9kKfwAjcKhXUHfFaSf6d7lq5Q6P/Xmw5Si3Zk31dGcEMTj2K2LkR2p/fejjbdj
 mDO3dgQVH0GfsNpAwzVOkzXIzHWBD+wwY74EthJfyrxbfqjauhi221PNpH0QAQrkUaER8tOCX
 42nSD2CGvm+TJV76FJ0S+AFpCV5F/770JjlW3THePuuHBW+nORbw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.15]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhU9j-1q45rJ2FYh-00eebk; Wed, 23
 Aug 2023 10:55:10 +0200
Date:   Wed, 23 Aug 2023 10:55:08 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 4/7] sequencer: factor out part of pick_commits()
In-Reply-To: <a1fad70f4b920252d84b5b5578b1b9b0a7bba7ca.1690903412.git.gitgitgadget@gmail.com>
Message-ID: <1718e29c-0dd8-84af-1fb4-82f01458625e@gmx.de>
References: <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com> <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com> <a1fad70f4b920252d84b5b5578b1b9b0a7bba7ca.1690903412.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:LH11BzE8DgkJgxWYZYNtp/zsedgsLIDGn+uA/KbSWhaHbYyPxht
 QTwIQjSe2CPVUmwPT1M1Wh0E4ZajzLdCanHariS7cqwOpDjuZbUBF9gLN+GikbM/qQWFgUw
 u5k0Eec8XG5XSG47yDsCU79T/WSo2DnhnhiXflBApis09dcs5vVWyQ2QpNPMeMfA7alwQmc
 G0XLGSK8OxMDf4BsvZxpA==
UI-OutboundReport: notjunk:1;M01:P0:9SkZaPN4LDo=;t+jwscqi0VDIuBEtPIeOOWP6UbE
 6LLnHi3gsjevG7fS64C06ubPuix/UrqubkO2rPFxIhEISpb0lTMpHkosbnybV13G0t8Bnoacb
 33ioiuZTp/sTRjA6vNv2rW9KQYKCRqOYF3nC7slpHBf8Vwt5LrORHOUmQtZXhk4ykfF4rCKyF
 oK2tuAEsZWwQ6RJlVQBOAJ1hxto+78HvtOGHrhzNq3/cZBRuS+RcEmZiLp5L+7WFK4HZa53Dy
 3pnULDhVxdYLK1WTDtteMWQMKgNDvjBpO7vmZ5wy1hVvlGAYsdLH+TXu5+4Esm+9DEoXYnBh8
 ahRejPlBjn6psa/hF/Gh06UdgbM0DPAXZrWJMaO6dLehPGHuj73I5AQYGj/AGDhUho1V/A7Gi
 nBtxg55EAvlfhiH4OLR2c6JWyyG3thnaajGnjFZA7fQQvhuyI3fvkuTra66b0OPzlPucj4X6J
 zYGhuHJ0HrVMi6ZGKKxUnOsWMu7ajF9oGSxLPd4o10FOcl9YxsmduRUp4pzeXXWqRIPuGoVc2
 9EvhZzVmS725MfIYRjf2UXYVcpaV6ft5bqJ84FpTagFO1uNXN1N/IEyaMR1sDnIqcLUHnIjEQ
 TytIuffrOaGdMBSix3uGrgs8uXtgm1FM9/uCpioCef+yYuIHV6QVe2pYdKmVfnk+rmN3sFr5p
 0TgXakJBoF8JJUXEBg4AroP1LY8v5rmbS//WfhHUQo/BwOz8xEE+4RdIby40aikFMw2/zmQHr
 rDz6aBOMIb+FF1GrBFPBioIcL9nXJMEN80vl4kictviInmOQZynqseVhrWoP4HImzGPudAGZM
 u+qEpMVUu7Ei0fJCDsiPXZS4j40bv+fpSrviPqr/5z0gFujORNkVFZyhHG4iIxLLYvXb2ELJo
 dQ6F2N7HJ9zWmDltxQmd3NRT/iRUNnHCSFyaI+VlqXbkGNw0VMNwttCfSi/4uaV9Xa+71TpoL
 gwRybwzbBDk9UXHs1N9pCB7qOYI=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Tue, 1 Aug 2023, Phillip Wood via GitGitGadget wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> This simplifies the next commit. If a pick fails we now return the error
> at the end of the loop body rather than returning early, a successful
> "edit" command continues to return early. There are three things to
> check to ensure that removing the early return for an error does not
> change the behavior of the code:
>
> (1) We could enter the block guarded by "if (reschedule)". This block
>     is not entered because "reschedlue" is always zero when picking a
>     commit.
>
> (2) We could enter the block guarded by
>     "else if (is_rebase_i(opts) &&  check_todo && !res)". This block is
>     not entered when returning an error because "res" is non-zero in
>     that case.
>
> (3) todo_list->current could be incremented before returning. That is
>     avoided by moving the increment which is of course a potential
>     change in behavior itself. The move is safe because none of the
>     callers look at todo_list after this function returns. Moving the
>     increment makes it clear we only want to advance the current item
>     if the command was successful.

Well argued, and it matches exactly what the patch says.

FWIW I had to look at the patch locally, using

$ git show --color-moved --color-moved-ws=3Dallow-indentation-change \
	a1fad70f4b920252d84b5b5578b1b9b0a7bba7ca

to convince myself that the code was extracted into `pick_one_commit()` as
verbatim as possible. There are a couple of (benign) differences: a `&`
was removed since `check_todo` is now a pointer, and some wrapping
differences that leave the logic unchanged.

So here is my ACK.

Thank you,
Johannes

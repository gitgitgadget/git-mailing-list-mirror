Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A46C77B61
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 14:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjDXOBl convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 24 Apr 2023 10:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjDXOBh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 10:01:37 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BF41FD7
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 07:01:36 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-3ef4a74b42dso21685551cf.1
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 07:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682344896; x=1684936896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQ0eawt8kQ5d402lyINEML0iiYxtLxcbzJUI1in2apQ=;
        b=KYeUzAhiuEAde0uEVxr1g3MNVjNCqBVU4R8ZaUeThOmpjtVmqc7iw4Ngjne0ruTIL3
         nO15xgxRtdn2grMF9xNjoFfPPR+U+k1qd+z2jxJt1vbRjHqdE43E8JHAdEtQYcZDYrT4
         iy5sGGA+vjWBg43nCcw1BJqpu1/qE2e9ObEM4Kh/JSoYkMfMCww7KwBVPJ1eK+dVdDj9
         wr3ChcipcF5/oSyiTIEtJvcUaeQSbH06xcS+qGGl+2b/RbImrRXPVI8VuXKYY/VISzrF
         0gb6pm6C7TFCtbWh/gSmgBQOm3gjKhzwKev1SRSuVx5DLMngXXjo6SMwFcRegSvxKn89
         iDVg==
X-Gm-Message-State: AAQBX9cmH4IZHBB1bdPOCRHNjqAM1RYUz9zjN6emUtjRCsNgpfVEPmpH
        eFSFmkny3BsNnuQL3Yp7XE0BgsPeMb94RuuuP9vTe8Qq
X-Google-Smtp-Source: AKy350ZOaZgp2oXzeY8f1sFbIQiemGrEjAuPQJuciWOR1sHUmyFlIsTQTgpkiFFvjBwY7Ccg4CYIBlzJ+re0Oo0v//s=
X-Received: by 2002:ac8:570d:0:b0:3bf:c407:10c6 with SMTP id
 13-20020ac8570d000000b003bfc40710c6mr22522817qtw.13.1682344895744; Mon, 24
 Apr 2023 07:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <8fe188a9-c01f-9fb5-5877-8ff508094b22@game-point.net>
 <CAPx1Gvdc6bqzt2PpqD1Z4e5w+b=8gZhUSyfUQC1n8QazdBacEw@mail.gmail.com>
 <74a361fd-4ee6-f362-8d49-92417f0e2dac@game-point.net> <CA+JQ7M-1YvZFzE_CtBQa5_eEXa1sPqK4xsTxdwpAQo_YcmW+-A@mail.gmail.com>
 <91dab444-5f65-31ae-c0c6-0b84313bcd94@game-point.net>
In-Reply-To: <91dab444-5f65-31ae-c0c6-0b84313bcd94@game-point.net>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Mon, 24 Apr 2023 16:00:58 +0200
Message-ID: <CA+JQ7M_Lv1acopOpPoHxp7mPwWMFj-7wwwDPpV7KUbwFsjpoxA@mail.gmail.com>
Subject: Re: Proposal: tell git a file has been renamed
To:     Jeremy Morton <admin@game-point.net>
Cc:     Chris Torek <chris.torek@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 24, 2023 at 1:17 PM Jeremy Morton <admin@game-point.net> wrote:
>
> There's no getting away from the fact that this adds a lot of (IMHO
> unnecessary) work if you've already done a rename that git can't
> detect and have both that and a bunch of other changes sitting in the
> index.  What feels like it would be a natural resolution in these
> cases, though, is a "no, this remove/add is actually a rename" command.

It can definitely be both arduous and non-obvious how to deal with this.

The problem is that such a command cannot exist atm. because renames
don't exist, they are only interpreted. So the only way to achieve
this is to revert enough of the contents staged to the index such that
the rename is detected. The only way to do that in a foolproof manner
is reverting all the staged changes except the path so that the moved
file in the index is identical to the old file in HEAD.

If I understand you correctly, your point here is that it's
non-trivial to go from a state where a file has been renamed, with
enough changes staged into the index that the rename hasn't been
detected, to a state where the rename is recorded in the index?

The most straightforward method I can think of to restore the staged
changes, do the rename without changes, commit and then go about the
rest
eg:
  git restore --staged file2
  mv file2 file1
  git mv file1 file2
  git commit -m rename

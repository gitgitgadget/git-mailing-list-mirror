Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90ADEB64DD
	for <git@archiver.kernel.org>; Thu, 22 Jun 2023 21:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjFVVNW convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 22 Jun 2023 17:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjFVVNV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2023 17:13:21 -0400
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4F4F1
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 14:13:19 -0700 (PDT)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-62fe192f7d3so68279726d6.3
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 14:13:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687468399; x=1690060399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/bHbYVoUl9wkZegWIMX29mpHGfXMWR7I8tqjBUtbl3g=;
        b=QSzscktGpHWeDugwfh9K9KISak2iKRYNuzlfjXDRkpxq5+OK0JCR3HFIDAkV2vD6gA
         145HohKpYV8+6ePHN/EM2CR/YAP/Mh3SRzbWsXAttMkRcYcv/rzBZshHGa64ublJDZVq
         2EBJdGZojV1B89woHE/fQCvvZ6D8VjvrjGekd6rw2ga11UxRjDRyLiWTfhaaG4owDoIA
         McrIUBdBjJXGvd8GFlNu7DUkDCbM5NrOOFRXa+953jPbMs5nHCVTdhH9QB4q/tVTw4We
         yV6REC2PbTsuFlEZcSTRq7HiZhhqS4SLNGFnAretIiIB7mI86OlvpFCRg/JGdN7RS4fE
         kxjA==
X-Gm-Message-State: AC+VfDyJbzLkM2o05PyHFztsVppFliz5vv0xJvZPa8mguL1Z12iqIz6g
        qIUxaEgn/maNqqrHRls8DBQlCBTC1pLdxRa6sKE=
X-Google-Smtp-Source: ACHHUZ7Hzf7+2KbRo9/0kvl/wA59tXUlYe3IldqHkgIj0LAKd1O6Kk5iBDCekTNgq8nMaiVooYmzZWMM7aWmSytDJks=
X-Received: by 2002:a05:6214:1c87:b0:628:8185:bd6e with SMTP id
 ib7-20020a0562141c8700b006288185bd6emr11892060qvb.5.1687468398794; Thu, 22
 Jun 2023 14:13:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230622195059.320593-1-sandals@crustytoothpaste.net>
 <20230622195059.320593-2-sandals@crustytoothpaste.net> <CAPig+cSTR6oHeYjcHZ7m2CKYcFo2eistxz_X-7J2rhd7h+uf3g@mail.gmail.com>
 <xmqqjzvvdx7g.fsf@gitster.g>
In-Reply-To: <xmqqjzvvdx7g.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 22 Jun 2023 17:13:08 -0400
Message-ID: <CAPig+cTnCth-qBcOXLAEQefpfmnOnBX0wdutwDGsoqJH648FmQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] var: add support for listing the shell
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 22, 2023 at 5:05 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > This can be implemented more simply without a temporary file:
> >
> >     shpath=$(git var GIT_SHELL_PATH) &&
> >     test -x "$shpath"
> >
> > This is safe since the exit code of the Git command is preserved
> > across the `shpath=...` assignment.
>
> Correct.  I also suspect that we want to add test_path_is_executable
> helper next to test_path_is_{file,dir,missing} helpers and list it
> in t/README.  One downside of your approach is that the output from
> the command is only in $shpath and cannot be observed easily in the
> $TRASH_DIRECTORY after the test fails, but with such a helper we can
> report the problematic path when the expectation fails.

Good idea. A test_path_is_executable() function would also be a good
place to encapsulate the Windows-specific hackiness.

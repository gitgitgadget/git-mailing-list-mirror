Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15463C3F2CD
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 17:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1202246A0
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 17:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=garantcoutu.com header.i=@garantcoutu.com header.b="e0l9Za9V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgB1Rg0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 12:36:26 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:43190 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgB1RgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Feb 2020 12:36:25 -0500
Received: by mail-ot1-f52.google.com with SMTP id j5so2422353otn.10
        for <git@vger.kernel.org>; Fri, 28 Feb 2020 09:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=garantcoutu.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=MHHjcMBLeAnJ8BuX+lhCcmfyoW4UCdYr+xX1XZCU2K8=;
        b=e0l9Za9V1RC6zLUqbDFbn7V4d4z+/BJpCjOkNVP+URsi9JKGs6LTO4h8Fc6NNV7js/
         Ba60UFFISqzvVuUAQv2TdXnk9NYf5DUiqezkwxLJsCkG7jexVsDoBR9WXREminoEJZxY
         uhgsBqMShBZzIitY8p2g2np5Mv1+4PycaPW/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=MHHjcMBLeAnJ8BuX+lhCcmfyoW4UCdYr+xX1XZCU2K8=;
        b=TapQZu2AbCvAtEZqca6tc+lZALVIDij9r3DiraLMHS+PL6DbO7tn27tR/R7Ycz/nRd
         W2MrMkI3VCQEmilpGxr1nnMNyM2tSkKweNJvSFmiG4lf0ifntvbFG8fj4ybD33COll4g
         j676DAuIl8VDHQaodkzys158HlNqzs4Z+a9O5th6wv1jrXvsSZpZqWQhccTNJUvKYIhg
         piO0o2xPBiYRR4lQajhy1y4zpid6qUm9q7CBptijisA7J+YAo1xG9q6QtS5v2rNY3Pps
         1j6qQe+RdzwQ0p01SS5z7zBscMhiuoe3Vo4LBUYzIWpg4dDYeSwlYwsjEu7ihENjyPYS
         GGMA==
X-Gm-Message-State: APjAAAV8PlVlX/n2yXKxXd+vXknaDamJUC/bCjXCpnXHlQPtgqRzL9oM
        SDIS5kxgQMzRkzUXFuwx6D8PU8/sbhggFtuI3xefcE2+skM=
X-Google-Smtp-Source: APXvYqwPwCoYU/4lrPY11BnbR26iz2IJ+z4ePSI6DkvRKPiIurDD8oPuU6TsMM3IlL91IuKlPYM0uALRF46EPtCoLXo=
X-Received: by 2002:a05:6830:114f:: with SMTP id x15mr4104331otq.291.1582911384840;
 Fri, 28 Feb 2020 09:36:24 -0800 (PST)
MIME-Version: 1.0
From:   Blaise Garant <blaise@garantcoutu.com>
Date:   Fri, 28 Feb 2020 12:36:14 -0500
Message-ID: <CANXsDork=bL=SUodXDzkcnjpPALm53e++UkVkJFWxaZPMBK-SQ@mail.gmail.com>
Subject: rebase --abort Unespected behavior
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I don't know if this is a bug but it was unexpected for us. I
accidentally added untracked files through a `git add .` while doing
an interactive rebase and aborting the rebase deleted those files. Is
this to be expected?

To reproduce:
mkdir test_folder
cd test_folder
git init
touch first
git add .
git commit -m 'First'
echo 1 >> first
git add .
git commit -m 'Second'
echo 2 >> first
git add .
touch second
git commit -m 'Third'
git rebase -i HEAD~2 #set second to be edited
git add .
git status        #second should have staged
git rebase --abort
ls        #second has been deleted

Not sure this is an expected behavior.
Thanks
Blaise Garant

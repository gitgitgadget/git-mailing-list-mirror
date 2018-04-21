Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 463721F404
	for <e@80x24.org>; Sat, 21 Apr 2018 02:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752771AbeDUC6p (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 22:58:45 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:42574 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752546AbeDUC6p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 22:58:45 -0400
Received: by mail-qt0-f170.google.com with SMTP id j3-v6so11962283qtn.9
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 19:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=YUeCU+Vmbaat0DmzZbFsc2n38PJ3Ki5Rf92m5ANDp2M=;
        b=WLMo202nDj38tg2PaALEVIE2nHBRc8j39jjHgxHfNrxg1mzzynF+1PIrtSyLPwt7UY
         ogN6yj1U2IGFVGdW8sfMnFPsG7gmqEj2dgjdAWG1vuULCs3UrjU97haw9sAbOwFEAq1t
         qaTHv+E7FvAiQ4WDY8zva4WHPPClybj/fV7NV0l8LzwkSm9hISMbMIn4tXcW83d2d4nn
         DV428v2EflNaZyZ8T7GY3Fr4dGKuErFYSJfOtw52XArI02rKkw5NVlAh3aLo2jtRLGUz
         IXYeInFmFEu6N7Xrdh6V6sKg+WWaPb6O8JUWBZmGK8xsd3Z19kvUPG9lNNpGSy7LNm0n
         +yxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=YUeCU+Vmbaat0DmzZbFsc2n38PJ3Ki5Rf92m5ANDp2M=;
        b=tqUlulmaco/QpOvm4mh01+kOeSKy+niFp2VLpTxiDBfRAwXW8yW46JnX32MrCFktJx
         5Z2NMolTTTBL1O/whJAa4ve10/2P2m8ighuPv5qcosbyBrIXpZ4rNfyK4dce1xY4rA+C
         rs34bXe8XZ8OisEU3fYj2QC7DUt83Uqy9Dy6L4zIxmOuQucykCxk8FGHjGXjW9PjmbUX
         JOQlpq+ABnEVoO29BVyLE/pjCCYgo1K5r/rBPNkqjYczxY711skiUk+HcbkG85VN20mP
         pWM7fmOHJVrh6q5eJV5PTfXbWg2CstvxUPniJPnJPtxnkv94SZ7xpryD3WbSsCuHjYJY
         7DHQ==
X-Gm-Message-State: ALQs6tCxmRsuFeXvTUKwydxLeHnqi1YJp1y0ypB+N4j/ihw/ma20uPDT
        TRnV7HiTIsXu34SWhJ1YFw13WQw6z4mBKsNAso1U8Q==
X-Google-Smtp-Source: AIpwx4+FSCQ0WaIiAPytoJwuIGRD3dL4yTfyWiOsO3sQjokdkjsPe3s58mwDRxu16pefmnCaTqiSdjs8G2gRvPNRx+s=
X-Received: by 2002:ac8:1113:: with SMTP id c19-v6mr13430580qtj.307.1524279524112;
 Fri, 20 Apr 2018 19:58:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.191.15 with HTTP; Fri, 20 Apr 2018 19:58:43 -0700 (PDT)
From:   Yutian Li <hotpxless@gmail.com>
Date:   Fri, 20 Apr 2018 19:58:43 -0700
Message-ID: <CABvSBngwh_C5dna=U9dLpg3r=BWQH8imsa-3q=yiLFeYdbT17Q@mail.gmail.com>
Subject: [USABILITY] git-reset removes directories
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ok I have been bitten by this issue twice. :(

`git reset --hard` will reset modifications in the working directory
(of course). But if I remove a file, add a directory with the same
name, `git reset --hard` will erase that whole directory.
Specifically the following steps:
```
touch file
git add file
git commit -m "add file"
# now the HEAD is constructed
rm file
mkdir file
touch file/a
# now here is the issue
git reset --hard # this will remove the directory and all its files
```

I guess this has to do with Git not tracking "changing a file to a
directory", especially because one is a blob and another is a tree.

In case of `git reset --hard`, people would expect reverting
modifications, bringing up removed files, but not removing a whole
directory with the same name. Especially if the directory is already
populated. Then the whole thing is gone.
I think it would better if Git could output a warning and abort, like
in case of checkout ("Updating the following ... would lose ...").

But honestly I usually take `git reset --hard` seriously and will
double check before invocation. What actually bit me was `git stash`.
It will call `git reset --hard -q` after saving the working directory.
But in the case I just described, since the new directory is not
tracked, it will not be saved and will be erased. `git stash` usually
gives me the mental model of "saving stuff in working directory", but
not like in this case where it also deletes stuff in working
directory.

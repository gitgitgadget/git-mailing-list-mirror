Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7BEC54EBD
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 10:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234753AbjAIKYB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 05:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237191AbjAIKXi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 05:23:38 -0500
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57727192A9
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 02:22:51 -0800 (PST)
Received: by mail-pf1-f174.google.com with SMTP id y5so5745404pfe.2
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 02:22:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HsdtcYbQGLp770QsgaPBnFplnrJo57L1dlB9EpjaE60=;
        b=5BXuhzs3nwUk3CREvaN/llYJFJFSFl8neBZwDoMdjJFM0fz/mXQPrpNpBKJOSNqd+h
         RuFXbTiOkvWT2OY0vvWUyT06WniVz31pgClGcw06ogjMIaMQRbYXlg62o/54xEzGACMA
         vGiFGRnK/NksaojGyhmG+Lo336TzTKKdYXrfKbVOsaEfd2r7q4AyofC4AUc0Tm1rfWVw
         vf08X06QRZMG2LMHJHWoizFrvtWR1C2yr8VZ3+k04UFW7PA8AKc+XJ0l5Fd/LhIZpfFf
         M1r7KsgKu7MZHVjpfHCPkKVAXToww8VQHCJeP7CBfIUkt6ojnY+Ji/hNraS09LXkUCOj
         kQQw==
X-Gm-Message-State: AFqh2kqOqE5CJ5xzcNO+zTVAgpN2JPTkcLalqAufkDkN8OIJawY9Ftsd
        yGVaFxDW6ovT/RTgTaSBUed7csFwL+Yx2vgUg8Y=
X-Google-Smtp-Source: AMrXdXvHCASBDLukw/0b9QpaXatko77/UVccDB420LnwyT/7SqzJJ6WrOX35+N1rIv45MX4edX5U4OLvkNRM+iRn/3Q=
X-Received: by 2002:a62:ae17:0:b0:575:c857:edc0 with SMTP id
 q23-20020a62ae17000000b00575c857edc0mr4434143pff.22.1673259770774; Mon, 09
 Jan 2023 02:22:50 -0800 (PST)
MIME-Version: 1.0
References: <PH7PR12MB779560B6C003FEE76E4F2471F1FE9@PH7PR12MB7795.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB779560B6C003FEE76E4F2471F1FE9@PH7PR12MB7795.namprd12.prod.outlook.com>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Mon, 9 Jan 2023 11:22:13 +0100
Message-ID: <CA+JQ7M--TeqxH3nj95sAvGTPz9FbHkS2eYfe763w05fUZX0XCA@mail.gmail.com>
Subject: Re: Reducing Git Repository size - git-filter-repo doesn't help
To:     fawaz ahmed0 <fawazahmed0@hotmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 9, 2023 at 3:24 AM fawaz ahmed0 <fawazahmed0@hotmail.com> wrote:
> I have this huge repo: https://github.com/fawazahmed0/currency-api#readme  and I am trying to reduce its size.
>
> I have run filter-repo script on this repo (  https://github.com/fawazahmed0/currency-api/blob/1/.github/workflows/cleanup-repo.yml )

Can you elaborate exactly how you're trying to reduce the repository?
Looking at the script it seems you're removing /latest? And/or folders
corresponding to certain years?

> The commits were reduced from 1k to 600 , but the space used is still same. (i.e size-pack: 6.47 GiB , https://github.com/fawazahmed95/currency-api/actions/runs/3865919157/jobs/6589710845#step:5:1498 )

The number of commits is actually irrelevant, what matters is really
only how much of the tree was pruned. And only if what was pruned
wasn't duplicated.

Say you commit
  2018/big.json
  2019/same-identical-big.json
and then delete 2018, the size of the repository in its packed state
will be virtually identical.

You can analyze which files and directories are occupying the most
space by running
  git filter-repo --analyze
and checking the output file. (It's somewhere like
.git/filter-repo/analysis I don't remember exactly)

However, it seems that you're using git in a highly unconventional
manner and I'd say it's probably worthwhile to consider if it's even
the appropriate tool for the task at hand.

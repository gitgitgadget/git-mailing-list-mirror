Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12610C433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 16:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiBXQSl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 11:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiBXQSk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 11:18:40 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D0E1C8DA2
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 08:18:02 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id e22so4360145qvf.9
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 08:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=859F/c2nc+5pVHHr3vMDFJDi7FVu/ZfApR1nxU4hYGA=;
        b=cqM0I+CcivGRLPpblIYp63nK6qneI0YMS7x/h9phVOr82lJas9PYsFcnwFyXgMf/oZ
         mnLY1Bjq/qA/YUd42p/HAJzUdJxpObtL/FEmeHJH9r6u86L2nK67INYjx8N3dXfm6Ky2
         KQfLRM2cOI2Os1b9v1KW+E2o1FDwY7C/Mkr83rcZNUvVKWiMsKzyqJw4U6HzGG1GqyT+
         RqIyVEp13vRYqimKqefyVlz1yBXFTDbryen4sjmZAjoyQMuF+erGDu/Jwp/lHhegOqmB
         Jr01JH1uH43M+8H6KRwsOhi8s8vbizz2PnkQ+ZFB811WRvX/LVFOhxm8G1V4+nEIOVDK
         wkAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=859F/c2nc+5pVHHr3vMDFJDi7FVu/ZfApR1nxU4hYGA=;
        b=7/IKr54U1M/ktjCzSbYmkfZEkOTCIOLY8cYuJiepaVdnIJZ0dda/9+eylmSj6o9pOv
         GuGQpMlw5wXef4CiUzvSwQA9IMVqu0pxu0Rket/DLww/7PhiTA5i8y6sOAq4ahLuPB5g
         PeOaSWD9UnPdXzQq6HM6Dm7D6YyprmKX6cjOmJgwauatfYK6TbJ8qfibmBEAWy+WXWPy
         4GmMX9dtfDnQ3YZfuNyE1cDpHWzXo0fYpj58xoyIVQ+cYx/7S2au7xIwgRIzi8Ck7cRk
         gC+zZeNHMw6WZiP624EWZhGYgzUs3ZzwdnA0BWn5KC+GOC66dH6Gjh1KPW6zJseLzVwH
         akPQ==
X-Gm-Message-State: AOAM532lCSjlOCgGnXAUwaU1onYTDBtDjRcElTBXLPF6GtqMNST1k+VY
        G3PmsYYnuckZMWuWp7+rXSltjbl3fp1t
X-Google-Smtp-Source: ABdhPJx7TQOGja625h/TxrCDjFc7R52pMlttlu1rQHy3hv6bLfUvNATTLvNIz4rEjQKqVy597rzJ7A==
X-Received: by 2002:ac8:73c6:0:b0:2d8:2b2f:a1d5 with SMTP id v6-20020ac873c6000000b002d82b2fa1d5mr3126391qtp.386.1645719184495;
        Thu, 24 Feb 2022 08:13:04 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id h4sm1621898qtr.95.2022.02.24.08.13.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 08:13:04 -0800 (PST)
Message-ID: <932d7a6a-010d-f659-137e-bf59f0e0b6a8@github.com>
Date:   Thu, 24 Feb 2022 11:13:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 21/23] fsmonitor: optimize processing of directory events
Content-Language: en-US
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
 <07a9c7542be79fb60861253848eca258bec87694.1644940774.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <07a9c7542be79fb60861253848eca258bec87694.1644940774.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/15/2022 10:59 AM, Jeff Hostetler via GitGitGadget wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Teach Git to perform binary search over the cache-entries for a directory
> notification and then linearly scan forward to find the immediate children.
> 
> Previously, when the FSMonitor reported a modified directory Git would
> perform a linear search on the entire cache-entry array for all
> entries matching that directory prefix and invalidate them.  Since the
> cache-entry array is already sorted, we can use a binary search to
> find the first matching entry and then only linearly walk forward and
> invalidate entries until the prefix changes.
> 
> Also, the original code would invalidate anything having the same
> directory prefix.  Since a directory event should only be received for
> items that are immediately within the directory (and not within
> sub-directories of it), only invalidate those entries and not the
> whole subtree.

This makes sense as an optimization. I've also taken a close look at
the code to be sure this makes sense if the file system events are
for a directory within a sparse directory entry, and the end result
will be that the sparse directory is marked as invalid, which is fine.

Thanks,
-Stolee

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2880BC433EF
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 02:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346527AbiAKCLX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 21:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344038AbiAKCLW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 21:11:22 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7D2C06173F
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 18:11:22 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id h30so3277649ila.12
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 18:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p5ouuKUjxOt6/34r9EkTeXB/Z/csZLsGm78+48mClaI=;
        b=Q/QaD22uScFO4ogWhy8WN5Go+RSHJbCzee794KMi7H3E0cNRqmhfo8UwJf83n5TKJy
         M00Gb4sGMiuxPN/0dE3aH97Kyq9Co1VTDKOEz1I6DYy7EvE9HTiqr+DTkv1tIi73m9y5
         lWAsqVHdVPb90afV6aJ0m3j1y+6YeXnqI4HA58h2Z8OHB3By4QkcCYvIMI3qbzAHNGxb
         k9hiyzv83rC17cDUcCf0p+HkX//CA3IFXSRLVJxOWklqnJkJ//ooYG5dGN3gXIj1VaTy
         RLZ1KbfD8I7dgg2UPEPTMfvOGcSWOrPM/lXB1dB35FkSOYxU+HDqVSdyHQntMAXhmohO
         thmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p5ouuKUjxOt6/34r9EkTeXB/Z/csZLsGm78+48mClaI=;
        b=42EVndSEk5/mqZlMlfVgXK/jHS3WcqqSM2Xyru1Gjnor0UyGJVB3F4YCiDpJtPK36X
         c2cLu2g5CzBnDUSPVm6wJ4uPlT2mAY5pxWcj7/OQo0RhUVunA/4dqvNpP1zrrCllRTqS
         y4tLGN+VU1t3E0hdIU4BDZClvtrXnkUTU/LnFittXEMN/DJhxuNf1c3/ZlmKC//0k1Xy
         /k3eBV6buPlSWVM3N8O7rWM5aSUAxdynK2l6oL77w4Zx+nnkrl5mELzSdAGCkTjyBv3q
         I2jyIxNOcezNdIpcSTbVS7Z13rTJ6b+yOCdtjmVspn1DLVb5XRU5PVspCO7PQKO28XdS
         1d7w==
X-Gm-Message-State: AOAM53173tp+q7VKfkQ0VXbiEqa+J5knMaz8GDZuOkQgVXd8QRbbRaCI
        Av0wbViFOZ3OiroNTnmmNvGHIo3ZCYskJw==
X-Google-Smtp-Source: ABdhPJzuVrQUIsftxmgzUjBx/ISF3e66LT9jIg1w+zubVimyGUNXxHVyQt0m5yExFVR4SrtsGPc3kw==
X-Received: by 2002:a92:c248:: with SMTP id k8mr1311395ilo.212.1641867081536;
        Mon, 10 Jan 2022 18:11:21 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y4sm5002335iln.4.2022.01.10.18.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 18:11:21 -0800 (PST)
Date:   Mon, 10 Jan 2022 21:11:20 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>,
        git@vger.kernel.org, iwiedler@gitlab.com
Subject: Re: [PATCH 1/1] fetch: fix deadlock when cleaning up lockfiles in
 async signals
Message-ID: <YdznSPJCSUQwVyg8@nand.local>
References: <cover.1641552500.git.ps@pks.im>
 <555ec6717ecab0fe6ef5660bcf0d61d59f84ef8b.1641552500.git.ps@pks.im>
 <YdjBkZsnYd+zYne1@nand.local>
 <2d8c1619-74ab-62b3-3a30-8e500a16649e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2d8c1619-74ab-62b3-3a30-8e500a16649e@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 08, 2022 at 10:54:35AM +0000, Phillip Wood wrote:
> > But is unlink() safe as-is? I'm not so sure. Reading signal-safety(7),
> > it's clearly on the list of functions that are OK to call. But reading
> > the errno section:
> >
> > (snip)
> >
> > We certainly not doing that, though that's nothing new, and so I wonder
> > why it doesn't seem to be an issue in practice.
>
> Because in this case we re-raise the signal and exit it does not matter if
> unlink() clobbers errno. If instead the program were to continue after
> handling the signal then we would have to save and restore errno to avoid
> interfering with the code that was running when the signal handler was
> called.

That makes perfect sense to me. Thanks for a clear explanation.

Taylor

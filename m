Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A905CEB64D7
	for <git@archiver.kernel.org>; Fri, 16 Jun 2023 22:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjFPWpf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jun 2023 18:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbjFPWpb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2023 18:45:31 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF8F359C
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 15:45:30 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f8d0d68530so11514705e9.0
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 15:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686955529; x=1689547529;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Di3P3m1AxgFGf1U9OSotd3CbGlAz4lXoYxYrv820gRg=;
        b=UXQv1qZdspNHZ6m1jmRBxAwInzQuImbVZf/SJYgfFacbExZQ8nNwLUdQ4aBiUjkm3p
         zc/DKvvALi1rJc3IEsDNtQx8PORjdF4Kl9JUe+CpnwF0hJ1O6t37ociCzl5HeZCF0buM
         nCp7+2UVOFNZQ+MMMZgRXirAic/4rHswXW64QDKpfTnoxm8tcLMm07DusL+wnlzL00xC
         siEGF38mAnobVBxDcpc/0Z+UZvPqbr1TkUXlu7dff32H2fOAhHJi+yo1LdVI9r8s64/Y
         OME9LCCf2jQ4i6DSSCbfKlorkdnxxhf2tClgrVX3KVi5oa7QUueJHpbOhZz3dc/zc7tO
         4dmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686955529; x=1689547529;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Di3P3m1AxgFGf1U9OSotd3CbGlAz4lXoYxYrv820gRg=;
        b=M5/5VlBOUaV+vUES4UzRcugWlfXsZYwH7URVVpZcqOi4cEbr8u61se3rwwf/xXydJ/
         Jrp1qyR/Fe0d0FTFLU+paOK1as3koNTmrYNZiguRBiQ7XybzfFu4oVFb4K5piOGYFe8H
         vRS9e78KdZ5eUaxFak83l5Ytwp2jKt3DZQ3whFGwDKfxdyElBUHlCBJYAfpLimuLRKiz
         2edZxrHSE1Z618DReBnZL2qR6nyMaPq2atUqqB6XQscC+dUPaaldj5kS47w//4JbbD5z
         yYgjRYQmPV7qvnvU6G7TK+RvfTzC4v1ixkyyV0ApMXp7e1AViVOAI8j33qCctJcKdjZf
         Xp3w==
X-Gm-Message-State: AC+VfDw5Gms47SSU9OakU+60jhn17KFL0hbbjLlrCL01GzYRzZ4cqepL
        zLD1slSgg5FjrxIPWaSAB88EXBOpK2w=
X-Google-Smtp-Source: ACHHUZ5lMAq8kVixUkvUBLPW4hNlIu3HLBnb03wpeofrnePjJns6utwsQCyDTeys/ON3uKpUbkfv1w==
X-Received: by 2002:a5d:5445:0:b0:30f:c56c:b5a7 with SMTP id w5-20020a5d5445000000b0030fc56cb5a7mr2481227wrv.4.1686955529179;
        Fri, 16 Jun 2023 15:45:29 -0700 (PDT)
Received: from [192.168.2.52] (151.red-88-14-53.dynamicip.rima-tde.net. [88.14.53.151])
        by smtp.gmail.com with ESMTPSA id w18-20020a05600018d200b0030af54c5f33sm24662786wrq.113.2023.06.16.15.45.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 15:45:28 -0700 (PDT)
Subject: Re: [PATCH 04/11] branch: fix a leak in dwim_and_setup_tracking
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
References: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
 <a6fec1ab-4006-2896-a2d9-dc0d8fa1c132@gmail.com>
 <20230612032106.GD306352@coredump.intra.peff.net>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <e75092a4-2629-85a9-1bd2-3193d6719a65@gmail.com>
Date:   Sat, 17 Jun 2023 00:45:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20230612032106.GD306352@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11-jun-2023 23:21:06, Jeff King wrote:
> On Sun, Jun 11, 2023 at 08:49:43PM +0200, Rubén Justo wrote:
> 
> > In e89f151db1 (branch: move --set-upstream-to behavior to
> > dwim_and_setup_tracking(), 2022-01-28) the string returned by
> > dwim_branch_start() was not freed, resulting in a memory leak.
> 
> Yep, looks good. One small comment:
> 
> > diff --git a/branch.c b/branch.c
> > index ba3914adf5..a7333a4c32 100644
> > --- a/branch.c
> > +++ b/branch.c
> > @@ -638,9 +638,10 @@ void dwim_and_setup_tracking(struct repository *r, const char *new_ref,
> >  			     const char *orig_ref, enum branch_track track,
> >  			     int quiet)
> >  {
> > -	char *real_orig_ref;
> > +	char *real_orig_ref = NULL;
> >  	dwim_branch_start(r, orig_ref, track, &real_orig_ref, NULL);
> >  	setup_tracking(new_ref, real_orig_ref, track, quiet);
> > +	free(real_orig_ref);
> >  }
> 
> Adding the NULL-initialization signals that we expect that real_orig_ref
> might sometimes _not_ be filled in by dwim_branch_start(). But I think
> it always will be; and if it weren't, that would make passing it to
> setup_tracking() rather suspicious.
> 
> So I don't think the NULL initialization is wrong, and certainly it is
> more defensive. But I find it a little misleading.

I don't have any objection to this.  But I've seen Junio has already
merged this to 'next'.  I'm not going to re-roll this commit.  Sorry.

Thank you for your review.

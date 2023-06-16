Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9BBEB64D7
	for <git@archiver.kernel.org>; Fri, 16 Jun 2023 22:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245310AbjFPWuy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jun 2023 18:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245204AbjFPWuw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2023 18:50:52 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDE53AA8
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 15:50:49 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-30fb7be435dso971208f8f.1
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 15:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686955848; x=1689547848;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uOi8JHxXteeriiLOrqBcM+4/tywhALXPQ7whQapUDB8=;
        b=Ao/S/6xKdWvHYrgG5fZc+U/JyuDxkkHERtRYgq9vFIholJlUWi5c8YxXU9vKfTnAVT
         LAcKdydMv+k8MoWXjrwpZ3KzOaT8qTBo01v3mxcFy3x3d8XzQr76XBEe1ub2sna+PHRe
         XRK/YLbEvFVO/8eKua3AwOJ5NnUs0ZIWegTcKVo7Ds73eW6kNKvZas4Bu1YA7Kxkllhb
         gm0jx6BB29zahyJTRvk1YdPbUE+Gxk3oOZ/8fJfofDWBUBs+/Wbj/EvHefYM1wOENJ3k
         1CaZVosOTTVvLjxFiCUaYgz4xzH4qWbXm4MsZ/essDhAaVKO7XMgEHSTVtKdzkJehfPE
         lISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686955848; x=1689547848;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uOi8JHxXteeriiLOrqBcM+4/tywhALXPQ7whQapUDB8=;
        b=NBCO9CXN6jOvfwqE2c0odg2qGL36p3n3DzK/8exFCZ+HexGYPVLw0KGV5e/nOaXWWq
         cSwzpWPcR94ocraaem42EDpsWP9JbEDhF7RuqSSZ+9PDgddf1K72rH+LrCKn6Mw/tsJZ
         GSYJpWG0qtkU78VIH/QY7GPWaLgE9y+z3jiOgPDcjdxct9qnfurt6PFJRkSgKri8Ydk5
         GgbWp842S8NrJVPg5fCiDNVyjj8sy6frn7MTYVBI+09KDg+cRxzzzmYL2fmFWj3Rnk21
         uPJmQu1lu9+tZjDxCNWAzi2FsuqzZHSyUkTyItrzgQjsrHAHQCoCq8VdBu67QpmogLMZ
         Bqeg==
X-Gm-Message-State: AC+VfDzgj/gRJ4TNKsCyymnLWcsuxBHkztsSIHbiFukYSJjcVSW/8aBh
        fsZnhwiP29b9riyspGCsqysXI8/rt8I=
X-Google-Smtp-Source: ACHHUZ5nhvm47lI3MNcFrOGGEHJeQZAArH5v3lExuwb6RqhauoDzYPoeCOlNhBdkFOf1sHqtlGuLeQ==
X-Received: by 2002:adf:df0b:0:b0:311:1009:10c9 with SMTP id y11-20020adfdf0b000000b00311100910c9mr2662940wrl.5.1686955847785;
        Fri, 16 Jun 2023 15:50:47 -0700 (PDT)
Received: from [192.168.2.52] (151.red-88-14-53.dynamicip.rima-tde.net. [88.14.53.151])
        by smtp.gmail.com with ESMTPSA id m9-20020a056000008900b0030ae499da59sm24724483wrx.111.2023.06.16.15.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 15:50:47 -0700 (PDT)
Subject: Re: [PATCH 06/11] branch: fix a leak in cmd_branch
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
References: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
 <6cbdf9b9-227a-4665-5725-6a863676e95d@gmail.com>
 <20230612034639.GF306352@coredump.intra.peff.net>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <2ff000c5-5b90-6271-a676-78c5bc93a054@gmail.com>
Date:   Sat, 17 Jun 2023 00:50:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20230612034639.GF306352@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11-jun-2023 23:46:39, Jeff King wrote:
> On Sun, Jun 11, 2023 at 08:50:05PM +0200, Rubén Justo wrote:
> 
> > We don't have a common clean-up section in cmd_branch().  To avoid
> > refactoring and keep the fix simple, and while we find a better
> > solution, let's silence the leak-hunter making the list static.
> 
> Gross. :)

XD

> 
> If we are just going to annotate here, I'd prefer to use UNLEAK(). It
> makes it more obvious this is about leak-checking, and doesn't imply
> that we otherwise care about the lifetime of this field. Like:
> 
> diff --git a/builtin/branch.c b/builtin/branch.c
> index e6c2655af6..075e580d22 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -832,6 +832,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  	if (list)
>  		setup_auto_pager("branch", 1);
>  
> +	UNLEAK(sorting_options);
> +
>  	if (delete) {
>  		if (!argc)
>  			die(_("branch name required"));

OK.  Will do this.

Thank you for reviewing the change with a wide view.

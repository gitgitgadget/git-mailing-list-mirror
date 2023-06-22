Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED5AEB64DA
	for <git@archiver.kernel.org>; Thu, 22 Jun 2023 21:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjFVVVj convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 22 Jun 2023 17:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjFVVVh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2023 17:21:37 -0400
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F49F1
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 14:21:37 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-62ffe4cabecso57235066d6.1
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 14:21:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687468896; x=1690060896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iXfhmWt99S42adGVCtbmYa1yqDaJ0qw9/4KCP+yClwA=;
        b=E7EzPHn2atTesO6N/vSjIzz63rnpPygiCpStQ4R/CZLB4KW/1j0miMf7wvHYC3R39Z
         ZlrtY/YTy7TbZnuWoT6oRvKKlm7Dp9TSmrk10sOVsxaa4126FKcQq+p7796rvE2+X8n2
         2/SpGMF+TQHSx2hkmSU1rmImYTntKrdnUe3siEJnk8FV+0W4bHCGb1PPGUyLc3JGb+pq
         GQ7JUp872J4W19T4K9Me0OWMucTXicWU1NYPniEZ1gBBJHv1C4e9QGaawbNT2PJrKYqe
         it+FQToUyY1ISFDZRr9OfKrVPzkEeCu2f7RZh+3jo7+jmHsImHCpsFGrwqnHq3N94uJl
         u+Fg==
X-Gm-Message-State: AC+VfDxnmeSn0GV4K3ZM8RfIsNRY0J/VQR46BNLfKrp1IkRZzARG5Hzc
        HKsEJfffBOjBl1K1WqjTz2ZDooPIjywATTf2W+I=
X-Google-Smtp-Source: ACHHUZ71t8l+Xfo71HlZv6I0aLpTHx0unO2gGZV80sCDSNsD3uZB0TQPYUYdfMgxp06gG/W7R9WFM8geRfn0X8KV+gA=
X-Received: by 2002:a05:6214:29cc:b0:626:37fe:218c with SMTP id
 gh12-20020a05621429cc00b0062637fe218cmr22183426qvb.24.1687468896098; Thu, 22
 Jun 2023 14:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230622195059.320593-1-sandals@crustytoothpaste.net> <20230622195059.320593-3-sandals@crustytoothpaste.net>
In-Reply-To: <20230622195059.320593-3-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 22 Jun 2023 17:21:25 -0400
Message-ID: <CAPig+cTq2QfOX71MZbxQo5uLMuekFXtf=eiAk0f_o_Du=v1P_Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] var: add attributes files locations
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 22, 2023 at 4:06 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Currently, there are some programs which would like to read and parse
> the gitattributes files at the global or system levels.  However, it's
> not always obvious where these files live, especially for the system
> file, which may have been hard-coded at compile time or computed
> dynamically based on the runtime prefix.
>
> It's not reasonable to expect all callers of Git to intuitively know
> where the Git distributor or user has configured these locations to
> be, so add some entries to allow us to determine their location.  Honor
> the GIT_ATTR_NOSYSTEM environment variable if one is specified.  Expose
> the accessor functions in a way that we can reuse them from within the
> var code.
>
> In order to make our paths consistent on Windows and also use the same
> form as paths use in "git rev-parse", let's normalize the path before we
> return it.  This results in Windows-style paths that use slashes, which
> is convenient for making our tests function in a consistent way across
> platforms.  Note that this requires that some of our values be freed, so
> let's add a flag about whether the value needs to be freed and use it
> accordingly.
>
> Signed-off-by: brian m. carlson <bk2204@github.com>
> ---
> diff --git a/attr.h b/attr.h
> @@ -227,4 +227,8 @@ void git_attr_set_direction(enum git_attr_direction new_direction);
> +const char *git_etc_gitattributes(void);
> +const char *get_home_gitattributes(void);
> +int git_attr_system(void);

I forgot to mention that it would be appreciated if you document these
new public declarations. Even a one-sentence comment would be helpful.
For instance:

    /* Return the location of the personal .gitattributes file. */
    const char *get_home_gitattributes(void);

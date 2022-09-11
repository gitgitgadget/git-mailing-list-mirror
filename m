Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FB4ECAAD5
	for <git@archiver.kernel.org>; Sun, 11 Sep 2022 01:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiIKBB4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Sep 2022 21:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiIKBBy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Sep 2022 21:01:54 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFFB48C93
        for <git@vger.kernel.org>; Sat, 10 Sep 2022 18:01:53 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-346cd4c3d7aso60630527b3.8
        for <git@vger.kernel.org>; Sat, 10 Sep 2022 18:01:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=9ZtE83y00QnuAPkmiU1GxY56nosq20jDjgF69dMLcdE=;
        b=gWtt1E71PjCL0l7Rd6wauBYn0wmgWQE5G6sq1XGOWhRus8uy9hDtZgIf3Ufdfrz3Q4
         Eoo4Cf9vdVT6YBohlhc4cLMnTMnaWyJv1lNNglseUNwmFyfjHjpVLcBh/KA7fr2zuuXf
         zJdREs11TGTlJpsaZvr3KUqUblvxJx5erL9JL4Qv6uRILAIxNDZ3E9460OAbERCbV8bY
         74vfacVbL5aYK8jDrcU+MhC0caJrsPY8e86/Ii9cppmpniEAnsBLCNxWebayVNygoKj/
         +8LD+AicPrbwswdtzP6rCXbeAIZq/8Rl0/0hjQrVwShMHHgoatoQJ2kYBo/M8b2M5vig
         EnXw==
X-Gm-Message-State: ACgBeo2SBEVCR5cNr6CGLpqGlPgxd42k10rXdzHSCHGRUkbmTsYv65y8
        YO61MW/Izp96iasHJu7nBpPPTHjTF/Hcl0DrlII=
X-Google-Smtp-Source: AA6agR7RkgY1XXiswwGzuRsD4l0mh5NByVfDjzUS/a7mcVBmjb/NISj3qBm9DHEC2ePNdGUQAneXVwF0br1PfwOSA3M=
X-Received: by 2002:a0d:c807:0:b0:336:cac2:59eb with SMTP id
 k7-20020a0dc807000000b00336cac259ebmr17405921ywd.70.1662858112201; Sat, 10
 Sep 2022 18:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1326.v4.git.1661962145.gitgitgadget@gmail.com>
 <pull.1326.v5.git.1662840031.gitgitgadget@gmail.com> <b7d6cf44695c7b6285573f454ebfd3866fe49f38.1662840031.git.gitgitgadget@gmail.com>
In-Reply-To: <b7d6cf44695c7b6285573f454ebfd3866fe49f38.1662840031.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 10 Sep 2022 21:01:41 -0400
Message-ID: <CAPig+cT0mKAX86cKPaJ44tH1StH+GnOEHuJEu=G4w2fOKkEgpQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] fsmonitor: deal with synthetic firmlinks on macOS
To:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jeff Hostetler <git@jeffhostetler.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta <edecosta@mathworks.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 10, 2022 at 4:00 PM Eric DeCosta via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Starting with macOS 10.15 (Catalina), Apple introduced a new feature
> called 'firmlinks' in order to separate the boot volume into two
> volumes, one read-only and one writable but still present them to the
> user as a single volume. Along with this change, Apple removed the
> ability to create symlinks in the root directory and replaced them with
> 'synthetic firmlinks'. See 'man synthetic.conf'
>
> When FSEevents reports the path of changed files, if the path invloves
> a synthetic firmlink, the path is reported from the point of the
> synthetic firmlink and not the real path. For example:

s/invloves/involves/

> Real path:
> /System/Volumes/Data/network/working/directory/foo.txt
>
> Synthetic firmlink:
> /network -> /System/Volumes/Data/network
>
> FSEvents path:
> /network/working/directory/foo.txt
>
> This causes the FSEvents path to not match against the worktree
> directory.
>
> There are several ways in which synthetic firmlinks can be created:
> they can be defined in /etc/synthetic.conf, the automounter can create
> them, and there may be other means. Simply reading /etc/synthetic.conf
> is insufficient. No matter what process creates synthetic firmlinks,
> they all get created in the root directory.
>
> Therefore, in order to deal with synthetic firmlinks, the root directory
> is scanned and the first possible synthetic firmink that, when resolved,
> is a prefix of the worktree is used to map FSEvents paths to worktree
> paths.
>
> Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
> ---
> diff --git a/compat/fsmonitor/fsm-path-utils-darwin.c b/compat/fsmonitor/fsm-path-utils-darwin.c
> @@ -38,3 +41,91 @@ int fsmonitor__is_fs_remote(const char *path)
> +/*
> + * Scan the root directory for synthetic firmlinks that when resolved
> + * are a prefix of the path, stopping at the first one found.
> + *
> + * Some information about firmlinks and synthetic firmlinks:
> + * https://eclecticlight.co/2020/01/23/catalina-boot-volumes/
> + *
> + * macOS no longer allows symlinks in the root directory; any link found
> + * there is therefore a synthetic firmlink.
> + *
> + * If this function gets called often, will want to cache all the firmlink
> + * information, but for now there is only one caller of this function.
> + *
> + * If there is more than one alias for the path, that is another
> + * matter altogteher.
> + */

s/altogteher/altogether/

> diff --git a/fsmonitor-path-utils.h b/fsmonitor-path-utils.h
> @@ -1,6 +1,14 @@
> +struct alias_info
> +{
> +       struct strbuf alias;
> +       struct strbuf points_to;
> +};
> +/*
> + * Get the alias in given path, if any.
> + *
> + * Sets alias to the first alias that matches any part of the path.
> + *
> + * Returns -1 on error, 0 otherwise.
> + */
> +int fsmonitor__get_alias(const char *path, struct alias_info *info);

I suppose it's somewhat clear here that the caller is responsible for
releasing the strbufs in alias_info (though it's not clear why they
need to be strbufs in the first place)...

> +/*
> + * Resolve the path against the given alias.
> + *
> + * Returns the resolved path if there is one, NULL otherwise.
> + */
> +char *fsmonitor__resolve_alias(const char *path,
> +       const struct alias_info *info);

But what about the return value from this function? It's `char*` which
suggests a possible ownership transfer(?). Is the caller responsible
for freeing it? If so, perhaps the documentation could state that.

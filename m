Return-Path: <SRS0=D6Hn=4A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16BEC352A4
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 21:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9347A206D7
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 21:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgBLVN4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Feb 2020 16:13:56 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55246 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbgBLVN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Feb 2020 16:13:56 -0500
Received: by mail-wm1-f67.google.com with SMTP id g1so3919701wmh.4
        for <git@vger.kernel.org>; Wed, 12 Feb 2020 13:13:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WTcXxM1vaVfK01MbrVTHucRbJ+esuSybn374X6KSGrQ=;
        b=YRxZLkNUMgsJDm/OYZiyt0z91DkN9ZqX1MY9YuVLMnckGE28Dl9wSW/s0laliGsrxm
         AhIHAgU/CKTvrlHBwZ8L5rngV6U0AlgnLwXgDX2R2S7dH/MlSZUR7t2bgtjmEyC1mr93
         w/l6VLdaOEYloeYzdSbpj68gE31oYdxIa13ckz+RAlImn/hGrKQiN2ethRk4QpHeN0Sa
         yPMbGgXEMsdjD7kZ7KiBsM3sEOyhEvQFgz5cq5bheKNxnJCV6tRVh7oYXGY1QSBvQecp
         sAYxf6A3ANXus9p1B7+YX2w/eBM3EURe+IH3cz/uxIb1AZTzHmmEyCaoPNb9DexWhZ9A
         /flg==
X-Gm-Message-State: APjAAAUKAPENuuFLNgvN8j9yfropJRD8UknQMUQS3JmRI5AZHtizotd9
        sJGDTP4d1l5gu4iFTfq1GrAwy4buOzYm6P2peC35GsQ4
X-Google-Smtp-Source: APXvYqwI4ExlcbH9SRzYacDPZJ+UiObWUuvz7w0owDJmRNFcAMHFe1DdWYxj0tLNjXlp2qHzuLmjoseJ+N4ytBB7q4c=
X-Received: by 2002:a05:600c:21c6:: with SMTP id x6mr994428wmj.177.1581542034297;
 Wed, 12 Feb 2020 13:13:54 -0800 (PST)
MIME-Version: 1.0
References: <pull.545.git.1581535151.gitgitgadget@gmail.com>
 <d98b7caff56cc839f251ac43c36826ecf800cf2f.1581535151.git.gitgitgadget@gmail.com>
 <20200212202210.GC4364@syl.local>
In-Reply-To: <20200212202210.GC4364@syl.local>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 12 Feb 2020 16:13:42 -0500
Message-ID: <CAPig+cQhh8pNppSsGGk62-VoHsOUv0aNTxHtDWY+_pousR+KMg@mail.gmail.com>
Subject: Re: [PATCH 1/5] object.c: get_max_object_index and get_indexed_object
 accept 'r' parameter
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Parth Gala via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Parth Gala <parthpgala@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 12, 2020 at 3:22 PM Taylor Blau <me@ttaylorr.com> wrote:
> On Wed, Feb 12, 2020 at 07:19:07PM +0000, Parth Gala via GitGitGadget wrote:
> > diff --git a/builtin/fsck.c b/builtin/fsck.c
> > @@ -375,6 +375,7 @@ static void check_object(struct object *obj)
> >  static void check_connectivity(void)
> >  {
> >       int i, max;
> > +     struct repository *r = the_repository;
>
> Is there a reason that you assign use/assign 'r' here? [...]
> but I'm not sure that it's necessary here. Could you instead pass
> 'the_repository' directly to the functions that now require it?

One benefit of doing it this way is that future patches will be much
less noisy which convert these callers to also work with any
'repository' object. For instance, after the current patch, we have:

    static void check_connectivity(void)
    {
        struct repository *r = the_repository;
        max = get_max_object_index(r);
        ...

A future patch which converts check_connectivity() to work with any
repository will then require very little change -- just adding an 'r'
argument to the function declaration, and dropping the line which
declares 'r':

    static void check_connectivity(struct repository *r)
    {
        max = get_max_object_index(r);
        ...

So, I'm fine with this patch series' approach of declaring a variable
'r' like this.

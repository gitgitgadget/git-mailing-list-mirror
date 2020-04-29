Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61838C83000
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 23:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46412208E0
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 23:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgD2XED (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 19:04:03 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54866 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgD2XED (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 19:04:03 -0400
Received: by mail-wm1-f66.google.com with SMTP id h4so3858774wmb.4
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 16:04:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3h2h8L0SniXZYGK62Fmo9byvugJ0IPbGyJAz/EhUrMs=;
        b=mDAqfF4pGCTh/jGJz5zuU40WSvAtTkARrGH7PSnrJUgbFDaueH1HxEK9Ku5JBTi/Av
         B5O2XErNI8TEuM/rwv8SErbdAGpuUInt1h0aOpmaZ1sKO5Lo5sZxzwq/DAEEnQjY1pVL
         Ebb0nwIKYtl54MUy3go3gmRrGvrMTtAYPtijQkDRcgy5RbEofGzKdzWSq8IutuqXyzD7
         Y2jCmflsO5hzNZ2ofqruKFuOPYkSCXF2tBRo+YuifgRw9XqzOZUnySu2OYe1DrCp8y8W
         vwZTPDh+tjxb7gkLQpuw+NAEr6nse7vFZF0l+c3/nosyJGTtZ0cJUu/aYZ6QqCgOdTQE
         DWmA==
X-Gm-Message-State: AGi0PubFUQ959JW05uTXK8cshdJfNo6fU4Q20H6xoR2auyUP5zpoARj9
        FEqavF3KY4gaWB2gSyPDF7jMsCz3tzDwqQsra7I=
X-Google-Smtp-Source: APiQypJeDzYoK7kSnNTENO4CwGlc026aiipYLbhZOKND6t4CfAwZo36zqduonr7EuwthL6MNvglgh5hkB5omJz3pO5o=
X-Received: by 2002:a1c:4e12:: with SMTP id g18mr171124wmh.11.1588201440106;
 Wed, 29 Apr 2020 16:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588199705.git.me@ttaylorr.com> <c0dc5024a9b368dfbca99b81bc843f66d725f3d7.1588199705.git.me@ttaylorr.com>
In-Reply-To: <c0dc5024a9b368dfbca99b81bc843f66d725f3d7.1588199705.git.me@ttaylorr.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 29 Apr 2020 19:03:48 -0400
Message-ID: <CAPig+cTvX1wT8kAha22uUQ5PDQ0mjeoDGQdA6VtMzfnAELpTaA@mail.gmail.com>
Subject: Re: [PATCH 5/5] shallow: use struct 'shallow_lock' for additional safety
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 29, 2020 at 6:39 PM Taylor Blau <me@ttaylorr.com> wrote:
> [...]
> This patch introduces that type as a thin wrapper around 'struct
> lockfile', and updates the two aforementioned functions and their
> callers to use it.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
> diff --git a/shallow.h b/shallow.h
> @@ -10,12 +10,22 @@ void set_alternate_shallow_file(struct repository *r, const char *path, int over
> +/*
> + * shallow_lock is a thin wrapper around 'struct lock_file' in order to restrict
> + * which locks can be used with '{commit,rollback}_shallow_file()'.
> + */
> +struct shallow_lock {
> +       struct lock_file lk;
> +};

The documentation comment for 'shallow_lock' may help newcomers to C
but probably doesn't add much value for seasoned programmers. If this
is the sort of idiom we want to introduce (or exists already in this
codebase) -- declaring a specific C type to avoid accidental use of an
unrelated lock -- then it's probably better documented in
CodingGuidelines rather than repeating it at each point in the code
which employs the idiom.

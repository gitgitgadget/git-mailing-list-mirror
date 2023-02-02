Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AFEC61DA4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 23:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbjBBXJl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 18:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbjBBXJb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 18:09:31 -0500
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3504F7DBFD
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 15:09:28 -0800 (PST)
Received: by mail-pl1-f170.google.com with SMTP id n13so3476501plf.11
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 15:09:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UFFpeKrjPOznN0iMDMAaA1rNJhTlZl5b0HQUeyzfiZI=;
        b=Whr2d5UOACDXNFcocOYhzSUDKIrGzZM4RVHCiQSE+A0PmBcbgrte9A14zaHDsFgr7s
         +q+eu3B8ACb0yQ8aH2kC/8WpLgdzb8DnWA/gyu85mf6v0X9Kg+NL9hfXqIjKACnUn+Pt
         e7x19g1PWgvURf8ufMVX/Qt6W+ofUnCAZVXDDGUg2Rn6roM+U753XzILmGxFGwvcak1u
         /M3rpmqgxX+ZmipmAkDHf7LjgIf9jBg+GcEbMOimC//HPZ/+0A4cbfFp9JshqSiqifji
         mMccW9EXHuLjzdE3wd6o2/wpZdImM/0+YxVmVbF3nXIe6Z0qnKMSEQ6OTcZMzUoideR0
         Jruw==
X-Gm-Message-State: AO0yUKXv5im/pztOuoH66jDnUVbUKpzao20vpvyj73uOHMDaBYxws5bb
        x2yEpqdjnjF579e9++cC2830dOMmLgcyJpDoyhc=
X-Google-Smtp-Source: AK7set/AkGJrqDfv6zyWxPDph1+wtHobcTOpnOonRTSNpx5dAcDKg9rMcJVrSOU8qz5Vl6tCsFEhP7jLqIYqxfvaN0Q=
X-Received: by 2002:a17:90a:ea0f:b0:22c:7bd:d662 with SMTP id
 w15-20020a17090aea0f00b0022c07bdd662mr947246pjy.81.1675379367552; Thu, 02 Feb
 2023 15:09:27 -0800 (PST)
MIME-Version: 1.0
References: <20230202202557.19297-1-kostya.farber@gmail.com> <xmqqa61vsniy.fsf@gitster.g>
In-Reply-To: <xmqqa61vsniy.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 2 Feb 2023 18:09:16 -0500
Message-ID: <CAPig+cTC4TUK2NXFmP6ymEYYjYAmCSd53dzFhKn0ido8x6uh1Q@mail.gmail.com>
Subject: Re: [GSoC][PATCH] t/t5000-tar-tree: add helper function
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kostya Farber <kostya.farber@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 2, 2023 at 5:37 PM Junio C Hamano <gitster@pobox.com> wrote:
> Kostya Farber <kostya.farber@gmail.com> writes:
> > Add the helper function test_file_path_exists to the
> > interpret pax header test. This change makes it clearer
> > as to what the test is trying to check, in this case whether
> > a file path exists.
> >
> > -                             if test -h $data || test -e $data
> > +                             if test -h $data || test_file_path_exists $data
>
> Nothing seems to be adding a new helper whose name is
> test_file_path_exists; the patch expects such a helper already
> exists and uses it in place for existing "test -e".
>
> Perhaps you meant to say "use test_path_exists" not "add helper" on
> the title, and use that function in the patch instead?

A couple comments...

The test framework does not define a function named
"test_file_path_exists". Probably "test_path_exists" was intended.

Delving more deeply, though, this change seems undesirable from a
clarity viewpoint. The function "test_path_exists" is an assertion;
its purpose is to make the test fail if the path is expected to exist
but doesn't. However, in the original code from t5000:

    if test -h $data || test -e $data
    then
        path=$(get_pax_header $header path) &&
        if test -n "$path"
        then
            mv "$data" "$path" || exit 1
        fi
    fi

it is perfectly fine if the path is neither a symbolic link nor an
actual file; that's not considered an error. Therefore, using an
assertion function -- which suggests test failure -- muddles the
intent of the code rather than clarifying it.

Additionally, t/test-lib-functions.sh also defines the function
"test_path_is_symlink" which would seem to be the obvious complement
to "test_path_exists", thus one might have expected the patch to
change the code to:

    if test_path_is_symlink $data || test_path_exists $data
    then
        ...

however, "test_path_is_symlink" is also an assertion, thus not really
suitable for this case in which it is acceptable (not an error) if
neither condition holds true.

So, t5000 seems to be one of those relatively rare cases in which the
raw "test" command is more correct than the higher-level helper
functions.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E1BC46467
	for <git@archiver.kernel.org>; Sat,  7 Jan 2023 23:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbjAGXEJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Jan 2023 18:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjAGXEI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2023 18:04:08 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B9734D76
        for <git@vger.kernel.org>; Sat,  7 Jan 2023 15:04:07 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id p17so3638204qvn.1
        for <git@vger.kernel.org>; Sat, 07 Jan 2023 15:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W/n2BhV2xFdqB8pC7XiIml2V4li33n/sndHUrRqGjXI=;
        b=pIyYT3c0HlyW+z5QHYl3IzcEgMW8aEne57jNDS4sy0zo32uHKYd7XtNlkV6Koj97vn
         4XgVkfUIWii3/csYMzU9gaETMke4QX/4lGyqxZgs4kHAbDoUsFuA2hwzbALCYZiZYkrM
         galX87dOQs5hUR53FA6jCT9/wcgbivzD7TjQVxLvA50lTMXzDnF6tE2mbqwE9602ZIFn
         ttXtm9E5CeY/maym+OsENbZC3J5YnQXFgb3Hf1GI4I7SV1FQieIu8n64z/3gU5QVuXwy
         SbJyakcsWxDRc08ZYQw+WPuqFfdMzGzVxBjWSyMrEXSHU91WnpEmvHlw+0AeGWJXtnIf
         6ccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W/n2BhV2xFdqB8pC7XiIml2V4li33n/sndHUrRqGjXI=;
        b=Un/uPHLKMh9MLEMwckGrJX3e0dDLfpRJZdp3gIBITM8HLZIcemeIYhNF5pwh1puFAV
         KDBtXDIA+HClPD62huvhWSoNp63R08gXxzYihNiSO+GbC0k5zzsZQrtJG8xIumt5KmcW
         MsNKIhgJnGf73PmhZnAsKO4Xw/uIrMsDWW+5nU7lS9DNt5sJNFlSwJL93Za0cdkFech9
         o2jAKu40/bQTRJVnKs/XuwCt6HfSdOTGosLAzxmrixyl0CJ1koBl4tRtpobE8TXd+40m
         RI5Q2rOjkl9K93H6gcu5u/y+zQglSNfve1j0DD0Rgs3OIwXKAteIEn6oU0eUhfTxN74j
         1xNQ==
X-Gm-Message-State: AFqh2krNp1rAR6y50dvhv0Kr1S7/quNtmfp0FbeMIjtKeqKMnqFEL1xt
        IJ/1x2lbi9Xv8+RG++meQcwjJK4QOpY9Q0qphL4JrsX1Th2wPQ==
X-Google-Smtp-Source: AMrXdXuN8Lwx7SbbFx9iZkaY7BdQ5xovzJ9FB93syNmn5lyY5H3PuOkPeHFUtawePeOggpG3CZXF/Fe9UnVssOeLetI=
X-Received: by 2002:a05:6214:3101:b0:51f:6af1:8fac with SMTP id
 ks1-20020a056214310100b0051f6af18facmr4089389qvb.11.1673132646697; Sat, 07
 Jan 2023 15:04:06 -0800 (PST)
MIME-Version: 1.0
From:   demerphq <demerphq@gmail.com>
Date:   Sun, 8 Jan 2023 00:03:55 +0100
Message-ID: <CANgJU+Vo3B=YuqgWVgiRMMiBwTFEh98O0LSJJ+ES6EM=MP4Cew@mail.gmail.com>
Subject: should git rev-parse -q --verify on a range produce output?
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I was curious if it is a bug that `rev-parse -q --verify` produces
output for a commit range, and only reveals it is supposed to be used
with a single commit as an error message? When combined with -q it
make it seem like it has silently worked if you aren't careful to
check $? afterwards. (Which obviously some script wasn't or I wouldn't
be posting this. :-)

For example:

git rev-parse --verify -q HEAD^..HEAD; echo $?
869400a03fff1b3dcff82f3357d37ab506af2788
^13073008cfc15016d862c630d56323bb7c9d775e
1

"looks" like it has worked, producing two output refs, but as it shows
the exit code is 1. We have also seen it output a single line from a
range, when the entire range wasn't cloned.

It seems weird that it produces output at all in this case. Shouldn't
it see that it is a range and exit with a nonzero exit code
immediately? The docs say:

       --verify
           Verify that exactly one parameter is provided, and that it
can be turned into a raw 20-byte SHA-1 that
           can be used to access the object database. If so, emit it
to the standard output; otherwise, error out.
           ...
       -q, --quiet
           Only meaningful in --verify mode. Do not output an error
message if the first argument is not a valid
           object name; instead exit with non-zero status silently.
SHA-1s for valid object names are printed to
           stdout on success.

It seems to me that the second sentence from --verify indicates that
it should not produce output from a range at all, although I guess the
exact meaning of "error out" is ambiguous, and the last sentence of
the --quiet documentation is not incompatible with it also producing
output when it fails,  but it seems like if this is expected behavior
it should be documented more explicitly. Which makes me think it is a
bug. :-)

I am testing with git version 2.25.1 but this was encountered on
GitHub with whatever git they used as well. (We noticed this in a CI
pipeline using a shallow clone.)

cheers
Yves


-- 
perl -Mre=debug -e "/just|another|perl|hacker/"

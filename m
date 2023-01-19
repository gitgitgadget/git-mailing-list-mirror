Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859B0C004D4
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 23:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjASXEl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 18:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjASXEN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 18:04:13 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE453D932
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 14:56:07 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id x36so4711376ede.13
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 14:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2q7pa0vrqq6PV3zj7YA9fNi6Z0qLQDuI6P4WuGGFyIE=;
        b=FPT1EcCQZxdP0b2Pb+sXpMxzWBqSQqvtSkECLHlT8HTRk2faRKFy/8Ox5kJpZu2MRR
         EsKNaQ0S8GLM4IxI6T0mwkv9S26qsh/hyESVu1ij9XR+KFaOl7adWo4LNMRiXduXqCr+
         mr0ogakC4OMvSN+T4EqvPxPftBpsxlIjVNf5UXNB4PIyYbTMszzbSHe7RT8AXIDAqBNN
         7CCAy2XMsyHsP/SBFKnEWjXwG8uiIcqy5Wnhf+duaWPNkZkXrRRB11EIAJuzIKxiLs+/
         3Pd/+9tcULy2aj6tR0pRIWoLKVoGQ9r7f7Bi5yR4iT79mWYACoQh+PRAE0likHNBhykE
         5Tdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2q7pa0vrqq6PV3zj7YA9fNi6Z0qLQDuI6P4WuGGFyIE=;
        b=6yvqwLZEOgKQJOgIs5CrxLTw43jxFol8eTTizzhbbTYW2NbIAhjaowIUE8qMxNS2s4
         FC/ledw7zVOtR/b7DZPLEEEgLMQK7p7ByjQq5HaflL6i6WdyQrQZOHQ3hhBBfX/TmOan
         2xIh/fAxkzO7wFL22lVqfKE4TlFdEWNgJ/fWssasMq46KyM7xhv0JzTmFhd36GXt5OMF
         8+pC77ecNcmvB7AOuhgXZJ5NtvZZHSWkhdhx3nFLMIqazHlb9eyr6eBJz5J1iod9a/TA
         M+fq1OzqkxyQcUVGDolWCetC2942rTXdS+ugD+sLPe81ZXHuBxKkERWr0o7yQ4Nn2ivT
         MMsg==
X-Gm-Message-State: AFqh2kpQfmSXzt4uSXiV6y653VtAHwmebrFkeKCRlNRw929SLEcCn0Xx
        en1LnrB9HhQzjNp0zL716U8mV+Viiphln0CcrLP234wJ
X-Google-Smtp-Source: AMrXdXtcgt8FTxb5SPc6zcDz07ZoXS5i0eGDXMk+ZPxmXjq67/JmLFx4VYY4AuUwbGnVni97u65NcTVJTEQ6sqYpd/g=
X-Received: by 2002:aa7:c30d:0:b0:46c:af80:636c with SMTP id
 l13-20020aa7c30d000000b0046caf80636cmr1348658edq.129.1674168966073; Thu, 19
 Jan 2023 14:56:06 -0800 (PST)
MIME-Version: 1.0
References: <CAEcbrFdE6X6=ppBWmFZrm0Z2RqGqFatjNHdZbGb_RMteCk6P6g@mail.gmail.com>
In-Reply-To: <CAEcbrFdE6X6=ppBWmFZrm0Z2RqGqFatjNHdZbGb_RMteCk6P6g@mail.gmail.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Thu, 19 Jan 2023 14:55:54 -0800
Message-ID: <CAPx1GvcBDcZ1K_YJKm3+fUBNYQWKE2FBz-qS6JrV2TJCTc5k1w@mail.gmail.com>
Subject: Re: Race condition on `git checkout -c`
To:     Arthur Milchior <arthur.milchior@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Top note: you mean `git checkout -b` or `git switch -c`, not `git
checkout -c`.)

On Thu, Jan 19, 2023 at 1:24 PM Arthur Milchior
<arthur.milchior@gmail.com> wrote:
>
> I expect either:
> * to see an error message stating that `b` already exists
> * to see `b` and `B` in the list of branch.

[snip]

> uname: Darwin 22.2.0 Darwin Kernel Version 22.2.0: Fri Nov 11 02:03:51

Darwin (macOS) is your problem here.  The same problem
occurs on Windows, but not on Linux, by default.

Technically the problem is in the file system itself, combined with
the ways (plural) that Git stores branch names.

As far as Git itself is concerned, branch names are *always* case
sensitive, so branches named `b` and `B` are different.  But Git
stores branch names in two different formats, at the moment:

 * Some are kept in a plain-text file `.git/packed-refs`.
 * Some are stored as directory-and-file-names in `.git/refs/`.

If the OS's file system is case sensitive, as most standard Linux
file systems are, there's no problem with the latter. But if the OS's
file system is case-INsensitive, as the default file systems on
Windows and MacOS are, this becomes a problem: the attempt
to create both `refs/heads/b` and a different file, `refs/head/B`,
fails, with one of the two names "winning" and the other attempt
to create a new name simply re-using the existing name.

If you create a case-sensitive disk volume on your Mac, which
can be a simple click-to-mount virtual drive within your regular
case-insensitive file system, you can happily use Git without this
complication. Note that the same complication applies to file
names: Linux users can create two different, separate files
named `README.TXT` and `ReadMe.txt` in a GIt project, and
if you use the default case-insensitive macOS file system, you
won't be able to check out both files.  Using your case sensitive
volume will allow you to work with the Linux group.

If and when a future version of Git starts using reftables instead
of the file system to store branch and tag names, this particular
issue will go away, but until then, I recommend keeping a case
sensitive volume handy on your mac, and more generally,
avoiding mixing upper and lower case branch and/or file names
(at all, ever) whenever possible.  This avoids a lot of problems,
though nothing can get you past the Windows `aux.h` problem. :-)

Chris

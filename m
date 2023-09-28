Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E58E732FB
	for <git@archiver.kernel.org>; Thu, 28 Sep 2023 17:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbjI1RHF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Sep 2023 13:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbjI1RG6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2023 13:06:58 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C561B1
        for <git@vger.kernel.org>; Thu, 28 Sep 2023 10:06:49 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3aec067556dso2283063b6e.2
        for <git@vger.kernel.org>; Thu, 28 Sep 2023 10:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695920809; x=1696525609; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DyHR03C6es90uGHToCkpSHF35WDMP7PWSAmFm+NY4n8=;
        b=nsqFNM6mZ156lz+T60V3I/kyNbK5bS4W6lOvRuzoyhV71t1DeWK7T1uZ4zYdWE3Ovw
         ZP4wMIc21FkcFWRqKoEnhMHRlfvKZJkrRJ5+TM1HaOukg6np1lZpguRXhHSv1CnUNmVH
         ecf3MhZOatIW62RJRn1adG2s9yaghM56rVG9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695920809; x=1696525609;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DyHR03C6es90uGHToCkpSHF35WDMP7PWSAmFm+NY4n8=;
        b=ZaMqpz37zKWTy+h+1EpMnNWbYZgM8aRdcFRyaikvPScsBK734HCczibit4G6baAtvW
         YSMnfzddl7LqJ36DYd8JxglmWJSZoUvcovVW9hs7WLfyMH8pJl0cISNvnEHqEnwK6vtp
         92gzUNR4iyEnDvb+U5yg28vB4D4GXoXL9mxc65gsF2TaHZsAuy0mUeiEO+a9ZREHM/lb
         2Cm5EPKM7WDA1jXD81Np3GE/BPVLWY3cnIeDqDcPOoCI2jbdKe19GT/H9VHtwp+o2ekL
         rRvVAXt6eH9Bw4WS92YS+QWfTTtvUADBlvqteYWVRw1Ejo7bSPXo+S5jWiNujDr16Mu4
         4oTw==
X-Gm-Message-State: AOJu0YzFvJgh3a/gFAi2PUyUirnkWQGW1U/gmFjLZpko1ubuEM1iLlv4
        8QcKXSBufj1ctQN9OO0RCVxo0PbNssUrwy8dlx5i/jsg/ZXMhr/Nivg=
X-Google-Smtp-Source: AGHT+IFmaVm85QlK8/uB5hLT9E9ag/mpjXQLvSctUVUZ4p0VSSUlLEXytzyAutdhF/LC4z+3kjbx/2aKflcAkufT5jk=
X-Received: by 2002:a05:6870:219c:b0:1d7:1ad1:3f8c with SMTP id
 l28-20020a056870219c00b001d71ad13f8cmr2123827oae.49.1695920809041; Thu, 28
 Sep 2023 10:06:49 -0700 (PDT)
MIME-Version: 1.0
From:   Joanna Wang <jojwang@chromium.org>
Date:   Thu, 28 Sep 2023 13:06:38 -0400
Message-ID: <CAL-HyEbxGqxid3vsvDk3Z0Gd3swbNP4qcXhApadu8ZgvRkr3WA@mail.gmail.com>
Subject: Supporting `git add -a <exclude submodules>`
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
We're looking for feedback on the idea of adding git support for users
to express `git add -a <exclude submodules>`.

We recently added submodules to our project.
A lot of our users don't like that when their submodules are on
commits that do not match what is pinned in the root superproject,
running `git add -a` and `git commit -a` (which they are so used to),
will now include those submodules that 99% of the time they do not
want to include.

So we think supporting `git add -a <exclude submodules>` and `git
commit -a <exclude submodules>` might be good to do.
(We know `git -c diff.ignoreSubmodules=all commit -a` is an option,
but this does not work for `git add`. However this support gets
implemented for `git add`, I assume it's ideal for the UX of "don't
include submodules" to be the same for both `git commit` and `git
add`, though I don't think this is a requirement)


In a separate high-level conversation, Junio brought up going about
this with magic pathsepc.
So the work would entail:
- adding 'native' submodule attribute support, so `git add -a
':(exclude,attr:submodule)' can work without having to add 'submodule'
for every submodule path in .gitattributes
- add magic pathspec support to `git add`

(It looks like `git commit -a` does not work with pathspec. In this
case I think that would be fine, we can just tell users they can set
aliases for `git -c diff.ignoreSubmodules=all commit -a` and `git add
-a ':(exclude,attr:submodule)' if they want)

Any thoughts from folks on all of the above?
Thanks!

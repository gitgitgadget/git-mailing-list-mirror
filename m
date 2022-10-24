Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DF0C38A2D
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 00:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiJYAkr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 20:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiJYAkb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 20:40:31 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D9BC5883
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 16:08:35 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id r3so12670255yba.5
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 16:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RsCvdASfsPEtUnfTNqQIaXEEiicz87a72Z/iUSWFxcU=;
        b=fCu+UvlTEYhsaiIBOpL67Ax8aD01gNXqWXLoFIfDLe1wfa3ISq/y/9mQrJ/TY8wWPJ
         nN5ZBXh2ODYxc1uf/vfAsUgXHWyDdhG9g0fMeiUKjnM3mcR9TKsRnrWzD24NdsHQC0PS
         lkRgYiugw0CEhd3mwRIW0hTnGbHH6NIYtdpXjPFKIDrFi2DQuPUE+MZ1lCSBfCwoD4gH
         loF/wTN6tvQ6M6mt1CizZAvMlAgrVytYIpA3mAnvB9Oc1CgiFzShrItY6CPQkjvROcvI
         AruMS+FI8+wk37T3JhqB7EWw/3MyUn6+rIyxDcCHk0J3OUl7tELt3YR3pND9ctKSyim6
         dI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RsCvdASfsPEtUnfTNqQIaXEEiicz87a72Z/iUSWFxcU=;
        b=BWdps23Yc/RzuO1AhRaoPE4cTF88csqHcK+vDukY9oIis2AhlUc+KHU0qrhNc3oLiW
         eWjgCUtYp8Nn06K0a82kadj/fO5fG9GvvO6X0f4srZ6m0QtAdFl2+WYXlP0t+tdXONzD
         ReCxlHFHnNXkb/cOnUeF+9etfX8j5mCC0JgPriTchsOYZvi0lwg9hwBGG2edUAA93q9d
         jBJxfhZuBCD6aivPCO2kowb+/EpgCoRiXOvpXW/ObjgQ11QsDItNvYNqGiinSShCNaYt
         50LyB9qCoRbh87VAk4Oc1TG3KSxuNLeylii8jS3lP8VGY8b3eTz2zGJp36qOuWspRmJq
         xmUg==
X-Gm-Message-State: ACrzQf3zU9FQ1qauBUEchN+GTqJufQyqq0VeYQWggtbJI240OURvddvZ
        7NPBVDged+S4kw4miU8mUMRzd02CcbKlTS/Oj5371tiwXByChQ==
X-Google-Smtp-Source: AMsMyM6rCfNvWaSEq65IhqzUrsOVYQbte6oyd3tOKxC0W95zn5LXFwO2IxKAmA9So9V8cFZm4lzRluNmemwWN8zoSHQ=
X-Received: by 2002:a5b:5c4:0:b0:67b:89d6:cbf5 with SMTP id
 w4-20020a5b05c4000000b0067b89d6cbf5mr30829976ybp.286.1666652914800; Mon, 24
 Oct 2022 16:08:34 -0700 (PDT)
MIME-Version: 1.0
From:   Calvin Wan <calvinwan@google.com>
Date:   Mon, 24 Oct 2022 16:08:24 -0700
Message-ID: <CAFySSZAbsPuyPVX0+DQzArny2CEWs+GpQqJ3AOxUB_ffo8B3SQ@mail.gmail.com>
Subject: Parallelism defaults and config options
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While trying to figure out how I was going to set the default
parallelism in cw/submodule-status-in-parallel, I noticed some
discrepancies between how all the parallelism config options are set in
git. I wanted to discuss what we can do now to make them more consistent
and also what the standard should be for the future. Here is a list of
parallelism config options in git (let me know if I missed any) and how
they're set:

grep.threads: if unset or set to 0, git uses number of logical cores.
index.threads: if unset or set to 0/true, git uses number of logical
  cores. If set to 1/false, multithreading is disabled
pack.threads: if unset or set to 0, git uses number of logical cores.
  (documentation doesn't mention what default is)
checkout.workers: if unset, defaults to 1. If set to < 1, git uses
  number of logical cores
fetch.parallel: if unset, defaults to 1. If set to 0, git uses number of
  logical cores (documentation says reasonable default)
http.maxRequests: if unset, defaults to 5. If set to < 1, git uses the
  default 5.
submodule.fetchJobs: if unset, defaults to 1. If set to 0, git uses
  number of logical cores (documentation says reasonable default)

The first inconsistency is the difference in language used to describe
when each option is set to "online_cpus()". Some are explicit while
others omit it or use language such as "reasonable default". Being
explicit for all of the options is probably the easiest documentation
fix.

The next inconsistency is for values < 1. Most options use online_cpus()
when set to 0 except index.threads which is a special case of its own.
Some options error out when set to a negative number while
checkout.workers falls back to online_cpus() and http.maxRequests falls
back to 5. I don't think we can fix this retroactively unless we decide
that all config options will be set to online_cpus() if the value is
negative. Should that be the case going forward or should 0 be the only
special cased value for now? I can see an argument for allowing other
negative values to be configured in the future for different defaulting
options.

The final inconsistency is how values are defaulted if unset. Some
default to online_cpus() while others default to 1 (http.maxRequests is
5). I want to call out grep.threads specifically here -- on my machine
with 48 cores, the default is actually SLOWER than using 1 thread. This
is because the grep operation is heavily IO bound, so creating too many
threads adds overhead every time the read head changes. Interestingly,
this option runs optimally at 4 since that's how many PCIe lanes my SSD
uses. While it makes sense to default processor heavy operations to
online_cpus(), does it make sense to do the same for IO heavy
operations? (I wasn't able to find an equivalent of online_cpus() for
drive reading capabilities.) And what about operations that have a fair
mix of each?

The safe option is to default to 1 process for many of these config
options, but we trade off in improving the experience for the average
user that is unaware of these options. If we're already defaulting to
online_cpus() for grep.threads and selecting 5 for http.maxRequests,
then why not do the same for other options? My suggestion would be
defaulting IO dominant operations to min(4, online_cpus()) since that
seems like the standard number of lanes for people using SSDs. I would
also default operations that have a mix of both to
min(8, online_cpus()).
-- 
Calvin Wan

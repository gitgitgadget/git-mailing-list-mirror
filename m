Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AD0C433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 17:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A66F360D07
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 17:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbhJ1R2m convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 28 Oct 2021 13:28:42 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:34757 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbhJ1R23 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 13:28:29 -0400
Received: by mail-ed1-f47.google.com with SMTP id g10so27511051edj.1
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 10:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E82kjTFyTRMnwaCfURcy9Een0Q2PJQBcO+gNQsGR2fs=;
        b=uPEClAPfM8f0BzxfwLQw6ZTtTzmqkRzNisj8XdBu1U1PF23z1KM0pi7Y2rwsLo1As1
         N162tYUnSxDggjwm4KPw1tPO9x+u4VyOwZEH0Az/XDO/bAPaPEGCDAkyy9IftbYtnbrm
         /7irMNSwyRArxkM9k0issTZBNXqVMHfnGZcU4gxqanbsWbYwHl1selQqSH4MLyv7E27W
         TZkR0ChE0605pImJBg54aL7IvmVh4Q7wSJf+0/7tBGUKGDP1EqQG9sl2ZFtUoKTyDFL2
         sL62BMTMYTuNeeVtkuRxq7SByoBOEq3MHRZq6xDX7GKxAI7GisT3MntVq5iMKnUF6Wee
         iGiA==
X-Gm-Message-State: AOAM531v7sNvRz7f/+L0fGnihgeOC4tQmXSTxxSJtwZRRFfk8xHfmyRL
        g+FYxQ38g9tVHhY0+ns8F2BH2F0zM8nQIA46TsQ=
X-Google-Smtp-Source: ABdhPJwYInvNizkSoGAfL6o9g0Cu8DBu77V15OZI3hn14x02GaMcnCG0cOnKfAa0rr5O6uQ3Nsenv+Jl8RBA4lu+8HY=
X-Received: by 2002:a17:906:480a:: with SMTP id w10mr7189669ejq.262.1635441961758;
 Thu, 28 Oct 2021 10:26:01 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1052.v3.git.1634684260142.gitgitgadget@gmail.com>
 <pull.1052.v4.git.1635288599.gitgitgadget@gmail.com> <c7f0977cabd4ba7311b8045bc57e9e30198651fd.1635288599.git.gitgitgadget@gmail.com>
 <211028.86sfwlw10o.gmgdl@evledraar.gmail.com>
In-Reply-To: <211028.86sfwlw10o.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 28 Oct 2021 13:25:50 -0400
Message-ID: <CAPig+cTKSp28oUvESCWLB+OLBjbUSt3vhz6n3eVmkfYf9arcrg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] http-fetch: redact url on die() message
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Ivan Frade via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Ivan Frade <ifrade@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 28, 2021 at 12:46 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On Tue, Oct 26 2021, Ivan Frade via GitGitGadget wrote:
> >               if (results.curl_result != CURLE_OK) {
> > -                     die("Unable to get pack file %s\n%s", preq->url,
> > -                         curl_errorstr);
> > +                     struct url_info url;
> > +                     char *nurl = url_normalize(preq->url, &url);
> > +                     if (!git_env_bool("GIT_TRACE_REDACT", 1) || !nurl) {
> > +                             die("Unable to get pack file %s\n%s", preq->url,
> > +                                 curl_errorstr);
>
> small nit: arrange if's from "if (cheap || expensive)", i.e. no need for
> getenv() if !nurl, but maybe compilers are smart enough for that...

I had the same passing thought when glancing over this code (although
this appears to be an error patch, thus not performance critical, so
not terribly important).

> nit: die() messages should start with lower-case (in CodingGuidelines), and I think it's better to quote both, so:
>
>     die("unable to get pack '%s': '%s'", ...)
>
> Or maybe without the second '%s', as in 3e8084f1884 (http: check
> CURLE_SSL_PINNEDPUBKEYNOTMATCH when emitting errors, 2021-09-24) (which
> I authored, but just copy/pasted the convention in the surrounding
> code)>

Note that this is not a new die() call; it just got indented as-is by
this patch, so the changes you suggest to the message string are
potentially outside the scope of this patch. Possibilities: (1) make
the changes in this patch but mention them in the commit message; (2)
make the changes in a preparatory patch; (3) punt on the changes for
now.

> > +                     } else {
> > +                             char *schema = xstrndup(url.url, url.scheme_len);
> > +                             char *host = xstrndup(&url.url[url.host_off], url.host_len);
> > +                             die("failed to get '%s' url from '%s' "
> > +                                 "(full URL redacted due to GIT_TRACE_REDACT setting)\n%s",
> > +                                 schema, host, curl_errorstr);
>
> Hrm, I haven't tested, but aren't both of those xstrndup's redundant to
> using %*s instead of %s for the printf format? I.e.:
>
>     die("failed to get '%*s'[...]", url.schema_len, url.url, )

I wondered the same when reading the patch. Thanks for mentioning it.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D523C433FE
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 16:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiKXQ3r (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 11:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiKXQ3n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 11:29:43 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE81017027F
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 08:29:42 -0800 (PST)
Received: (qmail 27223 invoked by uid 109); 24 Nov 2022 16:29:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Nov 2022 16:29:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28664 invoked by uid 111); 24 Nov 2022 16:29:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 24 Nov 2022 11:29:40 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 24 Nov 2022 11:29:39 -0500
From:   Jeff King <peff@peff.net>
To:     Yoichi Nakayama <yoichi.nakayama@gmail.com>
Cc:     Yoichi Nakayama via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v4 2/2] git-jump: invoke emacs/emacsclient
Message-ID: <Y3+b80Vb2/6lKQ40@coredump.intra.peff.net>
References: <pull.1423.v3.git.1669033620.gitgitgadget@gmail.com>
 <pull.1423.v4.git.1669126703.gitgitgadget@gmail.com>
 <2f0bffb484beccf58f2440ed5e2c04a1ba26e6c3.1669126703.git.gitgitgadget@gmail.com>
 <Y30a0ulfxyE7dnYi@coredump.intra.peff.net>
 <CAF5D8-vSsBsdiA8SiDgqUFkL9_3N-v+psVxj-AcibOB88gxWfA@mail.gmail.com>
 <Y37EPdUkBhsSPmRD@coredump.intra.peff.net>
 <CAF5D8-u14grTa9cUo=ge8TVRKNYtVHWhFHDW8yYD9gD8=f0Byg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAF5D8-u14grTa9cUo=ge8TVRKNYtVHWhFHDW8yYD9gD8=f0Byg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 24, 2022 at 09:32:45PM +0900, Yoichi Nakayama wrote:

> > Good point. The vim version is easier to fix (we just need to
> > double-quote \$1 inside the eval), but the fact that nobody has
> > complained is an indication that it does not really matter.
> 
> I've confirmed the vim version is fixed by
>     eval "$editor -q \"\$1\""
> 
> With your hint, I found the emacs version can be fixed
> by single-quoting the variable (I found a mistake in the
> emacs version. Since there is only one argument, I
> should use $1 instead of $@. I'll fix it.), and the vim
> version can be also in the similar form with single quote:
>     eval "$editor -q '$1'"

This isn't quite a full solution, though. The "$1" is expanded by the
outer double-quoted string, which is then fed to eval. The inner
single-quotes make most characters literally except for single-quotes
themselves. So if $1 has single-quotes, the eval will barf due to bad
syntax.

> The original vim version used the notation \$1 instead of $1.
> I'm worried that the emacs version might need the backslash.
> What does the backslash mean? Is it necessary?

As you figured out in the other email, it inhibits the outer layer of
expansion, and lets the eval expand it. This is the easiest way to pass
things through levels of shell evals (since otherwise you have to
actually quote, which is a real pain).

None of this is sufficient for your emacs example, though. There you
have three levels of quoting:

  - getting the argument intact into the eval; this can use the "\$"
    trick

  - the argument then appears inside a double-quoted string which will
    be evaluated by emacs. You'd want to protect it against
    double-quotes and presumably backslashes.

  - emacs will then execute the final command, presumably you a shell.
    So you'd want to protect against expansion in that shell. The
    easiest way to do that is usually to wrap each argument in
    single-quotes, and quoting against interior single quotes (by ending
    single-quote, adding a single backslashed single-quote, and then
    re-opening the single-quote). It's horribly ugly, but is (AFAIK) the
    shortest way to quote shell arguments, and what we usually do in
    Git.

Those are the three tricks I sent in the earlier email (though looking
at it again, I think the single-quote bits need to come first, so their
backslashes are then quoted to protect against emacs evaluation).

It's all quite confusing, which is why I am OK with just skipping it for
now. ;) The nice thing, though, is that doing the quoting right means
it's safe to get rid of the "cat", which solves your race problems in a
more direct and robust way.

-Peff

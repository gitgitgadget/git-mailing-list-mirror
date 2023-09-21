Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B218BE7D0AA
	for <git@archiver.kernel.org>; Thu, 21 Sep 2023 20:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbjIUUvM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Sep 2023 16:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbjIUUu5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2023 16:50:57 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C498C621
        for <git@vger.kernel.org>; Thu, 21 Sep 2023 10:42:28 -0700 (PDT)
Received: (qmail 20274 invoked by uid 109); 21 Sep 2023 04:15:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 Sep 2023 04:15:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3624 invoked by uid 111); 21 Sep 2023 04:15:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 Sep 2023 00:15:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 21 Sep 2023 00:15:45 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] attr: attr.allowInvalidSource config to allow invalid
 revision
Message-ID: <20230921041545.GA2338791@coredump.intra.peff.net>
References: <pull.1577.git.git.1695218431033.gitgitgadget@gmail.com>
 <xmqqfs38akx5.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfs38akx5.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 20, 2023 at 09:06:46AM -0700, Junio C Hamano wrote:

> > With empty repositories however, HEAD does not point to a valid treeish,
> > causing Git to die. This means we would need to check for a valid
> > treeish each time.
> 
> Naturally.
> 
> > To avoid this, let's add a configuration that allows
> > Git to simply ignore --attr-source if it does not resolve to a valid
> > tree.
> 
> Not convincing at all as to the reason why we want to do anything
> "to avoid this".  "git log" in a repository whose HEAD does not
> point to a valid treeish.  "git blame" dies with "no such ref:
> HEAD".  An empty repository (more precisely, an unborn history)
> needs special casing if you want to present it if you do not want to
> spew underlying error messages to the end users *anyway*.  It is
> unclear why seeing what commit the HEAD pointer points at (or which
> branch it points at for that matter) is *an* *extra* and *otherwise*
> *unnecessary* overhead that need to be avoided.

In an empty repository, "git log" will die anyway. So I think the more
interesting case is "I have a repository with stuff in it, but HEAD
points to an unborn branch". So:

  git --attr-source=HEAD diff foo^ foo

And there you really are saying "if there are attributes in HEAD, use
them; otherwise, don't worry about it". This is exactly what we do with
mailmap.blob: in a bare repository it is set to HEAD by default, but if
HEAD does not resolve, we just ignore it (just like a HEAD that does not
contain a .mailmap file). And those match the non-bare cases, where we'd
read those files from the working tree instead.

So I think the same notion applies here. You want to be able to point it
at HEAD by default, but if there is no HEAD, that is the same as if HEAD
simply did not contain any attributes. If we had attr.blob, that is
exactly how I would expect it to work.

My gut feeling is that --attr-source should do the same, and just
quietly ignore a ref that does not resolve. But I think an argument can
be made that because the caller explicitly gave us a ref, they expect it
to work (and that would catch misspellings, etc). Like:

  git --attr-source=my-barnch diff foo^ foo

So I'm OK with not changing that behavior.

But what is weird about this patch is that we are using a config option
to change how a command-line option is interpreted. If the idea is that
some invocations care about the validity of the source and some do not,
then the config option is much too blunt. It is set once long ago, but
it can't distinguish between times you care about invalid sources and
times you don't.

It would make much more sense to me to have another command-line option,
like:

  git --attr-source=HEAD --allow-invalid-attr-source

Obviously that is horrible to type, but I think the point is that you'd
only do this from a script anyway (because it's those automated cases
where you want to say "use HEAD only if it exists").

If there were an attr.blob config option and it complained about an
invalid HEAD, _then_ I think attr.allowInvalidSource might make sense
(though again, I would just argue for switching the behavior by
default). And I really think attr.blob is a better match for what GitLab
is trying to do here, because it is set once and applies to all
commands, rather than having to teach every invocation to pass it
(though I guess maybe they use it as an environment variable).

Of course I would think that, as the person who solved GitHub's exact
same problem for mailmap by adding mailmap.blob. So you may ingest the
appropriate grain of salt. :)

-Peff

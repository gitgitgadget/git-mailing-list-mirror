Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891A3C77B75
	for <git@archiver.kernel.org>; Wed, 17 May 2023 09:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjEQJcY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 05:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjEQJcX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 05:32:23 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB0F2D43
        for <git@vger.kernel.org>; Wed, 17 May 2023 02:32:16 -0700 (PDT)
Received: (qmail 17254 invoked by uid 109); 17 May 2023 09:32:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 May 2023 09:32:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7272 invoked by uid 111); 17 May 2023 09:32:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 May 2023 05:32:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 17 May 2023 05:32:14 -0400
From:   Jeff King <peff@peff.net>
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/3] tag: keep the message file in case ref transaction
 fails
Message-ID: <20230517093214.GA527234@coredump.intra.peff.net>
References: <cover.1684067644.git.code@khaugsbakk.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1684067644.git.code@khaugsbakk.name>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 14, 2023 at 03:17:57PM +0200, Kristoffer Haugsbakk wrote:

> The ref transaction can fail after the message has been written using the
> editor. The ref transaction is attempted after the message file (`TAG_EDITMSG`)
> has been unlinked, so there is no backup tag message file to retry the
> command.[1]
> 
> This is unfortunate if someone has written more than e.g. “v1.99.4” in the
> editor. (I don’t know if people write long tag messages in practice.)
> [...]
>
> So I added only Jeff King based on commit 3927bbe9a4 (tag: delete TAG_EDITMSG
> only on successful tag, 2008-12-06).

It has definitely been a while since that one. :) I agree what you are
doing here is in the same spirit as that commit, though there is one
small difference. 3927bbe9a4 was about saving the message file if we
failed to create the object, since otherwise there is no record of it.

Your patch is about saving it from a failed ref update. But in that case
we _do_ have the data saved in the object. You can find it with
git-fsck:

  [after running something like your test script]
  $ git fsck
  Checking object directories: 100% (256/256), done.
  dangling tag b9bde516952a863690027a611575a79d4c786b8d

  $ git cat-file tag b9bde516952a863690027a611575a79d4c786b8d
  object 8b1e708e32ae3af17825b3c713a3ab317824b932
  type commit
  tag foo/bar
  tagger Jeff King <peff@peff.net> 1684314980 -0400
  
  my message

That said, I'm willing to believe that most users wouldn't figure this
out on their own, and saving TAG_EDITMSG might be more friendly. But one
other alternative might be to mention the hash of that tag object, and
possibly give advice on recovering it.

It's too bad we do not have "git tag -c" to match "git commit -c", which
would allow us to say something like:

      A tag object was created, but we failed to update the ref.
      After correcting any errors, you can recover the original tag
      message with:

        git tag -c $oid [other options]

(where we'd replace $oid with the hash of the created tag object). The
best alternatives I could come up with were:

      # this is kind of obscure advice to give somebody, plus
      # it makes a weird tag if you originally tried to tag "foo/bar"
      # but then later switch to some other name. The "tag" field
      # in the object won't match the ref.
      git update-ref $ref $oid

      # this saves just the message but is horribly complicated
      git cat-file tag $oid | sed '1,/^$/d' |
      git tag -F -

I dunno. There is a certain elegance to telling the user about what
progress we _did_ make, but if there isn't an easy way to turn that into
a retry of their command, it may not be all that useful.

So I'm not really opposed to your patch, but mostly just brainstorming
alternatives.

I gave v3 a brief look, and it seems OK to me. It might be nice to
factor out the duplicated advice message, but since we cannot share any
of the other lines (one spot calls exit() and the other uses die()), I
am OK with it as-is.

-Peff

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C264C211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 04:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbeLDEJF (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 23:09:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:58100 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725971AbeLDEJF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 23:09:05 -0500
Received: (qmail 21113 invoked by uid 109); 4 Dec 2018 04:09:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 04 Dec 2018 04:09:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16461 invoked by uid 111); 4 Dec 2018 04:08:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 03 Dec 2018 23:08:32 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Dec 2018 23:09:03 -0500
Date:   Mon, 3 Dec 2018 23:09:03 -0500
From:   Jeff King <peff@peff.net>
To:     Jamie Zawinski <jwz@jwz.org>
Cc:     git@vger.kernel.org
Subject: Re: sharedrepository=group not working
Message-ID: <20181204040903.GA17059@sigill.intra.peff.net>
References: <F9365CBF-3D2D-4A05-AC0D-4604067B5826@jwz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <F9365CBF-3D2D-4A05-AC0D-4604067B5826@jwz.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 03, 2018 at 07:27:13PM -0800, Jamie Zawinski wrote:

> I think sharedrepository=group stopped working some time between
> 2.10.5 (works) and 2.12.4 (does not). 2.19.2 also does not.

Hmm. Given the time-frame and the fact that your strace shows problems
writing into the objects/incoming-* directory, it's likely caused by
722ff7f876 (receive-pack: quarantine objects until pre-receive accepts,
2016-10-03).

The big change there is that instead of writing directly into objects/,
we create a temporary objects/incoming-* directory, write there, and
then migrate the objects over after we determine they're sane.

So in your strace we see the temp directory get created:

>  mkdir("./objects/incoming-U5EN8D", 0700 <unfinished ...>
>  <... mkdir resumed> )       = 0

The permissions are tighter than we ultimately want, but that's OK.
This tempdir is just for this process (and its children) to look at, and
then we'd eventually migrate the files out.

I could definitely imagine there being a bug in which we don't then
properly loosen permissions when we move things out of the tempdir, but
we don't even get that far. We fail immediately:

>  mkdir("./objects/incoming-U5EN8D/pack", 0777) = -1 EACCES (Permission denied)

That seems strange. The outer directory is only 0700, but the user
permissions should be sufficient. Even with the g+s bit set, it should
still be owned by the same user, shouldn't it?

I tried reproducing your state like this:

  git init --bare dst.git
  git -C dst.git config core.sharedrepository group
  chgrp -R somegroup dst.git
  find dst.git -type f | xargs chmod g+rw
  find dst.git -type d | xargs chmod g+srw

  # push works from original user
  git clone dst.git client
  (
    cd client &&
    git commit --allow-empty -m foo
    git push
  )

  # push works from alternate user
  sudo su anotheruser sh -c '
    git clone dst.git /tmp/other &&
    cd /tmp/other &&
    git commit --allow-empty -m foo &&
    git push --receive-pack="strace -e mkdir git-receive-pack"
  '

but it works fine. Might there be some effective-uid trickiness with the
way the server side of git is invoked? Or is this a network mount where
the filesystem uid might not match the process uid?

-Peff

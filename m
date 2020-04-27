Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFC2C4CECD
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 21:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 496A22074F
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 21:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbgD0VKO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 17:10:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:41474 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726285AbgD0VKO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 17:10:14 -0400
Received: (qmail 16221 invoked by uid 109); 27 Apr 2020 21:10:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 27 Apr 2020 21:10:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27989 invoked by uid 111); 27 Apr 2020 21:21:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 27 Apr 2020 17:21:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 27 Apr 2020 17:10:13 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        git@vger.kernel.org, dirk@ed4u.de, sunshine@sunshineco.com
Subject: Re: [PATCH v3] git-credential-store: skip empty lines and comments
 from store
Message-ID: <20200427211013.GB1732530@coredump.intra.peff.net>
References: <20200427084235.60798-1-carenas@gmail.com>
 <20200427125915.88667-1-carenas@gmail.com>
 <xmqqftco94wx.fsf@gitster.c.googlers.com>
 <20200427191858.GB1728884@coredump.intra.peff.net>
 <xmqqv9lk7j7p.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv9lk7j7p.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 27, 2020 at 01:43:38PM -0700, Junio C Hamano wrote:

> >> These files are not supposed to be viewed or edited without the help
> >> of the credential helpers.  Do these blank lines and comments even
> >> survive when a new credential is approved, or do we just overwrite
> >> and lose them?
> >
> > That's a good question. In the older code we do save them, because
> > credential-store passes through lines which don't match the credential
> > we're operating on.
> >
> > But in Carlo's patch, the immediate "continue" means we wouldn't ever
> > call "other_cb", which is what does that pass-through.
> 
> So, does that mean the patch that started this thread will still help
> users who wrote custom comments and blank lines in their credential
> store by letting git-credential-store start up, but leaves a ticking
> bomb for them to lose these precious comments and blanks once they
> add a new site, change password, etc., at which point the user realizes
> that comments and blanks are not supported after all?

Yes, exactly. If I start with:

  cat >creds <<\EOF
  # this is a comment
  https://user:pass@example.com/
  EOF

then:

  echo url=https://other:pass@other.example.com |
  git credential-store --file=creds store

with v2.26.0 results in:

  https://other:pass@other.example.com
  # this is a comment
  https://user:pass@example.com

but applying the patch on top:

  https://other:pass@other.example.com
  https://user:pass@example.com/

That raises another issue about comments, too: we make no promises about
where we write new entries. They could be inserted between a comment
line and one it is meant to annotate (that line could even be moved if
we reject and then re-approve a credential).

> I think the first patch we need is a (belated) documentation patch,
> that adds to the existing "STORAGE FORMAT".  We already say "Each
> credential is stored on its own line as a URL", but we do not say
> anything about allowing other cruft in the file.  We probably
> should.  Adding a "comment" feature, if anybody feels like it, is OK
> and we can loosen the paragraph when that happens.

The more I look into it, the more negative I am on adding such a comment
feature.

> -- >8 --
> Subject: credential-store: document the file format a bit more

Yeah, this certainly clarifies things. I suppose one could ask why we'd
bother documenting the format at all, then, though I do think it could
be helpful for debugging.

> Reading a malformed credential URL line and silently ignoring it
> does not mean that we promise to torelate and/or keep empty lines
> and "# commented" lines forever.

s/torelate/tolerate/

-Peff

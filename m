Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94E5A1F406
	for <e@80x24.org>; Fri, 15 Dec 2017 09:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756353AbdLOJ6p (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Dec 2017 04:58:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:40468 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755396AbdLOJ6l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Dec 2017 04:58:41 -0500
Received: (qmail 31377 invoked by uid 109); 15 Dec 2017 09:58:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Dec 2017 09:58:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8029 invoked by uid 111); 15 Dec 2017 09:59:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Fri, 15 Dec 2017 04:59:04 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Dec 2017 04:58:38 -0500
Date:   Fri, 15 Dec 2017 04:58:38 -0500
From:   Jeff King <peff@peff.net>
To:     lars.schneider@autodesk.com
Cc:     git@vger.kernel.org, gitster@pobox.com, tboegi@web.de,
        patrick@luehne.de, Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v1] convert: add support for 'encoding' attribute
Message-ID: <20171215095838.GA3567@sigill.intra.peff.net>
References: <20171211155023.1405-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171211155023.1405-1-lars.schneider@autodesk.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 11, 2017 at 04:50:23PM +0100, lars.schneider@autodesk.com wrote:

> From: Lars Schneider <larsxschneider@gmail.com>
> 
> Git and its tools (e.g. git diff) expect all text files in UTF-8
> encoding. Git will happily accept content in all other encodings, too,
> but it might not be able to process the text (e.g. viewing diffs or
> changing line endings).
> 
> Add an attribute to tell Git what encoding the user has defined for a
> given file. If the content is added to the index, then Git converts the
> content to a canonical UTF-8 representation. On checkout Git will
> reverse the conversion.

This made me wonder what happens when you have a file that _was_ utf16,
and then you later convert it to utf8 and add a .gitattributes entry.

I tried this with your patch:

  git init repo
  cd repo
  
  echo foo | iconv -t utf16 >file
  git add file
  git commit -m utf16
  
  echo 'file encoding=utf16' >.gitattributes
  touch file ;# make it stat-dirty
  git commit -m convert
  
  git checkout HEAD^

That works OK, because we try to read the attributes from the
destination tree for a checkout. If you do this:

  echo 'file encoding=utf16' >.git/info/attributes
  git checkout HEAD^

then we get:

  warning: failed to encode 'file' from utf-8 to utf16

At least it figured out that it couldn't convert the content. It's
slightly troubling that it would try in the first place, though; are
there encoding pairs where we might accidentally generate nonsense?

It _should_ be uncommon, I think, to have a repo-level attribute set
like that. It's very common for us to use whatever happens to be in the
checked-out .gitattributes for some attributes (e.g., when doing a diff
of an older commit), but I think for checkout-related ones it's not.  So
I think it may generally work in practice. And certainly the line-ending
code would share any similar problems, but at least there the result is
less confusing than mojibake.

Playing around, I also managed to do this:

  echo 'file encoding=utf16' >.gitattributes
  echo foo >file

  # I did these with an old version of git that didn't
  # support the new attribute, so they blindly added the utf8 content.
  git add .
  git commit -m convert

  git.compile checkout HEAD^

which yielded:

  fatal: encoding 'file' from utf16 to utf-8 and back is not the same

Now obviously my situation is somewhat nonsense. I was trying to force
the in-repo representation to utf8, but ended up with a mismatched
working tree file. But what's somewhat troubling is that I couldn't
checkout _away_ from that state due to the die() in convert_to_git().
Which is in turn just there as part of refresh_index().

And indeed, other commands hit the same problem:

  $ git.compile diff
  fatal: encoding 'file' from utf16 to utf-8 and back is not the same

  $ git.compile checkout -f
  fatal: encoding 'file' from utf16 to utf-8 and back is not the same

It may make sense to die() during "git add ." (since we're actually
changing the index entry, and we don't want to put nonsense into a
tree). But I'm not sure it's the best thing for operations which just
want to read the content. For them, perhaps it would be more appropriate
to issue a warning and return the untouched content.

-Peff

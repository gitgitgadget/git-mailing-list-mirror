Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2F15201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 20:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751683AbdB1Uej (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 15:34:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:35933 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751332AbdB1Ueh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 15:34:37 -0500
Received: (qmail 20637 invoked by uid 109); 28 Feb 2017 20:26:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 20:26:36 +0000
Received: (qmail 29836 invoked by uid 111); 28 Feb 2017 20:26:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 15:26:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Feb 2017 15:26:34 -0500
Date:   Tue, 28 Feb 2017 15:26:34 -0500
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Typesafer git hash patch
Message-ID: <20170228202633.3pxbrnrhot7syiae@sigill.intra.peff.net>
References: <CA+55aFxYs1zp2c-UPe8EfshNNOxRVxZ2H+ipsnG489NBsE+DLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFxYs1zp2c-UPe8EfshNNOxRVxZ2H+ipsnG489NBsE+DLQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 27, 2017 at 10:59:15PM -0800, Linus Torvalds wrote:

> I saw that somebody is actually looking at doing this "well" - by
> doing it in many smaller steps. I tried. I gave up. The "unsigned char
> *sha1" model is so ingrained that doing it incrementally just seemed
> like a lot of pain. But it might be the right approach.

That somebody is brian carlson, cc'd.

> which is pretty nasty. The good news is that my patch passes all the
> tests, and while it's big it's mostly very very mindless, and a lot of
> it looks like cleanups, and the lines are generally shorter, eg
> 
> -               const unsigned char *mb = result->item->object.oid.hash;
> -               if (!hashcmp(mb, current_bad_oid->hash)) {
> 
> turns into
> 
> +               const hash_t *mb = &result->item->object.oid;
> +               if (!hashcmp(mb, current_bad_oid)) {
> 
> but I ended up also renaming a lot of common "sha1" as "hash", which
> adds to the noise in that patch.

I think the preimage there is worse than it ought to be because it's
mid-transition. "struct object" has an object_id, but the rest of the
function hasn't been converted yet. So ultimately it should be:

  const struct object_id *mb = &result->item->object.oid;
  if (!oidcmp(mb, current_bad_oid))

It looks like you stuck your "hash_t" inside "struct object_id", which I
think is redundant. They're both trying to solve the same problem.

> NOTE! It doesn't actually _fix_ the SHA1-centricity in any way, but it
> makes it a bit more obvious where the bigger problems are. Not that
> anybody would be surprised by what they are, but as part of writing
> the patch it did kind of pinpoint most of them, and about 30 of those
> new lines are added
> 
>  /* FIXME! Hardcoded hash sizes */
>  /* FIXME! Lots of fixed-size hashes */
>  /* FIXME! Fixed 20-byte hash usage */

Yeah, a lot of brian's patches have been focused around the fixing the
related size assumptions. We've got GIT_SHA1_HEXSZ which doesn't solve
the problem, but at least makes it easy to find. And a big improvement
in the most recent series is a parse_oid() function that lets you parse
object-ids left-to-right without knowing the size up front. So things
like:

  if (len > 82 &&
      !get_sha1_hex(buf, sha1_a) &&
      get_sha1_hex(buf + 41, sha1_b))

becomes more like:

  if (parse_oid(p, oid_a, &p) && *p++ == ' ' &&
      parse_oid(p, oid_b, &p) && *p++ == '\n')

Still, if you've done more conversion, it's probably worth showing it
publicly. It might not end up used, but it may serve as a reference
later.

> And as part of the type safety, I do think I may have found a bug:
> 
> show_one_mergetag():
> 
>                 strbuf_addf(&verify_message, "tag %s names a non-parent %s\n",
>                                     tag->tag, tag->tagged->oid.hash);
> 
> note how it prints out the "non-parent %s", but that's a SHA1 hash
> that hasn't been converted to hex. Hmm?

Yeah, that's definitely a bug. I'm surprised that -Wformat doesn't
complain, but I guess we'd need -Wformat-signedness (which triggers
quite a lot of warnings related to "int"). It's especially bad for "%x",
which is implicitly unsigned.

-Peff

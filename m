Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594ACC56202
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 00:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 280F6204EA
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 00:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgKXArS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 19:47:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:39430 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbgKXArS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 19:47:18 -0500
Received: (qmail 30054 invoked by uid 109); 24 Nov 2020 00:47:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Nov 2020 00:47:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9611 invoked by uid 111); 24 Nov 2020 00:47:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Nov 2020 19:47:17 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 23 Nov 2020 19:47:16 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] mktag: don't check SHA-1 object length under SHA-256
Message-ID: <X7xYFPGthu8BMWpH@coredump.intra.peff.net>
References: <20190826014344.16008-11-sandals@crustytoothpaste.net>
 <20201123120111.13567-1-avarab@gmail.com>
 <xmqqlferoq1m.fsf@gitster.c.googlers.com>
 <X7wrbI/pefHJsfdY@coredump.intra.peff.net>
 <xmqqft4zn2f7.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqft4zn2f7.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 23, 2020 at 02:17:32PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > It might just be me, but "object name" makes me think we'd take any name
> > (e.g., a refname that resolves to an object), whereas "object id" would
> > mean the object's hash specifically. And in this instance we only allow
> > the latter.
> 
> Yeah, but glossary-content is very much explicit about this.  "name"
> is the full hexadecimal hash, "identifier" is a synonym for it.  And
> "id" does not even appear to be defined.  We used to call "any name
> that refers to an object" an "extended SHA-1", but I haven't seen
> the phrase used for a long time on the list.

OK, then my "it might just be me" is clearly just me. :)

I think the distinction I laid out earlier is nicer, but it may not be
worth the trouble of trying to _change_ nomenclature at this point.
Let's see what your glossary changes say...

> I've always found it cumbersome that, when I want to mean a full hex
> representation, I have to say "40-byte object name".  It is not even
> technically correct these days with SHA-256.

Yeah, that is both long and wrong. I'd maybe say "hex object id" in some
cases, which is slightly less cumbersome and extends to sha256. And
distinguishes it from a binary object id (though see below).

>  Documentation/glossary-content.txt | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git c/Documentation/glossary-content.txt w/Documentation/glossary-content.txt
> index 090c888335..e2ab920911 100644
> --- c/Documentation/glossary-content.txt
> +++ w/Documentation/glossary-content.txt
> @@ -262,13 +262,20 @@ This commit is referred to as a "merge commit", or sometimes just a
>  	identified by its <<def_object_name,object name>>. The objects usually
>  	live in `$GIT_DIR/objects/`.
>  
> +[[def_object_id]]object ID::
> +	Synonym for <<def_object_identifier,object identifier>>.
> +
>  [[def_object_identifier]]object identifier::
> -	Synonym for <<def_object_name,object name>>.
> +	An <<def_object_name, object name>> written as an
> +	unabbreviated hexadecimal representation of the hash value
> +	that uniquely identifies an <<def_object,object>>.
> +	Also colloquially called <<def_SHA1,SHA-1>>.

You might want to touch on "binary" here, too, with something like:

  This may also be used to refer to the binary representation of the
  hash value (e.g., as found within Git trees). Unless specified, this
  term typically implies the hexadecimal representation.

But maybe that is overkill. When we are talking about the command line
interface, stdin, etc, I can't think of a place where we'd take the
binary ("hash-object -t tree", but I don't really count that).

>  [[def_object_name]]object name::
> -	The unique identifier of an <<def_object,object>>.  The
> -	object name is usually represented by a 40 character
> -	hexadecimal string.  Also colloquially called <<def_SHA1,SHA-1>>.
> +	A name that identifies an <<def_object,object>> uniquely,
> +	which can be given in various ways, including but not
> +	limited to, the object's full <<def_object_identifier,object
> +	identifier>>, a <<def_ref,ref>> that refers to the object.

This all seems like an improvement to me, though the real question is
how often the term "object name" appears in the _other_ manpages to
refer to the more limited case.

-Peff

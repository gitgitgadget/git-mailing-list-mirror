Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E1751F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 21:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfJ3VYY (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 17:24:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:34320 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727084AbfJ3VYY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 17:24:24 -0400
Received: (qmail 30618 invoked by uid 109); 30 Oct 2019 21:24:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 30 Oct 2019 21:24:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23962 invoked by uid 111); 30 Oct 2019 21:27:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Oct 2019 17:27:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 30 Oct 2019 17:24:22 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] manpage-bold-literal.xsl: provide namespaced template
 for "d:literal"
Message-ID: <20191030212422.GE29013@sigill.intra.peff.net>
References: <20191030204104.19603-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191030204104.19603-1-martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 30, 2019 at 09:41:04PM +0100, Martin Ågren wrote:

> We recently regressed our rendering of "literal" elements in our
> manpages, i.e, stuff we have placed within `backticks` in order to
> render as monospace. In particular, we lost the bold rendering of such
> literal text.

This is just when rendering with asciidoctor, right? AFAICT the bolding
is still fine in pages built with asciidoc.

> The culprit is f6461b82b9 ("Documentation: fix build with Asciidoctor 2",
> 2019-09-15), where we switched from DocBook 4.5 to DocBook 5 with
> Asciidoctor. As part of the switch, we started using the namespaced
> DocBook XSLT stylesheets rather than the non-namespaced ones. (See
> f6461b82b9 for more details on why we changed to the namespaced ones.)
> 
> The bold literals are implemented as an XSLT snippet <xsl:template
> match="literal">...</xsl:template>. Now that we use namespaces, this
> doesn't pick up our literals like it used to.
>
> Add an exact copy of the template where we match for "d:literal" instead
> of just "literal", after defining the d namespace. ("d" is what
> http://docbook.sourceforge.net/release/xsl-ns/current/manpages/docbook.xsl
> uses.) Note that we need to keep the non-namespaced version for
> AsciiDoc.

Both the explanation and the solution make sense. We'd eventually be
able to drop this duplicate xsl if we go asciidoctor-only.

I have more general thoughts below, but the patch itself looks good to
me (and IMHO is worth taking for 2.24).

> This boldness was introduced by 5121a6d993 ("Documentation: option to
> render literal text as bold for manpages", 2009-03-27) and made the
> default in 5945717009 ("Documentation: bold literals in man",
> 2016-05-31).

I somehow missed that we turned on this bolding by default. I can
finally delete MAN_BOLD_LITERAL from my config.mak. ;)

> One reason this was not caught in review is that our doc-diff tool diffs
> without any boldness, i.e., it "only" compares text.

I don't think this was intentional, but just a consequence of
redirecting man's stdout to a non-terminal. Doing:

  MAN_KEEP_FORMATTING=1 ./doc-diff --asciidoctor HEAD^ HEAD

on your patch shows the improvement, though note that the diffed version
is kind of ugly. It looks like the bolding is done with ^H characters,
and it interacts in a funny way with our diff coloring, as well as with
diff-highlight if you use it. Piping the above through "less" looks
decent, but it gives me pause on whether we should be setting that
variable inside the script.

One other annoyance is that the directory names we use as a key for
caching results from run to run don't know about MAN_KEEP_FORMATTING. So
you may need "-f".

Speaking of annoyances, is it just me, or does the rendering stage of
doc-diff not actually proceed in parallel? Doing this seems to help, but
I'm not sure why:

diff --git a/Documentation/doc-diff b/Documentation/doc-diff
index 88a9b20168..1694300e50 100755
--- a/Documentation/doc-diff
+++ b/Documentation/doc-diff
@@ -127,7 +127,7 @@ generate_render_makefile () {
 	while read src
 	do
 		dst=$2/${src#$1/}
-		printf 'all:: %s\n' "$dst"
+		printf 'all: %s\n' "$dst"
 		printf '%s: %s\n' "$dst" "$src"
 		printf '\t@echo >&2 "  RENDER $(notdir $@)" && \\\n'
 		printf '\tmkdir -p $(dir $@) && \\\n'

> This has been optically tested with AsciiDoc 8.6.10, Asciidoctor 1.5.5
> and Asciidoctor 2.0.10. I've also verified that doc-diff produces the
> empty output in all three cases, as expected.

I like the phrase "optically tested". :)

I also confirmed with the MAN_KEEP_FORMATTING trick above that "doc-diff
--asciidoctor" fixes the problem as advertised, and "--asciidoc" has no
change at all.

>  I'm pretty sure about the background here, but I'm not at all sure 
>  that this is the prettiest or correctest fix.
>  
>  Not sure if this problem is bad enough (and the fix good enough) for
>  this to go into 2.24, but I offer this anyway.

It will only be noticed by people building with asciidoctor. But it _is_
a regression for them in 2.24, and the patch seems pretty safe. So I
think it's probably worth doing, but if it doesn't happen until the next
maint release, I don't think it's the end of the world.

>  There are more manpage-*.xsl -- manpage-suppress-sp.xsl looks like it
>  would have the exact same problem. But before diving in too deep, I'd
>  rather submit this one to see if it's in the right direction at all.

It looks like a lot of them don't actually match on the namespaced
tagnames, and so are OK. Some of them require special options to enable,
so we wouldn't necessarily notice problems via doc-diff.

From my brief look, I think suppress-sp is the only one that needs
attention. I kind of wonder if we can just drop it. According to the
Makefile comment, it's needed only for docbook 1.69.1-1.71.0. But 1.71.1
came out in 2006. Surely even RHEL7 or whatever ancient system people
use is past that, right? :)

Or alternatively, as I've argued elsewhere, we could simply be a little
more aggressive about deprecating old doc build tools. According to the
Makefile, no extra settings are needed with docbook >1.73.0. That came
out in 2007. I'd be willing to just call that the cutoff point, and
anybody without it can install the pre-formatted pages.

-Peff

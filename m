Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3769420248
	for <e@80x24.org>; Tue, 19 Mar 2019 02:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfCSCqs (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 22:46:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:55914 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727089AbfCSCqs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 22:46:48 -0400
Received: (qmail 27600 invoked by uid 109); 19 Mar 2019 02:46:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 19 Mar 2019 02:46:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26070 invoked by uid 111); 19 Mar 2019 02:47:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 18 Mar 2019 22:47:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Mar 2019 22:46:46 -0400
Date:   Mon, 18 Mar 2019 22:46:46 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH] asciidoctor-extensions: provide `<refmiscinfo/>`
Message-ID: <20190319024645.GA6173@sigill.intra.peff.net>
References: <20190317144747.2418514-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190317144747.2418514-1-martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 17, 2019 at 03:47:47PM +0100, Martin Ågren wrote:

>  Cc Todd and Peff who had a brief exchange [1] a while ago. Apparently
>  Todd saw this "[FIXME: source]" on Fedora but Peff did not on Debian.
>  I'm on Ubuntu 18.04 and used to see this also on 16.04. I'm not sure
>  what might make Debian so special here.

I think it was just that my version of asciidoctor had

  https://github.com/asciidoctor/asciidoctor/pull/2636

and Todd's did not. However, mine still does not do the _right_ thing,
because we didn't pass the right attributes in to asciidoctor. It just
didn't print an ugly "FIXME". Looking at the XML, I have:

  <refentrytitle>git-add</refentrytitle>
  <manvolnum>1</manvolnum>
  <refmiscinfo class="source">&#160;</refmiscinfo>
  <refmiscinfo class="manual">&#160;</refmiscinfo>
  </refmeta>

So it's just an nbsp instead of the real content, and the "version"
field is missing entirely.

> That Asciidoctor ignores asciidoc.conf is nothing new. This is why we
> implement the `linkgit:` macro in asciidoc.conf *and* in
> asciidoctor-extensions.rb. Follow suit and provide these tags in
> asciidoctor-extensions.rb, using a "postprocessor" extension.

Yeah, that seems sensible overall. Some thoughts on your approach:

>   * Provide the `mansource` attribute to Asciidoctor. This attribute
>     looks promising until one realizes that it can only be given inside
>     the source file (the .txt file in our case), *not* on the command
>     line using `-a mansource=foobar`. I toyed with the idea of injecting
>     this attribute while feeding Asciidoctor the input on stdin, but it
>     didn't feel like it was worth the complexity in the Makefile.

It does seem like "mansource" is the way asciidoctor expects us to do
this. Why doesn't it work from the command line? Is it a bug in
asciidoctor, or is there something more subtle going on?

I think even if it is a bug and gets fixed, though, it still wouldn't
have the version field (though that seems like something we could
contribute to asciidoctor).

>   * Similar to that last idea, we could inject these lines into the
>     xml-files from the Makefile, e.g., using `sed`. This reduces
>     repetition, but seems fairly brittle. It feels wrong to impose
>     another step and another risk on the Asciidoc-processing only to
>     benefit the Asciidoctor-one.

That's more or less what your ruby code is doing on. That said, I'd just
as soon do it in ruby as with a separate sed invocation. At least then
the external build is the same.

>   * Considering the above abandoned ideas, it seems better to put any
>     complexity inside asciidoctor-extensions.rb. It is after all
>     supposed to be the "equivalent" of asciidoc.conf. I considered
>     providing a "tree processor" extension and use it to set, e.g.,
>     `mansource` mentioned above.

This seems like the least bad option, at least for now. Your code does
do a generic regex substitution. The promise of XML is that we're
supposed to be able to do structured, robust transformations of the
document. But my experience has been that the tooling is sufficiently
difficult to work with that you just end up writing a regex.

So I'm curious if you tried to use an actual XML parser (or god forbid,
XSLT) to do the transformation. But if you spent more than 5 minutes on
it and got disgusted, I wouldn't ask you to look deeper than that. :)

I doubt we'd see any other refmeta tags (and any non-tag content would
be quoted).

> Let's instead try to stay as close as possible to what asciidoc.conf
> does. We'll make it fairly obvious that we aim to inject the exact same
> three lines of `<refmiscinfo/>` that asciidoc.conf provides. The only
> somewhat tricky part is that we inject them *post*-processing so we need
> to do the variable expansion ourselves.

One thing that asciidoctor buys us that asciidoc does not is that we
might eventually move to directly generating the manpages, without the
XML / Docbook step in between. And if we do, then all of this XML
hackery is going to have to get replaced with something else. I guess we
can cross that bridge when we come to it.

> diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
> index 0089e0cfb8..059279dee1 100644
> --- a/Documentation/asciidoctor-extensions.rb
> +++ b/Documentation/asciidoctor-extensions.rb
> @@ -20,9 +20,25 @@ module Git
>          end
>        end
>      end
> +
> +    class DocumentPostProcessor < Asciidoctor::Extensions::Postprocessor
> +      def process document, output
> +        if document.basebackend? 'docbook'
> +          git_version = document.attributes['git_version']
> +          replacement = "" \
> +            "<refmiscinfo class=\"source\">Git</refmiscinfo>\n" \
> +            "<refmiscinfo class=\"version\">#{git_version}</refmiscinfo>\n" \
> +            "<refmiscinfo class=\"manual\">Git Manual</refmiscinfo>\n" \
> +            "<\/refmeta>"
> +          output = output.sub(/<\/refmeta>/, replacement)
> +        end
> +        output
> +      end
> +    end

The patch itself looks sane. Would we ever need to XML-quote the
contents of git_version? I guess the asciidoc.conf version doesn't
bother. Technically the user running "make" could put whatever they want
into it, but I think this is a case of "if it hurts, don't do it", and
we can ignore it.

-Peff

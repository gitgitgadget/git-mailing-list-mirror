Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A975D1F6DC
	for <e@80x24.org>; Thu, 26 Jan 2017 03:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752775AbdAZDq7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 22:46:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:45091 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752682AbdAZDq6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 22:46:58 -0500
Received: (qmail 29541 invoked by uid 109); 26 Jan 2017 03:46:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Jan 2017 03:46:58 +0000
Received: (qmail 19653 invoked by uid 111); 26 Jan 2017 03:46:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 22:46:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jan 2017 22:46:56 -0500
Date:   Wed, 25 Jan 2017 22:46:56 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>
Subject: Re: [PATCH] Documentation: implement linkgit macro for Asciidoctor
Message-ID: <20170126034655.fwzow2mgkjj5dpek@sigill.intra.peff.net>
References: <20170125234101.n2pzrp77df4zycv7@genre.crustytoothpaste.net>
 <20170126001344.445534-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170126001344.445534-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 26, 2017 at 12:13:44AM +0000, brian m. carlson wrote:

> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 19c42eb60..d1b7a6865 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -179,10 +179,7 @@ ASCIIDOC = asciidoctor
>  ASCIIDOC_CONF =
>  ASCIIDOC_HTML = xhtml5
>  ASCIIDOC_DOCBOOK = docbook45
> -ifdef ASCIIDOCTOR_EXTENSIONS_LAB
> -ASCIIDOC_EXTRA = -I$(ASCIIDOCTOR_EXTENSIONS_LAB) -rasciidoctor/extensions -rman-inline-macro
> -endif
> -ASCIIDOC_EXTRA += -alitdd='&\#x2d;&\#x2d;'
> +ASCIIDOC_EXTRA += -I. -rasciidoctor-extensions -alitdd='&\#x2d;&\#x2d;'

Might be more readable to just leave the litdd part on its own line.

> diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
> new file mode 100644
> index 000000000..09f7088ee
> --- /dev/null
> +++ b/Documentation/asciidoctor-extensions.rb
> @@ -0,0 +1,28 @@
> +require 'asciidoctor'
> +require 'asciidoctor/extensions'
> +
> +module Git
> +  module Documentation
> +    class LinkGitProcessor < Asciidoctor::Extensions::InlineMacroProcessor
> +      use_dsl
> +
> +      named :chrome
> +
> +      def process(parent, target, attrs)
> +        if parent.document.basebackend? 'html'
> +          prefix = parent.document.attr('git-relative-html-prefix')
> +          %(<a href="#{prefix}#{target}.html">#{target}(#{attrs[1]})</a>\n)
> +        elsif parent.document.basebackend? 'docbook'
> +          %(<citerefentry>
> +<refentrytitle>#{target}</refentrytitle><manvolnum>#{attrs[1]}</manvolnum>
> +</citerefentry>
> +)
> +        end
> +      end
> +    end
> +  end
> +end

I think this looks reasonable. There's some boilerplate, but even as
somebody not familiar with asciidoctor, it's all quite obvious.

The multi-line string is kind of ugly because of the indentation.
Apparently Ruby has here-docs that will eat leading whitespace, but the
syntax was not introduce until Ruby 2.3, which is probably more recent
than we should count on.

I think you could write:

          %(<citerefentry>
            <refentrytitle>#{target}</refentrytitle><manvolnum>#{attrs[1]}</manvolnum>
            </citerefentry>
	  ).gsub(/^\s*/, "")

I don't know if that's too clever or not.

But either way, I like this better than introducing an extra dependency.

-Peff

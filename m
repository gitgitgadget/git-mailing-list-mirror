Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BDB01F463
	for <e@80x24.org>; Fri, 13 Sep 2019 05:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfIMFGg (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 01:06:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:48904 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726509AbfIMFGg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 01:06:36 -0400
Received: (qmail 24330 invoked by uid 109); 13 Sep 2019 05:06:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Sep 2019 05:06:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14561 invoked by uid 111); 13 Sep 2019 05:08:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 13 Sep 2019 01:08:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 13 Sep 2019 01:06:35 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Documentation: fix build with Asciidoctor 2
Message-ID: <20190913050634.GB21172@sigill.intra.peff.net>
References: <20190906232947.GJ11334@genre.crustytoothpaste.net>
 <20190913015240.686522-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190913015240.686522-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 13, 2019 at 01:52:40AM +0000, brian m. carlson wrote:

> We also need to teach xmlto how to use the namespaced DocBook XSLT
> stylesheets instead of the non-namespaced ones it usually uses.
> Normally these stylesheets are interchangeable, but the non-namespaced
> ones have a bug that causes them not to strip whitespace automatically
> from certain elements when namespaces are in use.  This results in
> additional whitespace at the beginning of list elements, which is
> jarring and unsightly.

Thanks, this fixed most of the rendering problems I saw from the earlier
patch.

> We can do this by passing a custom stylesheet with the -x option that
> simply imports the namespaced stylesheets via a URL.  Any system with
> support for XML catalogs will automatically look this URL up and
> reference a local copy instead without us having to know where this
> local copy is located.  We know that anyone using xmlto will already
> have catalogs set up properly since the DocBook 4.5 DTD used during
> validation is also looked up via catalogs.  All major Linux
> distributions distribute the necessary stylesheets and have built-in
> catalog support, and Homebrew does as well, albeit with a requirement to
> set an environment variable to enable catalog support.

This did give me one minor hiccup: I had the debian docbook-xsl package
installed, but not docbook-xsl-ns. The error message was pretty standard
for XML: obvious if you know what catalogs are, and utterly confusing
otherwise. :)

Everything worked fine after installing docbook-xsl-ns. I wonder if
could/should provide some guidance somewhere (maybe in INSTALL, which
discusses some catalog issues?).

> Finally, we need to filter out some messages from other stylesheets that
> when invoking dblatex in the CI job.  This tool strips namespaces much

s/that/that occur/ or something?

> like the unnamespaced DocBook stylesheets and prints similar messages.
> If we permit these messages to be printed to standard error, our
> documentation CI job will because we check standard error for unexpected

s/will/will fail/?

> ---
>  Documentation/Makefile    | 4 +++-
>  Documentation/manpage.xsl | 3 +++
>  ci/test-documentation.sh  | 2 ++
>  3 files changed, 8 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/manpage.xsl

Running with this patch on asciidoctor 2.0.10, plus Martin's recent
literal-block cleanups, plus his refmiscinfo fix, I get pretty decent
output from:

  ./doc-diff --from-asciidoc --to-asciidoctor origin HEAD

The header/footer are still a little funny (but I think Martin said that
he needs to update the refmiscinfo patches for later versions of
asciidoctor, which is probably what's going on here):

  --- a/f1d4a28250629ae469fc5dd59ab843cb2fd68e12-asciidoc/home/peff/share/man/man1/git-add.1
  +++ b/6c08635fd1d38c83d3765ff05fabbfbd25ef4943-asciidoctor/home/peff/share/man/man1/git-add.1
  @@ -1,4 +1,4 @@
  -GIT-ADD(1)                        Git Manual                        GIT-ADD(1)
  +GIT-ADD(1)                                                          GIT-ADD(1)
   
   NAME
          git-add - Add file contents to the index
  @@ -356,4 +356,4 @@ SEE ALSO
   GIT
          Part of the git(1) suite
   
  -Git omitted                       01/01/1970                        GIT-ADD(1)
  +  omitted                         1970-01-01                        GIT-ADD(1)


One curiosity is that any ``smart-quotes'' now get two spaces between them
and the period of the last sentence (whereas in asciidoc they got only
one):

  -           <start> and <end> are optional. “-L <start>” or “-L <start>,” spans
  -           from <start> to end of file. “-L ,<end>” spans from start of file
  -           to <end>.
  +           <start> and <end> are optional.  “-L <start>” or “-L <start>,”
  +           spans from <start> to end of file.  “-L ,<end>” spans from start of
  +           file to <end>.

I don't think this is a big deal, but I think most of these should
actually be backticks these days (the text above is from
git-annotate.txt, which hasn't been touched in quite a while).

There are other miscellaneous indentation fixes. Most of them look
better in asciidoctor, IMHO. For example, some lists now wrap more
neatly (it looks like it's usually lists after an indented listing
block? Maybe a continuation thing?):

  -           1. This step and the next one could be combined into a single step
  -           with "checkout -b my2.6.14 v2.6.14".
  +            1. This step and the next one could be combined into a single
  +               step with "checkout -b my2.6.14 v2.6.14".

Another curiosity is that single-quote `smart-quotes' are rendered as
real smart-quotes by asciidoctor:

  -           The following features from ‘svn log’ are supported:
  +           The following features from “svn log” are supported:

The only other case I found was this one, where I think the asciidoctor
version is better (the source has literal backticks, so there shouldn't
be a visible quote; I'm guessing asciidoc got confused by the apostrophe
in "variable's"):

  -           The ‘merge.*.driver` variable’s value is used to construct a
  +           The merge.*.driver variable’s value is used to construct a command

So overall, I think we're getting very close to parity.

-Peff

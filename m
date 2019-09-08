Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25DD01F461
	for <e@80x24.org>; Sun,  8 Sep 2019 21:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730816AbfIHVa3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Sep 2019 17:30:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:43572 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730544AbfIHVa3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Sep 2019 17:30:29 -0400
Received: (qmail 31061 invoked by uid 109); 8 Sep 2019 21:30:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 08 Sep 2019 21:30:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2986 invoked by uid 111); 8 Sep 2019 21:32:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 08 Sep 2019 17:32:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 8 Sep 2019 17:30:28 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Todd Zullinger <tmz@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] asciidoctor-extensions: provide `<refmiscinfo/>`
Message-ID: <20190908213028.GB8514@sigill.intra.peff.net>
References: <CAN0heSr2zCQMM6wOM0UnD28qj_VygQ5CQHGHhMR9+H23snpt5Q@mail.gmail.com>
 <cover.1567534373.git.martin.agren@gmail.com>
 <20190904032609.GD28836@sigill.intra.peff.net>
 <CAN0heSpbRvNG9okz5pqkHqDMB2BM5T+FzAbaK3sVwzGC6fjpPA@mail.gmail.com>
 <20190907064508.GC28860@sigill.intra.peff.net>
 <CAN0heSoOcpiPiRcYwLxxByC49Q-yXipFzBGm=XKW-AZk4n=8Jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSoOcpiPiRcYwLxxByC49Q-yXipFzBGm=XKW-AZk4n=8Jg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 07, 2019 at 04:06:48PM +0200, Martin Ågren wrote:

> So of these steps:
> 
>   0. Get Asciidoctor (v1) in shape.
> 
>   1. Switch the default to Asciidoctor (v1).
> 
>   2. Drop AsciiDoc to have faster Asciidoctor-processing, avoid xmlto
>      and support Asciidoctor 2. And to avoid the Python 2 EOL, too.
> 
> Step 0 is not far away, so step 1 could be done fairly soon IMHO. Step 2
> would "hopefully" happen soon after -- maybe even in the same release
> cycle as step 1, and if not the same then the one just after. But I
> might be the wrong person to trust on that one. I currently don't even
> try to build with Asciidoctor 2. I might perhaps look into installing
> it, but it could also be that I'll only start using it when it happens
> to arrive through my distro.
> 
> So as long as I'm not looking into Asciidoctor 2, maybe I shouldn't be
> the one to impose "default to asciidoctor" on the world. Dunno. In any
> case, I should be able to bring the asciidoc/tor1 differences to a state
> where we trust asciidoctor 1 to be in a good shape, so that "someone
> else" could pick up the ball and work on asciidoctor 2 vs 1, knowing
> that it's ok if they regress AsciiDoc support or even drop it entirely
> in the process.

We could also drop xmlto for the asciidoctor codepaths, without making
it the default. That requires a little bit more Makefile massaging, but
here's a hacky way to do it (this is on top of brian's asciidoctor 2
patch, which I've been experimenting with, but obviously we could skip
that entirely, too):

---
diff --git a/Documentation/Makefile b/Documentation/Makefile
index 485f365cbf..c3ebca6e36 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -197,12 +197,12 @@ ifdef USE_ASCIIDOCTOR
 ASCIIDOC = asciidoctor
 ASCIIDOC_CONF =
 ASCIIDOC_HTML = xhtml5
-ASCIIDOC_DOCBOOK = docbook5
+ASCIIDOC_DOCBOOK = manpage
 ASCIIDOC_EXTRA += -acompat-mode -atabsize=8
 ASCIIDOC_EXTRA += -I. -rasciidoctor-extensions
 ASCIIDOC_EXTRA += -alitdd='&\#x2d;&\#x2d;'
 DBLATEX_COMMON =
-XMLTO_EXTRA += --skip-validation
+XMLTO = ./fake-xmlto
 endif
 
 SHELL_PATH ?= $(SHELL)
diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index 4ae130d2c6..aae891e8ff 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -17,6 +17,8 @@ module Git
             "<refentrytitle>#{target}</refentrytitle>" \
             "<manvolnum>#{attrs[1]}</manvolnum>\n" \
           "</citerefentry>"
+        elsif parent.document.basebackend? 'manpage'
+          "#{target}(#{attrs[1]})"
         end
       end
     end
diff --git a/Documentation/fake-xmlto b/Documentation/fake-xmlto
new file mode 100755
index 0000000000..eca7ba289d
--- /dev/null
+++ b/Documentation/fake-xmlto
@@ -0,0 +1,9 @@
+#!/bin/sh
+
+# pick last arg as file
+for file in "$@"; do
+  : nothing
+done
+
+nr=$(perl -lne '/^\.TH ".*?" "(\d)"/ and print $1' $file)
+cp $file ${file%.xml}.$nr
-- 
2.23.0.554.g6dbe768f61


That's enough to let you do:

  ./doc-diff --from-asciidoc --to-asciidoctor HEAD^ HEAD

and see what jumping to direct-manpage generation would look like. After
applying all of your recent patches, I see some improvements. E.g.:

  -           Files to add content from. Fileglobs (e.g.  *.c) can be given to
  +           Files to add content from. Fileglobs (e.g. *.c) can be given to add

and some regressions:

  -           of nothing). The other file, git-add--interactive.perl, has 403
  +           of nothing). The other file, git-add&#x2d;&#x2d;interactive.perl,

There's also a lot of noise. One curiosity is that it refuses to break
linkgit output when wrapping:

  -           Remove everything in body before a scissors line (see git-
  -           mailinfo(1)). Can be activated by default using the
  +           Remove everything in body before a scissors line (see
  +           git-mailinfo(1)). Can be activated by default using the

I think that's fine (and probably even better), but it makes the
doc-diff quite hard to read. ;) Setting MANWIDTH=1000 in doc-diff is a
hacky way to eliminate these, but I'm not sure it's a good idea in
general.

-Peff

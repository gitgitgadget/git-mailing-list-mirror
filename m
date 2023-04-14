Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9DAC77B6E
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 07:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjDNHE5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 03:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjDNHE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 03:04:56 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59F059CB
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 00:04:50 -0700 (PDT)
Received: (qmail 12163 invoked by uid 109); 14 Apr 2023 07:04:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Apr 2023 07:04:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25054 invoked by uid 111); 14 Apr 2023 07:04:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Apr 2023 03:04:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 Apr 2023 03:04:49 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc: set actual revdate for manpages
Message-ID: <20230414070449.GA540206@coredump.intra.peff.net>
References: <20230413074722.71260-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230413074722.71260-1-felipe.contreras@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 13, 2023 at 01:47:22AM -0600, Felipe Contreras wrote:

> manpages expect the date of the last revision, if that is not found
> DocBook Stylesheets go through a series of hacks to generate one with
> the format `%d/%d/%Y` which is not ideal.
> 
> In addition to this format not being standard, different tools generate
> dates with different formats.
> 
> There's no need for any confusion if we specify the revision date, so
> let's do so.

That seems like a good goal, and should reduce our asciidoc/asciidoctor
diff considerably.

> This patch requires [1] to actually work, and has a simple conflict with
> [2], so it's written on top of both.
> 
> [1] https://lore.kernel.org/git/20230323221523.52472-1-felipe.contreras@gmail.com/
> [2] https://lore.kernel.org/git/20230408001829.11031-1-felipe.contreras@gmail.com/

I wasted a bit of time trying this out, so let me elaborate on "actually
work" for the benefit of other reviewers. Without the patch in [1]
(which is 8806120de6c on fc/remove-header-workarounds-for-asciidoc),
this patch works as advertised with asciidoctor, but has no effect with
asciidoc.  The reason is that asciidoc puts the <date> tags in the
header, and the custom header removed by 8806120de6c suppresses
asciidoc's default header entirely (so a workaround would be to include
the <date> tags in our custom header, but I don't see any reason not to
just build on top of 8806120de6c, as you did here).

> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 3133ea3182..b629176d7d 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -144,13 +144,16 @@ man5dir = $(mandir)/man5
>  man7dir = $(mandir)/man7
>  # DESTDIR =
>  
> +GIT_DATE := $(shell git show --quiet --pretty='%as')

What will/should this do in a distribution tarball, where we won't have
a Git repository at all? I think we'll just end up with a blank date in
the xml file, though it looks like docbook turns that into today's date
in the result.

That's not _too_ bad, but feels a bit inconsistent (and it uses the
format you're trying to get rid of!).

It would be nicer to populate the date variable in that case, like we do
for GIT_VERSION. I think that could look something like this:

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 2ccc3a9bc9..307634a94f 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -144,8 +144,6 @@ man5dir = $(mandir)/man5
 man7dir = $(mandir)/man7
 # DESTDIR =
 
-GIT_DATE := $(shell git show --quiet --pretty='%as')
-
 ASCIIDOC = asciidoc
 ASCIIDOC_EXTRA =
 ASCIIDOC_HTML = xhtml11
diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 9a1111af9b..14903bd261 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -10,7 +10,8 @@ LF='
 # then try git-describe, then default.
 if test -f version
 then
-	VN=$(cat version) || VN="$DEF_VER"
+	VN=$(cut -d" " -f1 version) || VN="$DEF_VER"
+	DN=$(cut -d" " -f2 version) || DN=""
 elif test -d ${GIT_DIR:-.git} -o -f .git &&
 	VN=$(git describe --match "v[0-9]*" HEAD 2>/dev/null) &&
 	case "$VN" in
@@ -22,19 +23,22 @@ elif test -d ${GIT_DIR:-.git} -o -f .git &&
 	esac
 then
 	VN=$(echo "$VN" | sed -e 's/-/./g');
+	DN=$(git log -1 --format=%as HEAD)
 else
 	VN="$DEF_VER"
+	DN=""
 fi
 
 VN=$(expr "$VN" : v*'\(.*\)')
 
 if test -r $GVF
 then
-	VC=$(sed -e 's/^GIT_VERSION = //' <$GVF)
+	VC=$(sed -ne 's/^GIT_VERSION = //p' <$GVF)
 else
 	VC=unset
 fi
 test "$VN" = "$VC" || {
 	echo >&2 "GIT_VERSION = $VN"
 	echo "GIT_VERSION = $VN" >$GVF
+	echo "GIT_DATE = $DN" >>$GVF
 }
diff --git a/Makefile b/Makefile
index 60ab1a8b4f..fa8db1943c 100644
--- a/Makefile
+++ b/Makefile
@@ -3573,7 +3573,7 @@ endif
 dist: git-archive$(X) configure
 	@$(RM) -r .dist-tmp-dir
 	@mkdir .dist-tmp-dir
-	@echo $(GIT_VERSION) > .dist-tmp-dir/version
+	@echo $(GIT_VERSION) $(GIT_DATE) > .dist-tmp-dir/version
 	@$(MAKE) -C git-gui TARDIR=../.dist-tmp-dir/git-gui dist-version
 	./git-archive --format=tar \
 		$(GIT_ARCHIVE_EXTRA_FILES) \
-- 
2.40.0.515.gdfb9e78b42


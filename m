Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAA1C43600
	for <git@archiver.kernel.org>; Wed, 12 May 2021 06:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 290896193E
	for <git@archiver.kernel.org>; Wed, 12 May 2021 06:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhELGbd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 02:31:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:52040 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229626AbhELGbb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 02:31:31 -0400
Received: (qmail 26550 invoked by uid 109); 12 May 2021 06:30:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 May 2021 06:30:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2599 invoked by uid 111); 12 May 2021 06:30:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 May 2021 02:30:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 12 May 2021 02:30:20 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH 1/2] doc: add an option to have Asciidoctor build man
 pages directly
Message-ID: <YJt1/DO1cXNTRNxK@coredump.intra.peff.net>
References: <609b2828309fc_678ff2082@natae.notmuch>
 <20210512021138.63598-1-sandals@crustytoothpaste.net>
 <YJt0Dv7HP2VnLLwv@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YJt0Dv7HP2VnLLwv@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 12, 2021 at 02:22:06AM -0400, Jeff King wrote:

> With that change, plus a patch I'll send in a minute, it's easy to run
> doc-diff on the result.

And here that is (note that if you don't apply the flags fix I showed,
then doc-diff gets confused, because it expects back-to-back runs of
"make" to handle the changed flags correctly).

Feel free to add it to your series if it helps (I had originally thought
it would just be a one-off to look at the output, but there are enough
changes, both correctness and style, that it may be useful to have this
option around).

-- >8 --
Subject: [PATCH] doc-diff: support --asciidoctor-direct mode

The new option enables both asciidoctor as well as its direct-to-manpage
mode that skips xmlto. This lets you view the rendered difference
between the two pipelines with something like:

  ./doc-diff --from-asciidoctor --to-asciidoctor-direct HEAD HEAD

Note that we have to add quotes when passing around $makemanflags, as it
now may contain whitespace due to multiple arguments (but the deference
inside render_tree must remain unquoted, because it wants to perform
whitespace splitting to get the individual arguments back).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/doc-diff | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/doc-diff b/Documentation/doc-diff
index 1694300e50..2c774ee954 100755
--- a/Documentation/doc-diff
+++ b/Documentation/doc-diff
@@ -17,10 +17,13 @@ f			force rebuild; do not rely on cached results
 c,clean			cleanup temporary working files
 from-asciidoc		use asciidoc with the 'from'-commit
 from-asciidoctor	use asciidoctor with the 'from'-commit
+from-asciidoctor-direct use asciidoctor without xmlto for 'from'-commit
 asciidoc		use asciidoc with both commits
 to-asciidoc		use asciidoc with the 'to'-commit
 to-asciidoctor		use asciidoctor with the 'to'-commit
+to-asciidoctor-direct   use asciidoctor without xmlto for 'to'-commit
 asciidoctor		use asciidoctor with both commits
+asciidoctor-direct      use asciidoctor without xml for both commits
 cut-footer		cut away footer
 "
 SUBDIRECTORY_OK=1
@@ -55,6 +58,13 @@ do
 	--asciidoc)
 		from_program=-asciidoc
 		to_program=-asciidoc ;;
+	--from-asciidoctor-direct)
+		from_program=-asciidoctor-direct ;;
+	--to-asciidoctor-direct)
+		to_program=-asciidoctor-direct ;;
+	--asciidoctor-direct)
+		from_program=-asciidoctor-direct
+		to_program=-asciidoctor-direct ;;
 	--cut-footer)
 		cut_footer=-cut-footer ;;
 	--)
@@ -112,6 +122,10 @@ construct_makemanflags () {
 	elif test "$1" = "-asciidoctor"
 	then
 		echo USE_ASCIIDOCTOR=YesPlease
+	elif test "$1" = "-asciidoctor-direct"
+	then
+		echo USE_ASCIIDOCTOR=YesPlease
+		echo USE_ASCIIDOCTOR_MANPAGE=YesPlease
 	fi
 }
 
@@ -181,6 +195,6 @@ render_tree () {
 	fi
 }
 
-render_tree $from_oid $from_dir $from_makemanflags &&
-render_tree $to_oid $to_dir $to_makemanflags &&
+render_tree $from_oid $from_dir "$from_makemanflags" &&
+render_tree $to_oid $to_dir "$to_makemanflags" &&
 git -C $tmp/rendered diff --no-index "$@" $from_dir $to_dir
-- 
2.31.1.1027.g87a751368c


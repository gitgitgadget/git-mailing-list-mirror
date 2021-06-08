Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B81BC47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 07:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1629361184
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 07:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhFHH0m (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 03:26:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:48722 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229678AbhFHH0m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 03:26:42 -0400
Received: (qmail 28587 invoked by uid 109); 8 Jun 2021 07:24:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Jun 2021 07:24:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7396 invoked by uid 111); 8 Jun 2021 07:24:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Jun 2021 03:24:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 8 Jun 2021 03:24:48 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: [PATCH] doc: warn people against --max-pack-size
Message-ID: <YL8bQMOAHxApjVVe@coredump.intra.peff.net>
References: <776cb2f9-5fef-4486-5aef-f3ee62fcda7e@gmail.com>
 <YL8RfGijMY95miHI@coredump.intra.peff.net>
 <xmqqfsxsq1l4.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfsxsq1l4.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 08, 2021 at 04:04:23PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Mon, Jun 07, 2021 at 01:42:47PM +0700, Bagas Sanjaya wrote:
> >
> >> I would like to create packfiles with charm-numbered size (that is for
> >> example use 49.99M instead of 50M) with git-repack:
> >> 
> >> $ git repack --max-pack-size=49.99M -a -d
> >
> > The parser for numbers with units is shared by many options and config
> > variables. In general, I'm not really opposed to allowing floating point
> > values which get rounded to the nearest byte for any of them. So no
> > objection for the general feature if somebody wants to implement it.
> >
> > But I would note that --max-pack-size is almost never a good idea in
> > general. I don't know what you think it's accomplishing, but it is
> > probably making your repository larger than it needs to be, as well as
> > less performant.
> 
> Perhaps a doc update is in order?  It might have been cute and
> superficially useful to be able to cut packfiles in 650M chunks to
> fit on a CD-ROM, but I suspect that it would be more useful to feed
> a single large file to a generic multi-volume archive tool and let
> it split it to fit the physical volume the tool deals with.

Yeah. Let's do that while we're thinking about it. Here's what I came up
with.

-- >8 --
Subject: [PATCH] doc: warn people against --max-pack-size

This option is almost never a good idea, as the resulting repository is
larger and slower (see the new explanations in the docs).

I outlined the potential problems. We could go further and make the
option harder to find (or at least, make the command-line option
descriptions a much more terse "you probably don't want this; see
pack.packsizeLimit for details"). But this seems like a minimal change
that may prevent people from thinking it's more useful than it is.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config/pack.txt      | 23 +++++++++++++++++------
 Documentation/git-pack-objects.txt |  6 +++---
 Documentation/git-repack.txt       |  4 +++-
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/Documentation/config/pack.txt b/Documentation/config/pack.txt
index c0844d8d8e..763f7af7c4 100644
--- a/Documentation/config/pack.txt
+++ b/Documentation/config/pack.txt
@@ -99,12 +99,23 @@ pack.packSizeLimit::
 	packing to a file when repacking, i.e. the git:// protocol
 	is unaffected.  It can be overridden by the `--max-pack-size`
 	option of linkgit:git-repack[1].  Reaching this limit results
-	in the creation of multiple packfiles; which in turn prevents
-	bitmaps from being created.
-	The minimum size allowed is limited to 1 MiB.
-	The default is unlimited.
-	Common unit suffixes of 'k', 'm', or 'g' are
-	supported.
+	in the creation of multiple packfiles.
++
+Note that this option is rarely useful, and may result in a larger total
+on-disk size (because Git will not store deltas between packs), as well
+as worse runtime performance (object lookup within multiple packs is
+slower than a single pack, and optimizations like reachability bitmaps
+cannot cope with multiple packs).
++
+If you need to actively run Git using smaller packfiles (e.g., because your
+filesystem does not support large files), this option may help. But if
+your goal is to transmit a packfile over a medium that supports limited
+sizes (e.g., removable media that cannot store the whole repository),
+you are likely better off creating a single large packfile and splitting
+it using a generic multi-volume archive tool (e.g., Unix `split`).
++
+The minimum size allowed is limited to 1 MiB. The default is unlimited.
+Common unit suffixes of 'k', 'm', or 'g' are supported.
 
 pack.useBitmaps::
 	When true, git will use pack bitmaps (if available) when packing
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 25d9fbe37a..dbfd1f9017 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -128,10 +128,10 @@ depth is 4095.
 	into multiple independent packfiles, each not larger than the
 	given size. The size can be suffixed with
 	"k", "m", or "g". The minimum size allowed is limited to 1 MiB.
-	This option
-	prevents the creation of a bitmap index.
 	The default is unlimited, unless the config variable
-	`pack.packSizeLimit` is set.
+	`pack.packSizeLimit` is set. Note that this option may result in
+	a larger and slower repository; see the discussion in
+	`pack.packSizeLimit`.
 
 --honor-pack-keep::
 	This flag causes an object already in a local pack that
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index ef310f362e..24c00c9384 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -121,7 +121,9 @@ depth is 4095.
 	If specified, multiple packfiles may be created, which also
 	prevents the creation of a bitmap index.
 	The default is unlimited, unless the config variable
-	`pack.packSizeLimit` is set.
+	`pack.packSizeLimit` is set. Note that this option may result in
+	a larger and slower repository; see the discussion in
+	`pack.packSizeLimit`.
 
 -b::
 --write-bitmap-index::
-- 
2.32.0.527.gfd0058899e


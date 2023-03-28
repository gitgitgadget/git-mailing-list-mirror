Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E77AC76196
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 18:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjC1S0y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 14:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjC1S0x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 14:26:53 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381A9198A
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 11:26:51 -0700 (PDT)
Received: (qmail 1391 invoked by uid 109); 28 Mar 2023 18:26:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Mar 2023 18:26:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 561 invoked by uid 111); 28 Mar 2023 18:26:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Mar 2023 14:26:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Mar 2023 14:26:50 -0400
From:   Jeff King <peff@peff.net>
To:     "Baumann, Moritz" <moritz.baumann@sap.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH] docs: document caveats of rev-list's object-name output
Message-ID: <20230328182650.GC18558@coredump.intra.peff.net>
References: <AS1PR02MB8185A45DB63216699AFB2C5494849@AS1PR02MB8185.eurprd02.prod.outlook.com>
 <20230324192848.GC536967@coredump.intra.peff.net>
 <AS1PR02MB8185DF947EBC583318481E1994889@AS1PR02MB8185.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AS1PR02MB8185DF947EBC583318481E1994889@AS1PR02MB8185.eurprd02.prod.outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 28, 2023 at 08:08:02AM +0000, Baumann, Moritz wrote:

> > Those names are really just intended as hints for pack-objects. I
> > suspect the documentation could be more clear about these limitations.
> 
> That would indeed be great and would have likely prevented the obvious
> misconceptions on my side.

Here's what I came up with.

-- >8 --
Subject: docs: document caveats of rev-list's object-name output

At first glance, the names given by "rev-list --objects" seem like a
good way to see which paths are present in a set of commits. But there
are some subtle gotchas there. We do not document the format of the
names at all, so let's do so, along with warning of these problems.

I intentionally did not document the exact format of the names here, as
I don't think it's something we want people to rely on (though I doubt
in practice that we'd change it at this point).

Though all of this is historically tied to "--objects", these days we
have a separate "--object-names" flag which can turn the names off or
on. So I put the detailed documentation there, but added a note from
--objects (which did not otherwise mention the names at all, even though
they are on by default).

Signed-off-by: Jeff King <peff@peff.net>
---
I also considered adding a specific "if you want the names of each file
in a range of commits, pipe to diff-tree" example. But it seemed like it
would clutter up this section. It might be OK as a stand-alone in the
EXAMPLES section, but should probably be done as a separate patch if
anyone is interested.

 Documentation/rev-list-options.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 90c73d6708b..3000888a908 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -890,7 +890,7 @@ ifdef::git-rev-list[]
 	Print the object IDs of any object referenced by the listed
 	commits.  `--objects foo ^bar` thus means ``send me
 	all object IDs which I need to download if I have the commit
-	object _bar_ but not _foo_''.
+	object _bar_ but not _foo_''. See also `--object-names` below.
 
 --in-commit-order::
 	Print tree and blob ids in order of the commits. The tree
@@ -920,7 +920,12 @@ ifdef::git-rev-list[]
 
 --object-names::
 	Only useful with `--objects`; print the names of the object IDs
-	that are found. This is the default behavior.
+	that are found. This is the default behavior. Note that the
+	"name" of each object is ambiguous, and mostly intended as a
+	hint for packing objects. In particular: no distinction is made between
+	the names of tags, trees, and blobs; path names may be modified
+	to remove newlines; and if an object would appear multiple times
+	with different names, only one name is shown.
 
 --no-object-names::
 	Only useful with `--objects`; does not print the names of the object
-- 
2.40.0.616.gf524ec75088


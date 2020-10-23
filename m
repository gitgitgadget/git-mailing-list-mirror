Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A93C55178
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 08:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B96392192A
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 08:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S375663AbgJWIRO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 04:17:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:40262 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S374595AbgJWIRN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 04:17:13 -0400
Received: (qmail 27336 invoked by uid 109); 23 Oct 2020 08:17:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 Oct 2020 08:17:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16024 invoked by uid 111); 23 Oct 2020 08:17:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Oct 2020 04:17:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Oct 2020 04:17:11 -0400
From:   Jeff King <peff@peff.net>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] documentation symlink restrictions for .git* files
Message-ID: <20201023081711.GB4012156@coredump.intra.peff.net>
References: <20201005071751.GA2290770@coredump.intra.peff.net>
 <20201005121609.GA2907272@coredump.intra.peff.net>
 <6c0a0036-e217-a334-2a74-dd59a4592c1f@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6c0a0036-e217-a334-2a74-dd59a4592c1f@iee.email>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 21, 2020 at 12:19:25AM +0100, Philip Oakley wrote:

> On 05/10/2020 13:16, Jeff King wrote:
> > On Mon, Oct 05, 2020 at 03:17:51AM -0400, Jeff King wrote:
> >
> >> About 2 years ago as part of a security release we made it illegal to
> >> have a symlinked .gitmodules file (refusing it both in the index and via
> >> fsck). At the time we discussed (on the security list) outlawing
> >> symlinks for other .git files in the same way, but we decided not to do
> >> so as part of the security release, as it wasn't strictly necessary.
> 
> Is this something that should be recorded in the documentation, either as a
> simple (sensible) limitation, or explicitly as a security related safety
> measure?
> 
> I didn't see any changes to the .txt docs in the change list below.

Yeah, that's a good point.

How about this (on top of jk/symlinked-dotgitx-files)?

-- >8 --
Subject: [PATCH] documentation symlink restrictions for .git* files

We outlawed symbolic link versions of various .git files in 10ecfa7649
(verify_path: disallow symlinks in .gitmodules, 2018-05-04) and
dd4c2fe66b (verify_path(): disallow symlinks in .gitattributes and
.gitignore, 2020-10-05). The reasons are discussed in detail there, but
we never adjusted the documentation to let users know.

This hasn't been a big deal since the point is that such setups were
mildly broken and thought to be unusual anyway. But it certainly doesn't
hurt to be clear and explicit about it.

Suggested-by: Philip Oakley <philipoakley@iee.email>
Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/gitattributes.txt | 7 +++++++
 Documentation/gitignore.txt     | 5 +++++
 Documentation/gitmodules.txt    | 8 ++++++++
 3 files changed, 20 insertions(+)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 2d0a03715b..9a2ce4f1ea 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -1241,6 +1241,13 @@ to:
 [attr]binary -diff -merge -text
 ------------
 
+NOTES
+-----
+
+Note that Git does not allow a `.gitattributes` file within the working
+tree to be a symbolic link, and will refuse to check out such a tree
+entry.  This keeps behavior consistent when the file is accessed from
+the index or a tree versus from the filesystem.
 
 EXAMPLES
 --------
diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index d47b1ae296..7e9a1d49d6 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -149,6 +149,11 @@ not tracked by Git remain untracked.
 To stop tracking a file that is currently tracked, use
 'git rm --cached'.
 
+Note that Git does not allow a `.gitignore` file within the working tree
+to be a symbolic link, and will refuse to check out such a tree entry.
+This keeps behavior consistent when the file is accessed from the index
+or a tree versus from the filesystem.
+
 EXAMPLES
 --------
 
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index 539b4e1997..2b884be3c7 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -98,6 +98,14 @@ submodule.<name>.shallow::
 	shallow clone (with a history depth of 1) unless the user explicitly
 	asks for a non-shallow clone.
 
+NOTES
+-----
+
+Note that Git does not allow the `.gitmodules` file within a working
+tree to be a symbolic link, and will refuse to check out such a tree
+entry. This keeps behavior consistent when the file is accessed from the
+index or a tree versus from the filesystem, and helps Git reliably
+enforce security checks of the file contents.
 
 EXAMPLES
 --------
-- 
2.29.0.583.g8e3ac41d8f


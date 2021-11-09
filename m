Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E679C433F5
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 16:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EEE76112F
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 16:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237041AbhKIQif (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 11:38:35 -0500
Received: from cloud.peff.net ([104.130.231.41]:55980 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235827AbhKIQie (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 11:38:34 -0500
Received: (qmail 24535 invoked by uid 109); 9 Nov 2021 16:35:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 09 Nov 2021 16:35:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3096 invoked by uid 111); 9 Nov 2021 16:35:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 09 Nov 2021 11:35:48 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 9 Nov 2021 11:35:47 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH] git-jump: pass "merge" arguments to ls-files
Message-ID: <YYqjY/zcBWyqY8/5@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We currently throw away any arguments given to "git jump merge". We
should instead pass them along to ls-files, since they're likely to be
pathspecs. This matches the behavior of "git jump diff", etc.

Signed-off-by: Jeff King <peff@peff.net>
---
Just a little wart I noticed while doing a really tricky merge today.

 contrib/git-jump/README   | 3 +++
 contrib/git-jump/git-jump | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/contrib/git-jump/README b/contrib/git-jump/README
index 2f618a7f97..8bcace29d2 100644
--- a/contrib/git-jump/README
+++ b/contrib/git-jump/README
@@ -65,6 +65,9 @@ git jump diff --cached
 # jump to merge conflicts
 git jump merge
 
+# documentation conflicts are hard; skip past them for now
+git jump merge :^Documentation
+
 # jump to all instances of foo_bar
 git jump grep foo_bar
 
diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
index 931b0fe3a9..92dbd4cde1 100755
--- a/contrib/git-jump/git-jump
+++ b/contrib/git-jump/git-jump
@@ -39,7 +39,7 @@ mode_diff() {
 }
 
 mode_merge() {
-	git ls-files -u |
+	git ls-files -u "$@" |
 	perl -pe 's/^.*?\t//' |
 	sort -u |
 	while IFS= read fn; do
-- 
2.34.0.rc1.634.g85d556ea55

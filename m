From: Jeff King <peff@peff.net>
Subject: [PATCH] t3910: show failure of core.precomposeunicode with
 decomposed filenames
Date: Mon, 28 Apr 2014 12:16:31 -0400
Message-ID: <20140428161630.GA9435@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Apr 28 18:16:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeoER-0008HA-PA
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 18:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756060AbaD1QQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 12:16:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:40443 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751758AbaD1QQd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 12:16:33 -0400
Received: (qmail 32371 invoked by uid 102); 28 Apr 2014 16:16:33 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Apr 2014 11:16:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Apr 2014 12:16:31 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247372>

If you have existing decomposed filenames in your git
repository (e.g., that were created with older versions of
git that did not precompose unicode), a modern git with
core.precomposeunicode set does not handle them well.

The problem is that we normalize the paths coming from the
disk into their precomposed form, and then compare them
against the literal bytes in the index. This makes things
better if you have the precomposed form in the index. It
makes things worse if you actually have the decomposed form
in the index.

As a result, paths with decomposed filenames may have their
precomposed variants listed as untracked files (even though
the precomposed variants do not exist on-disk at all).

This patch just adds a test to demonstrate the breakage.
Some possible fixes are:

  1. Tell everyone that NFD in the git repo is wrong, and
     they should make a new commit to normalize all their
     in-repo files to be precomposed.

     This is probably not the right thing to do, because it
     still doesn't fix checkouts of old history. And it
     spreads the problem to people on byte-preserving
     filesystems (like ext4), because now they have to start
     precomposing their filenames as they are adde to git.

  2. Do all index filename comparisons using a UTF-8 aware
     comparison function when core.precomposeunicode is set.
     This would probably have bad performance, and somewhat
     defeats the point of converting the filenames at the
     readdir level in the first place.

  3. Convert index filenames to their precomposed form when
     we read the index from disk. This would be efficient,
     but we would have to be careful not to write the
     precomposed forms back out to disk.

  4. Introduce some infrastructure to efficiently match up
     the precomposed/decomposed forms. We already do
     something similar for case-insensitive files using
     name-hash.c. We might be able to adapt that strategy
     here.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t3910-mac-os-precompose.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t3910-mac-os-precompose.sh b/t/t3910-mac-os-precompose.sh
index e4ba601..23aa61e 100755
--- a/t/t3910-mac-os-precompose.sh
+++ b/t/t3910-mac-os-precompose.sh
@@ -140,6 +140,16 @@ test_expect_success "Add long precomposed filename" '
 	git add * &&
 	git commit -m "Long filename"
 '
+
+test_expect_failure 'handle existing decomposed filenames' '
+	echo content >"verbatim.$Adiarnfd" &&
+	git -c core.precomposeunicode=false add "verbatim.$Adiarnfd" &&
+	git commit -m "existing decomposed file" &&
+	>expect &&
+	git ls-files --exclude-standard -o "verbatim*" >untracked &&
+	test_cmp expect untracked
+'
+
 # Test if the global core.precomposeunicode stops autosensing
 # Must be the last test case
 test_expect_success "respect git config --global core.precomposeunicode" '
-- 
1.9.1.656.ge8a0637

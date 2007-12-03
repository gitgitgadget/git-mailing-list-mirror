From: Jeff King <peff@peff.net>
Subject: [PATCH] quote_path: fix collapsing of relative paths
Date: Mon, 3 Dec 2007 00:30:01 -0500
Message-ID: <20071203053001.GA12696@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 06:30:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz3sw-0007qC-FG
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 06:30:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbXLCFaG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 00:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbXLCFaG
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 00:30:06 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1463 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750707AbXLCFaF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 00:30:05 -0500
Received: (qmail 26142 invoked by uid 111); 3 Dec 2007 05:30:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 03 Dec 2007 00:30:02 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Dec 2007 00:30:01 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66863>

The code tries to collapse identical leading components
between the prefix and the path. So if we're in "dir1", the
path "dir1/file" should become just "file". However, we were
ending up with "../dir1/file". The included test expected
the wrong output.

Because the "len" parameter to quote_path can be passed in
as -1 to indicate a NUL-terminated string, we have to
consider that possibility in our loop conditional (but no
additional checks are necessary, since we already check that
prefix[off] and in[off] are identical, and that prefix[off]
is not NUL.

Signed-off-by: Jeff King <peff@peff.net>
---
This behavior in git-status had been bugging me, and when I went to fix
it, I was surprised to find code already there to do it. :) Dscho,
please confirm that the test is in fact in error, and that I've read the
intent of your code correctly.

 t/t7502-status.sh |    2 +-
 wt-status.c       |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t7502-status.sh b/t/t7502-status.sh
index 269b334..d6ae69d 100755
--- a/t/t7502-status.sh
+++ b/t/t7502-status.sh
@@ -68,7 +68,7 @@ cat > expect << \EOF
 # Changed but not updated:
 #   (use "git add <file>..." to update what will be committed)
 #
-#	modified:   ../dir1/modified
+#	modified:   modified
 #
 # Untracked files:
 #   (use "git add <file>..." to include in what will be committed)
diff --git a/wt-status.c b/wt-status.c
index e77120d..09666ec 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -90,7 +90,8 @@ static char *quote_path(const char *in, int len,
 
 	if (prefix) {
 		int off = 0;
-		while (prefix[off] && off < len && prefix[off] == in[off])
+		while (prefix[off] && (len < 0 || off < len)
+				&& prefix[off] == in[off])
 			if (prefix[off] == '/') {
 				prefix += off + 1;
 				in += off + 1;
-- 
1.5.3.7.2070.g88cf2-dirty

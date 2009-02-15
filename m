From: Jeff King <peff@peff.net>
Subject: [PATCH 5/5] remote: use exact HEAD lookup if it is available
Date: Sun, 15 Feb 2009 01:18:18 -0500
Message-ID: <20090215061818.GE30414@coredump.intra.peff.net>
References: <20090215060815.GA7473@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 15 07:19:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYaM1-00068X-13
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 07:19:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbZBOGSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 01:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbZBOGSV
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 01:18:21 -0500
Received: from peff.net ([208.65.91.99]:53096 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750830AbZBOGSU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 01:18:20 -0500
Received: (qmail 5461 invoked by uid 107); 15 Feb 2009 06:18:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 15 Feb 2009 01:18:39 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 15 Feb 2009 01:18:18 -0500
Content-Disposition: inline
In-Reply-To: <20090215060815.GA7473@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109970>

Our usual method for determining the ref pointed to by HEAD
is to compare HEAD's sha1 to the sha1 of all refs, trying to
find a unique match.

However, some transports actually get to look at HEAD
directly; we should make use of that information when it is
available.  Currently, only http remotes support this
feature.

Signed-off-by: Jeff King <peff@peff.net>
---
A possible 6/5 would be to do something similar for local repos (or
resurrecting the HEAD proposal).

 remote.c              |   10 ++++++++++
 t/t5550-http-fetch.sh |   11 +++++++++++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/remote.c b/remote.c
index 7ba1bff..a96a910 100644
--- a/remote.c
+++ b/remote.c
@@ -1395,6 +1395,16 @@ struct ref *guess_remote_head(const struct ref *head,
 	if (!head)
 		return NULL;
 
+	/*
+	 * Some transports support directly peeking at
+	 * where HEAD points; if that is the case, then
+	 * we don't have to guess.
+	 */
+	if (head->symref) {
+		r = find_ref_by_name(refs, head->symref);
+		return r ? copy_ref_with_peer(r) : NULL;
+	}
+
 	/* If refs/heads/master could be right, it is. */
 	if (!all) {
 		const struct ref *m;
diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
index b6e6ec9..05b1b62 100755
--- a/t/t5550-http-fetch.sh
+++ b/t/t5550-http-fetch.sh
@@ -42,5 +42,16 @@ test_expect_success 'fetch changes via http' '
 	test_cmp file clone/file
 '
 
+test_expect_success 'http remote detects correct HEAD' '
+	git push public master:other &&
+	(cd clone &&
+	 git remote set-head origin -d &&
+	 git remote set-head origin -a &&
+	 git symbolic-ref refs/remotes/origin/HEAD > output &&
+	 echo refs/remotes/origin/master > expect &&
+	 test_cmp expect output
+	)
+'
+
 stop_httpd
 test_done
-- 
1.6.2.rc0.256.gf004c.dirty

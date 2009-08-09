From: Jeff King <peff@peff.net>
Subject: [PATCH] merge: indicate remote tracking branches in merge message
Date: Sun, 9 Aug 2009 02:59:36 -0400
Message-ID: <20090809065936.GA24112@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 08:59:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ma2Nf-0000B0-PV
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 08:59:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752312AbZHIG7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 02:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752249AbZHIG7i
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 02:59:38 -0400
Received: from peff.net ([208.65.91.99]:35265 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751985AbZHIG7i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 02:59:38 -0400
Received: (qmail 2235 invoked by uid 107); 9 Aug 2009 07:01:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 09 Aug 2009 03:01:51 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Aug 2009 02:59:36 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125323>

Previously when merging directly from a local tracking
branch like:

  git merge origin/master

The merge message said:

   Merge commit 'origin/master'

     * commit 'origin/master':
       ...

Instead, let's be more explicit about what we are merging:

   Merge remote branch 'origin/master'

     * origin/master:
       ...

We accomplish this by recognizing remote tracking branches
in git-merge when we build the simulated FETCH_HEAD output
that we feed to fmt-merge-msg.

Signed-off-by: Jeff King <peff@peff.net>
---
This is a repost of

  http://article.gmane.org/gmane.comp.version-control.git/119909

which got no response from you. I think it is a good idea, but I am not
deeply committed to it. I mainly want a yes or no so I can clean it out
of my patch queue.

 builtin-merge.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index 0b12fb3..c5688e1 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -378,6 +378,17 @@ static void merge_name(const char *remote, struct strbuf *msg)
 		goto cleanup;
 	}
 
+	strbuf_setlen(&buf, 0);
+	strbuf_addstr(&buf, "refs/remotes/");
+	strbuf_addstr(&buf, remote);
+	resolve_ref(buf.buf, branch_head, 0, 0);
+
+	if (!hashcmp(remote_head->sha1, branch_head)) {
+		strbuf_addf(msg, "%s\t\tremote branch '%s' of .\n",
+				sha1_to_hex(branch_head), remote);
+		goto cleanup;
+	}
+
 	/* See if remote matches <name>^^^.. or <name>~<number> */
 	for (len = 0, ptr = remote + strlen(remote);
 	     remote < ptr && ptr[-1] == '^';
-- 
1.6.4.72.g50730

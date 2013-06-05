From: Jeff King <peff@peff.net>
Subject: [PATCH 4/4] archive: ignore blob objects when checking reachability
Date: Wed, 5 Jun 2013 18:40:39 -0400
Message-ID: <20130605224038.GD15607@sigill.intra.peff.net>
References: <20130605223551.GF8664@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ian Harvey <iharvey@good.com>
X-From: git-owner@vger.kernel.org Thu Jun 06 00:40:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkMNp-000717-Ja
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 00:40:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758059Ab3FEWkl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jun 2013 18:40:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:54353 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758036Ab3FEWkl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jun 2013 18:40:41 -0400
Received: (qmail 17029 invoked by uid 102); 5 Jun 2013 22:41:27 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Jun 2013 17:41:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Jun 2013 18:40:39 -0400
Content-Disposition: inline
In-Reply-To: <20130605223551.GF8664@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226475>

We cannot create an archive from a blob object, so we would
not expect anyone to provide one to us. And if they do, we
will fail anyway just after the reachability check.  We can
therefore optimize our reachability check to ignore blobs
completely, and not even create a "struct blob" for them.

Depending on the repository size and the exact place we find
the reachable object in the traversal, this can save 20-25%,
a we can avoid many lookups in the object hash.

The downside of this is that a blob provided to a remote
archive process will fail with "no such object" rather than
"object is not a tree" (we could organize the code to retain
the old message, but since we no longer know whether the
blob is reachable or not, we would potentially be leaking
information about the existence of unreachable objects).

Signed-off-by: Jeff King <peff@peff.net>
---
 archive.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/archive.c b/archive.c
index 4d77624..98691cd 100644
--- a/archive.c
+++ b/archive.c
@@ -290,6 +290,7 @@ static int object_is_reachable(const unsigned char *sha1)
 	save_commit_buffer = 0;
 	init_revisions(&data.revs, NULL);
 	setup_revisions(ARRAY_SIZE(argv) - 1, argv, &data.revs, NULL);
+	data.revs.blob_objects = 0;
 	if (prepare_revision_walk(&data.revs))
 		return 0;
 
-- 
1.8.3.rc2.14.g7eee6b3

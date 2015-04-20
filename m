From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] sha1_file: only freshen packs once per run
Date: Mon, 20 Apr 2015 15:55:00 -0400
Message-ID: <20150420195500.GB15760@peff.net>
References: <20150420195337.GA15447@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Saasen <ssaasen@atlassian.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 21:55:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkHme-0003Th-Qp
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 21:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752491AbbDTTzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 15:55:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:47794 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752390AbbDTTzD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 15:55:03 -0400
Received: (qmail 8976 invoked by uid 102); 20 Apr 2015 19:55:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Apr 2015 14:55:02 -0500
Received: (qmail 27993 invoked by uid 107); 20 Apr 2015 19:55:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Apr 2015 15:55:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Apr 2015 15:55:00 -0400
Content-Disposition: inline
In-Reply-To: <20150420195337.GA15447@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267495>

Since 33d4221 (write_sha1_file: freshen existing objects,
2014-10-15), we update the mtime of existing objects that we
would have written out (had they not existed). For the
common case in which many objects are packed, we may update
the mtime on a single packfile repeatedly. This can result
in a noticeable performance problem if calling utime() is
expensive (e.g., because your storage is on NFS).

We can fix this by keeping a per-pack flag that lets us
freshen only once per program invocation.

An alternative would be to keep the packed_git.mtime flag up
to date as we freshen, and freshen only once every N
seconds. In practice, it's not worth the complexity. We are
racing against prune expiration times here, which inherently
must be set to accomodate reasonable program running times
(because they really care about the time between an object
being written and it becoming referenced, and the latter is
typically the last step a program takes).

Signed-off-by: Jeff King <peff@peff.net>
---
Hopefully I didn't botch the flag logic again. :) I tested with "strace
-c" myself this time, so I think it is good.

 cache.h     | 1 +
 sha1_file.c | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index 3d3244b..72c6888 100644
--- a/cache.h
+++ b/cache.h
@@ -1174,6 +1174,7 @@ extern struct packed_git {
 	int pack_fd;
 	unsigned pack_local:1,
 		 pack_keep:1,
+		 freshened:1,
 		 do_not_close:1;
 	unsigned char sha1[20];
 	/* something like ".git/objects/pack/xxxxx.pack" */
diff --git a/sha1_file.c b/sha1_file.c
index 822aaef..26b9b2b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2999,7 +2999,14 @@ static int freshen_loose_object(const unsigned char *sha1)
 static int freshen_packed_object(const unsigned char *sha1)
 {
 	struct pack_entry e;
-	return find_pack_entry(sha1, &e) && freshen_file(e.p->pack_name);
+	if (!find_pack_entry(sha1, &e))
+		return 0;
+	if (e.p->freshened)
+		return 1;
+	if (!freshen_file(e.p->pack_name))
+		return 0;
+	e.p->freshened = 1;
+	return 1;
 }
 
 int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *returnsha1)
-- 
2.4.0.rc2.384.g7297a4a

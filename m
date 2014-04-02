From: Jeff King <peff@peff.net>
Subject: [PATCH] pack-objects: do not reuse packfiles without
 --delta-base-offset
Date: Wed, 2 Apr 2014 02:39:17 -0400
Message-ID: <20140402063916.GA1437@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 03 13:56:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeIy-0006sp-6n
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 11:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757941AbaDBGjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 02:39:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:52356 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756658AbaDBGjT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2014 02:39:19 -0400
Received: (qmail 21069 invoked by uid 102); 2 Apr 2014 06:39:19 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 02 Apr 2014 01:39:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Apr 2014 02:39:17 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245728>

When we are sending a packfile to a remote, we currently try
to reuse a whole chunk of packfile without bothering to look
at the individual objects. This can make things like initial
clones much lighter on the server, as we can just dump the
packfile bytes.

However, it's possible that the other side cannot read our
packfile verbatim. For example, we may have objects stored
as OFS_DELTA, but the client is an antique version of git
that only understands REF_DELTA. We negotiate this
capability over the fetch protocol. A normal pack-objects
run will convert OFS_DELTA into REF_DELTA on the fly, but
the "reuse pack" code path never even looks at the objects.

This patch disables packfile reuse if the other side is
missing any capabilities that we might have used in the
on-disk pack. Right now the only one is OFS_DELTA, but we
may need to expand in the future (e.g., if packv4 introduces
new object types).

We could be more thorough and only disable reuse in this
case when we actually have an OFS_DELTA to send, but:

  1. We almost always will have one, since we prefer
     OFS_DELTA to REF_DELTA when possible. So this case
     would almost never come up.

  2. Looking through the objects defeats the purpose of the
     optimization, which is to do as little work as possible
     to get the bytes to the remote.

Signed-off-by: Jeff King <peff@peff.net>
---
I happened to be fooling around with git v1.4.0 today, and noticed a
problem fetching from GitHub. Pre-OFS_DELTA git versions are ancient by
today's standard, but it's quite easy to remain compatible here, so I
don't see why not. And in theory, alternate implementations might not
understand OFS_DELTA, though in practice I would consider such an
implementation to be pretty crappy.

 builtin/pack-objects.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 7950c43..1503632 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2439,12 +2439,23 @@ static void loosen_unused_packed_objects(struct rev_info *revs)
 	}
 }
 
+/*
+ * This tracks any options which a reader of the pack might
+ * not understand, and which would therefore prevent blind reuse
+ * of what we have on disk.
+ */
+static int pack_options_allow_reuse(void)
+{
+	return allow_ofs_delta;
+}
+
 static int get_object_list_from_bitmap(struct rev_info *revs)
 {
 	if (prepare_bitmap_walk(revs) < 0)
 		return -1;
 
-	if (!reuse_partial_packfile_from_bitmap(
+	if (pack_options_allow_reuse() &&
+	    !reuse_partial_packfile_from_bitmap(
 			&reuse_packfile,
 			&reuse_packfile_objects,
 			&reuse_packfile_offset)) {
-- 
1.9.1.656.ge8a0637

From: Jeff King <peff@peff.net>
Subject: [PATCH 6/7] object_as_type: set commit index
Date: Fri, 11 Jul 2014 04:49:42 -0400
Message-ID: <20140711084942.GF5625@sigill.intra.peff.net>
References: <20140711084141.GA5521@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Jul 11 10:49:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5WWc-0005yH-Ds
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 10:49:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701AbaGKItq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 04:49:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:59971 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751402AbaGKIto (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 04:49:44 -0400
Received: (qmail 18729 invoked by uid 102); 11 Jul 2014 08:49:44 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 Jul 2014 03:49:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Jul 2014 04:49:42 -0400
Content-Disposition: inline
In-Reply-To: <20140711084141.GA5521@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253261>

The point of the "index" field of struct commit is that
every allocated commit would have a uniquely allocated
value. It is supposed to be an invariant that whenever
object->type is set to OBJ_COMMIT, we have a unique index.

Commit 969eba6 (commit: push commit_index update into
alloc_commit_node, 2014-06-10) covered this case for
newly-allocated commits. However, we may also allocate an
OBJ_NONE object via lookup_unknown_object, and only later
convert it to a commit. We must make sure that we set the
commit index when we switch the type field.

Signed-off-by: Jeff King <peff@peff.net>
---
 object.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/object.c b/object.c
index b2319f6..69fbbbf 100644
--- a/object.c
+++ b/object.c
@@ -163,6 +163,8 @@ void *object_as_type(struct object *obj, enum object_type type, int quiet)
 	if (obj->type == type)
 		return obj;
 	else if (obj->type == OBJ_NONE) {
+		if (type == OBJ_COMMIT)
+			((struct commit *)obj)->index = alloc_commit_index();
 		obj->type = type;
 		return obj;
 	}
-- 
2.0.0.566.gfe3e6b2

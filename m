From: Jeff King <peff@peff.net>
Subject: [PATCH] index-pack: distinguish missing objects from type errors
Date: Mon, 12 May 2014 00:38:39 -0400
Message-ID: <20140512043839.GA2252@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 12 06:38:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wji0o-0003p0-Rj
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 06:38:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbaELEio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2014 00:38:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:49633 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750717AbaELEio (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2014 00:38:44 -0400
Received: (qmail 29739 invoked by uid 102); 12 May 2014 04:38:42 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 11 May 2014 23:38:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 May 2014 00:38:39 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248689>

When we fetch a pack that does not contain an object we
expected to receive, we get an error like:

  $ git init --bare tmp.git && cd tmp.git
  $ git fetch ../parent.git
  [...]
  error: Could not read 964953ec7bcc0245cb1d0db4095455edd21a2f2e
  fatal: Failed to traverse parents of commit b8247b40caf6704fe52736cdece6d6aae87471aa
  error: ../parent.git did not send all necessary objects

This comes from the check_everything_connected rev-list. If
we try cloning the same repo (rather than a fetch), we end
up using index-pack's --check-self-contained-and-connected
option instead, which produces output like:

  $ git clone --no-local --bare parent.git tmp.git
  [...]
  fatal: object of unexpected type
  fatal: index-pack failed

Not only is the sha1 missing, but it's a misleading message.
There's no type problem, but rather a missing object
problem; we don't notice the difference because we simply
compare OBJ_BAD != OBJ_BLOB.  Let's provide a different
message for this case:

  $ git clone --no-local --bare parent.git tmp.git
  fatal: did not receive expected object 6b00a8c61ed379d5f925a72c1987c9c52129d364
  fatal: index-pack failed

While we're at it, let's also improve a true type mismatch
error to look like

  fatal: object 6b00a8c61ed379d5f925a72c1987c9c52129d364: expected type blob, got tree

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/index-pack.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index b9f6e12..35643e5 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -200,8 +200,13 @@ static unsigned check_object(struct object *obj)
 	if (!(obj->flags & FLAG_CHECKED)) {
 		unsigned long size;
 		int type = sha1_object_info(obj->sha1, &size);
-		if (type != obj->type || type <= 0)
-			die(_("object of unexpected type"));
+		if (type <= 0)
+			die(_("did not receive expected object %s"),
+			      sha1_to_hex(obj->sha1));
+		if (type != obj->type)
+			die(_("object %s: expected type %s, found %s"),
+			    sha1_to_hex(obj->sha1),
+			    typename(obj->type), typename(type));
 		obj->flags |= FLAG_CHECKED;
 		return 1;
 	}
-- 
2.0.0.rc1.436.g03cb729

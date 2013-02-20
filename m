From: Jeff King <peff@peff.net>
Subject: [PATCH v3 02/19] upload-pack: do not add duplicate objects to
 shallow list
Date: Wed, 20 Feb 2013 14:54:57 -0500
Message-ID: <20130220195457.GB25647@sigill.intra.peff.net>
References: <20130220195147.GA25332@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 20 20:55:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8FlD-0008M7-Qs
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 20:55:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934852Ab3BTTy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 14:54:59 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54550 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934749Ab3BTTy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 14:54:59 -0500
Received: (qmail 17545 invoked by uid 107); 20 Feb 2013 19:56:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Feb 2013 14:56:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Feb 2013 14:54:57 -0500
Content-Disposition: inline
In-Reply-To: <20130220195147.GA25332@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216716>

When the client tells us it has a shallow object via
"shallow <sha1>", we make sure we have the object, mark it
with a flag, then add it to a dynamic array of shallow
objects. This means that a client can get us to allocate
arbitrary amounts of memory just by flooding us with shallow
lines (whether they have the objects or not). You can
demonstrate it easily with:

  yes '0035shallow e83c5163316f89bfbde7d9ab23ca2e25604af290' |
  git-upload-pack git.git

We already protect against duplicates in want lines by
checking if our flag is already set; let's do the same thing
here. Note that a client can still get us to allocate some
amount of memory by marking every object in the repo as
"shallow" (or "want"). But this at least bounds it with the
number of objects in the repository, which is not under the
control of an upload-pack client.

Signed-off-by: Jeff King <peff@peff.net>
---
Looking over upload-pack, I think this is the only "consume arbitrary
memory" spot. Since you can convince git to go to quite a bit of work
just processing a big repo, the distinction may not be important, but
drawing the line between "large" and "arbitrarily large" seemed
reasonable to me (and it's a trivial fix).

 upload-pack.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index b058e8d..1aee407 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -603,8 +603,10 @@ static void receive_needs(void)
 				die("did not find object for %s", line);
 			if (object->type != OBJ_COMMIT)
 				die("invalid shallow object %s", sha1_to_hex(sha1));
-			object->flags |= CLIENT_SHALLOW;
-			add_object_array(object, NULL, &shallows);
+			if (!(object->flags & CLIENT_SHALLOW)) {
+			    object->flags |= CLIENT_SHALLOW;
+			    add_object_array(object, NULL, &shallows);
+			}
 			continue;
 		}
 		if (!prefixcmp(line, "deepen ")) {
-- 
1.8.2.rc0.9.g352092c

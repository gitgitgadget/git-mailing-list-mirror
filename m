From: Jeff King <peff@peff.net>
Subject: [PATCH 3/4] peel_ref: check object type before loading
Date: Thu, 4 Oct 2012 04:02:53 -0400
Message-ID: <20121004080253.GC31325@sigill.intra.peff.net>
References: <20121004075609.GA1355@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:28:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtUg-0001w8-Vr
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:02:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563Ab2JDIC6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 04:02:58 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40484 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932089Ab2JDIC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 04:02:56 -0400
Received: (qmail 17779 invoked by uid 107); 4 Oct 2012 08:03:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 04 Oct 2012 04:03:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Oct 2012 04:02:53 -0400
Content-Disposition: inline
In-Reply-To: <20121004075609.GA1355@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207004>

The point of peel_ref is to dereference tags; if the base
object is not a tag, then we can return early without even
loading the object into memory.

This patch accomplishes that by checking sha1_object_info
for the type. For a packed object, we can get away with just
looking in the pack index. For a loose object, we only need
to inflate the first couple of header bytes.

This is a bit of a gamble; if we do find a tag object, then
we will end up loading the content anyway, and the extra
lookup will have been wasteful. However, if it is not a tag
object, then we save loading the object entirely. Depending
on the ratio of non-tags to tags in the input, this can be a
minor win or minor loss.

However, it does give us one potential major win: if a ref
points to a large blob (e.g., via an unannotated tag), then
we can avoid looking at it entirely.

Signed-off-by: Jeff King <peff@peff.net>
---
This optimization is the one that gave me the most pause. While
upload-pack does call peel_ref on everything, the other callers all
constrain themselves to refs/tags/. So for many projects, we will be
calling it mostly on annotated tags, and it may be a very small net
loss. But in practice, it will not matter for most projects with a sane
number of normal tags, and saving even one accidental giant blob load
can have a huge impact.

 refs.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index f672ad9..02e47b1 100644
--- a/refs.c
+++ b/refs.c
@@ -1225,8 +1225,15 @@ fallback:
 	}
 
 fallback:
-	o = parse_object(base);
-	if (o && o->type == OBJ_TAG) {
+	o = lookup_unknown_object(base);
+	if (o->type == OBJ_NONE) {
+		int type = sha1_object_info(base, NULL);
+		if (type < 0)
+			return -1;
+		o->type = type;
+	}
+
+	if (o->type == OBJ_TAG) {
 		o = deref_tag_noverify(o);
 		if (o) {
 			hashcpy(sha1, o->sha1);
-- 
1.8.0.rc0.10.g8dd2a92

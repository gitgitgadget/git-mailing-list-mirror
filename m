From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] upload-pack: load non-tip "want" objects from disk
Date: Sat, 16 Mar 2013 06:28:30 -0400
Message-ID: <20130316102830.GC29533@sigill.intra.peff.net>
References: <20130316102428.GA29358@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 16 11:29:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGoMG-0006ic-Ug
	for gcvg-git-2@plane.gmane.org; Sat, 16 Mar 2013 11:29:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755600Ab3CPK2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Mar 2013 06:28:34 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53474 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755587Ab3CPK2d (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Mar 2013 06:28:33 -0400
Received: (qmail 931 invoked by uid 107); 16 Mar 2013 10:30:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 16 Mar 2013 06:30:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 16 Mar 2013 06:28:30 -0400
Content-Disposition: inline
In-Reply-To: <20130316102428.GA29358@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218297>

It is a long-time security feature that upload-pack will not
serve any "want" lines that do not correspond to the tip of
one of our refs. Traditionally, this was enforced by
checking the objects in the in-memory hash; they should have
been loaded and received the OUR_REF flag during the
advertisement.

The stateless-rpc mode, however, has a race condition here:
one process advertises, and another receives the want lines,
so the refs may have changed in the interim.  To address
this, commit 051e400 added a new verification mode; if the
object is not OUR_REF, we set a "has_non_tip" flag, and then
later verify that the requested objects are reachable from
our current tips.

However, we still die immediately when the object is not in
our in-memory hash, and at this point we should only have
loaded our tip objects. So the check_non_tip code path does
not ever actually trigger, as any non-tip objects would
have already caused us to die.

We can fix that by using parse_object instead of
lookup_object, which will load the object from disk if it
has not already been loaded.

We still need to check that parse_object does not return
NULL, though, as it is possible we do not have the object
at all. A more appropriate error message would be "no such
object" rather than "not our ref"; however, we do not want
to leak information about what objects are or are not in
the object database, so we continue to use the same "not
our ref" message that would be produced by an unreachable
object.

Signed-off-by: Jeff King <peff@peff.net>
---
 upload-pack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 41736ec..948cfff 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -638,8 +638,8 @@ static void receive_needs(void)
 		if (parse_feature_request(features, "include-tag"))
 			use_include_tag = 1;
 
-		o = lookup_object(sha1_buf);
-		if (!o || !parse_object(o->sha1))
+		o = parse_object(sha1_buf);
+		if (!o)
 			die("git upload-pack: not our ref %s",
 			    sha1_to_hex(sha1_buf));
 		if (!(o->flags & WANTED)) {
-- 
1.8.2.rc2.7.gef06216

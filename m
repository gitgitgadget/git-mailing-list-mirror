From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] fetch-pack: avoid repeatedly re-scanning pack directory
Date: Sat, 26 Jan 2013 17:40:43 -0500
Message-ID: <20130126224043.GB20849@sigill.intra.peff.net>
References: <20130126224011.GA20675@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 26 23:41:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzEQt-0008OY-Nz
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jan 2013 23:41:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754704Ab3AZWkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 17:40:46 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51677 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754484Ab3AZWkp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 17:40:45 -0500
Received: (qmail 25305 invoked by uid 107); 26 Jan 2013 22:42:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 26 Jan 2013 17:42:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 26 Jan 2013 17:40:43 -0500
Content-Disposition: inline
In-Reply-To: <20130126224011.GA20675@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214643>

When we look up a sha1 object for reading, we first check
packfiles, and then loose objects. If we still haven't found
it, we re-scan the list of packfiles in `objects/pack`. This
final step ensures that we can co-exist with a simultaneous
repack process which creates a new pack and then prunes the
old object.

This extra re-scan usually does not have a performance
impact for two reasons:

  1. If an object is missing, then typically the re-scan
     will find a new pack, then no more misses will occur.
     Or if it truly is missing, then our next step is
     usually to die().

  2. Re-scanning is cheap enough that we do not even notice.

However, these do not always hold. The assumption in (1) is
that the caller is expecting to find the object. This is
usually the case, but the call to `parse_object` in
`everything_local` does not follow this pattern. It is
looking to see whether we have objects that the remote side
is advertising, not something we expect to have. Therefore
if we are fetching from a remote which has many refs
pointing to objects we do not have, we may end up
re-scanning the pack directory many times.

Even with this extra re-scanning, the impact is often not
noticeable due to (2); we just readdir() the packs directory
and skip any packs that are already loaded. However, if
there are a large number of packs, then even enumerating the
directory directory can be expensive (especially if we do it
repeatedly). Having this many packs is a good sign the user
should run `git gc`, but it would still be nice to avoid
having to scan the directory at all.

Signed-off-by: Jeff King <peff@peff.net>
---
 fetch-pack.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fetch-pack.c b/fetch-pack.c
index f0acdf7..6d8926a 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -594,6 +594,9 @@ static int everything_local(struct fetch_pack_args *args,
 	for (ref = *refs; ref; ref = ref->next) {
 		struct object *o;
 
+		if (!has_sha1_file(ref->old_sha1))
+			continue;
+
 		o = parse_object(ref->old_sha1);
 		if (!o)
 			continue;
-- 
1.8.0.2.16.g72e2fc9

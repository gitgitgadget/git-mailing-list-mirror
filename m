From: Jeff King <peff@peff.net>
Subject: [PATCH] index-pack: always zero-initialize object_entry list
Date: Tue, 19 Mar 2013 06:58:52 -0400
Message-ID: <20130319105852.GA15182@sigill.intra.peff.net>
References: <20130319102422.GB6341@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Zager <szager@google.com>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Mar 19 11:59:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHuGL-0004eV-Tz
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 11:59:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423Ab3CSK66 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 06:58:58 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58207 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751077Ab3CSK65 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 06:58:57 -0400
Received: (qmail 27834 invoked by uid 107); 19 Mar 2013 11:00:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 19 Mar 2013 07:00:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Mar 2013 06:58:52 -0400
Content-Disposition: inline
In-Reply-To: <20130319102422.GB6341@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218504>

Commit 38a4556 (index-pack: start learning to emulate
"verify-pack -v", 2011-06-03) added a "delta_depth" counter
to each "struct object_entry". Initially, all object entries
have their depth set to 0; in resolve_delta, we then set the
depth of each delta to "base + 1". Base entries never have
their depth touched, and remain at 0.

To ensure that all depths start at 0, that commit changed
calls to xmalloc the object_entry list into calls to
xcalloc.  However, it forgot that we grow the list with
xrealloc later. These extra entries are used when we add an
object from elsewhere pack to complete a thin pack. If we
add a non-delta object, its depth value will just be
uninitialized heap data.

This patch fixes it by zero-initializing entries we add to
the objects list via the xrealloc.

Signed-off-by: Jeff King <peff@peff.net>
---
Another solution would be to say "only look at delta_depth
if the object is a delta"; we follow that rule already in
the output histogram code path, but just do not when
checking a delta's base. So it would similarly be a
one-liner.  But I think given the switch to xcalloc in the
original patch, the intent was to just always zero each
object, as I described above.

This would be more readable if we had an "xrecalloc" or
similar, which realloc'd a pointer and set just the _new_
space to zeros. I do not recall ever hearing of such a
function, though. I figured since it is a one-off, it is
simpler to just say what we mean with memset here than
invent a new allocation function that will leave people
scratching their heads about its semantics.

 builtin/index-pack.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 43d364b..ca62443 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1107,6 +1107,8 @@ static void conclude_pack(int fix_thin_pack, const char *curr_pack, unsigned cha
 		objects = xrealloc(objects,
 				   (nr_objects + nr_unresolved + 1)
 				   * sizeof(*objects));
+		memset(objects + nr_objects, 0,
+		       (nr_unresolved + 1) * sizeof(*objects));
 		f = sha1fd(output_fd, curr_pack);
 		fix_unresolved_deltas(f, nr_unresolved);
 		sprintf(msg, _("completed with %d local objects"),
-- 
1.8.2.4.g2ed830d

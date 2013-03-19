From: Jeff King <peff@peff.net>
Subject: [PATCH v2] index-pack: always zero-initialize object_entry list
Date: Tue, 19 Mar 2013 12:17:22 -0400
Message-ID: <20130319161722.GA17445@sigill.intra.peff.net>
References: <20130319102422.GB6341@sigill.intra.peff.net>
 <20130319105852.GA15182@sigill.intra.peff.net>
 <8738vr5rqh.fsf@pctrast.inf.ethz.ch>
 <20130319154353.GA10010@sigill.intra.peff.net>
 <20130319155244.GA16532@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Zager <szager@google.com>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Mar 19 17:18:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHzEd-0004ah-7z
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 17:17:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932699Ab3CSQR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 12:17:27 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58568 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751682Ab3CSQR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 12:17:27 -0400
Received: (qmail 31463 invoked by uid 107); 19 Mar 2013 16:19:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 19 Mar 2013 12:19:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Mar 2013 12:17:22 -0400
Content-Disposition: inline
In-Reply-To: <20130319155244.GA16532@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218536>

On Tue, Mar 19, 2013 at 11:52:44AM -0400, Jeff King wrote:

> > > > Commit 38a4556 (index-pack: start learning to emulate
> > > > "verify-pack -v", 2011-06-03) added a "delta_depth" counter
> > > > to each "struct object_entry". Initially, all object entries
> > > > have their depth set to 0; in resolve_delta, we then set the
> > > > depth of each delta to "base + 1". Base entries never have
> > > > their depth touched, and remain at 0.
> > > 
> > > This patch causes index-pack to fail on the pack that triggered the
> > > whole discussion.  More in a minute in another side thread, but
> > > meanwhile: NAK until we understand what is really going on here.
> > 
> > Odd; that's what I was testing with, and it worked fine.
> 
> Ah, interesting. I built the fix on top of d1a0ed1, the first commit
> that shows the problem. And it works fine there. But when it is
> forward-ported to the current master, it breaks as you saw.
> 
> More bisection fun.

So after bisecting, I realize that it is indeed broken on top of
d1a0ed1. I have no idea why I didn't notice that before; I'm guessing it
was because I was running it under valgrind and paying attention only to
valgrind errors.

Anyway, the problem is simple and stupid. The original object array is
not nr_objects item long; it is (nr_objects + 1) long, though I'm not
clear why (1-indexing?). So my previous patch was zeroing the final
entry, which was supposed to contain actual data. Oops.

Here's the corrected patch.

-- >8 --
Subject: [PATCH] index-pack: always zero-initialize object_entry list

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
 builtin/index-pack.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 43d364b..5860085 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1107,6 +1107,8 @@ static void conclude_pack(int fix_thin_pack, const char *curr_pack, unsigned cha
 		objects = xrealloc(objects,
 				   (nr_objects + nr_unresolved + 1)
 				   * sizeof(*objects));
+		memset(objects + nr_objects + 1, 0,
+		       nr_unresolved * sizeof(*objects));
 		f = sha1fd(output_fd, curr_pack);
 		fix_unresolved_deltas(f, nr_unresolved);
 		sprintf(msg, _("completed with %d local objects"),
-- 
1.8.2.22.g4863f63

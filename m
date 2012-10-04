From: Jeff King <peff@peff.net>
Subject: [PATCH 4/4] upload-pack: use peel_ref for ref advertisements
Date: Thu, 4 Oct 2012 04:03:33 -0400
Message-ID: <20121004080333.GD31325@sigill.intra.peff.net>
References: <20121004075609.GA1355@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:14:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtUh-0001w8-GJ
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:02:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442Ab2JDIDi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 04:03:38 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40488 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932089Ab2JDIDg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 04:03:36 -0400
Received: (qmail 17808 invoked by uid 107); 4 Oct 2012 08:04:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 04 Oct 2012 04:04:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Oct 2012 04:03:33 -0400
Content-Disposition: inline
In-Reply-To: <20121004075609.GA1355@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206982>

When upload-pack advertises refs, we attempt to peel tags
and advertise the peeled version. We currently hand-roll the
tag dereferencing, and use as many optimizations as we can
to avoid loading non-tag objects into memory.

Not only has peel_ref recently learned these optimizations,
too, but it also contains an even more important one: it
has access to the "peeled" data from the pack-refs file.
That means we can avoid not only loading annotated tags
entirely, but also avoid doing any kind of object lookup at
all.

This cut the CPU time to advertise refs by 50% in the
linux-2.6 repo, as measured by:

  echo 0000 | git-upload-pack . >/dev/null

best-of-five, warm cache, objects and refs fully packed:

  [before]             [after]
  real    0m0.026s     real    0m0.013s
  user    0m0.024s     user    0m0.008s
  sys     0m0.000s     sys     0m0.000s

Those numbers are irrelevantly small compared to an actual
fetch. Here's a larger repo (400K refs, of which 12K are
unique, and of which only 107 are unique annotated tags):

  [before]             [after]
  real    0m0.704s     real    0m0.596s
  user    0m0.600s     user    0m0.496s
  sys     0m0.096s     sys     0m0.092s

This shows only a 15% speedup (mostly because it has fewer
actual tags to parse), but a larger absolute value (100ms,
which isn't a lot compared to a real fetch, but this
advertisement happens on every fetch, even if the client is
just finding out they are completely up to date).

In truly pathological cases, where you have a large number
of unique annotated tags, it can make an even bigger
difference. Here are the numbers for a linux-2.6 repository
that has had every seventh commit tagged (so about 50K
tags):

  [before]             [after]
  real    0m0.443s     real    0m0.097s
  user    0m0.416s     user    0m0.080s
  sys     0m0.024s     sys     0m0.012s

Signed-off-by: Jeff King <peff@peff.net>
---
 upload-pack.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 2e90ccb..6142421 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -727,12 +727,7 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 		" include-tag multi_ack_detailed";
 	struct object *o = lookup_unknown_object(sha1);
 	const char *refname_nons = strip_namespace(refname);
-
-	if (o->type == OBJ_NONE) {
-		o->type = sha1_object_info(sha1, NULL);
-		if (o->type < 0)
-		    die("git upload-pack: cannot find object %s:", sha1_to_hex(sha1));
-	}
+	unsigned char peeled[20];
 
 	if (capabilities)
 		packet_write(1, "%s %s%c%s%s agent=%s\n",
@@ -747,11 +742,8 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 		o->flags |= OUR_REF;
 		nr_our_refs++;
 	}
-	if (o->type == OBJ_TAG) {
-		o = deref_tag_noverify(o);
-		if (o)
-			packet_write(1, "%s %s^{}\n", sha1_to_hex(o->sha1), refname_nons);
-	}
+	if (!peel_ref(refname, peeled))
+		packet_write(1, "%s %s^{}\n", sha1_to_hex(peeled), refname_nons);
 	return 0;
 }
 
-- 
1.8.0.rc0.10.g8dd2a92

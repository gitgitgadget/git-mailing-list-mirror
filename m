From: Jeff King <peff@peff.net>
Subject: [PATCH 1/4] peel_ref: use faster deref_tag_noverify
Date: Thu, 4 Oct 2012 03:58:15 -0400
Message-ID: <20121004075815.GA31325@sigill.intra.peff.net>
References: <20121004075609.GA1355@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:09:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtUb-0001w8-2E
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:02:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489Ab2JDH6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 03:58:19 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40474 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932089Ab2JDH6S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 03:58:18 -0400
Received: (qmail 17712 invoked by uid 107); 4 Oct 2012 07:58:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 04 Oct 2012 03:58:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Oct 2012 03:58:15 -0400
Content-Disposition: inline
In-Reply-To: <20121004075609.GA1355@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206971>

When we are asked to peel a ref to a sha1, we internally call
deref_tag, which will recursively parse each tagged object
until we reach a non-tag. This has the benefit that we will
verify our ability to load and parse the pointed-to object.

However, there is a performance downside: we may not need to
load that object at all (e.g., if we are listing peeled
simply listing peeled refs), or it may be a large object
that should follow a streaming code path (e.g., an annotated
tag of a large blob).

It makes more sense for peel_ref to choose the fast thing
rather than performing the extra check, for two reasons:

  1. We will already sometimes short-circuit the tag parsing
     in favor of a peeled entry from a packed-refs file. So
     we are already favoring speed in some cases, and it is
     not wise for a caller to rely on peel_ref to detect
     corruption.

  2. We already silently ignore much larger corruptions,
     like a ref that points to a non-existent object, or a
     tag object that exists but is corrupted.

  2. peel_ref is not the right place to check for such a
     database corruption. It is returning only the sha1
     anyway, not the actual object. Any callers which use
     that sha1 to load an object will soon discover the
     corruption anyway, so we are really just pushing back
     the discovery to later in the program.

Signed-off-by: Jeff King <peff@peff.net>
---
This is basically bringing the optimization from 90108a2 (upload-pack:
avoid parsing tag destinations, 2012-01-06) to users of peel_ref.

 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index da74a2b..0a916a0 100644
--- a/refs.c
+++ b/refs.c
@@ -1225,7 +1225,7 @@ fallback:
 fallback:
 	o = parse_object(base);
 	if (o && o->type == OBJ_TAG) {
-		o = deref_tag(o, refname, 0);
+		o = deref_tag_noverify(o);
 		if (o) {
 			hashcpy(sha1, o->sha1);
 			return 0;
-- 
1.8.0.rc0.10.g8dd2a92

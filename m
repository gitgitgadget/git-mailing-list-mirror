From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] upload-pack: avoid parsing objects during ref
 advertisement
Date: Fri, 6 Jan 2012 14:17:40 -0500
Message-ID: <20120106191740.GA12903@sigill.intra.peff.net>
References: <7vipkpn87d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, git-dev@github.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 06 20:17:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjFIR-0000Ut-SR
	for gcvg-git-2@lo.gmane.org; Fri, 06 Jan 2012 20:17:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758960Ab2AFTRn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jan 2012 14:17:43 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59566
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753438Ab2AFTRn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2012 14:17:43 -0500
Received: (qmail 8374 invoked by uid 107); 6 Jan 2012 19:24:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 06 Jan 2012 14:24:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Jan 2012 14:17:40 -0500
Content-Disposition: inline
In-Reply-To: <7vipkpn87d.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188041>

When we advertise a ref, the first thing we do is parse the
pointed-to object. This gives us two things:

  1. a "struct object" we can use to store flags

  2. the type of the object, so we know whether we need to
     dereference it as a tag

Instead, we can just use lookup_unknown_object to get an
object struct, and then fill in just the type field using
sha1_object_info (which, in the case of packed files, can
find the information without actually inflating the object
data).

This can save time if you have a large number of refs, and
the client isn't actually going to request those refs (e.g.,
because most of them are already up-to-date).

The downside is that we are no longer verifying objects that
we advertise by fully parsing them (however, we do still
know we actually have them, because sha1_object_info must
find them to get the type). While we might fail to detect a
corrupt object here, if the client actually fetches the
object, we will parse (and verify) it then.

On a repository with 120K refs, the advertisement portion of
upload-pack goes from ~3.4s to 3.2s (the failure to speed up
more is largely due to the fact that most of these refs are
tags, which need dereferenced to find the tag destination
anyway).

Signed-off-by: Jeff King <peff@peff.net>
---
 upload-pack.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 6f36f62..65cb0ff 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -720,11 +720,14 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 	static const char *capabilities = "multi_ack thin-pack side-band"
 		" side-band-64k ofs-delta shallow no-progress"
 		" include-tag multi_ack_detailed";
-	struct object *o = parse_object(sha1);
+	struct object *o = lookup_unknown_object(sha1);
 	const char *refname_nons = strip_namespace(refname);
 
-	if (!o)
-		die("git upload-pack: cannot find object %s:", sha1_to_hex(sha1));
+	if (o->type == OBJ_NONE) {
+		o->type = sha1_object_info(sha1, NULL);
+		if (o->type < 0)
+		    die("git upload-pack: cannot find object %s:", sha1_to_hex(sha1));
+	}
 
 	if (capabilities)
 		packet_write(1, "%s %s%c%s%s\n", sha1_to_hex(sha1), refname_nons,
@@ -738,6 +741,7 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 		nr_our_refs++;
 	}
 	if (o->type == OBJ_TAG) {
+		o = parse_object(o->sha1);
 		o = deref_tag(o, refname, 0);
 		if (o)
 			packet_write(1, "%s %s^{}\n", sha1_to_hex(o->sha1), refname_nons);
-- 
1.7.6.5.14.g7b06f

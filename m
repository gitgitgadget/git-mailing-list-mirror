From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] upload-pack: avoid parsing tag destinations
Date: Fri, 6 Jan 2012 14:18:01 -0500
Message-ID: <20120106191801.GB12903@sigill.intra.peff.net>
References: <7vipkpn87d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, git-dev@github.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 06 20:18:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjFIo-0000kZ-6X
	for gcvg-git-2@lo.gmane.org; Fri, 06 Jan 2012 20:18:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932617Ab2AFTSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jan 2012 14:18:05 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59571
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758874Ab2AFTSE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2012 14:18:04 -0500
Received: (qmail 8415 invoked by uid 107); 6 Jan 2012 19:24:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 06 Jan 2012 14:24:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Jan 2012 14:18:01 -0500
Content-Disposition: inline
In-Reply-To: <7vipkpn87d.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188042>

When upload-pack advertises refs, it dereferences any tags
it sees, and shows the resulting sha1 to the client. It does
this by calling deref_tag. That function must load and parse
each tag object to find the sha1 of the tagged object.
However, it also ends up parsing the tagged object itself,
which is not strictly necessary for upload-pack's use.

Each tag produces two object loads (assuming it is not a
recursive tag), when it could get away with only a single
one. Dropping the second load halves the effort we spend.

The downside is that we are no longer verifying the
resulting object by loading it. In particular:

  1. We never cross-check the "type" field given in the tag
     object with the type of the pointed-to object.  If the
     tag says it points to a tag but doesn't, then we will
     keep peeling and realize the error.  If the tag says it
     points to a non-tag but actually points to a tag, we
     will stop peeling and just advertise the pointed-to
     tag.

  2. If we are missing the pointed-to object, we will not
     realize (because we never even look it up in the object
     db).

However, both of these are errors in the object database,
and both will be detected if a client actually requests the
broken objects in question. So we are simply pushing the
verification away from the advertising stage, and down to
the actual fetching stage.

On my test repo with 120K refs, this drops the time to
advertise the refs from ~3.2s to ~2.0s.

Signed-off-by: Jeff King <peff@peff.net>
---
 tag.c         |   12 ++++++++++++
 tag.h         |    1 +
 upload-pack.c |    3 +--
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/tag.c b/tag.c
index 3aa186d..78d272b 100644
--- a/tag.c
+++ b/tag.c
@@ -24,6 +24,18 @@ struct object *deref_tag(struct object *o, const char *warn, int warnlen)
 	return o;
 }
 
+struct object *deref_tag_noverify(struct object *o)
+{
+	while (o && o->type == OBJ_TAG) {
+		o = parse_object(o->sha1);
+		if (o && o->type == OBJ_TAG && ((struct tag *)o)->tagged)
+			o = ((struct tag *)o)->tagged;
+		else
+			o = NULL;
+	}
+	return o;
+}
+
 struct tag *lookup_tag(const unsigned char *sha1)
 {
 	struct object *obj = lookup_object(sha1);
diff --git a/tag.h b/tag.h
index 5ee88e6..bc8a1e4 100644
--- a/tag.h
+++ b/tag.h
@@ -16,6 +16,7 @@ extern struct tag *lookup_tag(const unsigned char *sha1);
 extern int parse_tag_buffer(struct tag *item, const void *data, unsigned long size);
 extern int parse_tag(struct tag *item);
 extern struct object *deref_tag(struct object *, const char *, int);
+extern struct object *deref_tag_noverify(struct object *);
 extern size_t parse_signature(const char *buf, unsigned long size);
 
 #endif /* TAG_H */
diff --git a/upload-pack.c b/upload-pack.c
index 65cb0ff..c01e161 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -741,8 +741,7 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 		nr_our_refs++;
 	}
 	if (o->type == OBJ_TAG) {
-		o = parse_object(o->sha1);
-		o = deref_tag(o, refname, 0);
+		o = deref_tag_noverify(o);
 		if (o)
 			packet_write(1, "%s %s^{}\n", sha1_to_hex(o->sha1), refname_nons);
 	}
-- 
1.7.6.5.14.g7b06f

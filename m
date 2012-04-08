From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] credential: do not store credentials received from
 helpers
Date: Sun, 8 Apr 2012 03:13:00 -0400
Message-ID: <20120408071300.GB13662@sigill.intra.peff.net>
References: <20120407033417.GA13914@sigill.intra.peff.net>
 <CAJo=hJvqQ0CgCga4va3ZX+XV5DWc1kWS5v4vYWkEzRYT5+p+cg@mail.gmail.com>
 <7v398gywb1.fsf@alter.siamese.dyndns.org>
 <20120407050913.GA4211@sigill.intra.peff.net>
 <7vaa2myfsz.fsf@alter.siamese.dyndns.org>
 <20120408064059.GA6727@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 08 09:13:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGmJj-0002uU-DQ
	for gcvg-git-2@plane.gmane.org; Sun, 08 Apr 2012 09:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752350Ab2DHHNF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Apr 2012 03:13:05 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54307
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751747Ab2DHHNE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2012 03:13:04 -0400
Received: (qmail 475 invoked by uid 107); 8 Apr 2012 07:13:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 08 Apr 2012 03:13:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Apr 2012 03:13:00 -0400
Content-Disposition: inline
In-Reply-To: <20120408064059.GA6727@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194983>

On Sun, Apr 08, 2012 at 02:40:59AM -0400, Jeff King wrote:

> The second issue is that of communicating the ttl or expiration between
> helpers. That's easy enough. The protocol allows arbitrary key/value
> pairs. We typically just drop ones we don't care about, but we could
> retain them and pass them along.

And here's a rough patch for that. This is just to get an idea of the
scale, and which parts of the code need changed. I'd probably use a
key/value store instead of a string_list. On top of this,
credential-cache would have to learn to respect a TTL variable in the
input (actually, it does already respect "timeout" which is added on the
way from the cache client to the cache daemon, but the parsing around
that would have to be cleaned up a bit).

---
 credential.c |   14 +++++++++++---
 credential.h |    3 ++-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/credential.c b/credential.c
index 13409e1..2237e7e 100644
--- a/credential.c
+++ b/credential.c
@@ -9,6 +9,7 @@ void credential_init(struct credential *c)
 {
 	memset(c, 0, sizeof(*c));
 	c->helpers.strdup_strings = 1;
+	c->extra.strdup_strings = 1;
 }
 
 void credential_clear(struct credential *c)
@@ -19,6 +20,7 @@ void credential_clear(struct credential *c)
 	free(c->username);
 	free(c->password);
 	string_list_clear(&c->helpers, 0);
+	string_list_clear(&c->extra, 0);
 
 	credential_init(c);
 }
@@ -174,10 +176,11 @@ int credential_read(struct credential *c, FILE *fp)
 			c->path = xstrdup(value);
 		}
 		/*
-		 * Ignore other lines; we don't know what they mean, but
-		 * this future-proofs us when later versions of git do
-		 * learn new lines, and the helpers are updated to match.
+		 * Save other lines so they can be fed back to the helper or
+		 * transported to other helpers.
 		 */
+		*(value-1) = '=';
+		string_list_append(&c->extra, line.buf);
 	}
 
 	strbuf_release(&line);
@@ -193,11 +196,16 @@ static void credential_write_item(FILE *fp, const char *key, const char *value)
 
 void credential_write(const struct credential *c, FILE *fp)
 {
+	int i;
+
 	credential_write_item(fp, "protocol", c->protocol);
 	credential_write_item(fp, "host", c->host);
 	credential_write_item(fp, "path", c->path);
 	credential_write_item(fp, "username", c->username);
 	credential_write_item(fp, "password", c->password);
+
+	for (i = 0; i < c->extra.nr; i++)
+		fprintf(fp, "%s\n", c->extra.items[i].string);
 }
 
 static int run_credential_helper(struct credential *c,
diff --git a/credential.h b/credential.h
index daf3e81..5f98527 100644
--- a/credential.h
+++ b/credential.h
@@ -5,6 +5,7 @@
 
 struct credential {
 	struct string_list helpers;
+	struct string_list extra;
 	unsigned approved:1,
 		 configured:1,
 		 use_http_path:1;
@@ -16,7 +17,7 @@ struct credential {
 	char *path;
 };
 
-#define CREDENTIAL_INIT { STRING_LIST_INIT_DUP }
+#define CREDENTIAL_INIT { STRING_LIST_INIT_DUP, STRING_LIST_INIT_DUP }
 
 void credential_init(struct credential *);
 void credential_clear(struct credential *);
-- 
1.7.10.11.g901cee

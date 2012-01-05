From: Jeff King <peff@peff.net>
Subject: [PATCH] parse_object: try internal cache before reading object db
Date: Thu, 5 Jan 2012 16:00:01 -0500
Message-ID: <20120105210001.GA30549@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git-dev@github.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 05 22:00:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiuQ1-00045w-74
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 22:00:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932851Ab2AEVAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jan 2012 16:00:05 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58418
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932656Ab2AEVAE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jan 2012 16:00:04 -0500
Received: (qmail 30329 invoked by uid 107); 5 Jan 2012 21:06:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 05 Jan 2012 16:06:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Jan 2012 16:00:01 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187994>

When parse_object is called, we do the following:

  1. read the object data into a buffer via read_sha1_file

  2. call parse_object_buffer, which then:

     a. calls the appropriate lookup_{commit,tree,blob,tag}
	to either create a new "struct object", or to find
	an existing one. We know the appropriate type from
	the lookup in step 1.

     b. calls the appropriate parse_{commit,tree,blob,tag}
        to parse the buffer for the new (or existing) object

In step 2b, all of the called functions are no-ops for
object "X" if "X->object.parsed" is set. I.e., when we have
already parsed an object, we end up going to a lot of work
just to find out at a low level that there is nothing left
for us to do (and we throw away the data from read_sha1_file
unread).

We can optimize this by moving the check for "do we have an
in-memory object" from 2a before the expensive call to
read_sha1_file in step 1.

This might seem circular, since step 2a uses the type
information determined in step 1 to call the appropriate
lookup function. However, we can notice that all of the
lookup_* functions are backed by lookup_object. In other
words, all of the objects are kept in a master hash table,
and we don't actually need the type to do the "do we have
it" part of the lookup, only to do the "and create it if it
doesn't exist" part.

This can save time whenever we call parse_object on the same
sha1 twice in a single program. Some code paths already
perform this optimization manually, with either:

  if (!obj->parsed)
	  obj = parse_object(obj->sha1);

if you already have a "struct object", or:

  struct object *obj = lookup_unknown_object(sha1);
  if (!obj || !obj->parsed)
	  obj = parse_object(sha1);

if you don't.  This patch moves the optimization into
parse_object itself.

Most git operations won't notice any impact. Either they
don't parse a lot of duplicate sha1s, or the calling code
takes special care not to re-parse objects. I timed two
code paths that do benefit (there may be more, but these two
were immediately obvious and easy to time).

The first is fast-export, which calls parse_object on each
object it outputs, like this:

  object = parse_object(sha1);
  if (!object)
	  die(...);
  if (object->flags & SHOWN)
	  return;

which means that just to realize we have already shown an
object, we will read the whole object from disk!

With this patch, my best-of-five time for "fast-export --all" on
git.git dropped from 26.3s to 21.3s.

The second case is upload-pack, which will call parse_object
for each advertised ref (because it needs to peel tags to
show "^{}" entries). This doesn't matter for most
repositories, because they don't have a lot of refs pointing
to the same objects. However, if you have a big alternates
repository with a shared object db for a number of child
repositories, then the alternates repository will have
duplicated refs representing each of its children.

For example, GitHub's alternates repository for git.git has
~120,000 refs, of which only ~3200 are unique. The time for
upload-pack to print its list of advertised refs dropped
from 3.4s to 0.76s.

Signed-off-by: Jeff King <peff@peff.net>
---
 object.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/object.c b/object.c
index d8d09f9..6b06297 100644
--- a/object.c
+++ b/object.c
@@ -191,10 +191,15 @@ struct object *parse_object(const unsigned char *sha1)
 	enum object_type type;
 	int eaten;
 	const unsigned char *repl = lookup_replace_object(sha1);
-	void *buffer = read_sha1_file(sha1, &type, &size);
+	void *buffer;
+	struct object *obj;
+
+	obj = lookup_object(sha1);
+	if (obj && obj->parsed)
+		return obj;
 
+	buffer = read_sha1_file(sha1, &type, &size);
 	if (buffer) {
-		struct object *obj;
 		if (check_sha1_signature(repl, buffer, size, typename(type)) < 0) {
 			free(buffer);
 			error("sha1 mismatch %s\n", sha1_to_hex(repl));
-- 
1.7.6.5.6.ge6248

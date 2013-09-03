From: Jeff King <peff@peff.net>
Subject: [PATCH 2/1] peel_onion: do not assume length of x_type globals
Date: Tue, 3 Sep 2013 16:20:41 -0400
Message-ID: <20130903202041.GA7463@sigill.intra.peff.net>
References: <1378237816-28671-1-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 22:20:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGx5l-0008L9-Dt
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 22:20:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760787Ab3ICUUp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 16:20:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:58096 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760776Ab3ICUUo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 16:20:44 -0400
Received: (qmail 26574 invoked by uid 102); 3 Sep 2013 20:20:45 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Sep 2013 15:20:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Sep 2013 16:20:41 -0400
Content-Disposition: inline
In-Reply-To: <1378237816-28671-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233776>

When we are parsing "rev^{foo}", we check "foo" against the
various global type strings, like "commit_type",
"tree_type", etc. This is nicely abstracted, but then we
destroy the abstraction completely by using magic numbers
that must match the length of the type strings.

We can avoid these magic numbers by using skip_prefix. In an
ideal world, the compiler would compute the magic number
without even calling strlen() at runtime. However, it cannot
do so in this case because we hide the definition of
commit_type and friends behind an extern declaration.

This shouldn't matter, though, as this is not a performance
critical code path. A few short strlens inside get_sha1()
will not even be measurable. And if we care, we can adjust
the declaration of commit_type and friends later on.

Signed-off-by: Jeff King <peff@peff.net>
---
This is the potential cleanup we discussed. Having written that commit
message, I wonder if it is really even worth using commit_type at all.
It is not like that variable can ever change without the git data
structure changing, and even if it did, we would almost certainly want
to revisit how that change affects the user-visible "rev^{}" syntax
anyway.

So maybe simply:

  if (!prefixcmp("commit}"))

would be fine, and it is way more readable. That's what we do already
for "rev^{object}".

 sha1_name.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 6dc496d..23d0d71 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -652,7 +652,7 @@ static int peel_onion(const char *name, int len, unsigned char *sha1)
 static int peel_onion(const char *name, int len, unsigned char *sha1)
 {
 	unsigned char outer[20];
-	const char *sp;
+	const char *sp, *x;
 	unsigned int expected_type = 0;
 	unsigned lookup_flags = 0;
 	struct object *o;
@@ -677,13 +677,13 @@ static int peel_onion(const char *name, int len, unsigned char *sha1)
 		return -1;
 
 	sp++; /* beginning of type name, or closing brace for empty */
-	if (!strncmp(commit_type, sp, 6) && sp[6] == '}')
+	if ((x = skip_prefix(sp, commit_type)) && *x == '}')
 		expected_type = OBJ_COMMIT;
-	else if (!strncmp(tag_type, sp, 3) && sp[3] == '}')
+	else if ((x = skip_prefix(sp, tag_type)) && *x == '}')
 		expected_type = OBJ_TAG;
-	else if (!strncmp(tree_type, sp, 4) && sp[4] == '}')
+	else if ((x = skip_prefix(sp, tree_type)) && *x == '}')
 		expected_type = OBJ_TREE;
-	else if (!strncmp(blob_type, sp, 4) && sp[4] == '}')
+	else if ((x = skip_prefix(sp, blob_type)) && *x == '}')
 		expected_type = OBJ_BLOB;
 	else if (!prefixcmp(sp, "object}"))
 		expected_type = OBJ_ANY;
-- 
1.8.4.2.g87d4a77

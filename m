From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] fast-export: do not load blob objects twice
Date: Sun, 17 Mar 2013 04:38:57 -0400
Message-ID: <20130317083855.GB30183@sigill.intra.peff.net>
References: <20130317083235.GA29907@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 17 09:39:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UH984-0006Hs-9B
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 09:39:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756088Ab3CQIjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Mar 2013 04:39:09 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54201 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756015Ab3CQIjH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Mar 2013 04:39:07 -0400
Received: (qmail 7929 invoked by uid 107); 17 Mar 2013 08:40:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 17 Mar 2013 04:40:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Mar 2013 04:38:57 -0400
Content-Disposition: inline
In-Reply-To: <20130317083235.GA29907@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218352>

When fast-export wants to export a blob object, it first
calls parse_object to get a "struct object" and check
whether we have already shown the object.  If we haven't
shown it, we then use read_sha1_file to pull it from disk
and write it out.

That means we load each blob from disk twice: once for
parse_object to find its type and check its sha1, and a
second time when we actually output it. We can drop this to
a single load by using lookup_object to check the SHOWN
flag, and then checking the signature on and outputting a
single buffer.

This provides modest speedups on git.git (best-of-five, "git
fast-export HEAD >/dev/null"):

  [before]                [after]
  real    0m14.347s       real    0m13.780s
  user    0m14.084s       user    0m13.620s
  sys     0m0.208s        sys     0m0.100s

and somewhat more on more blob-heavy repos (this is a
repository full of media files):

  [before]                [after]
  real    0m52.236s       real    0m44.451s
  user    0m50.568s       user    0m43.000s
  sys     0m1.536s        sys     0m1.284s

Signed-off-by: Jeff King <peff@peff.net>
---
We actually spend a non-trivial amount of time re-checking the sha1 of
objects we are loading. This change also makes it easy to drop that
checking, though perhaps the additional safety is a good thing to have
during an export. The timings without it are:

  git.git (was 14.347s)
  real    0m11.452s
  user    0m11.336s
  sys     0m0.072s

  photos (was 44.451s)
  real    0m18.383s
  user    0m17.108s
  sys     0m1.224s

 builtin/fast-export.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 3eba852..d380155 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -119,6 +119,7 @@ static void export_blob(const unsigned char *sha1)
 	enum object_type type;
 	char *buf;
 	struct object *object;
+	int eaten;
 
 	if (no_data)
 		return;
@@ -126,16 +127,18 @@ static void export_blob(const unsigned char *sha1)
 	if (is_null_sha1(sha1))
 		return;
 
-	object = parse_object(sha1);
-	if (!object)
-		die ("Could not read blob %s", sha1_to_hex(sha1));
-
-	if (object->flags & SHOWN)
+	object = lookup_object(sha1);
+	if (object && object->flags & SHOWN)
 		return;
 
 	buf = read_sha1_file(sha1, &type, &size);
 	if (!buf)
 		die ("Could not read blob %s", sha1_to_hex(sha1));
+	if (check_sha1_signature(sha1, buf, size, typename(type)) < 0)
+		die("sha1 mismatch in blob %s", sha1_to_hex(sha1));
+	object = parse_object_buffer(sha1, type, size, buf, &eaten);
+	if (!object)
+		die("Could not read blob %s", sha1_to_hex(sha1));
 
 	mark_next_object(object);
 
@@ -147,7 +150,8 @@ static void export_blob(const unsigned char *sha1)
 	show_progress();
 
 	object->flags |= SHOWN;
-	free(buf);
+	if (!eaten)
+		free(buf);
 }
 
 static int depth_first(const void *a_, const void *b_)
-- 
1.8.2.rc2.7.gef06216

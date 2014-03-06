From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH 3/4] replace: factor object resolution out of
 replace_object
Date: Thu, 6 Mar 2014 12:49:29 -0500
Message-ID: <20140306174929.GC30691@sigill.intra.peff.net>
References: <20140306174803.GA30486@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Mar 06 18:49:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLcQK-00015I-0D
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 18:49:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753065AbaCFRtb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 12:49:31 -0500
Received: from cloud.peff.net ([50.56.180.127]:34190 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751645AbaCFRtb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 12:49:31 -0500
Received: (qmail 20841 invoked by uid 102); 6 Mar 2014 17:49:31 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 06 Mar 2014 11:49:31 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Mar 2014 12:49:29 -0500
Content-Disposition: inline
In-Reply-To: <20140306174803.GA30486@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243527>

As we add new options that operate on objects before
replacing them, we'll want to be able to feed raw sha1s
straight into replace_object. Split replace_object into the
object-resolution part and the actual replacement.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/replace.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 0b5cb17..a090302 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -123,19 +123,17 @@ static int delete_replace_ref(const char *name, const char *ref,
 	return 0;
 }
 
-static int replace_object(const char *object_ref, const char *replace_ref,
-			  int force)
+static int replace_object_sha1(const char *object_ref,
+			       unsigned char object[20],
+			       const char *replace_ref,
+			       unsigned char repl[20],
+			       int force)
 {
-	unsigned char object[20], prev[20], repl[20];
+	unsigned char prev[20];
 	enum object_type obj_type, repl_type;
 	char ref[PATH_MAX];
 	struct ref_lock *lock;
 
-	if (get_sha1(object_ref, object))
-		die("Failed to resolve '%s' as a valid ref.", object_ref);
-	if (get_sha1(replace_ref, repl))
-		die("Failed to resolve '%s' as a valid ref.", replace_ref);
-
 	if (snprintf(ref, sizeof(ref),
 		     "refs/replace/%s",
 		     sha1_to_hex(object)) > sizeof(ref) - 1)
@@ -166,6 +164,18 @@ static int replace_object(const char *object_ref, const char *replace_ref,
 	return 0;
 }
 
+static int replace_object(const char *object_ref, const char *replace_ref, int force)
+{
+	unsigned char object[20], repl[20];
+
+	if (get_sha1(object_ref, object))
+		die("Failed to resolve '%s' as a valid ref.", object_ref);
+	if (get_sha1(replace_ref, repl))
+		die("Failed to resolve '%s' as a valid ref.", replace_ref);
+
+	return replace_object_sha1(object_ref, object, replace_ref, repl, force);
+}
+
 int cmd_replace(int argc, const char **argv, const char *prefix)
 {
 	int force = 0;
-- 
1.8.5.2.500.g8060133

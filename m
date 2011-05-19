From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] receive-pack: eliminate duplicate .have refs
Date: Thu, 19 May 2011 17:34:46 -0400
Message-ID: <20110519213446.GC29793@sigill.intra.peff.net>
References: <20110519213231.GA29702@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 23:35:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNAsH-00074u-Qm
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 23:35:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934860Ab1ESVfB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 17:35:01 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39452
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934870Ab1ESVes (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 17:34:48 -0400
Received: (qmail 21183 invoked by uid 107); 19 May 2011 21:36:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 May 2011 17:36:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 May 2011 17:34:46 -0400
Content-Disposition: inline
In-Reply-To: <20110519213231.GA29702@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174020>

When receiving a push, we advertise ref tips from any
alternate repositories, in case that helps the client send a
smaller pack. Since these refs don't actually exist in the
destination repository, we don't transmit the real ref
names, but instead use the pseudo-ref ".have".

If your alternate has a large number of duplicate refs (for
example, because it is aggregating objects from many related
repositories, some of which will have the same tags and
branch tips), then we will send each ".have $sha1" line
multiple times. This is a pointless waste of bandwidth, as
we are simply repeating the same fact to the client over and
over.

This patch eliminates duplicate .have refs early on. It does
so efficiently by sorting the complete list and skipping
duplicates. This has the side effect of re-ordering the
.have lines by ascending sha1; this isn't a problem, though,
as the original order was meaningless.

There is a similar .have system in fetch-pack, but it
does not suffer from the same problem. For each alternate
ref we consider in fetch-pack, we actually open the object
and mark it with the SEEN flag, so duplicates are
automatically culled.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/receive-pack.c |   16 +++++++++++++---
 sha1-array.c           |   16 ++++++++++++++++
 sha1-array.h           |    6 ++++++
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 6bb1281..e1a687a 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -10,6 +10,7 @@
 #include "remote.h"
 #include "transport.h"
 #include "string-list.h"
+#include "sha1-array.h"
 
 static const char receive_pack_usage[] = "git receive-pack <git-dir>";
 
@@ -731,14 +732,23 @@ static int delete_only(struct command *commands)
 	return 1;
 }
 
-static void add_one_alternate_ref(const struct ref *ref, void *unused)
+static void add_one_alternate_sha1(const unsigned char sha1[20], void *unused)
 {
-	add_extra_ref(".have", ref->old_sha1, 0);
+	add_extra_ref(".have", sha1, 0);
+}
+
+static void collect_one_alternate_ref(const struct ref *ref, void *data)
+{
+	struct sha1_array *sa = data;
+	sha1_array_append(sa, ref->old_sha1);
 }
 
 static void add_alternate_refs(void)
 {
-	for_each_alternate_ref(add_one_alternate_ref, NULL);
+	struct sha1_array sa = SHA1_ARRAY_INIT;
+	for_each_alternate_ref(collect_one_alternate_ref, &sa);
+	sha1_array_for_each_unique(&sa, add_one_alternate_sha1, NULL);
+	sha1_array_clear(&sa);
 }
 
 int cmd_receive_pack(int argc, const char **argv, const char *prefix)
diff --git a/sha1-array.c b/sha1-array.c
index 5b75a5a..b2f47f9 100644
--- a/sha1-array.c
+++ b/sha1-array.c
@@ -41,3 +41,19 @@ void sha1_array_clear(struct sha1_array *array)
 	array->alloc = 0;
 	array->sorted = 0;
 }
+
+void sha1_array_for_each_unique(struct sha1_array *array,
+				for_each_sha1_fn fn,
+				void *data)
+{
+	int i;
+
+	if (!array->sorted)
+		sha1_array_sort(array);
+
+	for (i = 0; i < array->nr; i++) {
+		if (i > 0 && !hashcmp(array->sha1[i], array->sha1[i-1]))
+			continue;
+		fn(array->sha1[i], data);
+	}
+}
diff --git a/sha1-array.h b/sha1-array.h
index 15d3b6b..4499b5d 100644
--- a/sha1-array.h
+++ b/sha1-array.h
@@ -15,4 +15,10 @@ void sha1_array_sort(struct sha1_array *array);
 int sha1_array_lookup(struct sha1_array *array, const unsigned char *sha1);
 void sha1_array_clear(struct sha1_array *array);
 
+typedef void (*for_each_sha1_fn)(const unsigned char sha1[20],
+				 void *data);
+void sha1_array_for_each_unique(struct sha1_array *array,
+				for_each_sha1_fn fn,
+				void *data);
+
 #endif /* SHA1_ARRAY_H */
-- 
1.7.5.8.ga95ab

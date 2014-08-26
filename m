From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] log-tree: make add_name_decoration a public function
Date: Tue, 26 Aug 2014 06:23:36 -0400
Message-ID: <20140826102335.GA25687@peff.net>
References: <20140826102051.GA4885@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Arjun Sreedharan <arjun024@gmail.com>,
	git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 12:23:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMDug-0007Ck-Uv
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 12:23:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934466AbaHZKXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 06:23:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:59049 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932729AbaHZKXh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 06:23:37 -0400
Received: (qmail 9536 invoked by uid 102); 26 Aug 2014 10:23:38 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Aug 2014 05:23:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Aug 2014 06:23:36 -0400
Content-Disposition: inline
In-Reply-To: <20140826102051.GA4885@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255884>

The log-tree code keeps a "struct decoration" hash to show
text decorations for each commit during log traversals. It
makes this available to other files by providing global
access to the hash. This can result in other code adding
entries that do not conform to what log-tree expects.

For example, the bisect code adds its own "dist"
decorations to be shown. Originally the bisect code was
correct, but when the name_decoration code grew a new field
in eb3005e (commit.h: add 'type' to struct name_decoration,
2010-06-19), the bisect code was not updated. As a result,
the log-tree code can access uninitialized memory and even
segfault.

We can fix this by making name_decoration's adding function
public. If all callers use it, then any changes to structi
initialization only need to happen in one place (and because
the members come in as parameters, the compiler can notice a
caller who does not supply enough information).

As a bonus, this also means that the decoration hashes
created by the bisect code will use less memory (previously
we over-allocated space for the distance integer, but not we
format it into a temporary buffer and copy it to the final
flex-array).

Signed-off-by: Jeff King <peff@peff.net>
---
 bisect.c   |  7 ++++---
 commit.h   | 12 ++++++++++++
 log-tree.c | 12 +-----------
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/bisect.c b/bisect.c
index d6e851d..df09cbc 100644
--- a/bisect.c
+++ b/bisect.c
@@ -215,11 +215,12 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
 	}
 	qsort(array, cnt, sizeof(*array), compare_commit_dist);
 	for (p = list, i = 0; i < cnt; i++) {
-		struct name_decoration *r = xmalloc(sizeof(*r) + 100);
+		char buf[100]; /* enough for dist=%d */
 		struct object *obj = &(array[i].commit->object);
 
-		sprintf(r->name, "dist=%d", array[i].distance);
-		r->next = add_decoration(&name_decoration, obj, r);
+		snprintf(buf, sizeof(buf), "dist=%d", array[i].distance);
+		add_name_decoration(DECORATION_NONE, buf, obj);
+
 		p->item = array[i].commit;
 		p = p->next;
 	}
diff --git a/commit.h b/commit.h
index a8cbf52..4902f97 100644
--- a/commit.h
+++ b/commit.h
@@ -33,6 +33,18 @@ struct name_decoration {
 	char name[1];
 };
 
+enum decoration_type {
+	DECORATION_NONE = 0,
+	DECORATION_REF_LOCAL,
+	DECORATION_REF_REMOTE,
+	DECORATION_REF_TAG,
+	DECORATION_REF_STASH,
+	DECORATION_REF_HEAD,
+	DECORATION_GRAFTED,
+};
+
+void add_name_decoration(enum decoration_type type, const char *name, struct object *obj);
+
 struct commit *lookup_commit(const unsigned char *sha1);
 struct commit *lookup_commit_reference(const unsigned char *sha1);
 struct commit *lookup_commit_reference_gently(const unsigned char *sha1,
diff --git a/log-tree.c b/log-tree.c
index 0c53dc1..a821258 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -14,16 +14,6 @@
 
 struct decoration name_decoration = { "object names" };
 
-enum decoration_type {
-	DECORATION_NONE = 0,
-	DECORATION_REF_LOCAL,
-	DECORATION_REF_REMOTE,
-	DECORATION_REF_TAG,
-	DECORATION_REF_STASH,
-	DECORATION_REF_HEAD,
-	DECORATION_GRAFTED,
-};
-
 static char decoration_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RESET,
 	GIT_COLOR_BOLD_GREEN,	/* REF_LOCAL */
@@ -84,7 +74,7 @@ int parse_decorate_color_config(const char *var, const int ofs, const char *valu
 #define decorate_get_color_opt(o, ix) \
 	decorate_get_color((o)->use_color, ix)
 
-static void add_name_decoration(enum decoration_type type, const char *name, struct object *obj)
+void add_name_decoration(enum decoration_type type, const char *name, struct object *obj)
 {
 	int nlen = strlen(name);
 	struct name_decoration *res = xmalloc(sizeof(struct name_decoration) + nlen);
-- 
2.1.0.346.ga0367b9

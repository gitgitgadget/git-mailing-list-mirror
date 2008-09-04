From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/3] move load_ref_decorations() to log-tree.c and export
 it
Date: Thu, 04 Sep 2008 23:39:21 +0200
Message-ID: <48C05589.5050805@lsrfire.ath.cx>
References: <alpine.LNX.1.10.0809032036270.32295@pollux> <20080903191217.GA31195@coredump.intra.peff.net> <7v4p4xat3v.fsf@gitster.siamese.dyndns.org> <20080903203616.GB32223@coredump.intra.peff.net> <7vsksh9c9m.fsf@gitster.siamese.dyndns.org> <48BF0A5A.2040502@lsrfire.ath.cx> <20080904035139.GA28123@sigill.intra.peff.net> <48C002FB.9010401@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Michael Dressel <MichaelTiloDressel@t-online.de>
X-From: git-owner@vger.kernel.org Thu Sep 04 23:40:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbMZ8-0000qF-Ht
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 23:40:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754236AbYIDVjY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 17:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753981AbYIDVjY
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 17:39:24 -0400
Received: from india601.server4you.de ([85.25.151.105]:47259 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753829AbYIDVjX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 17:39:23 -0400
Received: from [10.0.1.200] (p57B7E7FB.dip.t-dialin.net [87.183.231.251])
	by india601.server4you.de (Postfix) with ESMTPSA id 1BD052F8045;
	Thu,  4 Sep 2008 23:39:22 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <48C002FB.9010401@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94961>

log-tree.c is the ideal place for load_ref_decorations() and its
helper functions to live in, because the variable name_decoration
they're operating on is already located there, so move them thither.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin-log.c |   35 -----------------------------------
 log-tree.c    |   36 ++++++++++++++++++++++++++++++++++++
 log-tree.h    |    1 +
 3 files changed, 37 insertions(+), 35 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 0f16462..081e660 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -14,7 +14,6 @@
 #include "tag.h"
 #include "reflog-walk.h"
 #include "patch-ids.h"
-#include "refs.h"
 #include "run-command.h"
 #include "shortlog.h"
 
@@ -25,40 +24,6 @@ static int default_show_root = 1;
 static const char *fmt_patch_subject_prefix = "PATCH";
 static const char *fmt_pretty;
 
-static void add_name_decoration(const char *prefix, const char *name, struct object *obj)
-{
-	int plen = strlen(prefix);
-	int nlen = strlen(name);
-	struct name_decoration *res = xmalloc(sizeof(struct name_decoration) + plen + nlen);
-	memcpy(res->name, prefix, plen);
-	memcpy(res->name + plen, name, nlen + 1);
-	res->next = add_decoration(&name_decoration, obj, res);
-}
-
-static int add_ref_decoration(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
-{
-	struct object *obj = parse_object(sha1);
-	if (!obj)
-		return 0;
-	add_name_decoration("", refname, obj);
-	while (obj->type == OBJ_TAG) {
-		obj = ((struct tag *)obj)->tagged;
-		if (!obj)
-			break;
-		add_name_decoration("tag: ", refname, obj);
-	}
-	return 0;
-}
-
-void load_ref_decorations(void)
-{
-	static int loaded;
-	if (!loaded) {
-		loaded = 1;
-		for_each_ref(add_ref_decoration, NULL);
-	}
-}
-
 static void cmd_log_init(int argc, const char **argv, const char *prefix,
 		      struct rev_info *rev)
 {
diff --git a/log-tree.c b/log-tree.c
index 30cd5bb..2c1f3e6 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -1,12 +1,48 @@
 #include "cache.h"
 #include "diff.h"
 #include "commit.h"
+#include "tag.h"
 #include "graph.h"
 #include "log-tree.h"
 #include "reflog-walk.h"
+#include "refs.h"
 
 struct decoration name_decoration = { "object names" };
 
+static void add_name_decoration(const char *prefix, const char *name, struct object *obj)
+{
+	int plen = strlen(prefix);
+	int nlen = strlen(name);
+	struct name_decoration *res = xmalloc(sizeof(struct name_decoration) + plen + nlen);
+	memcpy(res->name, prefix, plen);
+	memcpy(res->name + plen, name, nlen + 1);
+	res->next = add_decoration(&name_decoration, obj, res);
+}
+
+static int add_ref_decoration(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
+{
+	struct object *obj = parse_object(sha1);
+	if (!obj)
+		return 0;
+	add_name_decoration("", refname, obj);
+	while (obj->type == OBJ_TAG) {
+		obj = ((struct tag *)obj)->tagged;
+		if (!obj)
+			break;
+		add_name_decoration("tag: ", refname, obj);
+	}
+	return 0;
+}
+
+void load_ref_decorations(void)
+{
+	static int loaded;
+	if (!loaded) {
+		loaded = 1;
+		for_each_ref(add_ref_decoration, NULL);
+	}
+}
+
 static void show_parents(struct commit *commit, int abbrev)
 {
 	struct commit_list *p;
diff --git a/log-tree.h b/log-tree.h
index 59ba4c4..3c8127b 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -17,5 +17,6 @@ void log_write_email_headers(struct rev_info *opt, const char *name,
 			     const char **subject_p,
 			     const char **extra_headers_p,
 			     int *need_8bit_cte_p);
+void load_ref_decorations(void);
 
 #endif
-- 
1.6.0.1.161.g7f314

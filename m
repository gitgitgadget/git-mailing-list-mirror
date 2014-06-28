From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 5/7] replace: refactor replacing parents
Date: Sat, 28 Jun 2014 20:11:14 +0200
Message-ID: <20140628181117.5687.43446.chriscool@tuxfamily.org>
References: <20140628171731.5687.30308.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 20:20:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0xEV-0007lL-Fq
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jun 2014 20:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756786AbaF1STt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2014 14:19:49 -0400
Received: from mail-1y.bbox.fr ([194.158.98.14]:52630 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756414AbaF1STs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2014 14:19:48 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id EF97E11E;
	Sat, 28 Jun 2014 20:19:46 +0200 (CEST)
X-git-sha1: e8c22bc97abf73bc673cbb03d2845c3131a6d1d7 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140628171731.5687.30308.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252613>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replace.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 3515979..ad47237 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -295,27 +295,14 @@ static int edit_and_replace(const char *object_ref, int force)
 	return replace_object_sha1(object_ref, old, "replacement", new, force);
 }
 
-static int create_graft(int argc, const char **argv, int force)
+static void replace_parents(struct strbuf *buf, int argc, const char **argv)
 {
-	unsigned char old[20], new[20];
-	const char *old_ref = argv[0];
-	struct commit *commit;
-	struct strbuf buf = STRBUF_INIT;
 	struct strbuf new_parents = STRBUF_INIT;
 	const char *parent_start, *parent_end;
-	const char *buffer;
-	unsigned long size;
 	int i;
 
-	if (get_sha1(old_ref, old) < 0)
-		die(_("Not a valid object name: '%s'"), old_ref);
-	commit = lookup_commit_or_die(old, old_ref);
-
 	/* find existing parents */
-	buffer = get_commit_buffer(commit, &size);
-	strbuf_add(&buf, buffer, size);
-	unuse_commit_buffer(commit, buffer);
-	parent_start = buf.buf;
+	parent_start = buf->buf;
 	parent_start += 46; /* "tree " + "hex sha1" + "\n" */
 	parent_end = parent_start;
 
@@ -332,13 +319,34 @@ static int create_graft(int argc, const char **argv, int force)
 	}
 
 	/* replace existing parents with new ones */
-	strbuf_splice(&buf, parent_start - buf.buf, parent_end - parent_start,
+	strbuf_splice(buf, parent_start - buf->buf, parent_end - parent_start,
 		      new_parents.buf, new_parents.len);
 
+	strbuf_release(&new_parents);
+}
+
+static int create_graft(int argc, const char **argv, int force)
+{
+	unsigned char old[20], new[20];
+	const char *old_ref = argv[0];
+	struct commit *commit;
+	struct strbuf buf = STRBUF_INIT;
+	const char *buffer;
+	unsigned long size;
+
+	if (get_sha1(old_ref, old) < 0)
+		die(_("Not a valid object name: '%s'"), old_ref);
+	commit = lookup_commit_or_die(old, old_ref);
+
+	buffer = get_commit_buffer(commit, &size);
+	strbuf_add(&buf, buffer, size);
+	unuse_commit_buffer(commit, buffer);
+
+	replace_parents(&buf, argc, argv);
+
 	if (write_sha1_file(buf.buf, buf.len, commit_type, new))
 		die(_("could not write replacement commit for: '%s'"), old_ref);
 
-	strbuf_release(&new_parents);
 	strbuf_release(&buf);
 
 	if (!hashcmp(old, new))
-- 
2.0.0.421.g786a89d.dirty

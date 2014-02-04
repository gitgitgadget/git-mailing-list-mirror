From: Thomas Rast <tr@thomasrast.ch>
Subject: [POC PATCH 4/9] pretty: refactor add_merge_info() into parts
Date: Tue,  4 Feb 2014 23:17:33 +0100
Message-ID: <935d776f5799f1dd9ecc0010059a379dec224172.1391549294.git.tr@thomasrast.ch>
References: <cover.1391549294.git.tr@thomasrast.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 04 23:18:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAoK1-0001w8-29
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 23:18:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935759AbaBDWSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 17:18:11 -0500
Received: from ip1.thgersdorf.net ([148.251.9.194]:54785 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935748AbaBDWR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 17:17:58 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 2ED0D4D65EE
	for <git@vger.kernel.org>; Tue,  4 Feb 2014 23:17:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 5FGo2B9eIaob for <git@vger.kernel.org>;
	Tue,  4 Feb 2014 23:17:41 +0100 (CET)
Received: from linux.local (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id A9FFD4D65D0
	for <git@vger.kernel.org>; Tue,  4 Feb 2014 23:17:41 +0100 (CET)
X-Mailer: git-send-email 1.9.rc2.232.gdd31389
In-Reply-To: <cover.1391549294.git.tr@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241569>

pp_commit_list() will be reused later.

Signed-off-by: Thomas Rast <tr@thomasrast.ch>
---

Necessary only for the next patch, which may be of dubious value.

 commit.h |  1 +
 pretty.c | 40 ++++++++++++++++++++++++++--------------
 2 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/commit.h b/commit.h
index 16d9c43..b51817b 100644
--- a/commit.h
+++ b/commit.h
@@ -101,6 +101,7 @@ struct pretty_print_context {
 	struct string_list *mailmap;
 	int color;
 	struct ident_split *from_ident;
+	struct commit_list *merge_bases;
 
 	/*
 	 * Fields below here are manipulated internally by pp_* functions and
diff --git a/pretty.c b/pretty.c
index 87db08b..5e44cf8 100644
--- a/pretty.c
+++ b/pretty.c
@@ -517,6 +517,31 @@ static const char *skip_empty_lines(const char *msg)
 	return msg;
 }
 
+static const char *pp_sha1_to_hex(const struct pretty_print_context *pp,
+				  const unsigned char *sha1)
+{
+	const char *hex = NULL;
+	if (pp->abbrev)
+		hex = find_unique_abbrev(sha1, pp->abbrev);
+	if (!hex)
+		hex = sha1_to_hex(sha1);
+	return hex;
+}
+
+static void pp_commit_list(const struct pretty_print_context *pp,
+			   struct strbuf *sb,
+			   const char *prefix,
+			   const struct commit_list *list)
+{
+	strbuf_addstr(sb, prefix);
+	while (list) {
+		struct commit *commit = list->item;
+		strbuf_addf(sb, " %s", pp_sha1_to_hex(pp, commit->object.sha1));
+		list = list->next;
+	}
+	strbuf_addch(sb, '\n');
+}
+
 static void add_merge_info(const struct pretty_print_context *pp,
 			   struct strbuf *sb, const struct commit *commit)
 {
@@ -526,20 +551,7 @@ static void add_merge_info(const struct pretty_print_context *pp,
 	    !parent || !parent->next)
 		return;
 
-	strbuf_addstr(sb, "Merge:");
-
-	while (parent) {
-		struct commit *p = parent->item;
-		const char *hex = NULL;
-		if (pp->abbrev)
-			hex = find_unique_abbrev(p->object.sha1, pp->abbrev);
-		if (!hex)
-			hex = sha1_to_hex(p->object.sha1);
-		parent = parent->next;
-
-		strbuf_addf(sb, " %s", hex);
-	}
-	strbuf_addch(sb, '\n');
+	pp_commit_list(pp, sb, "Merge:", parent);
 }
 
 static char *get_header(const struct commit *commit, const char *msg,
-- 
1.9.rc2.232.gdd31389

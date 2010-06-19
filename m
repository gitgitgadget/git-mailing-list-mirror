From: Nazri Ramliy <ayiehere@gmail.com>
Subject: [PATCH 3/4] log --decorate: Colorize commit decorations
Date: Sat, 19 Jun 2010 09:37:35 +0800
Message-ID: <1276911456-18466-3-git-send-email-ayiehere@gmail.com>
References: <7vtyp11k9x.fsf@alter.siamese.dyndns.org>
Cc: Nazri Ramliy <ayiehere@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 19 03:38:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPn14-00062G-NK
	for gcvg-git-2@lo.gmane.org; Sat, 19 Jun 2010 03:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754571Ab0FSBiB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jun 2010 21:38:01 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:65036 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754540Ab0FSBiA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jun 2010 21:38:00 -0400
Received: by pxi12 with SMTP id 12so653549pxi.19
        for <git@vger.kernel.org>; Fri, 18 Jun 2010 18:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=eeMaklGK9SxdSESnDPZORta5v0WOr2G1BuqQBZJJp9c=;
        b=b3tYeG5JTwirG7R+G5bhJSbp1QU4uQLNMbGvr7jWXHOTxciS6+IIzzDMWisdxFtDlT
         TB8WA8X6JZzDCAY3VQV1RyohsaG7xUM4N0IQ60rgoR3emF5rqcivTLan3VhLn97uvTvT
         b3o2S3Ji6pO4DmXPhoeh2nDGIS0ModglB2jpI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=jfO+V54s1ld6EjQ+KujteAAQdRsYG4irUt1TgCgsjjLzvhI1Z18WN86OYSX1g4f6mk
         2nSefSlkrHJS0XK1wFs1GzstVR+VR37lp6B9jPjhiq2IfCOplWFKiEhBsX5qbjfrabbY
         06nPQOlAFrHpgtPtW4y7n4OhOiGN7F5y8Qlik=
Received: by 10.141.214.40 with SMTP id r40mr1527709rvq.11.1276911478840;
        Fri, 18 Jun 2010 18:37:58 -0700 (PDT)
Received: from localhost.localdomain ([115.132.104.117])
        by mx.google.com with ESMTPS id s9sm3587164rvl.5.2010.06.18.18.37.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Jun 2010 18:37:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.245.g7c42e.dirty
In-Reply-To: <7vtyp11k9x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149371>

This makes the decorations stand out more and easier to distinguish
and spot because they are colored differently depending on their type.

Signed-off-by: Nazri Ramliy <ayiehere@gmail.com>
---
 log-tree.c |   34 +++++++++++++++++++++++++++++++++-
 1 files changed, 33 insertions(+), 1 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 2d804ee..25586cf 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -7,6 +7,7 @@
 #include "reflog-walk.h"
 #include "refs.h"
 #include "string-list.h"
+#include "color.h"
 
 struct decoration name_decoration = { "object names" };
 
@@ -19,6 +20,29 @@ enum decoration_type {
 	DECORATION_REF_HEAD,
 };
 
+static char decoration_colors[][COLOR_MAXLEN] = {
+	GIT_COLOR_RESET,
+	GIT_COLOR_BOLD_GREEN,	/* REF_LOCAL */
+	GIT_COLOR_BOLD_RED,	/* REF_REMOTE */
+	GIT_COLOR_BOLD_YELLOW,	/* REF_TAG */
+	GIT_COLOR_BOLD_MAGENTA,	/* REF_STASH */
+	GIT_COLOR_BOLD_CYAN,	/* REF_HEAD */
+};
+
+static const char *decorate_get_color(int decorate_use_color, enum decoration_type ix)
+{
+	if (decorate_use_color)
+		return decoration_colors[ix];
+	return "";
+}
+
+/*
+ * log-tree.c uses DIFF_OPT_TST for determining whether to use color
+ * for showing the commit sha1, use the same check for --decorate
+ */
+#define decorate_get_color_opt(o, ix) \
+	decorate_get_color(DIFF_OPT_TST((o), COLOR_DIFF), ix)
+
 static void add_name_decoration(enum decoration_type type, const char *name, struct object *obj)
 {
 	int nlen = strlen(name);
@@ -81,6 +105,10 @@ void show_decorations(struct rev_info *opt, struct commit *commit)
 {
 	const char *prefix;
 	struct name_decoration *decoration;
+	const char *color_commit =
+		diff_get_color_opt(&opt->diffopt, DIFF_COMMIT);
+	const char *color_reset =
+		decorate_get_color_opt(&opt->diffopt, DECORATION_NONE);
 
 	if (opt->show_source && commit->util)
 		printf("\t%s", (char *) commit->util);
@@ -92,9 +120,13 @@ void show_decorations(struct rev_info *opt, struct commit *commit)
 	prefix = " (";
 	while (decoration) {
 		printf("%s", prefix);
+		fputs(decorate_get_color_opt(&opt->diffopt, decoration->type),
+		      stdout);
 		if (decoration->type == DECORATION_REF_TAG)
-			printf("tag: ");
+			fputs("tag: ", stdout);
 		printf("%s", decoration->name);
+		fputs(color_reset, stdout);
+		fputs(color_commit, stdout);
 		prefix = ", ";
 		decoration = decoration->next;
 	}
-- 
1.7.1.245.g7c42e.dirty

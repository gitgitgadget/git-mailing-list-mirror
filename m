From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/2] builtin-commit: refactor short-status code into wt-status.c
Date: Sat,  5 Dec 2009 16:04:37 +0100
Message-ID: <c42e3f38816a08aba4610cb808f09067a07ad097.1260025135.git.git@drmicha.warpmail.net>
References: <cover.1260025135.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 05 16:05:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGwC1-00064w-8N
	for gcvg-git-2@lo.gmane.org; Sat, 05 Dec 2009 16:05:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755950AbZLEPEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2009 10:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755942AbZLEPEo
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Dec 2009 10:04:44 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:56827 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755749AbZLEPEk (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Dec 2009 10:04:40 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3EADFC538E;
	Sat,  5 Dec 2009 10:04:47 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Sat, 05 Dec 2009 10:04:47 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=S3FIQ/H70x2p2HCMXHaHNh468ys=; b=hsnt43wEsIA/hxpZQ4mfFA7/o5n8q3acnI0Lj9eVMxIzx1oOhoHeOWgkZJid2O9bzXYlZ0RCx0481LtDyVr6RouvQ/e1mZm8OYDwib1kamAFLXU3Ng4aBL7Oftm//S8cWpMf5HFrxlwgBrwasi/AOoKsaVcJPytX4WOEFiP+2WE=
X-Sasl-enc: kO2wT0VpEZde8UUXwZCZo9foKgTVP5WO66uMiIZqBQMD 1260025485
Received: from localhost (p5DCC0D75.dip0.t-ipconnect.de [93.204.13.117])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E343A42BF;
	Sat,  5 Dec 2009 10:04:45 -0500 (EST)
X-Mailer: git-send-email 1.6.6.rc1.282.ge6667
In-Reply-To: <cover.1260025135.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134605>

Currently, builtin-commit.c contains most code producing the
short-status output, whereas wt-status.c contains most of the code for
the long format.

Refactor so that most of the long and short format producing code
resides in wt-status.c and is named analogously.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin-commit.c |  101 ++---------------------------------------------------
 wt-status.c      |   89 +++++++++++++++++++++++++++++++++++++++++++++++
 wt-status.h      |    2 +
 3 files changed, 95 insertions(+), 97 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index c103beb..548bbf5 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -79,8 +79,6 @@ static enum {
 	STATUS_FORMAT_PORCELAIN,
 } status_format = STATUS_FORMAT_LONG;
 
-static void short_print(struct wt_status *s, int null_termination);
-
 static int opt_parse_m(const struct option *opt, const char *arg, int unset)
 {
 	struct strbuf *buf = opt->value;
@@ -387,10 +385,10 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix, int
 
 	switch (status_format) {
 	case STATUS_FORMAT_SHORT:
-		short_print(s, null_termination);
+		wt_shortstatus_print(s, null_termination);
 		break;
 	case STATUS_FORMAT_PORCELAIN:
-		short_print(s, null_termination);
+		wt_shortstatus_print(s, null_termination);
 		break;
 	case STATUS_FORMAT_LONG:
 		wt_status_print(s);
@@ -982,97 +980,6 @@ static int git_status_config(const char *k, const char *v, void *cb)
 	return git_diff_ui_config(k, v, NULL);
 }
 
-#define quote_path quote_path_relative
-
-static void short_unmerged(int null_termination, struct string_list_item *it,
-			   struct wt_status *s)
-{
-	struct wt_status_change_data *d = it->util;
-	const char *how = "??";
-
-	switch (d->stagemask) {
-	case 1: how = "DD"; break; /* both deleted */
-	case 2: how = "AU"; break; /* added by us */
-	case 3: how = "UD"; break; /* deleted by them */
-	case 4: how = "UA"; break; /* added by them */
-	case 5: how = "DU"; break; /* deleted by us */
-	case 6: how = "AA"; break; /* both added */
-	case 7: how = "UU"; break; /* both modified */
-	}
-	printf("%s ", how);
-	if (null_termination) {
-		fprintf(stdout, "%s%c", it->string, 0);
-	} else {
-		struct strbuf onebuf = STRBUF_INIT;
-		const char *one;
-		one = quote_path(it->string, -1, &onebuf, s->prefix);
-		printf("%s\n", one);
-		strbuf_release(&onebuf);
-	}
-}
-
-static void short_status(int null_termination, struct string_list_item *it,
-			 struct wt_status *s)
-{
-	struct wt_status_change_data *d = it->util;
-
-	printf("%c%c ",
-	       !d->index_status ? ' ' : d->index_status,
-	       !d->worktree_status ? ' ' : d->worktree_status);
-	if (null_termination) {
-		fprintf(stdout, "%s%c", it->string, 0);
-		if (d->head_path)
-			fprintf(stdout, "%s%c", d->head_path, 0);
-	} else {
-		struct strbuf onebuf = STRBUF_INIT;
-		const char *one;
-		if (d->head_path) {
-			one = quote_path(d->head_path, -1, &onebuf, s->prefix);
-			printf("%s -> ", one);
-			strbuf_release(&onebuf);
-		}
-		one = quote_path(it->string, -1, &onebuf, s->prefix);
-		printf("%s\n", one);
-		strbuf_release(&onebuf);
-	}
-}
-
-static void short_untracked(int null_termination, struct string_list_item *it,
-			    struct wt_status *s)
-{
-	if (null_termination) {
-		fprintf(stdout, "?? %s%c", it->string, 0);
-	} else {
-		struct strbuf onebuf = STRBUF_INIT;
-		const char *one;
-		one = quote_path(it->string, -1, &onebuf, s->prefix);
-		printf("?? %s\n", one);
-		strbuf_release(&onebuf);
-	}
-}
-
-static void short_print(struct wt_status *s, int null_termination)
-{
-	int i;
-	for (i = 0; i < s->change.nr; i++) {
-		struct wt_status_change_data *d;
-		struct string_list_item *it;
-
-		it = &(s->change.items[i]);
-		d = it->util;
-		if (d->stagemask)
-			short_unmerged(null_termination, it, s);
-		else
-			short_status(null_termination, it, s);
-	}
-	for (i = 0; i < s->untracked.nr; i++) {
-		struct string_list_item *it;
-
-		it = &(s->untracked.items[i]);
-		short_untracked(null_termination, it, s);
-	}
-}
-
 int cmd_status(int argc, const char **argv, const char *prefix)
 {
 	struct wt_status s;
@@ -1115,10 +1022,10 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	case STATUS_FORMAT_SHORT:
 		if (s.relative_paths)
 			s.prefix = prefix;
-		short_print(&s, null_termination);
+		wt_shortstatus_print(&s, null_termination);
 		break;
 	case STATUS_FORMAT_PORCELAIN:
-		short_print(&s, null_termination);
+		wt_shortstatus_print(&s, null_termination);
 		break;
 	case STATUS_FORMAT_LONG:
 		s.verbose = verbose;
diff --git a/wt-status.c b/wt-status.c
index 3c2f580..93af994 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -600,3 +600,92 @@ void wt_status_print(struct wt_status *s)
 			printf("nothing to commit (working directory clean)\n");
 	}
 }
+
+static void wt_shortstatus_unmerged(int null_termination, struct string_list_item *it,
+			   struct wt_status *s)
+{
+	struct wt_status_change_data *d = it->util;
+	const char *how = "??";
+
+	switch (d->stagemask) {
+	case 1: how = "DD"; break; /* both deleted */
+	case 2: how = "AU"; break; /* added by us */
+	case 3: how = "UD"; break; /* deleted by them */
+	case 4: how = "UA"; break; /* added by them */
+	case 5: how = "DU"; break; /* deleted by us */
+	case 6: how = "AA"; break; /* both added */
+	case 7: how = "UU"; break; /* both modified */
+	}
+	printf("%s ", how);
+	if (null_termination) {
+		fprintf(stdout, "%s%c", it->string, 0);
+	} else {
+		struct strbuf onebuf = STRBUF_INIT;
+		const char *one;
+		one = quote_path(it->string, -1, &onebuf, s->prefix);
+		printf("%s\n", one);
+		strbuf_release(&onebuf);
+	}
+}
+
+static void wt_shortstatus_status(int null_termination, struct string_list_item *it,
+			 struct wt_status *s)
+{
+	struct wt_status_change_data *d = it->util;
+
+	printf("%c%c ",
+		!d->index_status ? ' ' : d->index_status,
+		!d->worktree_status ? ' ' : d->worktree_status);
+	if (null_termination) {
+		fprintf(stdout, "%s%c", it->string, 0);
+		if (d->head_path)
+			fprintf(stdout, "%s%c", d->head_path, 0);
+	} else {
+		struct strbuf onebuf = STRBUF_INIT;
+		const char *one;
+		if (d->head_path) {
+			one = quote_path(d->head_path, -1, &onebuf, s->prefix);
+			printf("%s -> ", one);
+			strbuf_release(&onebuf);
+		}
+		one = quote_path(it->string, -1, &onebuf, s->prefix);
+		printf("%s\n", one);
+		strbuf_release(&onebuf);
+	}
+}
+
+static void wt_shortstatus_untracked(int null_termination, struct string_list_item *it,
+			    struct wt_status *s)
+{
+	if (null_termination) {
+		fprintf(stdout, "?? %s%c", it->string, 0);
+	} else {
+		struct strbuf onebuf = STRBUF_INIT;
+		const char *one;
+		one = quote_path(it->string, -1, &onebuf, s->prefix);
+		printf("?? %s\n", one);
+		strbuf_release(&onebuf);
+	}
+}
+
+void wt_shortstatus_print(struct wt_status *s, int null_termination)
+{
+	int i;
+	for (i = 0; i < s->change.nr; i++) {
+		struct wt_status_change_data *d;
+		struct string_list_item *it;
+
+		it = &(s->change.items[i]);
+		d = it->util;
+		if (d->stagemask)
+			wt_shortstatus_unmerged(null_termination, it, s);
+		else
+			wt_shortstatus_status(null_termination, it, s);
+	}
+	for (i = 0; i < s->untracked.nr; i++) {
+		struct string_list_item *it;
+
+		it = &(s->untracked.items[i]);
+		wt_shortstatus_untracked(null_termination, it, s);
+	}
+}
diff --git a/wt-status.h b/wt-status.h
index 09fd9f1..39c9aef 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -56,4 +56,6 @@ void wt_status_prepare(struct wt_status *s);
 void wt_status_print(struct wt_status *s);
 void wt_status_collect(struct wt_status *s);
 
+void wt_shortstatus_print(struct wt_status *s, int null_termination);
+
 #endif /* STATUS_H */
-- 
1.6.6.rc1.282.ge6667

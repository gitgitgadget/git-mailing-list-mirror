From: Harry Jeffery <harry@exec64.co.uk>
Subject: [PATCH v4] pretty: add %D format specifier
Date: Thu, 18 Sep 2014 21:53:53 +0100
Message-ID: <1411073633-31271-1-git-send-email-harry@exec64.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 18 22:54:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUiiQ-0005Y0-DA
	for gcvg-git-2@plane.gmane.org; Thu, 18 Sep 2014 22:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757049AbaIRUyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2014 16:54:05 -0400
Received: from mail-wg0-f51.google.com ([74.125.82.51]:37169 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756203AbaIRUyE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2014 16:54:04 -0400
Received: by mail-wg0-f51.google.com with SMTP id k14so1500820wgh.22
        for <git@vger.kernel.org>; Thu, 18 Sep 2014 13:54:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=nmcHWj0QWmwEGlsRwl9/cH51BhyipjJ8gJy+vYEieXk=;
        b=XPj6ZcXtYXWKt2JNIUiY85jpd3PAPIAjA6Pu949wvJWwWW7KbXNvC800EMyAss+9c3
         4sHi5Qc25rdVIvb7MBn5rNHeFHiwNPmMwUkCu+RqyCVAwAtvpQWMrZz6Cg63yaryA7H3
         C/LMXWbj+Wr8KvRrBmEek+k0Uj7TN3vwFv67Uu6ATXlK4jNMYPu5zUkXWoC2KwZDMFtE
         UofeXBBq2H7gEKUg2kDzn4XfMDH2/u3xvAGJqCqVcDM1+pf/gzMCmfnKFXYDSc2aaIav
         /4qZ5K3cwHpiUOliovlsqNDRdsT4jWK46/j/p+gJC9XK/th2y8hr5a20LaymTAdKEkSk
         AIiA==
X-Gm-Message-State: ALoCoQksgG915jRCZZvKNDXekFBF4DYWOcOlOcRcYZhcOMtmYjBJcbvPEOFKGf5A7FdVni+l3ZZz
X-Received: by 10.180.86.33 with SMTP id m1mr49501014wiz.11.1411073641505;
        Thu, 18 Sep 2014 13:54:01 -0700 (PDT)
Received: from zenbook.localdomain (cpc69047-oxfd25-2-0-cust267.4-3.cable.virginm.net. [81.109.93.12])
        by mx.google.com with ESMTPSA id bk6sm27364715wjb.26.2014.09.18.13.53.59
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Sep 2014 13:54:00 -0700 (PDT)
X-Mailer: git-send-email 2.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257275>

Add a new format specifier, '%D' that is identical in behaviour to '%d',
except that it does not include the ' (' prefix or ')' suffix provided
by '%d'.

Signed-off-by: Harry Jeffery <harry@exec64.co.uk>
---
 Documentation/pretty-formats.txt |  6 ++++--
 log-tree.c                       | 17 +++++++++--------
 log-tree.h                       |  8 +++++++-
 pretty.c                         |  4 ++++
 t/t4205-log-pretty-formats.sh    | 11 +++++++++++
 5 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index eac7909..2632e1a 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -128,6 +128,7 @@ The placeholders are:
 - '%ct': committer date, UNIX timestamp
 - '%ci': committer date, ISO 8601 format
 - '%d': ref names, like the --decorate option of linkgit:git-log[1]
+- '%D': ref names without the " (", ")" wrapping.
 - '%e': encoding
 - '%s': subject
 - '%f': sanitized subject line, suitable for a filename
@@ -182,8 +183,9 @@ The placeholders are:
 NOTE: Some placeholders may depend on other options given to the
 revision traversal engine. For example, the `%g*` reflog options will
 insert an empty string unless we are traversing reflog entries (e.g., by
-`git log -g`). The `%d` placeholder will use the "short" decoration
-format if `--decorate` was not already provided on the command line.
+`git log -g`). The `%d` and `%D` placeholders will use the "short"
+decoration format if `--decorate` was not already provided on the command
+line.
 
 If you add a `+` (plus sign) after '%' of a placeholder, a line-feed
 is inserted immediately before the expansion if and only if the
diff --git a/log-tree.c b/log-tree.c
index 95e9b1d..8d05bb3 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -179,14 +179,16 @@ static void show_children(struct rev_info *opt, struct commit *commit, int abbre
 }
 
 /*
- * The caller makes sure there is no funny color before
- * calling. format_decorations makes sure the same after return.
+ * The caller makes sure there is no funny color before calling.
+ * format_decorations_extended makes sure the same after return.
  */
-void format_decorations(struct strbuf *sb,
+void format_decorations_extended(struct strbuf *sb,
 			const struct commit *commit,
-			int use_color)
+			int use_color,
+			const char *prefix,
+			const char *separator,
+			const char *suffix)
 {
-	const char *prefix;
 	struct name_decoration *decoration;
 	const char *color_commit =
 		diff_get_color(use_color, DIFF_COMMIT);
@@ -196,7 +198,6 @@ void format_decorations(struct strbuf *sb,
 	decoration = lookup_decoration(&name_decoration, &commit->object);
 	if (!decoration)
 		return;
-	prefix = " (";
 	while (decoration) {
 		strbuf_addstr(sb, color_commit);
 		strbuf_addstr(sb, prefix);
@@ -205,11 +206,11 @@ void format_decorations(struct strbuf *sb,
 			strbuf_addstr(sb, "tag: ");
 		strbuf_addstr(sb, decoration->name);
 		strbuf_addstr(sb, color_reset);
-		prefix = ", ";
+		prefix = separator;
 		decoration = decoration->next;
 	}
 	strbuf_addstr(sb, color_commit);
-	strbuf_addch(sb, ')');
+	strbuf_addstr(sb, suffix);
 	strbuf_addstr(sb, color_reset);
 }
 
diff --git a/log-tree.h b/log-tree.h
index d6ecd4d..b26160c 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -13,7 +13,13 @@ int log_tree_diff_flush(struct rev_info *);
 int log_tree_commit(struct rev_info *, struct commit *);
 int log_tree_opt_parse(struct rev_info *, const char **, int);
 void show_log(struct rev_info *opt);
-void format_decorations(struct strbuf *sb, const struct commit *commit, int use_color);
+void format_decorations_extended(struct strbuf *sb, const struct commit *commit,
+			     int use_color,
+			     const char *prefix,
+			     const char *separator,
+			     const char *suffix);
+#define format_decorations(strbuf, commit, color) \
+			     format_decorations_extended((strbuf), (commit), (color), " (", ", ", ")")
 void show_decorations(struct rev_info *opt, struct commit *commit);
 void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			     const char **subject_p,
diff --git a/pretty.c b/pretty.c
index 44b9f64..46d65b9 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1197,6 +1197,10 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		load_ref_decorations(DECORATE_SHORT_REFS);
 		format_decorations(sb, commit, c->auto_color);
 		return 1;
+	case 'D':
+		load_ref_decorations(DECORATE_SHORT_REFS);
+		format_decorations_extended(sb, commit, c->auto_color, "", ", ", "");
+		return 1;
 	case 'g':		/* reflog info */
 		switch(placeholder[1]) {
 		case 'd':	/* reflog selector */
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index de0cc4a..eb3d7a2 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -457,4 +457,15 @@ EOF
 	test_cmp expected actual1
 '
 
+test_expect_success 'clean log decoration' '
+	git log --no-walk --tags --pretty="%H %D" --decorate=full >actual &&
+	cat >expected <<EOF &&
+$head1 tag: refs/tags/tag2
+$head2 tag: refs/tags/message-one
+$old_head1 tag: refs/tags/message-two
+EOF
+	sort actual >actual1 &&
+	test_cmp expected actual1
+'
+
 test_done
-- 
2.1.0

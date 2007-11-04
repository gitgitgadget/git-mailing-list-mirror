From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 5/5] pretty describe: add %ds, %dn, %dd placeholders
Date: Sun, 04 Nov 2007 12:49:04 +0100
Message-ID: <472DB1B0.1050904@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Nov 04 12:49:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iodz1-0001JM-UR
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 12:49:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757269AbXKDLtV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 06:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757048AbXKDLtV
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 06:49:21 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:43787
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756245AbXKDLtU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Nov 2007 06:49:20 -0500
Received: from [10.0.1.201] (p57B7FCFB.dip.t-dialin.net [87.183.252.251])
	by neapel230.server4you.de (Postfix) with ESMTP id 41D34873BA;
	Sun,  4 Nov 2007 12:49:19 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63392>

The new placeholders %ds (description string, git-describe style), %dn
(the name part) and %dd (the depth part) are added.

To avoid imposing the significant cost of running describe_commit() on
every format string, even if none of the new placeholders are used, a
new function, interp_count(), is introduced.  It is a stripped down
version of interpolate(), that simply counts the placeholders in a
format string.  If the describe placeholders are not found, setting up
the corresponding replacements is skipped.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 Documentation/pretty-formats.txt |    3 +++
 commit.c                         |   38 ++++++++++++++++++++++++++++++++++++++
 interpolate.c                    |   36 ++++++++++++++++++++++++++++++++++++
 interpolate.h                    |    2 ++
 t/t6120-describe.sh              |   22 ++++++++++++++++++++++
 5 files changed, 101 insertions(+), 0 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 0193c3c..ec86415 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -100,6 +100,9 @@ The placeholders are:
 - '%t': abbreviated tree hash
 - '%P': parent hashes
 - '%p': abbreviated parent hashes
+- '%ds': description
+- '%dn': tag name part of the description
+- '%dd': depth part of the description
 - '%an': author name
 - '%ae': author email
 - '%ad': author date
diff --git a/commit.c b/commit.c
index 2e52a2f..06d5cec 100644
--- a/commit.c
+++ b/commit.c
@@ -781,6 +781,9 @@ void format_commit_message(struct commit *commit,
 		{ "%t" },	/* abbreviated tree hash */
 		{ "%P" },	/* parent hashes */
 		{ "%p" },	/* abbreviated parent hashes */
+		{ "%ds" },	/* description */
+		{ "%dn" },	/* tag name part of the description */
+		{ "%dd" },	/* depth part of the description */
 		{ "%an" },	/* author name */
 		{ "%ae" },	/* author email */
 		{ "%ad" },	/* author date */
@@ -809,6 +812,7 @@ void format_commit_message(struct commit *commit,
 		IHASH = 0, IHASH_ABBREV,
 		ITREE, ITREE_ABBREV,
 		IPARENTS, IPARENTS_ABBREV,
+		IDESC, IDESC_NAME, IDESC_DEPTH,
 		IAUTHOR_NAME, IAUTHOR_EMAIL,
 		IAUTHOR_DATE, IAUTHOR_DATE_RFC2822, IAUTHOR_DATE_RELATIVE,
 		IAUTHOR_TIMESTAMP, IAUTHOR_ISO8601,
@@ -829,10 +833,13 @@ void format_commit_message(struct commit *commit,
 	int i;
 	enum { HEADER, SUBJECT, BODY } state;
 	const char *msg = commit->buffer;
+	unsigned long occurs[ARRAY_SIZE(table)];
 
 	if (ILEFT_RIGHT + 1 != ARRAY_SIZE(table))
 		die("invalid interp table!");
 
+	interp_count(occurs, format, table, ARRAY_SIZE(table));
+
 	/* these are independent of the commit */
 	interp_set_entry(table, IRED, "\033[31m");
 	interp_set_entry(table, IGREEN, "\033[32m");
@@ -875,6 +882,37 @@ void format_commit_message(struct commit *commit,
 				DEFAULT_ABBREV));
 	interp_set_entry(table, IPARENTS_ABBREV, parents + 1);
 
+	if (occurs[IDESC] || occurs[IDESC_DEPTH] || occurs[IDESC_NAME]) {
+		struct strbuf desc;
+		char *name;
+		int depth = 0;
+		char *depthstr;
+		const char *abbr;
+
+		load_commit_names(2);
+		name = describe_commit(commit, 10, 0, &depth);
+		clear_commit_name_flags(commit);
+		abbr = find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV);
+
+		strbuf_init(&desc, 32);
+		strbuf_addstr(&desc, name ? name + 5 : abbr);
+		interp_set_entry(table, IDESC_NAME, desc.buf);
+		if (name) {
+			if (depth) {
+				strbuf_addch(&desc, '-');
+				depthstr = desc.buf + desc.len;
+				strbuf_addf(&desc, "%d", depth);
+				interp_set_entry(table, IDESC_DEPTH, depthstr);
+				strbuf_addstr(&desc, "-g");
+				strbuf_addstr(&desc, abbr);
+			} else {
+				interp_set_entry(table, IDESC_DEPTH, "0");
+			}
+		}
+		interp_set_entry(table, IDESC, desc.buf);
+		strbuf_release(&desc);
+	}
+
 	for (i = 0, state = HEADER; msg[i] && state < BODY; i++) {
 		int eol;
 		for (eol = i; msg[eol] && msg[eol] != '\n'; eol++)
diff --git a/interpolate.c b/interpolate.c
index 6ef53f2..8f51649 100644
--- a/interpolate.c
+++ b/interpolate.c
@@ -102,3 +102,39 @@ unsigned long interpolate(char *result, unsigned long reslen,
 		*dest = '\0';
 	return newlen;
 }
+
+/*
+ * interp_count - count occurences of placeholders
+ */
+void interp_count(unsigned long *result, const char *orig,
+                  const struct interp *interps, int ninterps)
+{
+	const char *src = orig;
+	const char *name;
+	unsigned long namelen;
+	int i;
+	char c;
+
+	for (i = 0; i < ninterps; i++)
+		result[i] = 0;
+
+	while ((c = *src)) {
+		if (c == '%') {
+			/* Try to match an interpolation string. */
+			for (i = 0; i < ninterps; i++) {
+				name = interps[i].name;
+				namelen = strlen(name);
+				if (strncmp(src, name, namelen) == 0)
+					break;
+			}
+
+			/* Check for valid interpolation. */
+			if (i < ninterps) {
+				result[i]++;
+				src += namelen;
+				continue;
+			}
+		}
+		src++;
+	}
+}
diff --git a/interpolate.h b/interpolate.h
index 77407e6..c41ea18 100644
--- a/interpolate.h
+++ b/interpolate.h
@@ -22,5 +22,7 @@ extern void interp_clear_table(struct interp *table, int ninterps);
 extern unsigned long interpolate(char *result, unsigned long reslen,
 				 const char *orig,
 				 const struct interp *interps, int ninterps);
+extern void interp_count(unsigned long *result, const char *orig,
+                         const struct interp *interps, int ninterps);
 
 #endif /* INTERPOLATE_H */
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index ae8ee11..3be43c4 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -23,6 +23,28 @@ check_describe () {
 		false ;;
 	esac
 	'
+
+	# %ds, %dn and %dd don't work with --tags or --all
+	case "$@" in
+	*--tags*|*--all*) return ;;
+	esac
+
+	R=$(git log -n 1 --pretty=format:%ds "$@") &&
+	test_expect_success "log --pretty=format:%ds $*" '
+	case "$R" in
+	$expect)	echo happy ;;
+	*)	echo "Oops - $R is not $expect";
+		false ;;
+	esac
+	'
+	R=$(git log -n 1 --pretty=format:%dn-%dd-g%h "$@" | sed 's/-0-g.*//') &&
+	test_expect_success "log --pretty=format:%dn-%dd-g%h $*" '
+	case "$R" in
+	$expect)	echo happy ;;
+	*)	echo "Oops - $R is not $expect";
+		false ;;
+	esac
+	'
 }
 
 test_expect_success setup '
-- 
1.5.3.5.529.ge3d6d

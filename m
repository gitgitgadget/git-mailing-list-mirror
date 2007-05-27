From: Johan Herland <johan@herland.net>
Subject: [PATCH 08/15] git-note: (Decorations) Add note decorations to
 "git-{log,show,whatchanged} --decorate"
Date: Sun, 27 May 2007 16:14:01 +0200
Message-ID: <200705271614.01462.johan@herland.net>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org>
 <alpine.LFD.0.98.0705101116480.3986@woody.linux-foundation.org>
 <200705271608.02122.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 27 16:14:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsJVd-0007IV-Bf
	for gcvg-git@gmane.org; Sun, 27 May 2007 16:14:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374AbXE0OOK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 10:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753431AbXE0OOJ
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 10:14:09 -0400
Received: from smtp.getmail.no ([84.208.20.33]:64693 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753374AbXE0OOI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 10:14:08 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JIP0050DE7J7S00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:14:07 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIP00GW9E7DR040@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:14:02 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIP000TSE7DJB50@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:14:01 +0200 (CEST)
In-reply-to: <200705271608.02122.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48548>

Introduce the concept of note decorations (supplementing the existing
name decorations), and teach the code handling the --decorate option
how to display note decorations.

The result is that notes are displayed below the commit message for
these commands:
- git-log --decorate
- git-show --decorate
- git-whatchanged --decorate

Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin-log.c |  108 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 commit.h      |    7 ++++
 log-tree.c    |   67 +++++++++++++++++++++++++++++++++--
 3 files changed, 178 insertions(+), 4 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 3744712..ee10f2a 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -20,6 +20,108 @@ static int default_show_root = 1;
 /* this is in builtin-diff.c */
 void add_head(struct rev_info *revs);
 
+static int get_note_decoration_data(const char *data, unsigned long data_len, const char **author, unsigned long *author_len, const char **date, unsigned long *date_len, const char **msg, unsigned long *msg_len)
+{
+	/*
+	 * Set author, date and msg pointers to their appropriate positions
+	 * within the given data buffer (tag object data). Also set the
+	 * appropriate lengths, respectively.
+	 */
+	const char *p, *q, *end = data + data_len;
+	if (!data || !data_len)
+		return 1;
+	p = data;
+	end = data + data_len;
+	do {
+		if (end - p >= 7 && !memcmp("tagger ", p, 7)) {
+			*author = p + 7;
+			if ((q = memchr(*author, '>', end - *author))) {
+				*author_len = ++q - *author;
+				*date = ++q;
+				q = memchr(*date, '\n', end - *date);
+				*date_len = q ? q - *date : 0;
+			}
+			else if ((q = memchr(*author, '\n', end - *author)))
+				*author_len = q - *author;
+			else
+				*author_len = 0;
+		}
+		else if (end - p >= 1 && !memcmp("\n", p, 1)) {
+			*msg = ++p;
+			*msg_len = end - *msg;
+			break;
+		}
+		p = memchr(p, '\n', end - p);
+	} while (p++);
+	return 0;
+}
+
+static int add_note_decoration(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
+{
+	struct object *obj;
+	struct tag *note;
+	struct note_decoration *res;
+	enum object_type data_type;
+	char *data;
+	const char   *author = "",   *date = "",   *msg = "";
+	unsigned long author_len = 0, date_len = 0, msg_len = 0;
+	unsigned long note_len, data_len;
+	unsigned long time = 0;
+
+	/* Get object pointed to by note */
+	obj = parse_object(sha1);
+	if (!obj)
+		return 0;
+	if (obj->type != OBJ_TAG)
+		return 0;
+
+	note = (struct tag *)obj;
+	obj = note->tagged;
+	if (!obj)
+		return 0;
+
+	/* Generate note decoration from note data */
+	data = read_sha1_file(note->object.sha1, &data_type, &data_len);
+	if (!data || !data_len)
+		return 0;
+	if (data_type != OBJ_TAG) {
+		free(data);
+		return 0; /* should not happen */
+	}
+
+	if (get_note_decoration_data(data,  data_len,
+			&author, &author_len, &date, &date_len, &msg, &msg_len))
+	{
+		free(data);
+		return 0; /* should not happen */
+	}
+	if (date && *date && date_len) { /* Found date; prettify it */
+		char *tz_p, *end;
+		int tz;
+		time = strtoul(date, &tz_p, 10);
+		tz = strtol(tz_p, &end, 10);
+		if (end - date > date_len) {
+			free(data);
+			return 0; /* overflowed; should not happen */
+		}
+		date = show_date(time, tz, DATE_NORMAL);
+		date_len = strlen(date);
+	}
+	note_len = 10 + author_len + date_len + msg_len;
+	res = xmalloc(sizeof(struct note_decoration) + note_len);
+	snprintf(res->note, note_len + 1, "\n--- by %.*s %.*s\n%.*s",
+			(int) author_len, author,
+			(int)   date_len,   date,
+			(int)    msg_len,    msg);
+	res->sort_hint = time;
+
+	/* Add note decoration to object that note points to */
+	res->next = add_decoration(&note_decoration, obj, res);
+
+	free(data);
+	return 0;
+}
+
 static void add_name_decoration(const char *prefix, const char *name, struct object *obj)
 {
 	int plen = strlen(prefix);
@@ -35,6 +137,8 @@ static int add_ref_decoration(const char *refname, const unsigned char *sha1, in
 	struct object *obj = parse_object(sha1);
 	if (!obj)
 		return 0;
+	if (!prefixcmp(refname, "refs/notes/"))
+		return 0; /* notes shouldn't show up here */
 	add_name_decoration("", refname, obj);
 	while (obj->type == OBJ_TAG) {
 		obj = ((struct tag *)obj)->tagged;
@@ -67,8 +171,10 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 			else
 				git_log_output_encoding = "";
 		} else if (!strcmp(arg, "--decorate")) {
-			if (!decorate)
+			if (!decorate) {
 				for_each_ref(add_ref_decoration, NULL);
+				for_each_note_ref(add_note_decoration, NULL);
+			}
 			decorate = 1;
 		} else
 			die("unrecognized argument: %s", arg);
diff --git a/commit.h b/commit.h
index 86e8dca..93cac79 100644
--- a/commit.h
+++ b/commit.h
@@ -28,6 +28,13 @@ struct name_decoration {
 	struct name_decoration *next;
 	char name[1];
 };
+/* While we can decorate any object with a note, it's only used for commits.. */
+extern struct decoration note_decoration;
+struct note_decoration {
+	struct note_decoration *next;
+	unsigned long sort_hint;
+	char note[1];
+};
 
 struct commit *lookup_commit(const unsigned char *sha1);
 struct commit *lookup_commit_reference(const unsigned char *sha1);
diff --git a/log-tree.c b/log-tree.c
index 4bef909..dccaca2 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -5,6 +5,7 @@
 #include "reflog-walk.h"
 
 struct decoration name_decoration = { "object names" };
+struct decoration note_decoration = { "object notes" };
 
 static void show_parents(struct commit *commit, int abbrev)
 {
@@ -15,7 +16,7 @@ static void show_parents(struct commit *commit, int abbrev)
 	}
 }
 
-static void show_decorations(struct commit *commit)
+static void show_name_decorations(struct commit *commit)
 {
 	const char *prefix;
 	struct name_decoration *decoration;
@@ -32,6 +33,65 @@ static void show_decorations(struct commit *commit)
 	putchar(')');
 }
 
+static int compare_note_decorations(const void *a, const void *b)
+{
+	const struct note_decoration *na = *((const struct note_decoration **) a);
+	const struct note_decoration *nb = *((const struct note_decoration **) b);
+	if (na->sort_hint < nb->sort_hint)
+		return -1;
+	else if (na->sort_hint == nb->sort_hint)
+		return 0;
+	return 1;
+}
+
+static void show_note_decorations(struct commit *commit)
+{
+	struct note_decoration *decoration;
+	struct note_decoration **decoArray;
+	unsigned int numDecorations = 0, i;
+
+	decoration = lookup_decoration(&note_decoration, &commit->object);
+	if (!decoration)
+		return;
+
+	/* Sort notes */
+	while (decoration) {
+		++numDecorations;
+		decoration = decoration->next;
+	}
+	decoration = lookup_decoration(&note_decoration, &commit->object);
+	decoArray = xmalloc(sizeof(struct note_decoration *) * numDecorations);
+	i = 0;
+	while (decoration) {
+		decoArray[i++] = decoration;
+		decoration = decoration->next;
+	}
+	qsort(decoArray, numDecorations, sizeof(struct note_decoration *), compare_note_decorations);
+
+	/* Print notes */
+	puts("\nNotes:");
+	for (i = 0; i < numDecorations; ++i) {
+		const char *p, *q;
+		decoration = decoArray[i];
+		p = decoration->note;
+		while (1) {
+			/* print everything indented by 4 spaces */
+			q = strchr(p, '\n');
+			if (!q)
+				q = p + strlen(p);
+			if (q - p)
+				printf("    %.*s\n", q - p, p);
+			else
+				printf("\n");
+			if (!*q || !*(q + 1))
+				break;
+			p = q + 1;
+		}
+	}
+
+	free(decoArray);
+}
+
 /*
  * Search for "^[-A-Za-z]+: [^@]+@" pattern. It usually matches
  * Signed-off-by: and Acked-by: lines.
@@ -155,7 +215,7 @@ void show_log(struct rev_info *opt, const char *sep)
 		fputs(diff_unique_abbrev(commit->object.sha1, abbrev_commit), stdout);
 		if (opt->parents)
 			show_parents(commit, abbrev_commit);
-		show_decorations(commit);
+		show_name_decorations(commit);
 		putchar(opt->diffopt.line_termination);
 		return;
 	}
@@ -260,7 +320,7 @@ void show_log(struct rev_info *opt, const char *sep)
 			printf(" (from %s)",
 			       diff_unique_abbrev(parent->object.sha1,
 						  abbrev_commit));
-		show_decorations(commit);
+		show_name_decorations(commit);
 		printf("%s",
 		       diff_get_color(opt->diffopt.color_diff, DIFF_RESET));
 		putchar(opt->commit_format == CMIT_FMT_ONELINE ? ' ' : '\n');
@@ -286,6 +346,7 @@ void show_log(struct rev_info *opt, const char *sep)
 		len = append_signoff(this_header, sizeof(this_header), len,
 				     opt->add_signoff);
 	printf("%s%s%s", this_header, extra, sep);
+	show_note_decorations(commit);
 }
 
 int log_tree_diff_flush(struct rev_info *opt)
-- 
1.5.2.101.gee49f

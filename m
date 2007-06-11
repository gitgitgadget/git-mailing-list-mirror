From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: use git-log rather than rev-list | xargs cat-file
Date: Mon, 11 Jun 2007 00:34:54 -0700
Message-ID: <7vhcpfrlk1.fsf@assigned-by-dhcp.pobox.com>
References: <20070610091259.48F8D13A4F8@magnus.utsl.gen.nz>
	<20070610212459.GA12222@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam@vilain.net>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Jun 11 09:35:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxeQb-0004TV-Fr
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 09:35:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbXFKHe5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 03:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbXFKHe5
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 03:34:57 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:42192 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226AbXFKHe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 03:34:56 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070611073456.OULR29545.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Mon, 11 Jun 2007 03:34:56 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id A7au1X00M1kojtg0000000; Mon, 11 Jun 2007 03:34:55 -0400
In-Reply-To: <20070610212459.GA12222@muzzle> (Eric Wong's message of "Sun, 10
	Jun 2007 14:24:59 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49827>

Eric Wong <normalperson@yhbt.net> writes:

> Sam Vilain <sam@vilain.net> wrote:
>> This saves a bit of time when rebuilding the git-svn index.
>
> Does git-log still have the 16k buffer limit?  If so then we can't use
> it because commit messages over 16k will be truncated and the git-svn-id
> line will not show up.  Also, if that limit is removed I'd prefer to
> just add --pretty=raw to rev-list because git-log is stil porcelain and
> more likely to change.

How about this?  It passes the test suite, but other than that
hasn't seen much test yet.  I tried to be careful, but sanity
checking by extra sets of eyeballs would be needed.

It changes length from int unsigned long in several places, and
you would need to look out for a boolean test like this:

	if (current_length < limit_length - slop)
        	... do something ...

as it now should be written like this:

	if (current_length + slop < limit_length)
        	... do something ...

-- >8 --
Subject: Lift 16kB limit of log message output

Traditionally we had 16kB limit when formatting log messages for
output, because it was easier to arrange for the caller to have
a reasonably big buffer and pass it down without ever worrying
about reallocating.

This changes the calling convention of pretty_print_commit() to
lift this limit.  Instead of the buffer and remaining length, it
now takes a pointer to the pointer that points at the allocated
buffer, and another pointer to the location that stores the
allocated length, and reallocates the buffer as necessary.

To support the user format, the error return of interpolate()
needed to be changed.  It used to return a bool telling "Ok the
result fits", or "Sorry, I had to truncate it".  Now it returns
0 on success, and returns the size of the buffer it wants in
order to fit the whole result.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 builtin-branch.c      |   17 +++++++++-----
 builtin-log.c         |    6 +++-
 builtin-rev-list.c    |    8 ++++--
 builtin-show-branch.c |   23 +++++++++++---------
 commit.c              |   55 ++++++++++++++++++++++++++++++++++++++----------
 commit.h              |    2 +-
 interpolate.c         |   46 ++++++++++++++++++----------------------
 interpolate.h         |    6 ++--
 log-tree.c            |   35 ++++++++++++++++++++----------
 9 files changed, 124 insertions(+), 74 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index da48051..d7c321a 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -242,7 +242,6 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 	char c;
 	int color;
 	struct commit *commit;
-	char subject[256];
 
 	switch (item->kind) {
 	case REF_LOCAL_BRANCH:
@@ -263,17 +262,23 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 	}
 
 	if (verbose) {
+		char *subject = NULL;
+		unsigned long subject_len = 0;
+		const char *sub = " **** invalid ref ****";
+
 		commit = lookup_commit(item->sha1);
-		if (commit && !parse_commit(commit))
+		if (commit && !parse_commit(commit)) {
 			pretty_print_commit(CMIT_FMT_ONELINE, commit, ~0,
-					    subject, sizeof(subject), 0,
+					    &subject, &subject_len, 0,
 					    NULL, NULL, 0);
-		else
-			strcpy(subject, " **** invalid ref ****");
+			sub = subject;
+		}
 		printf("%c %s%-*s%s %s %s\n", c, branch_get_color(color),
 		       maxwidth, item->name,
 		       branch_get_color(COLOR_BRANCH_RESET),
-		       find_unique_abbrev(item->sha1, abbrev), subject);
+		       find_unique_abbrev(item->sha1, abbrev), sub);
+		if (subject)
+			free(subject);
 	} else {
 		printf("%c %s%s%s\n", c, branch_get_color(color), item->name,
 		       branch_get_color(COLOR_BRANCH_RESET));
diff --git a/builtin-log.c b/builtin-log.c
index 0aede76..b9035ab 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -742,11 +742,13 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 			sign = '-';
 
 		if (verbose) {
-			static char buf[16384];
+			char *buf = NULL;
+			unsigned long buflen = 0;
 			pretty_print_commit(CMIT_FMT_ONELINE, commit, ~0,
-			                    buf, sizeof(buf), 0, NULL, NULL, 0);
+			                    &buf, &buflen, 0, NULL, NULL, 0);
 			printf("%c %s %s\n", sign,
 			       sha1_to_hex(commit->object.sha1), buf);
+			free(buf);
 		}
 		else {
 			printf("%c %s\n", sign,
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index ebf53f5..813aadf 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -92,11 +92,13 @@ static void show_commit(struct commit *commit)
 		putchar('\n');
 
 	if (revs.verbose_header) {
-		static char pretty_header[16384];
+		char *buf = NULL;
+		unsigned long buflen = 0;
 		pretty_print_commit(revs.commit_format, commit, ~0,
-				    pretty_header, sizeof(pretty_header),
+				    &buf, &buflen,
 				    revs.abbrev, NULL, NULL, revs.date_mode);
-		printf("%s%c", pretty_header, hdr_termination);
+		printf("%s%c", buf, hdr_termination);
+		free(buf);
 	}
 	fflush(stdout);
 	if (commit->parents) {
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index c892f1f..4fa87f6 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -259,17 +259,19 @@ static void join_revs(struct commit_list **list_p,
 
 static void show_one_commit(struct commit *commit, int no_name)
 {
-	char pretty[256], *cp;
+	char *pretty = NULL;
+	const char *pretty_str = "(unavailable)";
+	unsigned long pretty_len = 0;
 	struct commit_name *name = commit->util;
-	if (commit->object.parsed)
+
+	if (commit->object.parsed) {
 		pretty_print_commit(CMIT_FMT_ONELINE, commit, ~0,
-				    pretty, sizeof(pretty), 0, NULL, NULL, 0);
-	else
-		strcpy(pretty, "(unavailable)");
-	if (!prefixcmp(pretty, "[PATCH] "))
-		cp = pretty + 8;
-	else
-		cp = pretty;
+				    &pretty, &pretty_len,
+				    0, NULL, NULL, 0);
+		pretty_str = pretty;
+	}
+	if (!prefixcmp(pretty_str, "[PATCH] "))
+		pretty_str += 8;
 
 	if (!no_name) {
 		if (name && name->head_name) {
@@ -286,7 +288,8 @@ static void show_one_commit(struct commit *commit, int no_name)
 			printf("[%s] ",
 			       find_unique_abbrev(commit->object.sha1, 7));
 	}
-	puts(cp);
+	puts(pretty_str);
+	free(pretty);
 }
 
 static char *ref_name[MAX_REVS + 1];
diff --git a/commit.c b/commit.c
index 4ca4d44..d43a68e 100644
--- a/commit.c
+++ b/commit.c
@@ -776,7 +776,7 @@ static void fill_person(struct interp *table, const char *msg, int len)
 }
 
 static long format_commit_message(const struct commit *commit,
-		const char *msg, char *buf, unsigned long space)
+		const char *msg, char **buf_p, unsigned long *space_p)
 {
 	struct interp table[] = {
 		{ "%H" },	/* commit hash */
@@ -905,16 +905,27 @@ static long format_commit_message(const struct commit *commit,
 		if (!table[i].value)
 			interp_set_entry(table, i, "<unknown>");
 
-	interpolate(buf, space, user_format, table, ARRAY_SIZE(table));
+	do {
+		char *buf = *buf_p;
+		unsigned long space = *space_p;
+
+		space = interpolate(buf, space, user_format,
+				    table, ARRAY_SIZE(table));
+		if (!space)
+			break;
+		buf = xrealloc(buf, space);
+		*buf_p = buf;
+		*space_p = space;
+	} while (1);
 	interp_clear_table(table, ARRAY_SIZE(table));
 
-	return strlen(buf);
+	return strlen(*buf_p);
 }
 
 unsigned long pretty_print_commit(enum cmit_fmt fmt,
 				  const struct commit *commit,
 				  unsigned long len,
-				  char *buf, unsigned long space,
+				  char **buf_p, unsigned long *space_p,
 				  int abbrev, const char *subject,
 				  const char *after_subject,
 				  enum date_mode dmode)
@@ -927,9 +938,11 @@ unsigned long pretty_print_commit(enum cmit_fmt fmt,
 	int plain_non_ascii = 0;
 	char *reencoded;
 	const char *encoding;
+	char *buf;
+	unsigned long space, slop;
 
 	if (fmt == CMIT_FMT_USERFORMAT)
-		return format_commit_message(commit, msg, buf, space);
+		return format_commit_message(commit, msg, buf_p, space_p);
 
 	encoding = (git_log_output_encoding
 		    ? git_log_output_encoding
@@ -969,6 +982,26 @@ unsigned long pretty_print_commit(enum cmit_fmt fmt,
 		}
 	}
 
+	space = *space_p;
+	buf = *buf_p;
+
+	/*
+	 * We do not want to repeatedly realloc below, so
+	 * preallocate with enough slop to hold MIME headers,
+	 * "Subject: " prefix, etc.
+	 */
+	slop = 1000;
+	if (subject)
+		slop += strlen(subject);
+	if (after_subject)
+		slop += strlen(after_subject);
+	if (space < strlen(msg) + slop) {
+		space = strlen(msg) + slop;
+		buf = xrealloc(buf, space);
+		*space_p = space;
+		*buf_p = buf;
+	}
+
 	for (;;) {
 		const char *line = msg;
 		int linelen = get_one_line(msg, len);
@@ -976,14 +1009,12 @@ unsigned long pretty_print_commit(enum cmit_fmt fmt,
 		if (!linelen)
 			break;
 
-		/*
-		 * We want some slop for indentation and a possible
-		 * final "...". Thus the "+ 20".
-		 */
+		/* 20 would cover indent and leave us some slop */
 		if (offset + linelen + 20 > space) {
-			memcpy(buf + offset, "    ...\n", 8);
-			offset += 8;
-			break;
+			space = offset + linelen + 20;
+			buf = xrealloc(buf, space);
+			*buf_p = buf;
+			*space_p = space;
 		}
 
 		msg += linelen;
diff --git a/commit.h b/commit.h
index a313b53..467872e 100644
--- a/commit.h
+++ b/commit.h
@@ -61,7 +61,7 @@ enum cmit_fmt {
 };
 
 extern enum cmit_fmt get_commit_format(const char *arg);
-extern unsigned long pretty_print_commit(enum cmit_fmt fmt, const struct commit *, unsigned long len, char *buf, unsigned long space, int abbrev, const char *subject, const char *after_subject, enum date_mode dmode);
+extern unsigned long pretty_print_commit(enum cmit_fmt fmt, const struct commit *, unsigned long len, char **buf_p, unsigned long *space_p, int abbrev, const char *subject, const char *after_subject, enum date_mode dmode);
 
 /** Removes the first commit from a list sorted by date, and adds all
  * of its parents.
diff --git a/interpolate.c b/interpolate.c
index fb30694..0082677 100644
--- a/interpolate.c
+++ b/interpolate.c
@@ -44,33 +44,33 @@ void interp_clear_table(struct interp *table, int ninterps)
  *        { "%%", "%"},
  *    }
  *
- * Returns 1 on a successful substitution pass that fits in result,
- * Returns 0 on a failed or overflowing substitution pass.
+ * Returns 0 on a successful substitution pass that fits in result,
+ * Returns a number of bytes needed to hold the full substituted
+ * string otherwise.
  */
 
-int interpolate(char *result, int reslen,
+unsigned long interpolate(char *result, unsigned long reslen,
 		const char *orig,
 		const struct interp *interps, int ninterps)
 {
 	const char *src = orig;
 	char *dest = result;
-	int newlen = 0;
+	unsigned long newlen = 0;
 	const char *name, *value;
-	int namelen, valuelen;
+	unsigned long namelen, valuelen;
 	int i;
 	char c;
 
         memset(result, 0, reslen);
 
-	while ((c = *src) && newlen < reslen - 1) {
+	while ((c = *src)) {
 		if (c == '%') {
 			/* Try to match an interpolation string. */
 			for (i = 0; i < ninterps; i++) {
 				name = interps[i].name;
 				namelen = strlen(name);
-				if (strncmp(src, name, namelen) == 0) {
+				if (strncmp(src, name, namelen) == 0)
 					break;
-				}
 			}
 
 			/* Check for valid interpolation. */
@@ -78,29 +78,25 @@ int interpolate(char *result, int reslen,
 				value = interps[i].value;
 				valuelen = strlen(value);
 
-				if (newlen + valuelen < reslen - 1) {
+				if (newlen + valuelen + 1 < reslen) {
 					/* Substitute. */
 					strncpy(dest, value, valuelen);
-					newlen += valuelen;
 					dest += valuelen;
-					src += namelen;
-				} else {
-					/* Something's not fitting. */
-					return 0;
 				}
-
-			} else {
-				/* Skip bogus interpolation. */
-				*dest++ = *src++;
-				newlen++;
+				newlen += valuelen;
+				src += namelen;
+				continue;
 			}
-
-		} else {
-			/* Straight copy one non-interpolation character. */
-			*dest++ = *src++;
-			newlen++;
 		}
+		/* Straight copy one non-interpolation character. */
+		if (newlen + 1 < reslen)
+			*dest++ = *src;
+		src++;
+		newlen++;
 	}
 
-	return newlen < reslen - 1;
+	if (newlen + 1 < reslen)
+		return 0;
+	else
+		return newlen + 2;
 }
diff --git a/interpolate.h b/interpolate.h
index 16a26b9..77407e6 100644
--- a/interpolate.h
+++ b/interpolate.h
@@ -19,8 +19,8 @@ struct interp {
 extern void interp_set_entry(struct interp *table, int slot, const char *value);
 extern void interp_clear_table(struct interp *table, int ninterps);
 
-extern int interpolate(char *result, int reslen,
-		       const char *orig,
-		       const struct interp *interps, int ninterps);
+extern unsigned long interpolate(char *result, unsigned long reslen,
+				 const char *orig,
+				 const struct interp *interps, int ninterps);
 
 #endif /* INTERPOLATE_H */
diff --git a/log-tree.c b/log-tree.c
index 4bef909..0cf21bc 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -79,16 +79,25 @@ static int detect_any_signoff(char *letter, int size)
 	return seen_head && seen_name;
 }
 
-static int append_signoff(char *buf, int buf_sz, int at, const char *signoff)
+static unsigned long append_signoff(char **buf_p, unsigned long *buf_sz_p,
+				    unsigned long at, const char *signoff)
 {
 	static const char signed_off_by[] = "Signed-off-by: ";
-	int signoff_len = strlen(signoff);
+	size_t signoff_len = strlen(signoff);
 	int has_signoff = 0;
-	char *cp = buf;
-
-	/* Do we have enough space to add it? */
-	if (buf_sz - at <= strlen(signed_off_by) + signoff_len + 3)
-		return at;
+	char *cp;
+	char *buf;
+	unsigned long buf_sz;
+
+	buf = *buf_p;
+	buf_sz = *buf_sz_p;
+	if (buf_sz <= at + strlen(signed_off_by) + signoff_len + 3) {
+		buf_sz += strlen(signed_off_by) + signoff_len + 3;
+		buf = xrealloc(buf, buf_sz);
+		*buf_p = buf;
+		*buf_sz_p = buf_sz;
+	}
+	cp = buf;
 
 	/* First see if we already have the sign-off by the signer */
 	while ((cp = strstr(cp, signed_off_by))) {
@@ -133,7 +142,8 @@ static unsigned int digits_in_number(unsigned int number)
 
 void show_log(struct rev_info *opt, const char *sep)
 {
-	static char this_header[16384];
+	char *msgbuf = NULL;
+	unsigned long msgbuf_len = 0;
 	struct log_info *log = opt->loginfo;
 	struct commit *commit = log->commit, *parent = log->parent;
 	int abbrev = opt->diffopt.abbrev;
@@ -278,14 +288,15 @@ void show_log(struct rev_info *opt, const char *sep)
 	/*
 	 * And then the pretty-printed message itself
 	 */
-	len = pretty_print_commit(opt->commit_format, commit, ~0u, this_header,
-				  sizeof(this_header), abbrev, subject,
+	len = pretty_print_commit(opt->commit_format, commit, ~0u,
+				  &msgbuf, &msgbuf_len, abbrev, subject,
 				  extra_headers, opt->date_mode);
 
 	if (opt->add_signoff)
-		len = append_signoff(this_header, sizeof(this_header), len,
+		len = append_signoff(&msgbuf, &msgbuf_len, len,
 				     opt->add_signoff);
-	printf("%s%s%s", this_header, extra, sep);
+	printf("%s%s%s", msgbuf, extra, sep);
+	free(msgbuf);
 }
 
 int log_tree_diff_flush(struct rev_info *opt)

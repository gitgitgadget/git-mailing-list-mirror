From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH for "next"] pretty-formats: add 'format:<string>'
Date: Fri, 23 Feb 2007 01:35:03 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702230125270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
 <87hcx1u934.wl%cworth@cworth.org> <Pine.LNX.4.64.0611141518590.2591@xanadu.home>
 <87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>
 <Pine.LNX.4.64.0611141633430.2591@xanadu.home> <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142007010.2591@xanadu.home> <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142306090.2591@xanadu.home> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
 <455BBCE9.4050503@xs4all.nl> <Pine.LNX.4.64.0611151908130.3349@woody.osdl.org>
 <455C412D.1030408@xs4all.nl> <7v7ixvbq80.fsf@assigned-by-dhcp.cox.net>
 <455C618A.7080309@xs4all.nl> <ejkd6g$vog$1@sea.gmane.org> <4566E512.4010405@xs4all.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
X-From: git-owner@vger.kernel.org Fri Feb 23 01:35:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKOP3-0005aT-UH
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 01:35:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093AbXBWAfK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 19:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752090AbXBWAfK
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 19:35:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:50359 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752083AbXBWAfH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 19:35:07 -0500
Received: (qmail invoked by alias); 23 Feb 2007 00:35:03 -0000
X-Provags-ID: V01U2FsdGVkX1+q4DpNQjuqdEUNjrRkBhod8CKPTO2C0N1qdyMLDg
	gJWw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <4566E512.4010405@xs4all.nl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40401>


With this patch,

$ git show -s \
	--pretty=format:'  Ze komit %h woss%n  dunn buy ze great %an'

shows something like

  Ze komit 04c5c88 woss
  dunn buy ze great Junio C Hamano

The supported placeholders are:

	'%H': commit hash
	'%h': abbreviated commit hash
	'%T': tree hash
	'%t': abbreviated tree hash
	'%P': parent hashes
	'%p': abbreviated parent hashes
	'%an': author name
	'%ae': author email
	'%ad': author date
	'%aD': author date, RFC2822 style
	'%ar': author date, relative
	'%at': author date, UNIX timestamp
	'%cn': committer name
	'%ce': committer email
	'%cd': committer date
	'%cD': committer date, RFC2822 style
	'%cr': committer date, relative
	'%ct': committer date, UNIX timestamp
	'%e': encoding
	'%s': subject
	'%b': body
	'%Cred': switch color to red
	'%Cgreen': switch color to green
	'%Cblue': switch color to blue
	'%Creset': reset color
	'%n': newline

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Fri, 24 Nov 2006, Han-Wen Nienhuys wrote:

	> The recently posted patch documenting is an improvement, but why 
	> not add an option so you can do
	> 
	>   --format 'committer %c\nauthor %a\n'
	>   
	> this catches all combinations, and is easier for scripting.

	So, I overcame my laziness after 91 days...

	Of course, this is not as efficient as it could be: it _will_ get 
	_all_ variables from the commit, even if not needed. However, I 
	don't think that it matters in reality.

	BTW I have not found any implementation of xstrndup(), so I let it 
	be static.

 Documentation/pretty-formats.txt |   44 +++++++++
 commit.c                         |  195 ++++++++++++++++++++++++++++++++++++++
 commit.h                         |    1 +
 log-tree.c                       |    2 +-
 4 files changed, 241 insertions(+), 1 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index fb0b0b9..2fe6c31 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -77,9 +77,53 @@ displayed in full, regardless of whether --abbrev or
 true parent commits, without taking grafts nor history
 simplification into account.
 
+	* 'format:'
++
+The 'format:' format allows you to specify which information
+you want to show. It works a little bit like printf format,
+with the notable exception that you get a newline with '%n'
+instead of '\n'.
+
+E.g, 'format:"The author of %h was %an, %ar%nThe title was >>%s<<"'
+would show something like this:
+
+The author of fe6e0ee was Junio C Hamano, 23 hours ago
+The title was >>t4119: test autocomputing -p<n> for traditional diff input.<<
+
+The placeholders are:
+
+- '%H': commit hash
+- '%h': abbreviated commit hash
+- '%T': tree hash
+- '%t': abbreviated tree hash
+- '%P': parent hashes
+- '%p': abbreviated parent hashes
+- '%an': author name
+- '%ae': author email
+- '%ad': author date
+- '%aD': author date, RFC2822 style
+- '%ar': author date, relative
+- '%at': author date, UNIX timestamp
+- '%cn': committer name
+- '%ce': committer email
+- '%cd': committer date
+- '%cD': committer date, RFC2822 style
+- '%cr': committer date, relative
+- '%ct': committer date, UNIX timestamp
+- '%e': encoding
+- '%s': subject
+- '%b': body
+- '%Cred': switch color to red
+- '%Cgreen': switch color to green
+- '%Cblue': switch color to blue
+- '%Creset': reset color
+- '%n': newline
+
+
 --encoding[=<encoding>]::
 	The commit objects record the encoding used for the log message
 	in their encoding header; this option can be used to tell the
 	command to re-code the commit log message in the encoding
 	preferred by the user.  For non plumbing commands this
 	defaults to UTF-8.
+
diff --git a/commit.c b/commit.c
index 8d279b0..a97aef3 100644
--- a/commit.c
+++ b/commit.c
@@ -3,6 +3,7 @@
 #include "commit.h"
 #include "pkt-line.h"
 #include "utf8.h"
+#include "interpolate.h"
 
 int save_commit_buffer = 1;
 
@@ -36,8 +37,11 @@ struct cmt_fmt_map {
 	{ "full",	5,	CMIT_FMT_FULL },
 	{ "fuller",	5,	CMIT_FMT_FULLER },
 	{ "oneline",	1,	CMIT_FMT_ONELINE },
+	{ "format:",	7,	CMIT_FMT_USERFORMAT},
 };
 
+static char *user_format;
+
 enum cmit_fmt get_commit_format(const char *arg)
 {
 	int i;
@@ -46,6 +50,12 @@ enum cmit_fmt get_commit_format(const char *arg)
 		return CMIT_FMT_DEFAULT;
 	if (*arg == '=')
 		arg++;
+	if (!prefixcmp(arg, "format:")) {
+		if (user_format)
+			free(user_format);
+		user_format = xstrdup(arg + 7);
+		return CMIT_FMT_USERFORMAT;
+	}
 	for (i = 0; i < ARRAY_SIZE(cmt_fmts); i++) {
 		if (!strncmp(arg, cmt_fmts[i].n, cmt_fmts[i].cmp_len) &&
 		    !strncmp(arg, cmt_fmts[i].n, strlen(arg)))
@@ -710,6 +720,188 @@ static char *logmsg_reencode(const struct commit *commit,
 	return out;
 }
 
+static char *xstrndup(const char *text, int len)
+{
+	char *result = xmalloc(len + 1);
+	memcpy(result, text, len);
+	result[len] = '\0';
+	return result;
+}
+
+static void fill_person(struct interp *table, const char *msg, int len)
+{
+	int start, end, tz = 0;
+	unsigned long date;
+	char *ep;
+
+	/* parse name */
+	for (end = 0; end < len && msg[end] != '<'; end++)
+		; /* do nothing */
+	start = end + 1;
+	while (end > 0 && isspace(msg[end - 1]))
+		end--;
+	table[0].value = xstrndup(msg, end);
+
+	if (start >= len)
+		return;
+
+	/* parse email */
+	for (end = start + 1; end < len && msg[end] != '>'; end++)
+		; /* do nothing */
+
+	if (end >= len)
+		return;
+
+	table[1].value = xstrndup(msg + start, end - start);
+
+	/* parse date */
+	for (start = end + 1; start < len && isspace(msg[start]); start++)
+		; /* do nothing */
+	if (start >= len)
+		return;
+	date = strtoul(msg + start, &ep, 10);
+	if (msg + start == ep)
+		return;
+
+	table[5].value = xstrndup(msg + start, ep - msg + start);
+
+	/* parse tz */
+	for (start = ep - msg + 1; start < len && isspace(msg[start]); start++)
+		; /* do nothing */
+	if (start + 1 < len) {
+		tz = strtoul(msg + start + 1, NULL, 10);
+		if (msg[start] == '-')
+			tz = -tz;
+	}
+
+	interp_set_entry(table, 2, show_date(date, tz, 0));
+	interp_set_entry(table, 3, show_rfc2822_date(date, tz));
+	interp_set_entry(table, 4, show_date(date, tz, 1));
+}
+
+static long format_commit_message(const struct commit *commit,
+		const char *msg, char *buf, unsigned long space)
+{
+	struct interp table[] = {
+		{ "%H" },	/* commit hash */
+		{ "%h" },	/* abbreviated commit hash */
+		{ "%T" },	/* tree hash */
+		{ "%t" },	/* abbreviated tree hash */
+		{ "%P" },	/* parent hashes */
+		{ "%p" },	/* abbreviated parent hashes */
+		{ "%an" },	/* author name */
+		{ "%ae" },	/* author email */
+		{ "%ad" },	/* author date */
+		{ "%aD" },	/* author date, RFC2822 style */
+		{ "%ar" },	/* author date, relative */
+		{ "%at" },	/* author date, UNIX timestamp */
+		{ "%cn" },	/* committer name */
+		{ "%ce" },	/* committer email */
+		{ "%cd" },	/* committer date */
+		{ "%cD" },	/* committer date, RFC2822 style */
+		{ "%cr" },	/* committer date, relative */
+		{ "%ct" },	/* committer date, UNIX timestamp */
+		{ "%e" },	/* encoding */
+		{ "%s" },	/* subject */
+		{ "%b" },	/* body */
+		{ "%Cred" },	/* red */
+		{ "%Cgreen" },	/* green */
+		{ "%Cblue" },	/* blue */
+		{ "%Creset" },	/* reset color */
+		{ "%n" }	/* newline */
+	};
+	enum interp_index {
+		IHASH = 0, IHASH_ABBREV,
+		ITREE, ITREE_ABBREV,
+		IPARENTS, IPARENTS_ABBREV,
+		IAUTHOR_NAME, IAUTHOR_EMAIL,
+		IAUTHOR_DATE, IAUTHOR_DATE_RFC2822, IAUTHOR_DATE_RELATIVE,
+		IAUTHOR_TIMESTAMP,
+		ICOMMITTER_NAME, ICOMMITTER_EMAIL,
+		ICOMMITTER_DATE, ICOMMITTER_DATE_RFC2822,
+		ICOMMITTER_DATE_RELATIVE, ICOMMITTER_TIMESTAMP,
+		IENCODING,
+		ISUBJECT,
+		IBODY,
+		IRED, IGREEN, IBLUE, IRESET_COLOR,
+		INEWLINE
+	};
+	struct commit_list *p;
+	char parents[1024];
+	int i;
+	enum { HEADER, SUBJECT, BODY } state;
+
+	if (INEWLINE + 1 != ARRAY_SIZE(table))
+		die("invalid interp table!");
+
+	/* these are independent of the commit */
+	interp_set_entry(table, IRED, "\033[31m");
+	interp_set_entry(table, IGREEN, "\033[32m");
+	interp_set_entry(table, IBLUE, "\033[34m");
+	interp_set_entry(table, IRESET_COLOR, "\033[m");
+	interp_set_entry(table, INEWLINE, "\n");
+
+	/* these depend on the commit */
+	if (!commit->object.parsed)
+		parse_object(commit->object.sha1);
+	interp_set_entry(table, IHASH, sha1_to_hex(commit->object.sha1));
+	interp_set_entry(table, IHASH_ABBREV,
+			find_unique_abbrev(commit->object.sha1,
+				DEFAULT_ABBREV));
+	interp_set_entry(table, ITREE, sha1_to_hex(commit->tree->object.sha1));
+	interp_set_entry(table, ITREE_ABBREV,
+			find_unique_abbrev(commit->tree->object.sha1,
+				DEFAULT_ABBREV));
+	for (i = 0, p = commit->parents;
+			p && i < sizeof(parents) - 1;
+			p = p->next)
+		i += snprintf(parents + i, sizeof(parents) - i - 1, "%s ",
+			sha1_to_hex(p->item->object.sha1));
+	interp_set_entry(table, IPARENTS, parents);
+	for (i = 0, p = commit->parents;
+			p && i < sizeof(parents) - 1;
+			p = p->next)
+		i += snprintf(parents + i, sizeof(parents) - i - 1, "%s ",
+			find_unique_abbrev(p->item->object.sha1,
+				DEFAULT_ABBREV));
+	interp_set_entry(table, IPARENTS_ABBREV, parents);
+
+	for (i = 0, state = HEADER; msg[i] && state < BODY; i++) {
+		int eol;
+		for (eol = i; msg[eol] && msg[eol] != '\n'; eol++)
+			; /* do nothing */
+
+		if (state == SUBJECT) {
+			table[ISUBJECT].value = xstrndup(msg + i, eol - i);
+			i = eol;
+		}
+		if (i == eol) {
+			state++;
+			/* strip empty lines */
+			while (msg[eol + 1] == '\n')
+				eol++;
+		} else if (!prefixcmp(msg + i, "author "))
+			fill_person(table + IAUTHOR_NAME,
+					msg + i + 7, eol - i - 7);
+		else if (!prefixcmp(msg + i, "committer "))
+			fill_person(table + ICOMMITTER_NAME,
+					msg + i + 10, eol - i - 10);
+		else if (!prefixcmp(msg + i, "encoding "))
+			table[IENCODING].value = xstrndup(msg + i, eol - i);
+		i = eol;
+	}
+	if (msg[i])
+		table[IBODY].value = xstrdup(msg + i);
+	for (i = 0; i < ARRAY_SIZE(table); i++)
+		if (!table[i].value)
+			interp_set_entry(table, i, "<unknown>");
+
+	interpolate(buf, space, user_format, table, ARRAY_SIZE(table));
+	interp_clear_table(table, ARRAY_SIZE(table));
+
+	return strlen(buf);
+}
+
 unsigned long pretty_print_commit(enum cmit_fmt fmt,
 				  const struct commit *commit,
 				  unsigned long len,
@@ -727,6 +919,9 @@ unsigned long pretty_print_commit(enum cmit_fmt fmt,
 	char *reencoded;
 	char *encoding;
 
+	if (fmt == CMIT_FMT_USERFORMAT)
+		return format_commit_message(commit, msg, buf, space);
+
 	encoding = (git_log_output_encoding
 		    ? git_log_output_encoding
 		    : git_commit_encoding);
diff --git a/commit.h b/commit.h
index c737444..83507a0 100644
--- a/commit.h
+++ b/commit.h
@@ -47,6 +47,7 @@ enum cmit_fmt {
 	CMIT_FMT_FULLER,
 	CMIT_FMT_ONELINE,
 	CMIT_FMT_EMAIL,
+	CMIT_FMT_USERFORMAT,
 
 	CMIT_FMT_UNSPECIFIED,
 };
diff --git a/log-tree.c b/log-tree.c
index ac86194..6ce239d 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -211,7 +211,7 @@ void show_log(struct rev_info *opt, const char *sep)
 				 sha1, sha1);
 			opt->diffopt.stat_sep = buffer;
 		}
-	} else {
+	} else if (opt->commit_format != CMIT_FMT_USERFORMAT) {
 		fputs(diff_get_color(opt->diffopt.color_diff, DIFF_COMMIT),
 		      stdout);
 		if (opt->commit_format != CMIT_FMT_ONELINE)
-- 
1.5.0.1.620.gac8f

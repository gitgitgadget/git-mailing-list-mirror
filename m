From: =?utf-8?q?Adeodato=20Sim=C3=B3?= <dato@net.com.org.es>
Subject: [PATCH/RFC] shortlog: add option to group together different names/emails of an author
Date: Sat, 10 Jan 2009 16:16:29 +0100
Message-ID: <1231600589-11811-1-git-send-email-dato@net.com.org.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Adeodato=20Sim=C3=B3?= <dato@net.com.org.es>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 10 16:18:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLfb6-000713-0P
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 16:18:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232AbZAJPQg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Jan 2009 10:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752064AbZAJPQg
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 10:16:36 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:4094
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbZAJPQe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 10:16:34 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id 9749A801BF68;
	Sat, 10 Jan 2009 16:16:31 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LLfZd-00036u-Uu; Sat, 10 Jan 2009 16:16:29 +0100
X-Mailer: git-send-email 1.6.1.134.g55c35
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105121>

It's common for repositories to contain commits with different spelling=
s of
an author name, or different email addresses. The shortlog command trie=
s to
alleviate this by using .mailmap files. However, maintaining a .mailmap=
 file
up to date is a manual process, and it does not help when shortlog is
invoked with the -e option and different email addresses for an author =
are
involved.

This commit introduces a -j/--join-uids option that uses a very dumb lo=
gic
to detect different spellings and addresses of a same author. In partic=
ular,
it just joins commits when either the name or the address had been
previously seen, attaching the commit to that previous id. In other wor=
ds,
these three ids will be joined:

    Author: Joe Developer <joe@example.com>
    Author: Joe R. Developer <joe_r@example.com>
    Author: Joe R. Developer <joe@example.com>

but only because of the third spelling. The first two alone would be le=
ft
separate. When the names and addresses are printed, the most common spe=
lling
and address are used.

Incidentally, there is f817546 in git.git which has this author informa=
tion:

    Author: Wincent Colaiuta <gitster@pobox.com>

Which makes all of Wincent's commits to be assigned to Junio with -j. T=
his
is easily fixed with an entry for gitster@pobox.com in .mailmap, which =
this
commit includes. (And then, only f817546 is be assigned to Junio.)

Signed-off-by: Adeodato Sim=C3=B3 <dato@net.com.org.es>
---
This is my scratching of my own itch: I was used to `bzr author-stats`,
which is equivalent to `git shortlog -jsne`. I realize -sn comes close,
but I like having the email address listed. Please let me know what you
think.

Tests and a mention in git-shortlog.txt are missing. That'll come next
when/if I'm told this has a chance of inclusion. :-)

The code is valgrind'ed. I'm not completely confident, though, bugs wil=
l
not be hiding in corner cases. Also, I don't see any appreciable
slowdown with this version in git.git, particularly not between the
current git-shortlog and this new when run without -j (not when run wit=
h
-j either, but that's less critical).

This patch applies on top of my as/maint-shortlog-cleanup branch.

 .mailmap           |    1 +
 builtin-shortlog.c |  280 ++++++++++++++++++++++++++++++++++++++++++++=
+-------
 shortlog.h         |   14 ++-
 3 files changed, 256 insertions(+), 39 deletions(-)

diff --git a/.mailmap b/.mailmap
index 373476b..f86d8a7 100644
--- a/.mailmap
+++ b/.mailmap
@@ -27,6 +27,7 @@ Joachim Berdal Haga <cjhaga@fys.uio.no>
 Jon Loeliger <jdl@freescale.com>
 Jon Seymour <jon@blackcubes.dyndns.org>
 Jonathan Nieder <jrnieder@uchicago.edu>
+Junio C Hamano <gitster@pobox.com>
 Junio C Hamano <junio@twinsun.com>
 Karl Hasselstr=C3=B6m <kha@treskal.com>
 Kent Engstrom <kent@lysator.liu.se>
diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index 90e76ae..af155b9 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -9,24 +9,79 @@
 #include "shortlog.h"
 #include "parse-options.h"
=20
+struct idinfo {
+	int count;
+	size_t idx;
+};
+
 static char const * const shortlog_usage[] =3D {
 	"git shortlog [-n] [-s] [-e] [-w] [rev-opts] [--] [<commit-id>... ]",
 	"",
 	"[rev-opts] are documented in git-rev-list(1)",
 	NULL
 };
-
-static int compare_by_number(const void *a1, const void *a2)
-{
-	const struct string_list_item *i1 =3D a1, *i2 =3D a2;
-	const struct string_list *l1 =3D i1->util, *l2 =3D i2->util;
+
+static int compare_by_count(const void *a1, const void *a2)
+{
+	const struct idinfo *i1 =3D a1, *i2 =3D a2;
+
+	if (i1->count < i2->count)
+		return 1;
+	else if (i1->count =3D=3D i2->count)
+		return 0;
+	else
+		return -1;
+}
+
+static int compare_by_idx_and_count(const void *a1, const void *a2)
+{
+	const struct string_list_item *it1 =3D a1, *it2 =3D a2;
+	const struct idinfo *i1 =3D it1->util, *i2 =3D it2->util;
+
+	if (i1->idx < i2->idx)
+		return -1;
+	else if (i1->idx > i2->idx)
+		return 1;
+	else if (i1->count < i2->count)
+		return 1;
+	else if (i1->count > i2->count)
+		return -1;
+	else
+		return 0;
+}
+
+static int compare_by_nr(const void *a1, const void *a2)
+{
+	const struct string_list *l1 =3D a1, *l2 =3D a2;
=20
 	if (l1->nr < l2->nr)
 		return 1;
-	else if (l1->nr =3D=3D l2->nr)
+	else if (l1->nr > l2->nr)
+		return -1;
+	else if (l1->nr =3D=3D 0)
 		return 0;
 	else
+		return strcmp(l1->items[0].util, l2->items[0].util);
+}
+
+static int compare_by_first_util_str(const void *a1, const void *a2)
+{
+	const struct string_list *l1 =3D a1, *l2 =3D a2;
+	if (l1->nr && l2->nr)
+		return strcmp(l1->items[0].util, l2->items[0].util);
+	else if (!l1->nr && !l2->nr)
+		return 0;
+	else if (l1->nr)
 		return -1;
+	else
+		return 1;
+}
+
+static inline void alloc_grow_all_lines(struct shortlog *log)
+{
+	ALLOC_GROW(log->all_lines, log->nr + 1, log->alloc);
+	memset(log->all_lines + log->nr,
+	       0, (log->alloc - log->nr) * sizeof(struct string_list));
 }
=20
 static void insert_one_record(struct shortlog *log,
@@ -35,9 +90,11 @@ static void insert_one_record(struct shortlog *log,
 {
 	const char *dot3 =3D log->common_repo_prefix;
 	char *buffer, *p;
-	struct string_list_item *item;
+	struct string_list_item *item, *name, *email;
 	char namebuf[1024];
-	size_t len;
+	char emailbuf[1024];
+	struct idinfo *nu, *eu;
+	size_t len, idx;
 	const char *eol;
 	const char *boemail, *eoemail;
=20
@@ -61,16 +118,117 @@ static void insert_one_record(struct shortlog *lo=
g,
 	else
 		len =3D strlen(namebuf);
=20
-	if (log->email) {
-		size_t room =3D sizeof(namebuf) - len - 1;
-		int maillen =3D eoemail - boemail + 1;
-		snprintf(namebuf + len, room, " %.*s", maillen, boemail);
-	}
-
-	item =3D string_list_insert(namebuf, &log->list);
-	if (item->util =3D=3D NULL)
-		item->util =3D xcalloc(1, sizeof(struct string_list));
-
+	/*
+	 * log->all_lines is an array of string_lists where each list
+	 * contains all the records by an author. The author information
+	 * for all_lines[i] is in the element in log->names that has
+	 * the "idx" member set to i.
+	 *
+	 * If join_uids is on, we try to detect different spellings and
+	 * different email addresses of a same author: when saving a
+	 * record, we check if we've already seen either the name or the
+	 * address. If we have, we append to that author (and save the
+	 * new name/address as alternative spelling). If we have seen
+	 * both, but they point to different authors, we merge the
+	 * entries, and always associate the result with the address.
+	 *
+	 * To merge in the right order, each record in all_lines[x] has
+	 * an id (autocounter) in the "util" member.
+	 */
+	if (!log->join_uids) {
+		if (log->email) {
+			size_t room =3D sizeof(namebuf) - len - 1;
+			int maillen =3D eoemail - boemail + 1;
+			snprintf(namebuf + len, room,
+				 " %.*s", maillen, boemail);
+		}
+		name =3D string_list_insert(namebuf, &log->names);
+
+		if (name->util =3D=3D NULL) {
+			alloc_grow_all_lines(log);
+			name->util =3D nu =3D xcalloc(1, sizeof(struct idinfo));
+			nu->idx =3D idx =3D log->nr++;
+			nu->count =3D 1;
+		}
+		else {
+			nu =3D name->util;
+			idx =3D nu->idx;
+			nu->count++;
+		}
+		goto write_line; /* Save one precious level of indentation. */
+	}
+
+	int maillen =3D eoemail - boemail - 1;
+	snprintf(emailbuf, sizeof(emailbuf), "%.*s", maillen, boemail+1);
+
+	name =3D string_list_insert(namebuf, &log->names);
+	email =3D string_list_insert(emailbuf, &log->emails);
+
+	if (name->util =3D=3D NULL && email->util =3D=3D NULL) {
+		alloc_grow_all_lines(log);
+		nu =3D xcalloc(1, sizeof(struct idinfo));
+		eu =3D xcalloc(1, sizeof(struct idinfo));
+		idx =3D nu->idx =3D eu->idx =3D log->nr++;
+	}
+	else if (name->util =3D=3D NULL) {
+		nu =3D xcalloc(1, sizeof(struct idinfo));
+		eu =3D email->util;
+		idx =3D nu->idx =3D eu->idx;
+	}
+	else if (email->util =3D=3D NULL) {
+		nu =3D name->util;
+		eu =3D xcalloc(1, sizeof(struct idinfo));
+		idx =3D eu->idx =3D nu->idx;
+	}
+	else {
+		nu =3D name->util;
+		eu =3D email->util;
+
+		if (nu->idx !=3D eu->idx) {
+			/* Merge both entries. */
+			int i, j, oldidx;
+			struct idinfo *info;
+			struct string_list new =3D { NULL, 0, 0, 0 };
+			struct string_list *l1 =3D &log->all_lines[nu->idx];
+			struct string_list *l2 =3D &log->all_lines[eu->idx];
+
+			for (i =3D 0, j =3D 0; i < l1->nr && j < l2->nr; ) {
+				int c1 =3D (intptr_t) l1->items[i].util;
+				int c2 =3D (intptr_t) l2->items[j].util;
+				if (c1 < c2)
+					string_list_append(l1->items[i++].string, &new);
+				else
+					string_list_append(l2->items[j++].string, &new);
+			}
+			while (i < l1->nr) {
+				string_list_append(l1->items[i++].string, &new);
+			}
+			while (j < l2->nr) {
+				string_list_append(l2->items[j++].string, &new);
+			}
+
+			oldidx =3D nu->idx; /* Always favour the email. */
+
+			for (i =3D 0; i < log->names.nr; i++)
+				if ((info =3D log->names.items[i].util)->idx =3D=3D oldidx)
+					info->idx =3D eu->idx;
+
+			for (i =3D 0; i < log->emails.nr; i++)
+				if ((info =3D log->emails.items[i].util)->idx =3D=3D oldidx)
+					info->idx =3D eu->idx;
+
+			string_list_clear(l1, 0);
+			string_list_clear(l2, 0);
+			memcpy(l2, &new, sizeof(struct string_list));
+		}
+		idx =3D nu->idx;
+	}
+	nu->count++;
+	eu->count++;
+	name->util =3D nu;
+	email->util =3D eu;
+
+write_line:
 	/* Skip any leading whitespace, including any blank lines. */
 	while (*oneline && isspace(*oneline))
 		oneline++;
@@ -100,7 +258,8 @@ static void insert_one_record(struct shortlog *log,
 		}
 	}
=20
-	string_list_append(buffer, item->util);
+	item =3D string_list_append(buffer, &log->all_lines[idx]);
+	item->util =3D (void*)(intptr_t) log->commit_count++;
 }
=20
 static void read_from_stdin(struct shortlog *log)
@@ -218,10 +377,12 @@ void shortlog_init(struct shortlog *log)
=20
 	read_mailmap(&log->mailmap, ".mailmap", &log->common_repo_prefix);
=20
-	log->list.strdup_strings =3D 1;
 	log->wrap =3D DEFAULT_WRAPLEN;
 	log->in1 =3D DEFAULT_INDENT1;
 	log->in2 =3D DEFAULT_INDENT2;
+
+	log->names.strdup_strings =3D 1;
+	log->emails.strdup_strings =3D 1;
 }
=20
 int cmd_shortlog(int argc, const char **argv, const char *prefix)
@@ -237,6 +398,8 @@ int cmd_shortlog(int argc, const char **argv, const=
 char *prefix)
 			    "Suppress commit descriptions, only provides commit count"),
 		OPT_BOOLEAN('e', "email", &log.email,
 			    "Show the email address of each author"),
+		OPT_BOOLEAN('j', "join-uids", &log.join_uids,
+			    "Group together different spellings and addresses of an author"=
),
 		{ OPTION_CALLBACK, 'w', NULL, &log, "w[,i1[,i2]]",
 			"Linewrap output", PARSE_OPT_OPTARG, &parse_wrap_args },
 		OPT_END(),
@@ -285,16 +448,65 @@ parse_done:
 void shortlog_output(struct shortlog *log)
 {
 	int i, j;
-	if (log->sort_by_number)
-		qsort(log->list.items, log->list.nr, sizeof(struct string_list_item)=
,
-			compare_by_number);
-	for (i =3D 0; i < log->list.nr; i++) {
-		struct string_list *onelines =3D log->list.items[i].util;
-
+
+	/*
+	 * We do some pre-processing to find the author name for each item
+	 * in log->all_lines, saving it in all_lines[i].util. If join_uids
+	 * is on, the most common spelling and address will be used.
+	 */
+	qsort(log->names.items, log->names.nr,
+	      sizeof(struct string_list_item), compare_by_idx_and_count);
+
+	if (log->join_uids && log->email)
+		qsort(log->emails.items, log->emails.nr,
+		      sizeof(struct string_list_item), compare_by_idx_and_count);
+
+	for (i =3D 0, j =3D 0; ; i++) {
+		static int idx =3D -1;
+		static const struct idinfo *info =3D NULL;
+		while (i < log->names.nr &&
+		       (info =3D log->names.items[i].util)->idx =3D=3D idx)
+			i++;
+		if (!info || info->idx =3D=3D idx)
+			break;
+		idx =3D info->idx;
+		if (log->join_uids && log->email) {
+			int len;
+			char *name, *email, *newname;
+			while (j < log->emails.nr &&
+			       (info =3D log->emails.items[j].util)->idx !=3D idx)
+				j++;
+			if (j =3D=3D log->emails.nr)
+				die("Could not find email address for '%s'",
+				    log->names.items[i].string);
+			name =3D log->names.items[i].string;
+			email =3D log->emails.items[j].string;
+			len =3D strlen(name) + strlen(email) + 4;
+			newname =3D xmalloc(len);
+			snprintf(newname, len, "%s <%s>", name, email);
+			free(name);
+			log->names.items[i].string =3D newname;
+		}
+		log->all_lines[idx].items[0].util =3D log->names.items[i].string;
+	}
+
+	qsort(log->all_lines, log->nr, sizeof(struct string_list),
+	      log->sort_by_number ? compare_by_nr : compare_by_first_util_str=
);
+
+	for (i =3D 0; i < log->nr; i++) {
+		const char *name;
+		struct string_list *onelines =3D &log->all_lines[i];
+
+		if (onelines->nr =3D=3D 0)
+			/* There can be empty lists for merged names. */
+			continue;
+		else
+			name =3D onelines->items[0].util;
+
 		if (log->summary) {
-			printf("%6d\t%s\n", onelines->nr, log->list.items[i].string);
+			printf("%6d\t%s\n", onelines->nr, name);
 		} else {
-			printf("%s (%d):\n", log->list.items[i].string, onelines->nr);
+			printf("%s (%d):\n", name, onelines->nr);
 			for (j =3D onelines->nr - 1; j >=3D 0; j--) {
 				const char *msg =3D onelines->items[j].string;
=20
@@ -308,15 +520,13 @@ void shortlog_output(struct shortlog *log)
 			}
 			putchar('\n');
 		}
-
 		onelines->strdup_strings =3D 1;
 		string_list_clear(onelines, 0);
-		free(onelines);
-		log->list.items[i].util =3D NULL;
-	}
-
-	log->list.strdup_strings =3D 1;
-	string_list_clear(&log->list, 1);
+	}
+
+	free(log->all_lines);
+	string_list_clear(&log->names, 1);
+	string_list_clear(&log->emails, 1);
 	log->mailmap.strdup_strings =3D 1;
 	string_list_clear(&log->mailmap, 1);
 }
diff --git a/shortlog.h b/shortlog.h
index bc02cc2..f539bf0 100644
--- a/shortlog.h
+++ b/shortlog.h
@@ -4,18 +4,24 @@
 #include "string-list.h"
=20
 struct shortlog {
-	struct string_list list;
 	int summary;
 	int wrap_lines;
 	int sort_by_number;
 	int wrap;
 	int in1;
 	int in2;
-	int user_format;
-
+	int email;
+	int join_uids;
+
+	int user_format;
 	char *common_repo_prefix;
-	int email;
 	struct string_list mailmap;
+
+	int nr, alloc;
+	int commit_count;
+	struct string_list names;
+	struct string_list emails;
+	struct string_list *all_lines;
 };
=20
 void shortlog_init(struct shortlog *log);
--=20
1.6.1.134.g55c35

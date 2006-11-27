X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] (experimental) per-topic shortlog.
Date: Sun, 26 Nov 2006 16:44:18 -0800
Message-ID: <7v8xhxsopp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 27 Nov 2006 00:44:31 +0000 (UTC)
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32374>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoUbh-0007gU-0x for gcvg-git@gmane.org; Mon, 27 Nov
 2006 01:44:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755628AbWK0AoV convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006 19:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755650AbWK0AoV
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 19:44:21 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:37555 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S1755627AbWK0AoU
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006
 19:44:20 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061127004419.IFAN9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Sun, 26
 Nov 2006 19:44:19 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id rckT1V00W1kojtg0000000; Sun, 26 Nov 2006
 19:44:28 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

This implements an experimental "git log-fpc" command that shows
short-log style output sorted by topics.

A "topic" is identified by going through the first-parent
chains; this ignores the fast-forward case, but for a top-level
integrator it often is good enough.

=46or example, if the commit ancestry graph looks like this:

         x---x---x---X---o---*---o---o---o HEAD
          \                 /
           o---o---o---o---o

and the command line asks for

	git log-fpc --no-merges X..

It first finds all the commits 'o'.  Then it emits the four
commits on the upper line (assume the merge '*' has the commit
that is a child of X as its first parent in the picture).  When
it does so, it the list of authors for these four commits on one
line, followed by the title of these commits.  After that, it
does the same for the five commits on the lower line.

---

I initially wanted to do this inside Johannes's enhanced
shortlog, but ended up doing this as a pretty much independent
thing, because the shortlog implementation stringifies the
information from the commits too early to be easily enhanced for
this purpose.

If this turns out to be a better way to present shortlog,
however, this should become an option to git-shortlog.

A sample output from:

	git log-fpc --no-merges v1.4.4.1..f64d7fd2

looks like this (f64d7fd2 was the tip of master when the last
"What's in" message was sent out).  It shows that many "fixes"
and git-svn enhancements were directly done on "master" (that is
the first group), while many gitweb enhancements, changing the
output from "prune -n", "git branch" enhancements, etc. were
first cooked in separate topic branches and then later merged
into 'master'.

To this output, I can manually add a topic title to the
beginning of each group and it would make a better overview than
what I currently send out in "What's in" message which is
generated with shortlog.

----------------------------------------------------------------

Eric Wong (6), Junio C Hamano (5), Lars Hjemli, Jakub Narebski,
 I=F1aki Arenaza, Petr Baudis, Andy Parkins, and Ren=E9 Scharfe
 git-fetch: exit with non-zero status when fast-forward check fails
 git-svn: exit with status 1 for test failures
 git-svn: correctly access repos when only given partial read permissio=
ns
 git-branch -D: make it work even when on a yet-to-be-born branch
 Add -v and --abbrev options to git-branch
 git-clone: stop dumb protocol from copying refs outside heads/ and tag=
s/.
 gitweb: (style) use chomp without parentheses consistently.
 gitweb: Replace SPC with &nbsp; also in tag comment
 git-svn: handle authentication without relying on cached tokens on dis=
k
 git-cvsimport: add support for CVS pserver method HTTP/1.x proxying
 Make git-clone --use-separate-remote the default
 refs outside refs/{heads,tags} match less strongly.
 Increase length of function name buffer
 git-svn: preserve uncommitted changes after dcommit
 git-svn: correctly handle revision 0 in SVN repositories
 git-svn: error out from dcommit on a parent-less commit
 archive-zip: don't use sizeof(struct ...)

Junio C Hamano and Andy Parkins
 Typefix builtin-prune.c::prune_object()
 Improve git-prune -n output

Peter Baumann
 config option log.showroot to show the diff of root commits

Andy Parkins
 Add support to git-branch to show local and remote branches

Jakub Narebski (7)
 gitweb: Finish restoring "blob" links in git_difftree_body
 gitweb: Refactor feed generation, make output prettier, add Atom feed
 gitweb: Add an option to href() to return full URL
 gitweb: New improved formatting of chunk header in diff
 gitweb: Default to $hash_base or HEAD for $hash in "commit" and "commi=
tdiff"
 gitweb: Buffer diff header to deal with split patches + git_patchset_b=
ody refactoring
 gitweb: Protect against possible warning in git_commitdiff

----------------------------------------------------------------

 builtin-log.c |  177 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 builtin.h     |    1 +
 git.c         |    1 +
 3 files changed, 179 insertions(+), 0 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 7acf5d3..1c2838c 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -99,6 +99,183 @@ int cmd_log(int argc, const char **argv, const char=
 *prefix)
 	return cmd_log_walk(&rev);
 }
=20
+/* bits #0..7 in revision.h, #8..11 in commit.c */
+#define FPC_RESULT (1u<<12)
+#define FPC_SHOWN  (1u<<13)
+
+struct author_record {
+	char *name;
+	int count;
+};
+struct author_count {
+	int nr, alloc;
+	struct author_record **au;
+};
+
+static int cmp_count(const void *a_, const void *b_)
+{
+	struct author_record **a =3D (struct author_record **) a_;
+	struct author_record **b =3D (struct author_record **) b_;
+	return (*b)->count - (*a)->count;
+}
+
+static void add_author(struct commit *c, struct author_count *ac)
+{
+	const char *buf =3D c->buffer;
+	char *au =3D strstr(buf, "\nauthor ");
+	char *eon;
+	struct author_record *ar;
+	int i;
+
+	if (!au)
+		return; /* oops */
+	au +=3D 7;
+	while (*au && isspace(*au))
+		au++;
+	if (!*au)
+		return; /* oops */
+	eon =3D strchr(au, '<');
+	if (!eon)
+		return; /* oops */
+	while (au < --eon && isspace(*eon))
+		; /* back back back... */
+	eon++;
+	for (i =3D 0; i < ac->nr; i++)
+		if (!strncmp(ac->au[i]->name, au, eon-au) &&
+		    strlen(ac->au[i]->name) =3D=3D eon - au) {
+			/* found it */
+			ac->au[i]->count++;
+			return;
+		}
+	if (ac->alloc <=3D ac->nr) {
+		ac->alloc =3D alloc_nr(ac->alloc);
+		ac->au =3D xrealloc(ac->au, sizeof(struct author_record *) *
+				  ac->alloc);
+	}
+	ar =3D xcalloc(1, sizeof(struct author_record));
+	ar->name =3D xmalloc(eon - au + 1);
+	memcpy(ar->name, au, eon - au);
+	ar->name[eon - au] =3D 0;
+	ar->count =3D 1;
+	ac->au[ac->nr++] =3D ar;
+}
+
+static void show_fpc(struct object_array *list)
+{
+	int i;
+	struct author_count ac;
+
+	if (!list->nr)
+		return;
+	memset(&ac, 0, sizeof(ac));
+	for (i =3D 0; i < list->nr; i++)
+		add_author((struct commit *) list->objects[i].item, &ac);
+	qsort(ac.au, ac.nr, sizeof(struct author_record *), cmp_count);
+
+	for (i =3D 0; i < ac.nr; i++) {
+		if (i) {
+			if (i < ac.nr - 1)
+				fputs(", ", stdout);
+			else if (ac.nr !=3D 2)
+				fputs(", and ", stdout);
+			else
+				fputs(" and ", stdout);
+		}
+		if (ac.au[i]->count < 2)
+			printf("%s", ac.au[i]->name);
+		else
+			printf("%s (%d)", ac.au[i]->name, ac.au[i]->count);
+		free(ac.au[i]->name);
+		free(ac.au[i]);
+	}
+	free(ac.au);
+	putchar('\n');
+
+	for (i =3D 0; i < list->nr; i++) {
+		struct commit *c =3D (struct commit *) list->objects[i].item;
+		char *buf =3D c->buffer;
+		char *it =3D "<unnamed>";
+		int len =3D strlen(it);
+		buf =3D strstr(buf, "\n\n");
+		if (buf) {
+			char *lineend;
+			while (*buf && isspace(*buf))
+				buf++;
+			if (!*buf)
+				goto emit;
+			lineend =3D strchr(buf, '\n');
+			if (!lineend)
+				goto emit;
+			while (buf < lineend && isspace(*lineend))
+				lineend--;
+			len =3D lineend - buf + 1;
+			it =3D buf;
+		}
+	emit:
+		printf(" %.*s\n", len, it);
+	}
+	putchar('\n');
+}
+
+int cmd_log_fpc(int argc, const char **argv, const char *prefix)
+{
+	struct rev_info rev;
+	struct commit *c;
+	struct object_array result =3D { 0, 0, NULL };
+	int i;
+
+	git_config(git_log_config);
+	init_revisions(&rev, prefix);
+	rev.always_show_header =3D 1;
+	cmd_log_init(argc, argv, prefix, &rev);
+
+	prepare_revision_walk(&rev);
+	while ((c =3D get_revision(&rev)) !=3D NULL)
+		add_object_array(&(c->object), NULL, &result);
+
+	/* clear flags and mark them "relevant" */
+	for (i =3D 0; i < result.nr; i++)
+		result.objects[i].item->flags |=3D FPC_RESULT;
+
+	for (;;) {
+		struct object_array current;
+
+		for (i =3D 0; i < result.nr; i++) {
+			if (!(result.objects[i].item->flags & FPC_SHOWN))
+				break;
+		}
+		if (i >=3D result.nr)
+			break;
+
+		memset(&current, 0, sizeof(current));
+		c =3D (struct commit *) result.objects[i].item;
+		while (c) {
+			int flags =3D c->object.flags;
+
+			if ((flags & (FPC_RESULT|FPC_SHOWN)) =3D=3D FPC_RESULT) {
+				add_object_array(&(c->object), NULL, &current);
+				c->object.flags |=3D FPC_SHOWN;
+			}
+			if (!c->object.parsed)
+				parse_object(c->object.sha1);
+			if (!c->parents)
+				break;
+			c =3D c->parents->item;
+		}
+
+		/* Finally, show the series. */
+		show_fpc(&current);
+	}
+
+	/* free them */
+	for (i =3D 0; i < result.nr; i++) {
+		c =3D (struct commit *) result.objects[i].item;
+		free(c->buffer);
+		free_commit_list(c->parents);
+	}
+	return 0;
+}
+
 static int istitlechar(char c)
 {
 	return (c >=3D 'a' && c <=3D 'z') || (c >=3D 'A' && c <=3D 'Z') ||
diff --git a/builtin.h b/builtin.h
index 43fed32..a94540d 100644
--- a/builtin.h
+++ b/builtin.h
@@ -38,6 +38,7 @@ extern int cmd_grep(int argc, const char **argv, cons=
t char *prefix);
 extern int cmd_help(int argc, const char **argv, const char *prefix);
 extern int cmd_init_db(int argc, const char **argv, const char *prefix=
);
 extern int cmd_log(int argc, const char **argv, const char *prefix);
+extern int cmd_log_fpc(int argc, const char **argv, const char *prefix=
);
 extern int cmd_ls_files(int argc, const char **argv, const char *prefi=
x);
 extern int cmd_ls_tree(int argc, const char **argv, const char *prefix=
);
 extern int cmd_mailinfo(int argc, const char **argv, const char *prefi=
x);
diff --git a/git.c b/git.c
index 1aa07a5..65d98bd 100644
--- a/git.c
+++ b/git.c
@@ -243,6 +243,7 @@ static void handle_internal_command(int argc, const=
 char **argv, char **envp)
 		{ "help", cmd_help },
 		{ "init-db", cmd_init_db },
 		{ "log", cmd_log, RUN_SETUP | USE_PAGER },
+		{ "log-fpc", cmd_log_fpc, RUN_SETUP | USE_PAGER },
 		{ "ls-files", cmd_ls_files, RUN_SETUP },
 		{ "ls-tree", cmd_ls_tree, RUN_SETUP },
 		{ "mailinfo", cmd_mailinfo },
--=20
1.4.4.1.ge3fb


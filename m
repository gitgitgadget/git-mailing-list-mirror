From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH] tagger id
Date: Mon, 11 Jul 2005 22:39:25 -0600
Message-ID: <m1slyk63k2.fsf_-_@ebiederm.dsl.xmission.com>
References: <Pine.LNX.4.58.0507101814210.17536@g5.osdl.org>
	<m1eka574c8.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0507110958400.17536@g5.osdl.org>
	<m1vf3gzvvd.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0507111815180.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 12 06:43:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsCby-0008BM-DE
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 06:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262340AbVGLEmM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jul 2005 00:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262365AbVGLEmL
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jul 2005 00:42:11 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52883 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262340AbVGLEjl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2005 00:39:41 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j6C4dSVd024807;
	Mon, 11 Jul 2005 22:39:28 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j6C4dPTo024806;
	Mon, 11 Jul 2005 22:39:25 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507111815180.17536@g5.osdl.org> (Linus
 Torvalds's message of "Mon, 11 Jul 2005 18:15:52 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This patch adds a command git-id for use on
the command line to see what git will set your id too,
and for use in scripts (git-tag-script) so they can get your git id.

The common code for computing the git-id is moved to ident.c

Fix parse_date to not mind being passed a constant date
to parse.

The code to compute the identifier has been restructured
to at least make a reasonable stab at error handling.  The
original version had so many unchecked return values it was
just scary to think about.

Eric

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -47,7 +47,7 @@ PROG=   git-update-cache git-diff-files 
 	git-diff-stages git-rev-parse git-patch-id git-pack-objects \
 	git-unpack-objects git-verify-pack git-receive-pack git-send-pack \
 	git-prune-packed git-fetch-pack git-upload-pack git-clone-pack \
-	git-show-index
+	git-show-index git-id
 
 all: $(PROG)
 
@@ -57,7 +57,7 @@ install: $(PROG) $(SCRIPTS)
 
 LIB_OBJS=read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o \
 	 tag.o date.o index.o diff-delta.o patch-delta.o entry.o path.o \
-	 epoch.o refs.o csum-file.o pack-check.o pkt-line.o connect.o
+	 epoch.o refs.o csum-file.o pack-check.o pkt-line.o connect.o ident.o
 LIB_FILE=libgit.a
 LIB_H=cache.h object.h blob.h tree.h commit.h tag.h delta.h epoch.h csum-file.h \
 	pack.h pkt-line.h refs.h
diff --git a/cache.h b/cache.h
--- a/cache.h
+++ b/cache.h
@@ -208,9 +208,14 @@ extern void *read_object_with_reference(
 					unsigned char *sha1_ret);
 
 const char *show_date(unsigned long time, int timezone);
-void parse_date(char *date, char *buf, int bufsize);
+void parse_date(const char *date, char *buf, int bufsize);
 void datestamp(char *buf, int bufsize);
 
+int git_ident(char *buf, size_t bufsize,
+	const char *env_name, const char *env_email, const char *env_date);
+int git_committer_ident(char *buf, size_t bufsize);
+int git_author_ident(char *buf, size_t bufsize);
+
 static inline void *xmalloc(size_t size)
 {
 	void *ret = malloc(size);
diff --git a/commit-tree.c b/commit-tree.c
--- a/commit-tree.c
+++ b/commit-tree.c
@@ -5,9 +5,10 @@
  */
 #include "cache.h"
 
-#include <pwd.h>
 #include <time.h>
 #include <ctype.h>
+#include <string.h>
+#include <errno.h>
 
 #define BLOCKING (1ul << 14)
 
@@ -45,39 +46,6 @@ static void add_buffer(char **bufp, unsi
 	memcpy(buf + size, one_line, len);
 }
 
-static void remove_special(char *p)
-{
-	char c;
-	char *dst = p, *src = p;
-
-	for (;;) {
-		c = *src;
-		src++;
-		switch(c) {
-		case '\n': case '<': case '>':
-			continue;
-		}
-		*dst++ = c;
-		if (!c)
-			break;
-	}
-
-	/*
-	 * Go back, and remove crud from the end: some people
-	 * have commas etc in their gecos field
-	 */
-	dst--;
-	while (--dst >= p) {
-		unsigned char c = *dst;
-		switch (c) {
-		case ',': case ';': case '.':
-			*dst = 0;
-			continue;
-		}
-		break;
-	}
-}
-
 static void check_valid(unsigned char *sha1, const char *expect)
 {
 	void *buf;
@@ -114,16 +82,13 @@ static int new_parent(int idx)
 
 int main(int argc, char **argv)
 {
-	int i, len;
+	int i;
 	int parents = 0;
 	unsigned char tree_sha1[20];
 	unsigned char commit_sha1[20];
-	char *gecos, *realgecos, *commitgecos;
-	char *email, *commitemail, realemail[1000];
-	char date[50], realdate[50];
-	char *audate, *cmdate;
+	char committer[1000];
+	char author[1000];
 	char comment[1000];
-	struct passwd *pw;
 	char *buffer;
 	unsigned int size;
 
@@ -142,35 +107,12 @@ int main(int argc, char **argv)
 	}
 	if (!parents)
 		fprintf(stderr, "Committing initial tree %s\n", argv[1]);
-	pw = getpwuid(getuid());
-	if (!pw)
-		die("You don't exist. Go away!");
-	realgecos = pw->pw_gecos;
-	len = strlen(pw->pw_name);
-	memcpy(realemail, pw->pw_name, len);
-	realemail[len] = '@';
-	gethostname(realemail+len+1, sizeof(realemail)-len-1);
-	if (!strchr(realemail+len+1, '.')) {
-		strcat(realemail, ".");
-		getdomainname(realemail+strlen(realemail), sizeof(realemail)-strlen(realemail)-1);
+	if (git_author_ident(author, sizeof(author)) < 0) {
+		die("Bad author! %s", strerror(errno));
+	}
+	if (git_committer_ident(committer, sizeof(committer)) < 0) {
+		die("Bad Committer! %s", strerror(errno));
 	}
-
-	datestamp(realdate, sizeof(realdate));
-	strcpy(date, realdate);
-
-	commitgecos = gitenv("GIT_COMMITTER_NAME") ? : realgecos;
-	commitemail = gitenv("GIT_COMMITTER_EMAIL") ? : realemail;
-	gecos = gitenv("GIT_AUTHOR_NAME") ? : realgecos;
-	email = gitenv("GIT_AUTHOR_EMAIL") ? : realemail;
-	audate = gitenv("GIT_AUTHOR_DATE");
-	if (audate)
-		parse_date(audate, date, sizeof(date));
-	cmdate = gitenv("GIT_COMMITTER_DATE");
-	if (cmdate)
-		parse_date(cmdate, realdate, sizeof(realdate));
-
-	remove_special(gecos); remove_special(realgecos); remove_special(commitgecos);
-	remove_special(email); remove_special(realemail); remove_special(commitemail);
 
 	init_buffer(&buffer, &size);
 	add_buffer(&buffer, &size, "tree %s\n", sha1_to_hex(tree_sha1));
@@ -184,8 +126,8 @@ int main(int argc, char **argv)
 		add_buffer(&buffer, &size, "parent %s\n", sha1_to_hex(parent_sha1[i]));
 
 	/* Person/date information */
-	add_buffer(&buffer, &size, "author %s <%s> %s\n", gecos, email, date);
-	add_buffer(&buffer, &size, "committer %s <%s> %s\n\n", commitgecos, commitemail, realdate);
+	add_buffer(&buffer, &size, "author %s <%s> %s\n", author);
+	add_buffer(&buffer, &size, "committer %s <%s> %s\n\n", committer);
 
 	/* And add the comment */
 	while (fgets(comment, sizeof(comment), stdin) != NULL)
diff --git a/date.c b/date.c
--- a/date.c
+++ b/date.c
@@ -224,7 +224,7 @@ static int is_date(int year, int month, 
 	return 0;
 }
 
-static int match_multi_number(unsigned long num, char c, char *date, char *end, struct tm *tm)
+static int match_multi_number(unsigned long num, char c, const char *date, char *end, struct tm *tm)
 {
 	long num2, num3;
 
@@ -270,7 +270,7 @@ static int match_multi_number(unsigned l
 /*
  * We've seen a digit. Time? Year? Date? 
  */
-static int match_digit(char *date, struct tm *tm, int *offset, int *tm_gmt)
+static int match_digit(const char *date, struct tm *tm, int *offset, int *tm_gmt)
 {
 	int n;
 	char *end;
@@ -361,7 +361,7 @@ static int match_digit(char *date, struc
 	return n;
 }
 
-static int match_tz(char *date, int *offp)
+static int match_tz(const char *date, int *offp)
 {
 	char *end;
 	int offset = strtoul(date+1, &end, 10);
@@ -388,7 +388,7 @@ static int match_tz(char *date, int *off
 
 /* Gr. strptime is crap for this; it doesn't have a way to require RFC2822
    (i.e. English) day/month names, and it doesn't work correctly with %z. */
-void parse_date(char *date, char *result, int maxlen)
+void parse_date(const char *date, char *result, int maxlen)
 {
 	struct tm tm;
 	int offset, sign, tm_gmt;
diff --git a/git-tag-script b/git-tag-script
--- a/git-tag-script
+++ b/git-tag-script
@@ -7,6 +7,7 @@ name="$1"
 
 object=${2:-$(cat "$GIT_DIR"/HEAD)}
 type=$(git-cat-file -t $object) || exit 1
+tagger=$(git-id) || exit 1
 
 ( echo "#"
   echo "# Write a tag message"
@@ -17,8 +18,9 @@ grep -v '^#' < .editmsg | git-stripspace
 
 [ -s .tagmsg ] || exit
 
-( echo -e "object $object\ntype $type\ntag $name\n"; cat .tagmsg ) > .tmp-tag
+( echo -e "object $object\ntype $type\ntag $name\ntagger $tagger\n"; cat .tagmsg ) > .tmp-tag
 rm -f .tmp-tag.asc .tagmsg
 gpg -bsa .tmp-tag && cat .tmp-tag.asc >> .tmp-tag
+mkdir -p "$GIT_DIR/refs/tags"
 git-mktag < .tmp-tag > "$GIT_DIR/refs/tags/$name"
 #rm .tmp-tag .tmp-tag.sig
diff --git a/id.c b/id.c
new file mode 100644
--- /dev/null
+++ b/id.c
@@ -0,0 +1,36 @@
+#include "cache.h"
+#include <stdio.h>
+#include <errno.h>
+#include <string.h>
+
+static char *id_usage = "git-id [--author | --committer]";
+
+int main(int argc, char **argv)
+{
+	char buf[1000];
+	int (*ident)(char *buf, size_t bufsize);
+	int i;
+
+	ident = git_committer_ident;
+	for(i = 1; i < argc; i++) {
+		char *arg = argv[i];
+		if (strcmp(arg, "--author") == 0) {
+			ident = git_author_ident;
+		}
+		else if (strcmp(arg, "--committer") == 0) {
+			ident = git_committer_ident;
+		}
+		else {
+			usage(id_usage);
+		}
+	}
+
+
+	if (ident(buf, sizeof(buf)) < 0) {
+		die("Cannot resolve ident: %s\n", strerror(errno));
+	}
+
+	printf("%s\n", buf);
+
+	return 0;
+}
diff --git a/ident.c b/ident.c
new file mode 100644
--- /dev/null
+++ b/ident.c
@@ -0,0 +1,144 @@
+/*
+ * GIT - The information manager from hell
+ *
+ * Copyright (C) Eric Biederman, 2005
+ */
+#include "cache.h"
+
+#include <pwd.h>
+#include <time.h>
+#include <ctype.h>
+#include <errno.h>
+#include <string.h>
+#include <stdio.h>
+
+#define MAX_NAME 1000
+#define MAX_EMAIL 1000
+#define MAX_DATE 50
+static void remove_special(char *p)
+{
+	char c;
+	char *dst = p, *src = p;
+
+	for (;;) {
+		c = *src;
+		src++;
+		switch(c) {
+		case '\n': case '<': case '>':
+			continue;
+		}
+		*dst++ = c;
+		if (!c)
+			break;
+	}
+
+	/*
+	 * Go back, and remove crud from the end: some people
+	 * have commas etc in their gecos field
+	 */
+	dst--;
+	while (--dst >= p) {
+		unsigned char c = *dst;
+		switch (c) {
+		case ',': case ';': case '.':
+			*dst = 0;
+			continue;
+		}
+		break;
+	}
+}
+
+int git_ident(char *buf, size_t bufsize,
+	const char *env_name, const char *env_email, const char *env_date)
+{
+	int len;
+	char name[MAX_NAME];
+	char email[MAX_EMAIL];
+	char date[MAX_DATE];
+	struct passwd *pw;
+	int count;
+	
+	/* Lookup the user in the password file */
+	pw = getpwuid(getuid());
+	if (!pw)
+		return -1;
+
+	/* Get the users full name */
+	strncpy(name, pw->pw_gecos, sizeof(name));
+	name[sizeof(name) - 1] = '\0';
+
+	/* Get the email address with error handling */
+	len = strlen(pw->pw_name);
+	if (len >= (sizeof(email) - 2)) {
+		/* Bad user name length */
+		errno = ENOMEM;
+		return -1;
+	}
+	memcpy(email, pw->pw_name, len);
+	email[len] = '@';
+	email[len + 1] = '\0';
+
+	if (gethostname(email+len+1, sizeof(email)-len-1) < 0) {
+		return -1;
+	}
+	email[sizeof(email) - 1] = '\0';
+	len = strlen(email);
+	if (!strchr(email+len+1, '.')) {
+		if (len >= (sizeof(email) - 1)) {
+			errno = ENOMEM;
+			return -1;
+		}
+		email[len] = '.';
+		if (getdomainname(email+len+1, sizeof(email) - len - 1) < 0) {
+			return -1;
+		}
+	}
+	/* Get the date */
+	datestamp(date, sizeof(date));
+
+	if (env_name) {
+		strncpy(name, env_name, sizeof(name));
+		name[sizeof(name) - 1] = '\0';
+	}
+	if (env_email) {
+		strncpy(email, env_email, sizeof(email));
+		email[sizeof(email) - 1] = '\0';
+	}
+	if (env_date) {
+		parse_date(env_date, date, sizeof(date));
+	}
+	remove_special(name);
+	remove_special(email);
+	count = snprintf(buf, bufsize, "%s <%s> %s", name, email, date);
+	if (count > bufsize) {
+		errno = ENOMEM;
+		return -1;
+	}
+	if (count < 0) {
+		return -1;
+	}
+	return 0;
+}
+
+int git_committer_ident(char *buf, size_t bufsize)
+{
+	const char *name;
+	const char *email;
+	const char *date;
+	name  = gitenv("GIT_COMMITTER_NAME");
+	email = gitenv("GIT_COMMITTER_EMAIL");
+	date  = gitenv("GIT_COMMITTER_DATE");
+	return git_ident(buf, bufsize, name, email, date);
+}
+
+int git_author_ident(char *buf, size_t bufsize)
+{
+	const char *name;
+	const char *email;
+	const char *date;
+	name  = gitenv("GIT_AUTHOR_NAME");
+	email = gitenv("GIT_AUTHOR_EMAIL");
+	date  = gitenv("GIT_AUTHOR_DATE");
+	return git_ident(buf, bufsize, name, email, date);
+}
+
diff --git a/mktag.c b/mktag.c
--- a/mktag.c
+++ b/mktag.c
@@ -42,7 +42,7 @@ static int verify_tag(char *buffer, unsi
 	int typelen;
 	char type[20];
 	unsigned char sha1[20];
-	const char *object, *type_line, *tag_line;
+	const char *object, *type_line, *tag_line, *tagger_line;
 
 	if (size < 64 || size > MAXSIZE-1)
 		return -1;
@@ -92,6 +92,12 @@ static int verify_tag(char *buffer, unsi
 		return -1;
 	}
 
+	/* Verify the tagger line */
+	tagger_line = tag_line;
+	
+	if (memcmp(tagger_line, "tagger", 6) || (tagger_line[6] == '\n'))
+		return -1;
+
 	/* The actual stuff afterwards we don't care about.. */
 	return 0;
 }
@@ -119,7 +125,7 @@ int main(int argc, char **argv)
 		size += ret;
 	}
 
-	// Verify it for some basic sanity: it needs to start with "object <sha1>\ntype "
+	// Verify it for some basic sanity: it needs to start with "object <sha1>\ntype\ntagger "
 	if (verify_tag(buffer, size) < 0)
 		die("invalid tag signature file");
 

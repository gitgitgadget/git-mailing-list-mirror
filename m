From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 00/17] Peace with CRLF
Date: Wed, 16 Dec 2015 14:03:01 -0800
Message-ID: <1450303398-25900-1-git-send-email-gitster@pobox.com>
References: <1446071161-15610-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 16 23:04:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9KBD-0001uL-MM
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 23:04:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755468AbbLPWDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 17:03:22 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57799 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751906AbbLPWDV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 17:03:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 00813325AC;
	Wed, 16 Dec 2015 17:03:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Ig/p
	F9Q0m1EFUAs51mcnFSgxeIo=; b=gXn3DYMgHPHzT8ZcO2bGWZOlzWh1Z/HgfHC1
	ccb1stpITdR1dWRNh71mkww1dzAnnhomGiseJjnhO44WZtp0b+Eev0bxI/+kirUu
	QcblCmzf7RkQ18y00JSTRa95k07gjZd8uPdNYJe425K5dwfpJa7j1agNy2r5VlMQ
	Af3R50U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=C2RvUK
	PZ7zM5KeO7wrt+E0CPzagi77zZNPT+UtokK8cBVizkSws7hJsQuLmUMAspOWjgh6
	MFSvHgsBugdTS5RR91656B4Jy9UDGw9ZV+IZgamK0itbfkPQ5SZW4DLtCdleQNLW
	NbGCv6tjUVgaAvFERMZRH6zkTQn3gvWe/VHcQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EB0EA325AB;
	Wed, 16 Dec 2015 17:03:19 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 39B78325A9;
	Wed, 16 Dec 2015 17:03:19 -0500 (EST)
X-Mailer: git-send-email 2.7.0-rc1-83-ga8b6b9e
In-Reply-To: <1446071161-15610-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D0CB1FF0-A440-11E5-B4D5-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282614>

We have too many topics titled "War on something"; let's try to make
peace for a change.

This is a reroll with small changes of the previous one that appears
here:

  http://thread.gmane.org/gmane.comp.version-control.git/280401

which is a continuation to $gmane/275735, which is filed in the
archive under another mailing list:

  http://thread.gmane.org/gmane.comp.version-control.msysgit/21773

We read "text" files from filesystem (or from the standard input) in
various places in the code.  Some of them are written by us, but
others are often prepared by an editor driven by human user.  Even
though we write (and expect) lines in these text files to be
terminated with LF (not CRLF), the end-user's editor can be told to
use CRLF termination, and on some platforms that may be the default.

Because many codepaths (e.g. commit log message) first pass the
contents of such a file through stripspace(), and as a side effect
of discarding the whitespace at the end of each line, lines
terminated with CRLF are normalized to LF terminated lines (but we
do not lose a lone CR in the middle of a non-blank string), this is
not a problem in many codepaths.  But not all of the codepaths are
safe.

Typically, we use strbuf_getline() to read these "text" files, which
reads a single line up to the first LF into a buffer, discard that
LF at the end, and returns (an incomplete last line gets returned
as-is).  In theory, these places that expect to read "text", we
should be able to update the logic to read a line up to the first
LF, discard that LF, together with a CR if one appears immediately
before that LF, without breaking anything.

I inspected all the callsites of this function to see if it is safe
to use such an updated logic at these callsites, and did not find
anything problematic.  I could update strbuf_getline() in place, but
just to be extra careful, this series instead introduces another
helper, strbuf_getline_crlf(), that is aware of this CRLF business,
and convert the ones that are safe to update as we verify.

 * This series converts only the callers of strbuf_getline() that
   would misbehave when fed a file with CRLF-terminated lines and
   use the data with an unwanted CR appended at the end.  With the
   update the code should work as intended with such a file, without
   breaking the expected behaviour when working on a file with
   LF-terminated lines.

 * Callers of strbuf_getline() that expect to only read from our own
   output do not have to accommodate CRLF-terminated lines, but they
   can be updated to do so safely if we do not rely on the ability
   to express a payload that has CR at the end.  For example, the
   insn sheet "rebase -i" uses typically ends each line with a
   commit log summary that we ourselves do not read or use, so even
   if the end-user on a platform with LF lines deliberately does
   insert \r at the end of the line and strbuf_gets() removed that
   \r from the payload, no unexpected behaviour should happen.

   This series does not touch them, but it may be a good GSoC
   microproject to convert them to use strbuf_getline_crlf().

 * Callers of strbuf_getline() that call strbuf_trim() immediately
   on the result before doing anything, or otherwise have logic that
   tolerates whitespaces at the end of the line, can continue using
   strbuf_getline() and will not misbehave on CRLF-terminated lines.

   This series does not touch them; converting them to use
   strbuf_getline_crlf() would a good way to document them as
   dealing with "text".  While doing so, they can also lose their
   custom logic that happens to make CRLF-terminated lines work.

 * A caller of strbuf_getline() that wants to only see LF-terminated
   lines (in other words, "ABC\r\n" must be treated as a line with 4
   bytes payload on it, A B C and CR), would be broken if we replace
   it with strbuf_getline_crlf().  This series does not touch them,
   and no follow-up series should, either.

An ideal endgame would be to retire the current strbuf_getline() and
use strbuf_getline_crlf() everywhere.  For that to happen, follow-up
topics to cover the second and the third class of callers above need
to show that there is no remaining callers to strbuf_getline() that
falls into the fourth category.

Even better, once you say "line", as in strbuf_getline(), you ought
to be talking about "text", so we could rename strbuf_getline_crlf()
back to strbuf_getline() after all of the above happens.


Junio C Hamano (17):
  strbuf: make strbuf_getline_crlf() global
  check-attr, check-ignore, checkout-index: read paths with
    strbuf_getline_crlf()
  update-index: read --index-info with strbuf_getline_crlf()
  update-index: read list of paths with strbuf_getline_crlf() under
    --stdin
  mktree: read textual tree representation with strbuf_getline_crlf()
  hash-object: read --stdin-paths with strbuf_getline_crlf()
  revision: read --stdin with strbuf_getline_crlf()
  rev-parse: read parseopt spec with strbuf_getline_crlf()
  ident.c: read /etc/mailname with strbuf_getline_crlf()
  remote.c: read $GIT_DIR/remotes/* with strbuf_getline_crlf()
  clone/sha1_file: read info/alternates with strbuf_getline_crlf()
  transport-helper: read helper response with strbuf_getline_crlf()
  cat-file: read batch stream with strbuf_getline_crlf()
  column: read lines with strbuf_getline_crlf()
  send-pack: read list of refs with strbuf_getline_crlf()
  grep: read -f file with strbuf_getline_crlf()
  test-sha1-array: read command stream with strbuf_getline_crlf()

 builtin/am.c             | 15 ---------------
 builtin/cat-file.c       |  2 +-
 builtin/check-attr.c     |  4 +++-
 builtin/check-ignore.c   |  5 ++++-
 builtin/checkout-index.c |  4 +++-
 builtin/clone.c          |  2 +-
 builtin/column.c         |  2 +-
 builtin/grep.c           |  2 +-
 builtin/hash-object.c    |  2 +-
 builtin/mktree.c         |  4 +++-
 builtin/rev-parse.c      |  4 ++--
 builtin/send-pack.c      |  2 +-
 builtin/update-index.c   |  9 +++++++--
 ident.c                  |  2 +-
 remote.c                 |  2 +-
 revision.c               |  9 ++-------
 sha1_file.c              |  2 +-
 strbuf.c                 | 16 ++++++++++++++--
 strbuf.h                 |  7 +++++++
 test-sha1-array.c        |  2 +-
 transport-helper.c       |  2 +-
 21 files changed, 56 insertions(+), 43 deletions(-)

-- 
2.7.0-rc1-83-ga8b6b9e


The interdiff between this round and v1 follows.

diff --git a/builtin/am.c b/builtin/am.c
index 9376d5e..94a533a 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -612,7 +612,7 @@ static int is_mail(FILE *fp)
 	if (regcomp(&regex, header_regex, REG_NOSUB | REG_EXTENDED))
 		die("invalid pattern: %s", header_regex);
 
-	while (!strbuf_gets(&sb, fp)) {
+	while (!strbuf_getline_crlf(&sb, fp)) {
 		if (!sb.len)
 			break; /* End of header */
 
@@ -659,7 +659,7 @@ static int detect_patch_format(const char **paths)
 
 	fp = xfopen(*paths, "r");
 
-	while (!strbuf_gets(&l1, fp)) {
+	while (!strbuf_getline_crlf(&l1, fp)) {
 		if (l1.len)
 			break;
 	}
@@ -680,9 +680,9 @@ static int detect_patch_format(const char **paths)
 	}
 
 	strbuf_reset(&l2);
-	strbuf_gets(&l2, fp);
+	strbuf_getline_crlf(&l2, fp);
 	strbuf_reset(&l3);
-	strbuf_gets(&l3, fp);
+	strbuf_getline_crlf(&l3, fp);
 
 	/*
 	 * If the second line is empty and the third is a From, Author or Date
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index e79097d..a2e75ad 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -401,7 +401,7 @@ static int batch_objects(struct batch_options *opt)
 	save_warning = warn_on_object_refname_ambiguity;
 	warn_on_object_refname_ambiguity = 0;
 
-	while (strbuf_gets(&buf, stdin) != EOF) {
+	while (strbuf_getline_crlf(&buf, stdin) != EOF) {
 		if (data.split_on_whitespace) {
 			/*
 			 * Split at first whitespace, tying off the beginning
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 72d4bb6..4c44d8f 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -78,7 +78,7 @@ static void check_attr_stdin_paths(const char *prefix, int cnt,
 	strbuf_init(&buf, 0);
 	strbuf_init(&nbuf, 0);
 	while ((line_termination
-		? strbuf_gets(&buf, stdin)
+		? strbuf_getline_crlf(&buf, stdin)
 		: strbuf_getline(&buf, stdin, '\0')) != EOF) {
 		if (line_termination && buf.buf[0] == '"') {
 			strbuf_reset(&nbuf);
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index d36e9bf..862ced1 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -124,7 +124,7 @@ static int check_ignore_stdin_paths(struct dir_struct *dir, const char *prefix)
 	strbuf_init(&nbuf, 0);
 
 	while ((line_termination
-		? strbuf_gets(&buf, stdin)
+		? strbuf_getline_crlf(&buf, stdin)
 		: strbuf_getline(&buf, stdin, '\0')) != EOF) {
 		if (line_termination && buf.buf[0] == '"') {
 			strbuf_reset(&nbuf);
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 8b6be57..27d65f2 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -259,7 +259,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 			die("git checkout-index: don't mix '--all' and '--stdin'");
 
 		while ((line_termination
-			? strbuf_gets(&buf, stdin)
+			? strbuf_getline_crlf(&buf, stdin)
 			: strbuf_getline(&buf, stdin, '\0')) != EOF) {
 			char *p;
 			if (line_termination && buf.buf[0] == '"') {
diff --git a/builtin/clone.c b/builtin/clone.c
index 3d2615c..0a85243 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -339,7 +339,7 @@ static void copy_alternates(struct strbuf *src, struct strbuf *dst,
 	FILE *in = fopen(src->buf, "r");
 	struct strbuf line = STRBUF_INIT;
 
-	while (strbuf_gets(&line, in) != EOF) {
+	while (strbuf_getline_crlf(&line, in) != EOF) {
 		char *abs_path;
 		if (!line.len || line.buf[0] == '#')
 			continue;
diff --git a/builtin/column.c b/builtin/column.c
index e9fe928..3205aa9 100644
--- a/builtin/column.c
+++ b/builtin/column.c
@@ -51,7 +51,7 @@ int cmd_column(int argc, const char **argv, const char *prefix)
 			die(_("--command must be the first argument"));
 	}
 	finalize_colopts(&colopts, -1);
-	while (!strbuf_gets(&sb, stdin))
+	while (!strbuf_getline_crlf(&sb, stdin))
 		string_list_append(&list, sb.buf);
 
 	print_columns(&list, colopts, &copts);
diff --git a/builtin/grep.c b/builtin/grep.c
index ac27690..df162f1 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -562,7 +562,7 @@ static int file_callback(const struct option *opt, const char *arg, int unset)
 	patterns = from_stdin ? stdin : fopen(arg, "r");
 	if (!patterns)
 		die_errno(_("cannot open '%s'"), arg);
-	while (strbuf_gets(&sb, patterns) == 0) {
+	while (strbuf_getline_crlf(&sb, patterns) == 0) {
 		/* ignore empty line like grep does */
 		if (sb.len == 0)
 			continue;
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 46d55e5..57c743d 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -60,7 +60,7 @@ static void hash_stdin_paths(const char *type, int no_filters, unsigned flags,
 {
 	struct strbuf buf = STRBUF_INIT, nbuf = STRBUF_INIT;
 
-	while (strbuf_gets(&buf, stdin) != EOF) {
+	while (strbuf_getline_crlf(&buf, stdin) != EOF) {
 		if (buf.buf[0] == '"') {
 			strbuf_reset(&nbuf);
 			if (unquote_c_style(&nbuf, buf.buf, NULL))
diff --git a/builtin/mktree.c b/builtin/mktree.c
index a55f067..c6cafb6 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -158,7 +158,7 @@ int cmd_mktree(int ac, const char **av, const char *prefix)
 	while (!got_eof) {
 		while (1) {
 			if ((line_termination
-			     ? strbuf_gets(&sb, stdin)
+			     ? strbuf_getline_crlf(&sb, stdin)
 			     : strbuf_getline(&sb, stdin, '\0')) == EOF) {
 				got_eof = 1;
 				break;
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 5317389..f2cf99c 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -386,7 +386,7 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 
 	/* get the usage up to the first line with a -- on it */
 	for (;;) {
-		if (strbuf_gets(&sb, stdin) == EOF)
+		if (strbuf_getline_crlf(&sb, stdin) == EOF)
 			die("premature end of input");
 		ALLOC_GROW(usage, unb + 1, usz);
 		if (!strcmp("--", sb.buf)) {
@@ -399,7 +399,7 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 	}
 
 	/* parse: (<short>|<short>,<long>|<long>)[*=?!]*<arghint>? SP+ <help> */
-	while (strbuf_gets(&sb, stdin) != EOF) {
+	while (strbuf_getline_crlf(&sb, stdin) != EOF) {
 		const char *s;
 		const char *help;
 		struct option *o;
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index ba318c9..02e6e24 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -212,7 +212,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 				argv_array_push(&all_refspecs, buf);
 		} else {
 			struct strbuf line = STRBUF_INIT;
-			while (strbuf_gets(&line, stdin) != EOF)
+			while (strbuf_getline_crlf(&line, stdin) != EOF)
 				argv_array_push(&all_refspecs, line.buf);
 			strbuf_release(&line);
 		}
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 004871b..3a6c5b2 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -474,7 +474,7 @@ static void read_index_info(int line_termination)
 	struct strbuf uq = STRBUF_INIT;
 
 	while ((line_termination
-		? strbuf_gets(&buf, stdin)
+		? strbuf_getline_crlf(&buf, stdin)
 		: strbuf_getline(&buf, stdin, '\0')) != EOF) {
 		char *ptr, *tab;
 		char *path_name;
@@ -1077,7 +1077,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		setup_work_tree();
 
 		while ((line_termination
-			? strbuf_gets(&buf, stdin)
+			? strbuf_getline_crlf(&buf, stdin)
 			: strbuf_getline(&buf, stdin, '\0')) != EOF) {
 			char *p;
 			if (line_termination && buf.buf[0] == '"') {
diff --git a/ident.c b/ident.c
index c377f2b..9018df0 100644
--- a/ident.c
+++ b/ident.c
@@ -55,7 +55,7 @@ static int add_mailname_host(struct strbuf *buf)
 				strerror(errno));
 		return -1;
 	}
-	if (strbuf_gets(&mailnamebuf, mailname) == EOF) {
+	if (strbuf_getline_crlf(&mailnamebuf, mailname) == EOF) {
 		if (ferror(mailname))
 			warning("cannot read /etc/mailname: %s",
 				strerror(errno));
diff --git a/remote.c b/remote.c
index 90eef22..e88d936 100644
--- a/remote.c
+++ b/remote.c
@@ -256,7 +256,7 @@ static void read_remotes_file(struct remote *remote)
 	if (!f)
 		return;
 	remote->origin = REMOTE_REMOTES;
-	while (strbuf_gets(&buf, f) != EOF) {
+	while (strbuf_getline_crlf(&buf, f) != EOF) {
 		const char *v;
 
 		strbuf_rtrim(&buf);
diff --git a/revision.c b/revision.c
index 7d100d8..651a34b 100644
--- a/revision.c
+++ b/revision.c
@@ -1641,7 +1641,7 @@ static void append_prune_data(struct cmdline_pathspec *prune, const char **av)
 static void read_pathspec_from_stdin(struct rev_info *revs, struct strbuf *sb,
 				     struct cmdline_pathspec *prune)
 {
-	while (strbuf_gets(sb, stdin) != EOF) {
+	while (strbuf_getline_crlf(sb, stdin) != EOF) {
 		ALLOC_GROW(prune->path, prune->nr + 1, prune->alloc);
 		prune->path[prune->nr++] = xstrdup(sb->buf);
 	}
@@ -1658,7 +1658,7 @@ static void read_revisions_from_stdin(struct rev_info *revs,
 	warn_on_object_refname_ambiguity = 0;
 
 	strbuf_init(&sb, 1000);
-	while (strbuf_gets(&sb, stdin) != EOF) {
+	while (strbuf_getline_crlf(&sb, stdin) != EOF) {
 		int len = sb.len;
 		if (!len)
 			break;
diff --git a/sha1_file.c b/sha1_file.c
index 957178c..7a748f2 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -395,7 +395,7 @@ void add_to_alternates_file(const char *reference)
 		struct strbuf line = STRBUF_INIT;
 		int found = 0;
 
-		while (strbuf_gets(&line, in) != EOF) {
+		while (strbuf_getline_crlf(&line, in) != EOF) {
 			if (!strcmp(reference, line.buf)) {
 				found = 1;
 				break;
diff --git a/strbuf.c b/strbuf.c
index 290fc74..7ad5ea4 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -510,7 +510,7 @@ int strbuf_getline(struct strbuf *sb, FILE *fp, int term)
 	return 0;
 }
 
-int strbuf_gets(struct strbuf *sb, FILE *fp)
+int strbuf_getline_crlf(struct strbuf *sb, FILE *fp)
 {
 	if (strbuf_getwholeline(sb, fp, '\n'))
 		return EOF;
diff --git a/strbuf.h b/strbuf.h
index c22bae0..d84c866 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -393,7 +393,7 @@ extern int strbuf_getline(struct strbuf *, FILE *, int);
  * and additionally treats a '\r' that comes immediately before '\n'
  * as part of the terminator.
  */
-extern int strbuf_gets(struct strbuf *, FILE *);
+extern int strbuf_getline_crlf(struct strbuf *, FILE *);
 
 /**
  * Like `strbuf_getline`, but keeps the trailing terminator (if
diff --git a/test-sha1-array.c b/test-sha1-array.c
index 46ff240..87b04de 100644
--- a/test-sha1-array.c
+++ b/test-sha1-array.c
@@ -11,7 +11,7 @@ int main(int argc, char **argv)
 	struct sha1_array array = SHA1_ARRAY_INIT;
 	struct strbuf line = STRBUF_INIT;
 
-	while (strbuf_gets(&line, stdin) != EOF) {
+	while (strbuf_getline_crlf(&line, stdin) != EOF) {
 		const char *arg;
 		unsigned char sha1[20];
 
diff --git a/transport-helper.c b/transport-helper.c
index e0e1c9c..7de52e1 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -54,7 +54,7 @@ static int recvline_fh(FILE *helper, struct strbuf *buffer, const char *name)
 	strbuf_reset(buffer);
 	if (debug)
 		fprintf(stderr, "Debug: Remote helper: Waiting...\n");
-	if (strbuf_gets(buffer, helper) == EOF) {
+	if (strbuf_getline_crlf(buffer, helper) == EOF) {
 		if (debug)
 			fprintf(stderr, "Debug: Remote helper quit.\n");
 		return 1;

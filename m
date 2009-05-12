From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [RFC 4/8] UTF file names.
Date: Wed, 13 May 2009 00:50:27 +0200
Message-ID: <1242168631-30753-5-git-send-email-robin.rosenberg@dewire.com>
References: <1242168631-30753-1-git-send-email-robin.rosenberg@dewire.com>
 <1242168631-30753-2-git-send-email-robin.rosenberg@dewire.com>
 <1242168631-30753-3-git-send-email-robin.rosenberg@dewire.com>
 <1242168631-30753-4-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 00:51:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M40oK-0000Sx-Jn
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 00:50:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754377AbZELWuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 18:50:51 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752519AbZELWut
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 18:50:49 -0400
Received: from mail.dewire.com ([83.140.172.130]:19398 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752739AbZELWup (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 18:50:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 25D4C145A58E;
	Wed, 13 May 2009 00:50:44 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0ruuGf1GcxQM; Wed, 13 May 2009 00:50:41 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.9])
	by dewire.com (Postfix) with ESMTP id 606B2145A58F;
	Wed, 13 May 2009 00:50:33 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.dirty
In-Reply-To: <1242168631-30753-4-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118964>

---
 builtin-add.c            |    5 +-
 builtin-checkout-index.c |   46 ++++++---
 builtin-ls-files.c       |   26 +++++-
 builtin-ls-tree.c        |   16 +++-
 builtin-rev-parse.c      |    7 +-
 builtin-update-index.c   |   18 +++-
 builtin-write-tree.c     |    5 +-
 diff.c                   |   97 ++++++++++++++------
 git-commit.sh            |    5 +
 git-compat-util.h        |   42 +++++++++
 merge-index.c            |   25 ++++--
 read-cache.c             |    8 +-
 setup.c                  |   28 +++++-
 t/t-utf-filenames.sh     |   95 +++++++++++++++++++
 utf.c                    |  230 ++++++++++++++++++++++++++++++++++++++=
++++++++
 15 files changed, 580 insertions(+), 73 deletions(-)
 create mode 100755 t/t-utf-filenames.sh

diff --git a/builtin-add.c b/builtin-add.c
index febb75e..62ea692 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -131,9 +131,10 @@ int cmd_add(int argc, const char **argv, const cha=
r *prefix)
 		return 0;
 	}
=20
-	for (i =3D 0; i < dir.nr; i++)
+	for (i =3D 0; i < dir.nr; i++) {
+	  P(("Adding '%s'\n", dir.entries[i]->name));
 		add_file_to_index(dir.entries[i]->name, verbose);
-
+	}
 	if (active_cache_changed) {
 		if (write_cache(newfd, active_cache, active_nr) ||
 		    close(newfd) || commit_lock_file(&lock_file))
diff --git a/builtin-checkout-index.c b/builtin-checkout-index.c
index b097c88..745bf9a 100644
--- a/builtin-checkout-index.c
+++ b/builtin-checkout-index.c
@@ -57,16 +57,22 @@ static void write_tempfile_record(const char *name,=
 int prefix_length)
 		for (i =3D 1; i < 4; i++) {
 			if (i > 1)
 				putchar(' ');
-			if (topath[i][0])
-				fputs(topath[i], stdout);
-			else
+			if (topath[i][0]) {
+				char localbuf[MAXPATHLEN];
+				localcpy(localbuf, topath[i], strlen(topath[i])+1);
+				fputs(localbuf, stdout);
+			} else
 				putchar('.');
 		}
-	} else
-		fputs(topath[checkout_stage], stdout);
-
+	} else {
+		char localbuf[MAXPATHLEN];
+		localcpy(localbuf, topath[checkout_stage], strlen(topath[checkout_st=
age])+1);
+		fputs(localbuf, stdout);
+	}
 	putchar('\t');
-	write_name_quoted("", 0, name + prefix_length,
+	char localbuf[MAXPATHLEN];
+	localcpy(localbuf, name + prefix_length, strlen(name + prefix_length)=
 + 1);
+	write_name_quoted("", 0, localbuf,=20
 		line_termination, stdout);
 	putchar(line_termination);
=20
@@ -77,8 +83,11 @@ static void write_tempfile_record(const char *name, =
int prefix_length)
=20
 static int checkout_file(const char *name, int prefix_length)
 {
+	char utfname[MAXPATHLEN];
 	int namelen =3D strlen(name);
-	int pos =3D cache_name_pos(name, namelen);
+	utfcpy(utfname, name, namelen + 1);
+	int utfnamelen =3D strlen(utfname);
+	int pos =3D cache_name_pos(utfname, utfnamelen);
 	int has_same_name =3D 0;
 	int did_checkout =3D 0;
 	int errs =3D 0;
@@ -88,8 +97,8 @@ static int checkout_file(const char *name, int prefix=
_length)
=20
 	while (pos < active_nr) {
 		struct cache_entry *ce =3D active_cache[pos];
-		if (ce_namelen(ce) !=3D namelen ||
-		    memcmp(ce->name, name, namelen))
+		if (ce_namelen(ce) !=3D utfnamelen ||
+		    memcmp(ce->name, utfname, utfnamelen))
 			break;
 		has_same_name =3D 1;
 		pos++;
@@ -224,7 +233,9 @@ int cmd_checkout_index(int argc, const char **argv,=
 const char *prefix)
 			continue;
 		}
 		if (!strncmp(arg, "--prefix=3D", 9)) {
-			state.base_dir =3D arg+9;
+			static char utfbasedir[MAXPATHLEN];
+			utfcpy(utfbasedir, arg+9, strlen(arg+9)+1);
+			state.base_dir =3D utfbasedir;
 			state.base_dir_len =3D strlen(state.base_dir);
 			continue;
 		}
@@ -262,13 +273,16 @@ int cmd_checkout_index(int argc, const char **arg=
v, const char *prefix)
 		const char *arg =3D argv[i];
 		const char *p;
=20
+		char utfarg[MAXPATHLEN];
+		utfcpy(utfarg, arg, strlen(arg)+1);
+
 		if (all)
 			die("git-checkout-index: don't mix '--all' and explicit filenames")=
;
 		if (read_from_stdin)
 			die("git-checkout-index: don't mix '--stdin' and explicit filenames=
");
-		p =3D prefix_path(prefix, prefix_length, arg);
+		p =3D prefix_path(prefix, prefix_length, utfarg);
 		checkout_file(p, prefix_length);
-		if (p < arg || p > arg + strlen(arg))
+		if (p < arg || p > arg + strlen(utfarg))
 			free((char*)p);
 	}
=20
@@ -288,9 +302,11 @@ int cmd_checkout_index(int argc, const char **argv=
, const char *prefix)
 				path_name =3D unquote_c_style(buf.buf, NULL);
 			else
 				path_name =3D buf.buf;
-			p =3D prefix_path(prefix, prefix_length, path_name);
+			char utfpath_name[MAXPATHLEN];
+			utfcpy(utfpath_name, path_name, strlen(path_name)+1);
+			p =3D prefix_path(prefix, prefix_length, utfpath_name);
 			checkout_file(p, prefix_length);
-			if (p < path_name || p > path_name + strlen(path_name))
+			if (p < utfpath_name || p > utfpath_name + strlen(utfpath_name))
 				free((char *)p);
 			if (path_name !=3D buf.buf)
 				free(path_name);
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index ad8c41e..babac34 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -65,6 +65,7 @@ static int match(const char **spec, char *ps_matched,
 			ps_matched++;
 		continue;
 	matched:
+		P(("matched(%s,%s)\n",m+len, filename+len));
 		if (ps_matched)
 			*ps_matched =3D 1;
 		return 1;
@@ -76,6 +77,9 @@ static void show_dir_entry(const char *tag, struct di=
r_entry *ent)
 {
 	int len =3D prefix_len;
 	int offset =3D prefix_offset;
+	char localpath[MAXPATHLEN];
+
+	P(("show_dir_entry(\"%s\",\"%s\"\n",tag,ent->name));
=20
 	if (len >=3D ent->len)
 		die("git-ls-files: internal error - directory entry not superset of =
prefix");
@@ -84,7 +88,8 @@ static void show_dir_entry(const char *tag, struct di=
r_entry *ent)
 		return;
=20
 	fputs(tag, stdout);
-	write_name_quoted("", 0, ent->name + offset, line_terminator, stdout)=
;
+	localcpy(localpath, ent->name + offset, strlen(ent->name + offset) + =
1);
+	write_name_quoted("", 0, localpath, line_terminator, stdout);
 	putchar(line_terminator);
 }
=20
@@ -165,6 +170,8 @@ static void show_ce_entry(const char *tag, struct c=
ache_entry *ce)
 	int len =3D prefix_len;
 	int offset =3D prefix_offset;
=20
+	P(("show_ce_entry(\"%s\",\"%s\"\n",tag,ce->name));
+
 	if (len >=3D ce_namelen(ce))
 		die("git-ls-files: internal error - cache entry not superset of pref=
ix");
=20
@@ -189,19 +196,23 @@ static void show_ce_entry(const char *tag, struct=
 cache_entry *ce)
 	}
=20
 	if (!show_stage) {
+		char localpath[MAXPATHLEN];
 		fputs(tag, stdout);
-		write_name_quoted("", 0, ce->name + offset,
+		localcpy(localpath, ce->name + offset, strlen(ce->name + offset) + 1=
);
+		write_name_quoted("", 0, localpath,
 				  line_terminator, stdout);
 		putchar(line_terminator);
 	}
 	else {
+		char localpath[MAXPATHLEN];
 		printf("%s%06o %s %d\t",
 		       tag,
 		       ntohl(ce->ce_mode),
 		       abbrev ? find_unique_abbrev(ce->sha1,abbrev)
 				: sha1_to_hex(ce->sha1),
 		       ce_stage(ce));
-		write_name_quoted("", 0, ce->name + offset,
+		localcpy(localpath, ce->name + offset, strlen(ce->name + offset) + 1=
);
+		write_name_quoted("", 0, localpath,
 				  line_terminator, stdout);
 		putchar(line_terminator);
 	}
@@ -451,6 +462,12 @@ int cmd_ls_files(int argc, const char **argv, cons=
t char *prefix)
=20
 	pathspec =3D get_pathspec(prefix, argv + i);
=20
+#ifdef DEBUG
+ 	if (pathspec) {
+		P(("pathspec[0]=3D%s\n",pathspec[0]));
+		P(("pathspec[1]=3D%s\n",pathspec[1]));
+	}
+#endif
 	/* Verify that the pathspec matches the prefix */
 	if (pathspec)
 		prefix =3D verify_pathspec(prefix);
@@ -461,6 +478,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *prefix)
 		for (num =3D 0; pathspec[num]; num++)
 			;
 		ps_matched =3D xcalloc(1, num);
+		P(("allocated ps_matched, %d entries\n",num));
 	}
=20
 	if (dir.show_ignored && !exc_given) {
@@ -485,12 +503,14 @@ int cmd_ls_files(int argc, const char **argv, con=
st char *prefix)
 		 */
 		int num, errors =3D 0;
 		for (num =3D 0; pathspec[num]; num++) {
+		  	P(("ps_matched[%d]=3D%d\n",num,ps_matched[num]));
 			if (ps_matched[num])
 				continue;
 			error("pathspec '%s' did not match any.",
 			      pathspec[num] + prefix_offset);
 			errors++;
 		}
+		P(("return errors ? 1 : 0; =3D> %d\n",errors ? 1 : 0));
 		return errors ? 1 : 0;
 	}
=20
diff --git a/builtin-ls-tree.c b/builtin-ls-tree.c
index 201defd..4f53b0d 100644
--- a/builtin-ls-tree.c
+++ b/builtin-ls-tree.c
@@ -78,8 +78,14 @@ static int show_tree(const unsigned char *sha1, cons=
t char *base, int baselen,
 		printf("%06o %s %s\t", mode, type,
 				abbrev ? find_unique_abbrev(sha1,abbrev)
 					: sha1_to_hex(sha1));
-	write_name_quoted(base + chomp_prefix, baselen - chomp_prefix,
-			  pathname,
+	char localprefix[MAXPATHLEN];
+	int localprefixlen =3D locallen(base + chomp_prefix, baselen - chomp_=
prefix);
+	localcpy(localprefix, base + chomp_prefix, baselen - chomp_prefix);
+=09
+	char localpathname[MAXPATHLEN];
+	localcpy(localpathname, pathname, strlen(pathname)+1);
+	write_name_quoted(localprefix, localprefixlen,
+			  localpathname,
 			  line_termination, stdout);
 	putchar(line_termination);
 	return retval;
@@ -147,6 +153,12 @@ int cmd_ls_tree(int argc, const char **argv, const=
 char *prefix)
 		die("Not a valid object name %s", argv[1]);
=20
 	pathspec =3D get_pathspec(prefix, argv + 2);
+#ifdef DEBUG
+	if (pathspec) {
+	  P(("pathspec[0]=3D%s\n",pathspec[0]));
+	  P(("pathspec[1]=3D%s\n",pathspec[1]));
+	}
+#endif
 	tree =3D parse_tree_indirect(sha1);
 	if (!tree)
 		die("not a tree object");
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index fd3ccc8..da03906 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -315,8 +315,11 @@ int cmd_rev_parse(int argc, const char **argv, con=
st char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--show-prefix")) {
-				if (prefix)
-					puts(prefix);
+				if (prefix) {
+					char localprefix[MAXPATHLEN];
+					localcpy(localprefix, prefix, strlen(prefix)+1);
+					puts(localprefix);
+				}
 				continue;
 			}
 			if (!strcmp(arg, "--show-cdup")) {
diff --git a/builtin-update-index.c b/builtin-update-index.c
index a3c0a45..cfea4cd 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -274,7 +274,9 @@ static void read_index_info(int line_termination)
 		else
 			path_name =3D ptr;
=20
-		if (!verify_path(path_name)) {
+		char utfpath_name[MAXPATHLEN];
+		utfcpy(utfpath_name, path_name, strlen(path_name) + 1);
+		if (!verify_path(utfpath_name)) {
 			fprintf(stderr, "Ignoring path %s\n", path_name);
 			if (path_name !=3D ptr)
 				free(path_name);
@@ -284,7 +286,7 @@ static void read_index_info(int line_termination)
=20
 		if (!mode) {
 			/* mode =3D=3D 0 means there is no such path -- remove */
-			if (remove_file_from_cache(path_name))
+			if (remove_file_from_cache(utfpath_name))
 				die("git-update-index: unable to remove %s",
 				    ptr);
 		}
@@ -294,7 +296,7 @@ static void read_index_info(int line_termination)
 			 * ptr[-41] is at the beginning of sha1
 			 */
 			ptr[-42] =3D ptr[-1] =3D 0;
-			if (add_cacheinfo(mode, sha1, path_name, stage))
+			if (add_cacheinfo(mode, sha1, utfpath_name, stage))
 				die("git-update-index: unable to update %s",
 				    path_name);
 		}
@@ -616,7 +618,9 @@ int cmd_update_index(int argc, const char **argv, c=
onst char *prefix)
 				usage(update_index_usage);
 			die("unknown option %s", path);
 		}
-		update_one(path, prefix, prefix_length);
+		char utfpath[MAXPATHLEN];
+		utfcpy(utfpath, path, strlen(path) + 1);
+		update_one(utfpath, prefix, prefix_length);
 		if (set_executable_bit)
 			chmod_path(set_executable_bit, path);
 	}
@@ -633,11 +637,13 @@ int cmd_update_index(int argc, const char **argv,=
 const char *prefix)
 				path_name =3D unquote_c_style(buf.buf, NULL);
 			else
 				path_name =3D buf.buf;
-			p =3D prefix_path(prefix, prefix_length, path_name);
+			char utfpath_name[MAXPATHLEN];
+			utfcpy(utfpath_name, path_name, strlen(path_name) + 1);
+			p =3D prefix_path(prefix, prefix_length, utfpath_name);
 			update_one(p, NULL, 0);
 			if (set_executable_bit)
 				chmod_path(set_executable_bit, p);
-			if (p < path_name || p > path_name + strlen(path_name))
+			if (p < utfpath_name || p > utfpath_name + strlen(utfpath_name))
 				free((char*) p);
 			if (path_name !=3D buf.buf)
 				free(path_name);
diff --git a/builtin-write-tree.c b/builtin-write-tree.c
index 50670dc..84c370f 100644
--- a/builtin-write-tree.c
+++ b/builtin-write-tree.c
@@ -80,7 +80,10 @@ int cmd_write_tree(int argc, const char **argv, cons=
t char *unused_prefix)
 	if (argc > 2)
 		die("too many options");
=20
-	ret =3D write_tree(sha1, missing_ok, prefix);
+	char utfprefix[MAXPATHLEN];
+	if (prefix)
+	  utfcpy(utfprefix, prefix, strlen(prefix)+1);
+	ret =3D write_tree(sha1, missing_ok, prefix!=3DNULL ? utfprefix : NUL=
L);
 	printf("%s\n", sha1_to_hex(sha1));
=20
 	return ret;
diff --git a/diff.c b/diff.c
index 3315378..170ec5a 100644
--- a/diff.c
+++ b/diff.c
@@ -964,9 +964,14 @@ static void builtin_diff(const char *name_a,
 	char *a_one, *b_two;
 	const char *set =3D diff_get_color(o->color_diff, DIFF_METAINFO);
 	const char *reset =3D diff_get_color(o->color_diff, DIFF_RESET);
+	char localname_a[MAXPATHLEN];
+	char localname_b[MAXPATHLEN];
=20
-	a_one =3D quote_two("a/", name_a);
-	b_two =3D quote_two("b/", name_b);
+	localcpy(localname_a, name_a, strlen(name_a) + 1);
+	localcpy(localname_b, name_b, strlen(name_b) + 1);
+
+	a_one =3D quote_two("a/", localname_a);
+	b_two =3D quote_two("b/", localname_b);
 	lbl[0] =3D DIFF_FILE_VALID(one) ? a_one : "/dev/null";
 	lbl[1] =3D DIFF_FILE_VALID(two) ? b_two : "/dev/null";
 	printf("%sdiff --git %s %s%s\n", set, a_one, b_two, reset);
@@ -995,7 +1000,7 @@ static void builtin_diff(const char *name_a,
 		if ((one->mode ^ two->mode) & S_IFMT)
 			goto free_ab_and_return;
 		if (complete_rewrite) {
-			emit_rewrite_diff(name_a, name_b, one, two);
+			emit_rewrite_diff(localname_a, localname_b, one, two);
 			goto free_ab_and_return;
 		}
 	}
@@ -1372,18 +1377,22 @@ static void prepare_temp_file(const char *name,
 	    work_tree_matches(name, one->sha1)) {
 		struct stat st;
 		if (lstat(name, &st) < 0) {
+			char localname[MAXPATHLEN];
 			if (errno =3D=3D ENOENT)
 				goto not_a_valid_file;
-			die("stat(%s): %s", name, strerror(errno));
+			localcpy(localname, name, strlen(name) + 1);
+			die("stat(%s): %s", localname, strerror(errno));
 		}
 		if (S_ISLNK(st.st_mode)) {
 			int ret;
 			char buf[PATH_MAX + 1]; /* ought to be SYMLINK_MAX */
+			char localname[MAXPATHLEN];
+			localcpy(localname, name, strlen(name) + 1);
 			if (sizeof(buf) <=3D st.st_size)
-				die("symlink too long: %s", name);
+				die("symlink too long: %s", localname);
 			ret =3D readlink(name, buf, st.st_size);
 			if (ret < 0)
-				die("readlink(%s)", name);
+				die("readlink(%s)", localname);
 			prep_temp_blob(temp, buf, st.st_size,
 				       (one->sha1_valid ?
 					one->sha1 : null_sha1),
@@ -1522,7 +1531,9 @@ static void run_external_diff(const char *pgm,
 	retval =3D spawn_prog(pgm, spawn_arg);
 	remove_tempfile();
 	if (retval) {
-		fprintf(stderr, "external diff died, stopping at %s.\n", name);
+	  	char localname[MAXPATHLEN];
+	  	localcpy(localname, name, strlen(name) + 1);
+		fprintf(stderr, "external diff died, stopping at %s.\n", localname);
 		exit(1);
 	}
 }
@@ -1574,6 +1585,9 @@ static void run_diff(struct diff_filepair *p, str=
uct diff_options *o)
 	char *name_munged, *other_munged;
 	int complete_rewrite =3D 0;
 	int len;
+	char localname[MAXPATHLEN];
+	char localotherbuf[MAXPATHLEN];
+	char *localother;
=20
 	if (DIFF_PAIR_UNMERGED(p)) {
 		/* unmerged */
@@ -1583,8 +1597,14 @@ static void run_diff(struct diff_filepair *p, st=
ruct diff_options *o)
=20
 	name =3D p->one->path;
 	other =3D (strcmp(name, p->two->path) ? p->two->path : NULL);
-	name_munged =3D quote_one(name);
-	other_munged =3D quote_one(other);
+	localcpy(localname, name, strlen(name) + 1);
+	if (other) {
+		localcpy(localotherbuf, other, strlen(other) + 1);
+		localother =3D localotherbuf;
+	} else
+		localother =3D NULL;
+	name_munged =3D quote_one(localname);
+	other_munged =3D quote_one(localother);
 	one =3D p->one; two =3D p->two;
=20
 	diff_fill_sha1_info(one);
@@ -2093,12 +2113,15 @@ static void diff_flush_raw(struct diff_filepair=
 *p,
 	const char *path_one, *path_two;
 	int inter_name_termination =3D '\t';
 	int line_termination =3D options->line_termination;
+	char localpath_one[MAXPATHLEN];
+	char localpath_two[MAXPATHLEN];
=20
 	if (!line_termination)
 		inter_name_termination =3D 0;
-
-	path_one =3D p->one->path;
-	path_two =3D p->two->path;
+	localcpy(localpath_one, p->one->path, strlen(p->one->path) + 1);
+	localcpy(localpath_two, p->two->path, strlen(p->two->path) + 1);
+	path_one =3D localpath_one;
+	path_two =3D localpath_two;
 	if (line_termination) {
 		path_one =3D quote_one(path_one);
 		path_two =3D quote_one(path_two);
@@ -2135,20 +2158,22 @@ static void diff_flush_raw(struct diff_filepair=
 *p,
 	if (two_paths)
 		printf("%c%s", inter_name_termination, path_two);
 	putchar(line_termination);
-	if (path_one !=3D p->one->path)
+	if (path_one !=3D localpath_one)
 		free((void*)path_one);
-	if (path_two !=3D p->two->path)
+	if (path_two !=3D localpath_two)
 		free((void*)path_two);
 }
=20
 static void diff_flush_name(struct diff_filepair *p, int line_terminat=
ion)
 {
-	char *path =3D p->two->path;
+	char localpath_two[MAXPATHLEN];
+	char *path =3D localpath_two;
+	localcpy(localpath_two, p->two->path, strlen(p->two->path) + 1);
=20
 	if (line_termination)
-		path =3D quote_one(p->two->path);
+		path =3D quote_one(localpath_two);
 	printf("%s%c", path, line_termination);
-	if (p->two->path !=3D path)
+	if (localpath_two !=3D path)
 		free(path);
 }
=20
@@ -2325,8 +2350,10 @@ static void diff_resolve_rename_copy(void)
 			/* This is a "no-change" entry and should not
 			 * happen anymore, but prepare for broken callers.
 			 */
+		        char localpath[MAXPATHLEN];
+			localcpy(localpath, p->one->path, strlen(p->one->path) + 1);
 			error("feeding unmodified %s to diffcore",
-			      p->one->path);
+			      localpath);
 			p->status =3D DIFF_STATUS_UNKNOWN;
 		}
 	}
@@ -2359,20 +2386,24 @@ static void flush_one_pair(struct diff_filepair=
 *p, struct diff_options *opt)
=20
 static void show_file_mode_name(const char *newdelete, struct diff_fil=
espec *fs)
 {
+        char localpath[MAXPATHLEN];
+	localcpy(localpath, fs->path, strlen(fs->path) + 1);
 	if (fs->mode)
-		printf(" %s mode %06o %s\n", newdelete, fs->mode, fs->path);
+		printf(" %s mode %06o %s\n", newdelete, fs->mode, localpath);
 	else
-		printf(" %s %s\n", newdelete, fs->path);
+		printf(" %s %s\n", newdelete, localpath);
 }
=20
=20
 static void show_mode_change(struct diff_filepair *p, int show_name)
 {
 	if (p->one->mode && p->two->mode && p->one->mode !=3D p->two->mode) {
-		if (show_name)
+	        if (show_name) {
+		 	char localpath[MAXPATHLEN];
+			localcpy(localpath, p->two->path, strlen(p->two->path) + 1);
 			printf(" mode change %06o =3D> %06o %s\n",
-			       p->one->mode, p->two->mode, p->two->path);
-		else
+			       p->one->mode, p->two->mode, localpath);
+		} else
 			printf(" mode change %06o =3D> %06o\n",
 			       p->one->mode, p->two->mode);
 	}
@@ -2381,10 +2412,16 @@ static void show_mode_change(struct diff_filepa=
ir *p, int show_name)
 static void show_rename_copy(const char *renamecopy, struct diff_filep=
air *p)
 {
 	const char *old, *new;
+	char localpath_one[MAXPATHLEN];
+	char localpath_two[MAXPATHLEN];
+	char localpath_old[MAXPATHLEN];
+	char localpath_new[MAXPATHLEN];
=20
 	/* Find common prefix */
-	old =3D p->one->path;
-	new =3D p->two->path;
+	localcpy(localpath_old, p->one->path, strlen(p->one->path) + 1);
+	localcpy(localpath_new, p->two->path, strlen(p->two->path) + 1);
+	old =3D localpath_old;
+	new =3D localpath_new;
 	while (1) {
 		const char *slash_old, *slash_new;
 		slash_old =3D strchr(old, '/');
@@ -2400,13 +2437,15 @@ static void show_rename_copy(const char *rename=
copy, struct diff_filepair *p)
 	/* p->one->path thru old is the common prefix, and old and new
 	 * through the end of names are renames
 	 */
+	localcpy(localpath_one, p->one->path, strlen(p->one->path) + 1);
+	localcpy(localpath_two, p->two->path, strlen(p->two->path) + 1);
 	if (old !=3D p->one->path)
 		printf(" %s %.*s{%s =3D> %s} (%d%%)\n", renamecopy,
-		       (int)(old - p->one->path), p->one->path,
+		       (int)(old - localpath_one), localpath_one,
 		       old, new, (int)(0.5 + p->score * 100.0/MAX_SCORE));
 	else
 		printf(" %s %s =3D> %s (%d%%)\n", renamecopy,
-		       p->one->path, p->two->path,
+		       localpath_one, localpath_two,
 		       (int)(0.5 + p->score * 100.0/MAX_SCORE));
 	show_mode_change(p, 0);
 }
@@ -2428,7 +2467,9 @@ static void diff_summary(struct diff_filepair *p)
 		break;
 	default:
 		if (p->score) {
-			printf(" rewrite %s (%d%%)\n", p->two->path,
+		  	char localpath[MAXPATHLEN];
+			localcpy(localpath, p->two->path, strlen(p->two->path) + 1);
+			printf(" rewrite %s (%d%%)\n", localpath,
 				(int)(0.5 + p->score * 100.0/MAX_SCORE));
 			show_mode_change(p, 0);
 		} else	show_mode_change(p, 1);
diff --git a/git-commit.sh b/git-commit.sh
index 5b1cf85..e2c647a 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -1,4 +1,9 @@
 #!/bin/sh
+if grep -q "^xALL_CFLAGS +=3D -DDEBUG=3D1" $(dirname $0)/Makefile
+then
+    set -x
+    PS4=3D'$0:$LINENO:'
+fi
 #
 # Copyright (c) 2005 Linus Torvalds
 # Copyright (c) 2006 Junio C Hamano
diff --git a/git-compat-util.h b/git-compat-util.h
index f83352b..6a61026 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -188,4 +188,46 @@ static inline int sane_case(int x, int high)
 	return x;
 }
=20
+#ifndef MAXPATHLEN
+#define MAXPATHLEN 256
+#endif
+
+#ifdef UTF8INTERNAL
+#ifdef NO_ICONV
+#error "NO_ICONV must NOT be set when UTF8INTERNAL is set"
+#endif
+extern int utf_lstat(const char *path,struct stat *buf);
+extern int utf_stat(const char *path,struct stat *buf);
+extern DIR *utf_opendir(const char *path);
+extern struct dirent* utf_readdir(DIR *dir);
+extern int utf_closedir(DIR *dir);
+extern FILE *utf_fopen(const char *path,char *mode);
+extern FILE *utf_freopen(const char *path,char *mode,FILE *stream);
+extern int utf_unlink(const char *path);
+extern int utf_rmdir(const char *path);
+extern int utf_open(const char *path,int flags, ...) __nonnull((1));
+extern int utf_access(const char *path, int mode);
+extern char *utf_getcwd(char *buf,int bufsize);
+extern int utf_creat(const char *path,int mode);
+extern int utf_mkdir(const char *path,int mode);
+extern ssize_t utf_readlink(const char *path,char *buf,size_t bufsiz);
+
+#define lstat(path,buf) utf_lstat(path,buf)
+#define stat(path,buf) utf_stat(path,buf)
+#define opendir(path) utf_opendir(path)
+#define readdir(dir) utf_readdir(dir)
+#define closedir(dir) utf_closedir(dir)
+#define fopen(name,mode) utf_fopen(name,mode)
+#define freopen(name,mode,stream) utf_freopen(name,mode,stream)
+#define unlink(name) utf_unlink(name)
+#define rmdir(name) utf_rmdir(name)
+//#define open(name,flags,mode) utf_open(name,flags,mode)
+#define open utf_open
+#define access(path,mode) utf_access(path,mode)
+#define getcwd(buf,bufsize) utf_getcwd(buf,bufsize)
+#define creat(path,mode) utf_creat(path,mode)
+#define mkdir(path,mode) utf_mkdir(path,mode)
+#define readlink(path,buf,bufsiz) utf_readlink(path,buf,bufsiz)
+#endif
+
 #endif
diff --git a/merge-index.c b/merge-index.c
index 646d090..8a98b49 100644
--- a/merge-index.c
+++ b/merge-index.c
@@ -17,14 +17,23 @@ static void run_program(void)
 	if (pid < 0)
 		die("unable to fork");
 	if (!pid) {
-		execlp(pgm, arguments[0],
-			    arguments[1],
-			    arguments[2],
-			    arguments[3],
-			    arguments[4],
-			    arguments[5],
-			    arguments[6],
-			    arguments[7],
+		char argbuf[8][MAXPATHLEN];
+		char* args[8];
+		int i;
+		for (i=3D0; i<8; ++i) {
+			if (arguments[i]) {
+			      args[i] =3D argbuf[i];
+			      localcpy(args[i], arguments[i], strlen(arguments[i]) + 1);
+			}
+		}
+		execlp(pgm, args[0],
+			    args[1],
+			    args[2],
+			    args[3],
+			    args[4],
+			    args[5],
+			    args[6],
+			    args[7],
 			    NULL);
 		die("unable to execute '%s'", pgm);
 	}
diff --git a/read-cache.c b/read-cache.c
index 97c3867..f7642ca 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -701,7 +701,9 @@ int refresh_cache(unsigned int flags)
 			i--;
 			if (allow_unmerged)
 				continue;
-			printf("%s: needs merge\n", ce->name);
+			char localname[MAXPATHLEN];
+			localcpy(localname, ce->name, strlen(ce->name) + 1);
+			printf("%s: needs merge\n", localname);
 			has_errors =3D 1;
 			continue;
 		}
@@ -721,7 +723,9 @@ int refresh_cache(unsigned int flags)
 			}
 			if (quiet)
 				continue;
-			printf("%s: needs update\n", ce->name);
+			char localname[MAXPATHLEN];
+			localcpy(localname, ce->name, strlen(ce->name) + 1);
+			printf("%s: needs update\n", localname);
 			has_errors =3D 1;
 			continue;
 		}
diff --git a/setup.c b/setup.c
index 9a46a58..9e500f1 100644
--- a/setup.c
+++ b/setup.c
@@ -43,6 +43,8 @@ const char *prefix_path(const char *prefix, int len, =
const char *path)
 		memcpy(n, prefix, len);
 		memcpy(n + len, path, speclen+1);
 		path =3D n;
+	} else {
+		path =3D xstrdup(path);
 	}
 	return path;
 }
@@ -107,6 +109,8 @@ void verify_non_filename(const char *prefix, const =
char *arg)
=20
 const char **get_pathspec(const char *prefix, const char **pathspec)
 {
+	char utfprefixbuf[MAXPATHLEN];
+	char *utfprefix;
 	const char *entry =3D *pathspec;
 	const char **p;
 	int prefixlen;
@@ -114,20 +118,36 @@ const char **get_pathspec(const char *prefix, con=
st char **pathspec)
 	if (!prefix && !entry)
 		return NULL;
=20
+	if (prefix) {
+	  utfcpy(utfprefixbuf, prefix, strlen(prefix)+1);
+	  utfprefix =3D utfprefixbuf;
+	} else {
+	  utfprefix =3D NULL;
+	}
+
 	if (!entry) {
 		static const char *spec[2];
-		spec[0] =3D prefix;
+		spec[0] =3D xstrdup(utfprefix);
 		spec[1] =3D NULL;
 		return spec;
 	}
=20
 	/* Otherwise we have to re-write the entries.. */
+	int n;
+	for (n=3D0; pathspec[n]; ++n)
+		;
+	char **ret =3D xcalloc(n+1,sizeof(char*));
+	char **r =3D ret;
 	p =3D pathspec;
-	prefixlen =3D prefix ? strlen(prefix) : 0;
+	prefixlen =3D utfprefix ? strlen(utfprefix) : 0;
 	do {
-		*p =3D prefix_path(prefix, prefixlen, entry);
+	        char utfentry[MAXPATHLEN];
+		utfcpy(utfentry, entry, strlen(entry)+1);
+		*r =3D prefix_path(utfprefix, prefixlen, utfentry);
+		P(("*r=3D%s\n",*r));
+		++r;
 	} while ((entry =3D *++p) !=3D NULL);
-	return (const char **) pathspec;
+	return (const char**)ret;
 }
=20
 /*
diff --git a/t/t-utf-filenames.sh b/t/t-utf-filenames.sh
new file mode 100755
index 0000000..0731086
--- /dev/null
+++ b/t/t-utf-filenames.sh
@@ -0,0 +1,95 @@
+#!/bin/sh
+
+test_description=3D'Test charset management.
+
+This assumes normal tests works fine
+and concentrates on filenames with non-ascii
+characters.'
+
+. ./test-lib.sh
+
+test_expect_success \
+    'add simple text file' \
+    'mkdir =E5 &&
+    echo hej >=E5/=E5land.txt &&
+    git-add =E5/=E5land.txt &&
+    git-commit -a -m "Changed" &&
+    echo test $(git-ls-files) =3D "\"\\345/\\345land.txt\"" &&
+    LC_CTYPE=3Dsv_SE.UTF-8 echo test $(git-ls-files) =3D "\"\\345/\\34=
5land.txt\""
+    '
+
+test_expect_success \
+    'change single text file, first time' \
+    'echo san >>=E5/=E5land.txt &&
+    git-commit -a -m "Changed again"
+    '
+test_expect_success \
+    'add simple binary file' \
+    'dd if=3D/dev/urandom of=3D=E5/=E5=E4=F6 bs=3D1 count=3D312 &&
+    git-add =E5/=E5=E4=F6 &&
+    git-commit -a -m "Changed" &&
+    git-ls-files &&
+    test "$(git-ls-files)" =3D "\"\\345/\\345land.txt\"
+\"\\345/\\345\\344\\366\""
+    '
+test_expect_success \
+    'change single text file, second time' \
+    'echo san >>=E5/=E5land.txt &&
+    git-commit -a -m "Changed igen"
+    '
+test_expect_success \
+    'change single binary file' \
+    'dd if=3D/dev/urandom of=3D=E5/=E5=E4=F6 bs=3D1 count=3D312 &&
+    git-commit -a -m "Changed igen"
+    '
+
+test_expect_success \
+    'branch and merge, new file' \
+    '
+    git-tag -f HERE &&
+    git-checkout -b "gren1" &&
+    echo >=E5/=F6land.txt hej &&
+    git-add . &&
+    git-commit -a -m "=C4ndrad" &&
+    git-checkout master &&
+    git-pull . gren1 &&
+    test "$(git-ls-files)" =3D "\"\\345/\\345land.txt\"
+\"\\345/\\345\\344\\366\"
+\"\\345/\\366land.txt\""
+    '
+test_expect_success \
+    'merge old file' \
+    '
+    git-checkout gren1 &&
+    echo >=E5/=F6land.txt hejsan &&
+    git-commit -a -m "=C4ndrad" &&
+    git-checkout master &&
+    git-pull . gren1
+    test "$(git-ls-files)" =3D "\"\\345/\\345land.txt\"
+\"\\345/\\345\\344\\366\"
+\"\\345/\\366land.txt\""
+    '
+
+test_expect_success \
+    'merge in-tree file' \
+    '
+    echo >>=E5/=F6land.txt in master &&
+    git-commit -a -m "in master" &&=20
+    git-checkout gren1 &&
+    echo >=E5/=F6land.txt in branch &&
+    git-update-index =E5/=F6land.txt &&
+    git-checkout -m master
+    test "$(git-ls-files)" =3D "\"\\345/\\345land.txt\"
+\"\\345/\\345\\344\\366\"
+\"\\345/\\366land.txt\""
+    test $(echo $(wc -l <=E5/=F6land.txt)) =3D 6
+    '
+
+test_expect_success \
+    'clone to UTF' \
+    '
+    rm -rf ../trash2 &&
+    LC_ALL=3Dsv_SE.UTF-8 LC_CTYPE=3Dsv_SE.UTF-8 git-clone . ../trash2
+    '
+
+test_done
diff --git a/utf.c b/utf.c
index eb430b2..7c44cac 100644
--- a/utf.c
+++ b/utf.c
@@ -180,6 +180,236 @@ void localcpy(char *tolocal, char *fromutf, size_=
t utflen)
 #endif
 }
=20
+#define MAXRESOURCES 50
+struct resource {
+  void *key;
+  void *value;
+};
+
+static struct resource resources[MAXRESOURCES];
+static void put(void *key, void *value)
+{
+  int i;
+  for (i=3D0; i<MAXRESOURCES; ++i) {
+    if (resources[i].key =3D=3D 0) {
+      resources[i].key =3D key;
+      resources[i].value =3D value;
+      return;
+    }
+  }
+}
+
+static void* get(void *key)
+{
+  int i;
+  for (i=3D0; i<MAXRESOURCES; ++i) {
+    if (resources[i].key =3D=3D key) {
+      return resources[i].value;
+    }
+  }
+  return NULL;
+}
+
+static void* getandremove(void *key)
+{
+  int i;
+  for (i=3D0; i<MAXRESOURCES; ++i) {
+    if (resources[i].key =3D=3D key) {
+      resources[i].key =3D NULL;
+      return resources[i].value;
+    }
+  }
+  return NULL;
+}
+=20
+static void zfree(void *ret)
+{
+  if (ret)
+    free(ret);
+}
+
+int utf_lstat(char *path, struct stat *buf)
+{
+  P(("utf_lstat(\"%s\",buf)[",path));
+  char localpath[MAXPATHLEN];
+  localcpy(localpath, path, strlen(path)+1);
+  P(("\"%s\"]\n",localpath));
+  int ret =3D lstat(localpath, buf);
+  if (ret >=3D 0 && (buf->st_mode & S_IFMT) =3D=3D S_IFLNK) {
+    char sympath[MAXPATHLEN];
+    int n =3D utf_readlink(path, sympath, sizeof sympath);
+    if (n < 0)
+      die("Panic, cannot read link %s in utf_lstat\n", path);
+    buf->st_size =3D strlen(sympath);
+  }
+  return ret;
+}
+
+int utf_stat(char *path, struct stat *buf)
+{
+  P(("utf_stat(\"%s\",buf)[",path));
+  char localpath[MAXPATHLEN];
+  localcpy(localpath, path, strlen(path)+1);
+  P(("\"%s\"]\n",localpath));
+  return stat(localpath, buf);
+}
+
+DIR *utf_opendir(char *path)
+{
+  P(("utf_opendir(\"%s\")\n",path));
+  char localpath[MAXPATHLEN];
+  DIR *ret =3D NULL;
+  localcpy(localpath, path, strlen(path)+1);
+  P(("\"%s\"]\n",localpath));
+  ret =3D opendir(localpath);
+  if (ret)
+    put(ret, NULL);
+  return ret;
+}
+
+struct dirent* utf_readdir(DIR *dir)
+{
+  P(("utf_readdir(\"%p\")",dir));
+  struct dirent *ret;
+  int len;
+  char utfpath[256];
+  struct dirent *myret;
+
+  zfree(getandremove(dir));
+  ret =3D readdir(dir);
+  if (ret !=3D NULL) {
+    utfcpy(utfpath, ret->d_name, strlen(ret->d_name)+1);
+    len=3Dsizeof(struct dirent)+strlen(utfpath)+1;
+    myret=3Dmalloc(len);
+    memcpy(myret, ret, sizeof (struct dirent));
+    put(dir, myret);
+    strcpy(myret->d_name, utfpath);
+    P(("=3D>\"%s\"\n",myret->d_name));
+    return myret;
+  } else {
+    return NULL;
+  }
+}
+
+int utf_closedir(DIR *dir)
+{
+  P(("utf_closedir(%p)\n",dir));
+  zfree(getandremove(dir));
+  return closedir(dir);
+}
+
+FILE *utf_fopen(char *path, char *mode)
+{
+  P(("utf_fopen(\"%s\",\"%s\")[",path,mode));
+  char localpath[MAXPATHLEN];
+  localcpy(localpath, path, strlen(path)+1);
+  P(("\"%s\"]\n",localpath));
+  return fopen(localpath, mode);
+}=20
+
+FILE *utf_freopen(char *path, char *mode, FILE *stream)
+{
+  P(("utf_freopen(\"%s\",\"%s\",%p)[",path,mode,stream));
+  char localpath[MAXPATHLEN];
+  localcpy(localpath, path, strlen(path)+1);
+  P(("\"%s\"]\n",localpath));
+  return freopen(localpath, mode, stream);
+}=20
+
+int utf_unlink(char *path)
+{
+  P(("utf_unlink(\"%s\")[",path));
+  char localpath[MAXPATHLEN];
+  localcpy(localpath, path, strlen(path)+1);
+  P(("\"%s\"]\n",localpath));
+  return unlink(localpath);
+}
+
+int utf_rmdir(char *path)
+{
+  P(("utf_rmdir(\"%s\")[",path));
+  char localpath[MAXPATHLEN];
+  localcpy(localpath, path, strlen(path)+1);
+  P(("\"%s\"]\n",localpath));
+  return rmdir(localpath);
+}
+
+int utf_open(char *path, int flags,...)
+{
+  va_list va;
+  int mode;
+  va_start(va,flags);
+  mode =3D va_arg(va,int);
+  va_end(va);
+  P(("utf_open(\"%s\",%d,%d)[",path,flags,mode));
+  char localpath[MAXPATHLEN];
+  localcpy(localpath, path, strlen(path)+1);
+  P(("\"%s\"]\n",localpath));
+  return open(localpath, flags, mode);
+}
+
+int utf_access(char *path, int mode)
+{
+  P(("utf_access(\"%s\",%d)[",path,mode));
+  char localpath[MAXPATHLEN];
+  localcpy(localpath, path, strlen(path)+1);
+  P(("\"%s\"]\n",localpath));
+  return access(localpath,mode);
+}
+
+char *utf_getcwd(char *buf,int bufsize)
+{
+  char localbuf[MAXPATHLEN];
+  char *ret=3Dgetcwd(localbuf,sizeof localbuf);
+  if (ret !=3D NULL) {
+    if (buf =3D=3D NULL) {
+      if (bufsize =3D=3D 0) {
+	buf =3D malloc(bufsize);
+      } else {
+	buf =3D malloc(utflen(localbuf,strlen(localbuf)) + 1);
+      }
+    }
+    utfcpy(buf, localbuf, strlen(localbuf) + 1);
+    return buf;
+  } else {
+    return NULL;   =20
+  }
+}
+
+int utf_creat(const char *path,int mode)
+{
+  P(("utf_creat(\"%s\",%d)[",path,mode));
+  char localpath[MAXPATHLEN];
+  localcpy(localpath, path, strlen(path)+1);
+  P(("\"%s\"]\n",localpath));
+  return creat(localpath, mode);
+}
+
+int utf_mkdir(const char *path,int mode)
+{
+  P(("utf_mkdir(\"%s\",%d)[",path,mode));
+  char localpath[MAXPATHLEN];
+  localcpy(localpath, path, strlen(path)+1);
+  P(("\"%s\"]\n",localpath));
+  return mkdir(localpath, mode);
+}
+
+ssize_t utf_readlink(const char *path,char *buf,size_t bufsiz)
+{
+  P(("utf_readlink(\"%s\",BUF,%d)[",path,bufsiz));
+  char localpath[MAXPATHLEN];
+  localcpy(localpath, path, strlen(path)+1);
+  P(("readlink(%s)\n", localpath));
+  char localret[MAXPATHLEN];
+  ssize_t ret =3D readlink(localpath, localret, bufsiz);
+  if (ret =3D=3D -1)
+	return ret;
+  localret[ret] =3D 0;
+  utfcpy(buf, localret, ret+1);
+  P(("\"%s\"]\n",buf));
+  return strlen(buf);
+}
+
 int PP(const char *fmt,...)
 {
   va_list va;
--=20
1.6.3.dirty

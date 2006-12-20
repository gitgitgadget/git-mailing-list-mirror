X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/3] Make git-rerere a builtin
Date: Wed, 20 Dec 2006 17:39:41 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612201738000.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 20 Dec 2006 16:39:55 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34949>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx4Ts-0004aB-1T for gcvg-git@gmane.org; Wed, 20 Dec
 2006 17:39:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030204AbWLTQjp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 11:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030205AbWLTQjo
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 11:39:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:47297 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1030204AbWLTQjn
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006 11:39:43 -0500
Received: (qmail invoked by alias); 20 Dec 2006 16:39:41 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp035) with SMTP; 20 Dec 2006 17:39:41 +0100
To: git@vger.kernel.org, junkio@cox.net
Sender: git-owner@vger.kernel.org


The perl version used modules which are non-standard in some setups.
This patch brings the full power of rerere to a wider audience.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	If this is not liked, at least we have a test now. And I can use 
	it on all my machines.

 Makefile         |    2 +-
 builtin-rerere.c |  407 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 builtin.h        |    1 +
 git-rerere.perl  |  284 -------------------------------------
 git.c            |    1 +
 5 files changed, 410 insertions(+), 285 deletions(-)

diff --git a/Makefile b/Makefile
index 2c19c4d..6ce3ada 100644
--- a/Makefile
+++ b/Makefile
@@ -179,7 +179,6 @@ SCRIPT_SH = \
 SCRIPT_PERL = \
 	git-add--interactive.perl \
 	git-archimport.perl git-cvsimport.perl git-relink.perl \
-	git-rerere.perl \
 	git-cvsserver.perl \
 	git-svnimport.perl git-cvsexportcommit.perl \
 	git-send-email.perl git-svn.perl
@@ -294,6 +293,7 @@ BUILTIN_OBJS = \
 	builtin-push.o \
 	builtin-read-tree.o \
 	builtin-repo-config.o \
+	builtin-rerere.o \
 	builtin-rev-list.o \
 	builtin-rev-parse.o \
 	builtin-rm.o \
diff --git a/builtin-rerere.c b/builtin-rerere.c
new file mode 100644
index 0000000..191aeec
--- /dev/null
+++ b/builtin-rerere.c
@@ -0,0 +1,407 @@
+#include "cache.h"
+#include "path-list.h"
+#include "xdiff/xdiff.h"
+#include "xdiff-interface.h"
+
+#include <time.h>
+
+static const char git_rerere_usage[] =
+"git-rerere [clear | status | diff | gc]";
+
+/* these values are days */
+static int cutoff_noresolve = 15;
+static int cutoff_resolve = 60;
+
+static char *merge_rr_path;
+
+static const char *rr_path(const char *name, const char *file)
+{
+	return git_path("rr-cache/%s/%s", name, file);
+}
+
+static void read_rr(struct path_list *rr)
+{
+	unsigned char sha1[20];
+	char buf[PATH_MAX];
+	FILE *in = fopen(merge_rr_path, "r");
+	if (!in)
+		return;
+	while (fread(buf, 40, 1, in) == 1) {
+		int i;
+		char *name;
+		if (get_sha1_hex(buf, sha1))
+			die("corrupt MERGE_RR");
+		buf[40] = '\0';
+		name = xstrdup(buf);
+		if (fgetc(in) != '\t')
+			die("corrupt MERGE_RR");
+		for (i = 0; i < sizeof(buf) && (buf[i] = fgetc(in)); i++)
+			; /* do nothing */
+		if (i == sizeof(buf))
+			die("filename too long");
+		path_list_insert(buf, rr)->util = xstrdup(name);
+	}
+	fclose(in);
+}
+
+static struct lock_file write_lock;
+
+static int write_rr(struct path_list *rr, int out_fd)
+{
+	int i;
+	for (i = 0; i < rr->nr; i++) {
+		const char *path = rr->items[i].path;
+		write(out_fd, rr->items[i].util, 40);
+		write(out_fd, "\t", 1);
+		write(out_fd, path, strlen(path) + 1);
+	}
+	close(out_fd);
+	return commit_lock_file(&write_lock);
+}
+
+struct buffer {
+	char *ptr;
+	int nr, alloc;
+};
+
+static void append_line(struct buffer *buffer, const char *line)
+{
+	int len = strlen(line);
+
+	if (buffer->nr + len > buffer->alloc) {
+		buffer->alloc = alloc_nr(buffer->nr + len);
+		buffer->ptr = xrealloc(buffer->ptr, buffer->alloc);
+	}
+	memcpy(buffer->ptr + buffer->nr, line, len);
+	buffer->nr += len;
+}
+
+static int handle_file(const char *path,
+	 unsigned char *sha1, const char *output)
+{
+	SHA_CTX ctx;
+	char buf[1024];
+	int hunk = 0, hunk_no = 0;
+	struct buffer minus = { NULL, 0, 0 }, plus = { NULL, 0, 0 };
+	struct buffer *one = &minus, *two = &plus;
+	FILE *f = fopen(path, "r");
+	FILE *out;
+
+	if (!f)
+		return error("Could not open %s", path);
+
+	if (output) {
+		out = fopen(output, "w");
+		if (!out) {
+			fclose(f);
+			return error("Could not write %s", output);
+		}
+	} else
+		out = NULL;
+
+	if (sha1)
+		SHA1_Init(&ctx);
+
+	while (fgets(buf, sizeof(buf), f)) {
+		if (!strncmp("<<<<<<< ", buf, 8))
+			hunk = 1;
+		else if (!strncmp("=======", buf, 7))
+			hunk = 2;
+		else if (!strncmp(">>>>>>> ", buf, 8)) {
+			hunk_no++;
+			hunk = 0;
+			if (memcmp(one->ptr, two->ptr, one->nr < two->nr ?
+						one->nr : two->nr) > 0) {
+				struct buffer *swap = one;
+				one = two;
+				two = swap;
+			}
+			if (out) {
+				fputs("<<<<<<<\n", out);
+				fwrite(one->ptr, one->nr, 1, out);
+				fputs("=======\n", out);
+				fwrite(two->ptr, two->nr, 1, out);
+				fputs(">>>>>>>\n", out);
+			}
+			if (sha1) {
+				SHA1_Update(&ctx, one->ptr, one->nr);
+				SHA1_Update(&ctx, "\0", 1);
+				SHA1_Update(&ctx, two->ptr, two->nr);
+				SHA1_Update(&ctx, "\0", 1);
+			}
+		} else if (hunk == 1)
+			append_line(one, buf);
+		else if (hunk == 2)
+			append_line(two, buf);
+		else if (out)
+			fputs(buf, out);
+	}
+
+	fclose(f);
+	if (out)
+		fclose(out);
+	if (sha1)
+		SHA1_Final(sha1, &ctx);
+	return hunk_no;
+}
+
+static int find_conflict(struct path_list *conflict)
+{
+	int i;
+	if (read_cache() < 0)
+		return error("Could not read index");
+	for (i = 0; i + 2 < active_nr; i++) {
+		struct cache_entry *e1 = active_cache[i];
+		struct cache_entry *e2 = active_cache[i + 1];
+		struct cache_entry *e3 = active_cache[i + 2];
+		if (ce_stage(e1) == 1 && ce_stage(e2) == 2 &&
+				ce_stage(e3) == 3 && ce_same_name(e1, e2) &&
+				ce_same_name(e1, e3)) {
+			path_list_insert((const char *)e1->name, conflict);
+			i += 3;
+		}
+	}
+	return 0;
+}
+
+static int merge(const char *name, const char *path)
+{
+	int ret;
+	mmfile_t cur, base, other;
+	mmbuffer_t result = {NULL, 0};
+	xpparam_t xpp = {XDF_NEED_MINIMAL};
+
+	if (handle_file(path, NULL, rr_path(name, "thisimage")) < 0)
+		return 1;
+
+	if (read_mmfile(&cur, rr_path(name, "thisimage")) ||
+			read_mmfile(&base, rr_path(name, "preimage")) ||
+			read_mmfile(&other, rr_path(name, "postimage")))
+		return 1;
+	ret = xdl_merge(&base, &cur, "", &other, "",
+			&xpp, XDL_MERGE_ZEALOUS, &result);
+	if (!ret) {
+		FILE *f = fopen(path, "w");
+		if (!f)
+			return error("Could not write to %s", path);
+		fwrite(result.ptr, result.size, 1, f);
+		fclose(f);
+	}
+
+	free(cur.ptr);
+	free(base.ptr);
+	free(other.ptr);
+	free(result.ptr);
+
+	return ret;
+}
+
+static void unlink_rr_item(const char *name)
+{
+	unlink(rr_path(name, "thisimage"));
+	unlink(rr_path(name, "preimage"));
+	unlink(rr_path(name, "postimage"));
+	rmdir(git_path("rr-cache/%s", name));
+}
+
+static void garbage_collect(struct path_list *rr)
+{
+	struct path_list to_remove = { NULL, 0, 0, 1 };
+	char buf[1024];
+	DIR *dir;
+	struct dirent *e;
+	int len, i, cutoff;
+	time_t now = time(NULL), then;
+
+	strlcpy(buf, git_path("rr-cache"), sizeof(buf));
+	len = strlen(buf);
+	dir = opendir(buf);
+	strcpy(buf + len++, "/");
+	while ((e = readdir(dir))) {
+		const char *name = e->d_name;
+		struct stat st;
+		if (name[0] == '.' && (name[1] == '\0' ||
+					(name[1] == '.' && name[2] == '\0')))
+			continue;
+		i = snprintf(buf + len, sizeof(buf) - len, "%s", name);
+		strlcpy(buf + len + i, "/preimage", sizeof(buf) - len - i);
+		if (stat(buf, &st))
+			continue;
+		then = st.st_mtime;
+		strlcpy(buf + len + i, "/postimage", sizeof(buf) - len - i);
+		cutoff = stat(buf, &st) ? cutoff_noresolve : cutoff_resolve;
+		if (then < now - cutoff * 86400) {
+			buf[len + i] = '\0';
+			path_list_insert(xstrdup(name), &to_remove);
+		}
+	}
+	for (i = 0; i < to_remove.nr; i++)
+		unlink_rr_item(to_remove.items[i].path);
+	path_list_clear(&to_remove, 0);
+}
+
+static int outf(void *dummy, mmbuffer_t *ptr, int nbuf)
+{
+	int i;
+	for (i = 0; i < nbuf; i++)
+		write(1, ptr[i].ptr, ptr[i].size);
+	return 0;
+}
+
+static int diff_two(const char *file1, const char *label1,
+		const char *file2, const char *label2)
+{
+	xpparam_t xpp;
+	xdemitconf_t xecfg;
+	xdemitcb_t ecb;
+	mmfile_t minus, plus;
+
+	if (read_mmfile(&minus, file1) || read_mmfile(&plus, file2))
+		return 1;
+
+	printf("--- a/%s\n+++ b/%s\n", label1, label2);
+	fflush(stdout);
+	xpp.flags = XDF_NEED_MINIMAL;
+	xecfg.ctxlen = 3;
+	xecfg.flags = 0;
+	ecb.outf = outf;
+	xdl_diff(&minus, &plus, &xpp, &xecfg, &ecb);
+
+	free(minus.ptr);
+	free(plus.ptr);
+	return 0;
+}
+
+static int copy_file(const char *src, const char *dest)
+{
+	FILE *in, *out;
+	char buffer[32768];
+	int count;
+
+	if (!(in = fopen(src, "r")))
+		return error("Could not open %s", src);
+	if (!(out = fopen(dest, "w")))
+		return error("Could not open %s", dest);
+	while ((count = fread(buffer, 1, sizeof(buffer), in)))
+		fwrite(buffer, 1, count, out);
+	fclose(in);
+	fclose(out);
+	return 0;
+	
+}
+
+static int do_plain_rerere(struct path_list *rr, int fd)
+{
+	struct path_list conflict = { NULL, 0, 0, 1 };
+	int i;
+
+	find_conflict(&conflict);
+
+	/*
+	 * MERGE_RR records paths with conflicts immediately after merge
+	 * failed.  Some of the conflicted paths might have been hand resolved
+	 * in the working tree since then, but the initial run would catch all
+	 * and register their preimages.
+	 */
+
+	for (i = 0; i < conflict.nr; i++) {
+		const char *path = conflict.items[i].path;
+		if (!path_list_has_path(rr, path)) {
+			unsigned char sha1[20];
+			char *hex;
+			int ret;
+			ret = handle_file(path, sha1, NULL);
+			if (ret < 1)
+				continue;
+			hex = xstrdup(sha1_to_hex(sha1));
+			path_list_insert(path, rr)->util = hex;
+			if (mkdir(git_path("rr-cache/%s", hex), 0755))
+				continue;;
+			handle_file(path, NULL, rr_path(hex, "preimage"));
+			fprintf(stderr, "Recorded preimage for '%s'\n", path);
+		}
+	}
+
+	/*
+	 * Now some of the paths that had conflicts earlier might have been
+	 * hand resolved.  Others may be similar to a conflict already that
+	 * was resolved before.
+	 */
+
+	for (i = 0; i < rr->nr; i++) {
+		struct stat st;
+		int ret;
+		const char *path = rr->items[i].path;
+		const char *name = (const char *)rr->items[i].util;
+
+		if (!stat(rr_path(name, "preimage"), &st) &&
+				!stat(rr_path(name, "postimage"), &st)) {
+			if (!merge(name, path)) {
+				fprintf(stderr, "Resolved '%s' using "
+						"previous resolution.\n", path);
+				goto tail_optimization;
+			}
+		}
+
+		/* Let's see if we have resolved it. */
+		ret = handle_file(path, NULL, NULL);
+		if (ret)
+			continue;
+
+		fprintf(stderr, "Recorded resolution for '%s'.\n", path);
+		copy_file(path, rr_path(name, "postimage"));
+tail_optimization:
+		if (i < rr->nr - 1) {
+			memmove(rr->items + i,
+					rr->items + i + 1,
+					rr->nr - i - 1);
+		}
+		rr->nr--;
+		i--;
+	}
+
+	return write_rr(rr, fd);
+}
+
+int cmd_rerere(int argc, const char **argv, const char *prefix)
+{
+	struct path_list merge_rr = { NULL, 0, 0, 1 };
+	int i, fd = -1;
+	struct stat st;
+
+	if (stat(git_path("rr-cache"), &st) || !S_ISDIR(st.st_mode))
+		return 0;
+
+	merge_rr_path = xstrdup(git_path("rr-cache/MERGE_RR"));
+	fd = hold_lock_file_for_update(&write_lock, merge_rr_path, 1);
+	read_rr(&merge_rr);
+
+	if (argc < 2)
+		return do_plain_rerere(&merge_rr, fd);
+	else if (!strcmp(argv[1], "clear")) {
+		for (i = 0; i < merge_rr.nr; i++) {
+			const char *name = (const char *)merge_rr.items[i].util;
+			if (!stat(git_path("rr-cache/%s", name), &st) &&
+					S_ISDIR(st.st_mode) &&
+					stat(rr_path(name, "postimage"), &st))
+				unlink_rr_item(name);
+		}
+		unlink(merge_rr_path);
+	} else if (!strcmp(argv[1], "gc"))
+		garbage_collect(&merge_rr);
+	else if (!strcmp(argv[1], "status"))
+		for (i = 0; i < merge_rr.nr; i++)
+			printf("%s\n", merge_rr.items[i].path);
+	else if (!strcmp(argv[1], "diff"))
+		for (i = 0; i < merge_rr.nr; i++) {
+			const char *path = merge_rr.items[i].path;
+			const char *name = (const char *)merge_rr.items[i].util;
+			diff_two(rr_path(name, "preimage"), path, path, path);
+		}
+	else
+		usage(git_rerere_usage);
+
+	path_list_clear(&merge_rr, 1);
+	return 0;
+}
+
diff --git a/builtin.h b/builtin.h
index 08519e7..8ffd8b2 100644
--- a/builtin.h
+++ b/builtin.h
@@ -52,6 +52,7 @@ extern int cmd_prune_packed(int argc, const char **argv, const char *prefix);
 extern int cmd_push(int argc, const char **argv, const char *prefix);
 extern int cmd_read_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_repo_config(int argc, const char **argv, const char *prefix);
+extern int cmd_rerere(int argc, const char **argv, const char *prefix);
 extern int cmd_rev_list(int argc, const char **argv, const char *prefix);
 extern int cmd_rev_parse(int argc, const char **argv, const char *prefix);
 extern int cmd_rm(int argc, const char **argv, const char *prefix);
diff --git a/git-rerere.perl b/git-rerere.perl
deleted file mode 100755
index 4f69209..0000000
--- a/git-rerere.perl
+++ /dev/null
@@ -1,284 +0,0 @@
-#!/usr/bin/perl
-#
-# REuse REcorded REsolve.  This tool records a conflicted automerge
-# result and its hand resolution, and helps to resolve future
-# automerge that results in the same conflict.
-#
-# To enable this feature, create a directory 'rr-cache' under your
-# .git/ directory.
-
-use Digest;
-use File::Path;
-use File::Copy;
-
-my $git_dir = $::ENV{GIT_DIR} || ".git";
-my $rr_dir = "$git_dir/rr-cache";
-my $merge_rr = "$git_dir/rr-cache/MERGE_RR";
-
-my %merge_rr = ();
-
-sub read_rr {
-	if (!-f $merge_rr) {
-		%merge_rr = ();
-		return;
-	}
-	my $in;
-	local $/ = "\0";
-	open $in, "<$merge_rr" or die "$!: $merge_rr";
-	while (<$in>) {
-		chomp;
-		my ($name, $path) = /^([0-9a-f]{40})\t(.*)$/s;
-		$merge_rr{$path} = $name;
-	}
-	close $in;
-}
-
-sub write_rr {
-	my $out;
-	open $out, ">$merge_rr" or die "$!: $merge_rr";
-	for my $path (sort keys %merge_rr) {
-		my $name = $merge_rr{$path};
-		print $out "$name\t$path\0";
-	}
-	close $out;
-}
-
-sub compute_conflict_name {
-	my ($path) = @_;
-	my @side = ();
-	my $in;
-	open $in, "<$path"  or die "$!: $path";
-
-	my $sha1 = Digest->new("SHA-1");
-	my $hunk = 0;
-	while (<$in>) {
-		if (/^<<<<<<< .*/) {
-			$hunk++;
-			@side = ([], undef);
-		}
-		elsif (/^=======$/) {
-			$side[1] = [];
-		}
-		elsif (/^>>>>>>> .*/) {
-			my ($one, $two);
-			$one = join('', @{$side[0]});
-			$two = join('', @{$side[1]});
-			if ($two le $one) {
-				($one, $two) = ($two, $one);
-			}
-			$sha1->add($one);
-			$sha1->add("\0");
-			$sha1->add($two);
-			$sha1->add("\0");
-			@side = ();
-		}
-		elsif (@side == 0) {
-			next;
-		}
-		elsif (defined $side[1]) {
-			push @{$side[1]}, $_;
-		}
-		else {
-			push @{$side[0]}, $_;
-		}
-	}
-	close $in;
-	return ($sha1->hexdigest, $hunk);
-}
-
-sub record_preimage {
-	my ($path, $name) = @_;
-	my @side = ();
-	my ($in, $out);
-	open $in, "<$path"  or die "$!: $path";
-	open $out, ">$name" or die "$!: $name";
-
-	while (<$in>) {
-		if (/^<<<<<<< .*/) {
-			@side = ([], undef);
-		}
-		elsif (/^=======$/) {
-			$side[1] = [];
-		}
-		elsif (/^>>>>>>> .*/) {
-			my ($one, $two);
-			$one = join('', @{$side[0]});
-			$two = join('', @{$side[1]});
-			if ($two le $one) {
-				($one, $two) = ($two, $one);
-			}
-			print $out "<<<<<<<\n";
-			print $out $one;
-			print $out "=======\n";
-			print $out $two;
-			print $out ">>>>>>>\n";
-			@side = ();
-		}
-		elsif (@side == 0) {
-			print $out $_;
-		}
-		elsif (defined $side[1]) {
-			push @{$side[1]}, $_;
-		}
-		else {
-			push @{$side[0]}, $_;
-		}
-	}
-	close $out;
-	close $in;
-}
-
-sub find_conflict {
-	my $in;
-	local $/ = "\0";
-	my $pid = open($in, '-|');
-	die "$!" unless defined $pid;
-	if (!$pid) {
-		exec(qw(git ls-files -z -u)) or die "$!: ls-files";
-	}
-	my %path = ();
-	my @path = ();
-	while (<$in>) {
-		chomp;
-		my ($mode, $sha1, $stage, $path) =
-		    /^([0-7]+) ([0-9a-f]{40}) ([123])\t(.*)$/s;
-		$path{$path} |= (1 << $stage);
-	}
-	close $in;
-	while (my ($path, $status) = each %path) {
-		if ($status == 14) { push @path, $path; }
-	}
-	return @path;
-}
-
-sub merge {
-	my ($name, $path) = @_;
-	record_preimage($path, "$rr_dir/$name/thisimage");
-	unless (system('git', 'merge-file', map { "$rr_dir/$name/${_}image" }
-		       qw(this pre post))) {
-		my $in;
-		open $in, "<$rr_dir/$name/thisimage" or
-		    die "$!: $name/thisimage";
-		my $out;
-		open $out, ">$path" or die "$!: $path";
-		while (<$in>) { print $out $_; }
-		close $in;
-		close $out;
-		return 1;
-	}
-	return 0;
-}
-
-sub garbage_collect_rerere {
-	# We should allow specifying these from the command line and
-	# that is why the caller gives @ARGV to us, but I am lazy.
-
-	my $cutoff_noresolve = 15; # two weeks
-	my $cutoff_resolve = 60; # two months
-	my @to_remove;
-	while (<$rr_dir/*/preimage>) {
-		my ($dir) = /^(.*)\/preimage$/;
-		my $cutoff = ((-f "$dir/postimage")
-			      ? $cutoff_resolve
-			      : $cutoff_noresolve);
-		my $age = -M "$_";
-		if ($cutoff <= $age) {
-			push @to_remove, $dir;
-		}
-	}
-	if (@to_remove) {
-		rmtree(\@to_remove);
-	}
-}
-
--d "$rr_dir" || exit(0);
-
-read_rr();
-
-if (@ARGV) {
-	my $arg = shift @ARGV;
-	if ($arg eq 'clear') {
-		for my $path (keys %merge_rr) {
-			my $name = $merge_rr{$path};
-			if (-d "$rr_dir/$name" &&
-			    ! -f "$rr_dir/$name/postimage") {
-				rmtree(["$rr_dir/$name"]);
-			}
-		}
-		unlink $merge_rr;
-	}
-	elsif ($arg eq 'status') {
-		for my $path (keys %merge_rr) {
-			print $path, "\n";
-		}
-	}
-	elsif ($arg eq 'diff') {
-		for my $path (keys %merge_rr) {
-			my $name = $merge_rr{$path};
-			system('diff', ((@ARGV == 0) ? ('-u') : @ARGV),
-				'-L', "a/$path", '-L', "b/$path",
-				"$rr_dir/$name/preimage", $path);
-		}
-	}
-	elsif ($arg eq 'gc') {
-		garbage_collect_rerere(@ARGV);
-	}
-	else {
-		die "$0 unknown command: $arg\n";
-	}
-	exit 0;
-}
-
-my %conflict = map { $_ => 1 } find_conflict();
-
-# MERGE_RR records paths with conflicts immediately after merge
-# failed.  Some of the conflicted paths might have been hand resolved
-# in the working tree since then, but the initial run would catch all
-# and register their preimages.
-
-for my $path (keys %conflict) {
-	# This path has conflict.  If it is not recorded yet,
-	# record the pre-image.
-	if (!exists $merge_rr{$path}) {
-		my ($name, $hunk) = compute_conflict_name($path);
-		next unless ($hunk);
-		$merge_rr{$path} = $name;
-		if (! -d "$rr_dir/$name") {
-			mkpath("$rr_dir/$name", 0, 0777);
-			print STDERR "Recorded preimage for '$path'\n";
-			record_preimage($path, "$rr_dir/$name/preimage");
-		}
-	}
-}
-
-# Now some of the paths that had conflicts earlier might have been
-# hand resolved.  Others may be similar to a conflict already that
-# was resolved before.
-
-for my $path (keys %merge_rr) {
-	my $name = $merge_rr{$path};
-
-	# We could resolve this automatically if we have images.
-	if (-f "$rr_dir/$name/preimage" &&
-	    -f "$rr_dir/$name/postimage") {
-		if (merge($name, $path)) {
-			print STDERR "Resolved '$path' using previous resolution.\n";
-			# Then we do not have to worry about this path
-			# anymore.
-			delete $merge_rr{$path};
-			next;
-		}
-	}
-
-	# Let's see if we have resolved it.
-	(undef, my $hunk) = compute_conflict_name($path);
-	next if ($hunk);
-
-	print STDERR "Recorded resolution for '$path'.\n";
-	copy($path, "$rr_dir/$name/postimage");
-	# And we do not have to worry about this path anymore.
-	delete $merge_rr{$path};
-}
-
-# Write out the rest.
-write_rr();
diff --git a/git.c b/git.c
index 016ee8a..202f25d 100644
--- a/git.c
+++ b/git.c
@@ -257,6 +257,7 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 		{ "push", cmd_push, RUN_SETUP },
 		{ "read-tree", cmd_read_tree, RUN_SETUP },
 		{ "repo-config", cmd_repo_config },
+		{ "rerere", cmd_rerere, RUN_SETUP },
 		{ "rev-list", cmd_rev_list, RUN_SETUP },
 		{ "rev-parse", cmd_rev_parse, RUN_SETUP },
 		{ "rm", cmd_rm, RUN_SETUP },
-- 
1.4.4.2.g35224

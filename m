From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] shortstatus v1
Date: Tue, 10 Feb 2009 14:25:39 -0800
Message-ID: <7vtz72kjz0.fsf@gitster.siamese.dyndns.org>
References: <1234227067-56666-1-git-send-email-tuncer.ayaz@gmail.com>
 <20090210110330.GB12089@coredump.intra.peff.net>
 <7vwsbynv0o.fsf@gitster.siamese.dyndns.org>
 <20090210181052.GA19634@coredump.intra.peff.net>
 <20090210191118.GA26651@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tuncer Ayaz <tuncer.ayaz@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 10 23:27:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX14Y-0001CD-5P
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 23:27:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756060AbZBJWZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 17:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756027AbZBJWZt
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 17:25:49 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49110 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755405AbZBJWZt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 17:25:49 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A5C519822A;
	Tue, 10 Feb 2009 17:25:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E0A8C98227; Tue,
 10 Feb 2009 17:25:41 -0500 (EST)
In-Reply-To: <20090210191118.GA26651@coredump.intra.peff.net> (Jeff King's
 message of "Tue, 10 Feb 2009 14:11:18 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C331A3C4-F7C1-11DD-B562-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109323>

Jeff King <peff@peff.net> writes:

> Warm cache, it runs in .042s on my git repo, about half of which is the
> untracked files check. It takes about .49s on the kernel repo. The
> read_directory() bit is not optimized at all, and could probably benefit
> from an early return (OTOH, the worst case is still going to need to
> look at every path).

I suspect that with a large tree your have_untracked() would show
unnecessary overhead from dir_add_name(), because you only want one bit of
information but there is no way to stop with "ok, we know enough".  This
toy patch adds a trivial "early return" to read_directory() codepath, but
there are two sad things about it.

 * In order to cheaply run "is there a single other file", you really
   should scan the level you have already opened first before digging
   deeper.  I didn't bother because the primary use of read_directory is
   the depth first traversal.

 * In a cloned work tree, the tracked files and directories come early in
   the physical directory and then crufts you created yourself comes at
   the end in readdir() order.  We tend to read a lot of tracked ones
   first and the finally hit other files.

 builtin-ministatus.c |    4 +++-
 dir.c                |   32 +++++++++++++++++++++++++++-----
 dir.h                |    2 ++
 3 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/builtin-ministatus.c b/builtin-ministatus.c
index aff9e5a..4b5a191 100644
--- a/builtin-ministatus.c
+++ b/builtin-ministatus.c
@@ -25,7 +25,7 @@ static int have_untracked(void)
 
 	read_directory(&dir, ".", "", 0, NULL);
 	/* XXX we are probably leaking memory from dir */
-	for (i = 0; i < dir.nr; i++)
+	for (i = 0; i < dir.nr; i++) {
 		struct dir_entry *ent = dir.entries[i];
 		if (cache_name_is_other(ent->name, ent->len))
 			return 1;
@@ -47,6 +47,8 @@ int cmd_ministatus(int argc, const char **argv, const char *prefix)
 		putchar('*');
 	if (have_untracked())
 		putchar('?');
+	if (untracked_files_exist())
+		putchar('%');
 
 	return 0;
 }
diff --git a/dir.c b/dir.c
index cfd1ea5..8d4fcdd 100644
--- a/dir.c
+++ b/dir.c
@@ -16,7 +16,10 @@ struct path_simplify {
 
 static int read_directory_recursive(struct dir_struct *dir,
 	const char *path, const char *base, int baselen,
-	int check_only, const struct path_simplify *simplify);
+	int mode, const struct path_simplify *simplify);
+#define READ_DIRECTORY_EMPTY_CHECK 1
+#define READ_DIRECTORY_OTHER_CHECK 2
+
 static int get_dtype(struct dirent *de, const char *path);
 
 int common_prefix(const char **pathspec)
@@ -505,7 +508,8 @@ static enum directory_treatment treat_directory(struct dir_struct *dir,
 	/* This is the "show_other_directories" case */
 	if (!dir->hide_empty_directories)
 		return show_directory;
-	if (!read_directory_recursive(dir, dirname, dirname, len, 1, simplify))
+	if (!read_directory_recursive(dir, dirname, dirname, len,
+				      READ_DIRECTORY_EMPTY_CHECK, simplify))
 		return ignore_directory;
 	return show_directory;
 }
@@ -574,10 +578,12 @@ static int get_dtype(struct dirent *de, const char *path)
  * Also, we ignore the name ".git" (even if it is not a directory).
  * That likely will not change.
  */
-static int read_directory_recursive(struct dir_struct *dir, const char *path, const char *base, int baselen, int check_only, const struct path_simplify *simplify)
+static int read_directory_recursive(struct dir_struct *dir, const char *path, const char *base, int baselen, int mode, const struct path_simplify *simplify)
 {
 	DIR *fdir = opendir(path);
 	int contents = 0;
+	int empty_check_only = (mode == READ_DIRECTORY_EMPTY_CHECK);
+	int other_check_only = (mode == READ_DIRECTORY_OTHER_CHECK);
 
 	if (fdir) {
 		struct dirent *de;
@@ -639,7 +645,7 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
 					break;
 				case recurse_into_directory:
 					contents += read_directory_recursive(dir,
-						fullname, fullname, baselen + len, 0, simplify);
+						fullname, fullname, baselen + len, mode, simplify);
 					continue;
 				case ignore_directory:
 					continue;
@@ -650,10 +656,12 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
 				break;
 			}
 			contents++;
-			if (check_only)
+			if (empty_check_only)
 				goto exit_early;
 			else
 				dir_add_name(dir, fullname, baselen + len);
+			if (other_check_only && dir->nr)
+				goto exit_early;
 		}
 exit_early:
 		closedir(fdir);
@@ -731,6 +739,20 @@ int read_directory(struct dir_struct *dir, const char *path, const char *base, i
 	return dir->nr;
 }
 
+int untracked_files_exist(void)
+{
+	struct dir_struct dir;
+	int i;
+
+	memset(&dir, 0, sizeof(dir));
+	setup_standard_excludes(&dir);
+	read_directory_recursive(&dir, ".", "", 0, READ_DIRECTORY_OTHER_CHECK,
+				 NULL);
+	for (i = 0; i < dir.nr; i++)
+		free(dir.entries[i]);
+	return !!dir.nr;
+}
+
 int file_exists(const char *f)
 {
 	struct stat sb;
diff --git a/dir.h b/dir.h
index bdc2d47..1f8b575 100644
--- a/dir.h
+++ b/dir.h
@@ -92,4 +92,6 @@ extern int remove_dir_recursively(struct strbuf *path, int only_empty);
 /* tries to remove the path with empty directories along it, ignores ENOENT */
 extern int remove_path(const char *path);
 
+extern int untracked_files_exist(void);
+
 #endif

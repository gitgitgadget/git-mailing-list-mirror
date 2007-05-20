From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Commit ID in exported Tar Ball
Date: Sun, 20 May 2007 13:20:31 +0200
Message-ID: <46502EFF.2080104@lsrfire.ath.cx>
References: <20070517163803.GE4095@cip.informatik.uni-erlangen.de>	<200705171857.22891.johan@herland.net>	<20070517171150.GL5272@planck.djpig.de>	<464F5CA2.3070809@lsrfire.ath.cx> <7vd50wv88t.fsf@assigned-by-dhcp.cox.net> <464F932D.6040509@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Frank Lichtenheld <frank@lichtenheld.de>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Thomas Glanzmann <thomas@glanzmann.de>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 13:20:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpjSu-0004dq-2D
	for gcvg-git@gmane.org; Sun, 20 May 2007 13:20:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754965AbXETLUi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 07:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755044AbXETLUi
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 07:20:38 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:58445
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754357AbXETLUi (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 May 2007 07:20:38 -0400
Received: from [10.0.1.201] (p508E617B.dip.t-dialin.net [80.142.97.123])
	by neapel230.server4you.de (Postfix) with ESMTP id 35BB816006;
	Sun, 20 May 2007 13:20:36 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.0 (Windows/20070326)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <464F932D.6040509@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47827>

Turns out a matcher for the kind of pathspecs used in git-archive
is much easier to write than I thought. :-)

This is just a progress note and not for inclusion, yet -- Shawn has
a good point suggesting git-describe output to be used instead of
bare commit IDs.

 Documentation/git-archive.txt |    4 +++
 archive-tar.c                 |    7 ++++++
 archive-zip.c                 |    7 ++++++
 archive.h                     |    1 +
 builtin-archive.c             |   44 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 721e035..7016d1e 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -43,6 +43,10 @@ OPTIONS
 --prefix=<prefix>/::
 	Prepend <prefix>/ to each filename in the archive.
 
+--commit-id-file=<filename>::
+	Adds a file to the archive containing the commit ID.  This option
+	is can only be used if <tree-ish> references a commit or tag.
+
 <extra>::
 	This can be any options that the archiver backend understand.
 	See next section.
diff --git a/archive-tar.c b/archive-tar.c
index 33e7657..555850a 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -319,6 +319,13 @@ int write_tar_archive(struct archiver_args *args)
 	}
 	read_tree_recursive(args->tree, args->base, plen, 0,
 			    args->pathspec, write_tar_entry);
+	if (args->commit_sha1 && args->commit_sha1_file) {
+		unsigned char fake_sha1[20];
+		pretend_sha1_file(sha1_to_hex(args->commit_sha1), 40,
+		                  OBJ_BLOB, fake_sha1);
+		write_tar_entry(fake_sha1, args->base, plen,
+		                args->commit_sha1_file, 0100666, 0);
+	}
 	write_trailer();
 
 	return 0;
diff --git a/archive-zip.c b/archive-zip.c
index 3cbf6bb..88c5dfa 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -328,6 +328,13 @@ int write_zip_archive(struct archiver_args *args)
 	}
 	read_tree_recursive(args->tree, args->base, plen, 0,
 			    args->pathspec, write_zip_entry);
+	if (args->commit_sha1 && args->commit_sha1_file) {
+		unsigned char fake_sha1[20];
+		pretend_sha1_file(sha1_to_hex(args->commit_sha1), 40,
+		                  OBJ_BLOB, fake_sha1);
+		write_zip_entry(fake_sha1, args->base, plen,
+		                args->commit_sha1_file, 0100666, 0);
+	}
 	write_zip_trailer(args->commit_sha1);
 
 	free(zip_dir);
diff --git a/archive.h b/archive.h
index 6838dc7..020f82f 100644
--- a/archive.h
+++ b/archive.h
@@ -8,6 +8,7 @@ struct archiver_args {
 	const char *base;
 	struct tree *tree;
 	const unsigned char *commit_sha1;
+	const char *commit_sha1_file;
 	time_t time;
 	const char **pathspec;
 	unsigned int verbose : 1;
diff --git a/builtin-archive.c b/builtin-archive.c
index 7f4e409..1fe4d47 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -151,6 +151,7 @@ int parse_archive_args(int argc, const char **argv, struct archiver *ar)
 	int extra_argc = 0;
 	const char *format = "tar";
 	const char *base = "";
+	const char *commit_sha1_file = NULL;
 	int verbose = 0;
 	int i;
 
@@ -174,6 +175,10 @@ int parse_archive_args(int argc, const char **argv, struct archiver *ar)
 			base = arg + 9;
 			continue;
 		}
+		if (!prefixcmp(arg, "--commit-id-file=")) {
+			commit_sha1_file = arg + 17;
+			continue;
+		}
 		if (!strcmp(arg, "--")) {
 			i++;
 			break;
@@ -192,6 +197,11 @@ int parse_archive_args(int argc, const char **argv, struct archiver *ar)
 		usage(archive_usage);
 	if (init_archiver(format, ar) < 0)
 		die("Unknown archive format '%s'", format);
+	if (commit_sha1_file) {
+		size_t namelen = strlen(commit_sha1_file);
+		if (namelen == 0 || commit_sha1_file[namelen - 1] == '/')
+			die("Invalid commit ID file name: %s", commit_sha1_file);
+	}
 
 	if (extra_argc) {
 		if (!ar->parse_extra)
@@ -201,6 +211,7 @@ int parse_archive_args(int argc, const char **argv, struct archiver *ar)
 	}
 	ar->args.verbose = verbose;
 	ar->args.base = base;
+	ar->args.commit_sha1_file = commit_sha1_file;
 
 	return i;
 }
@@ -236,6 +247,32 @@ static const char *extract_remote_arg(int *ac, const char **av)
 	return remote;
 }
 
+static int is_path_in_spec(const struct archiver_args *args, const char *path)
+{
+	unsigned char sha1[20];
+	unsigned int mode;
+	const char *match;
+	const char **pathspec = args->pathspec;
+
+	if (get_tree_entry(args->tree->object.sha1, path, sha1, &mode))
+		return 0;
+	if (!pathspec)
+		return 1;
+	while ((match = *pathspec++) != NULL) {
+		size_t matchlen = strlen(match);
+		if (matchlen == 0)
+			return 1;
+		if (match[matchlen - 1] == '/') {
+			if (!prefixcmp(path, match))
+				return 1;
+		} else {
+			if (!strcmp(path, match))
+				return 1;
+		}
+	}
+	return 0;
+}
+
 int cmd_archive(int argc, const char **argv, const char *prefix)
 {
 	struct archiver ar;
@@ -257,5 +294,12 @@ int cmd_archive(int argc, const char **argv, const char *prefix)
 	parse_treeish_arg(argv, &ar.args, prefix);
 	parse_pathspec_arg(argv + 1, &ar.args);
 
+	if (ar.args.commit_sha1_file) {
+		if (is_path_in_spec(&ar.args, ar.args.commit_sha1_file))
+			die("Commit ID file name already exists in archive.");
+		if (!ar.args.commit_sha1)
+			die("Need a commit to use --commit-id-file, and not a tree.");
+	}
+
 	return ar.write_archive(&ar.args);
 }

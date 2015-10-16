From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] usage: do not insist that standard input must come from a file
Date: Fri, 16 Oct 2015 11:27:42 -0700
Message-ID: <xmqqvba6ekip.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 16 20:27:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zn9jQ-0006jd-Os
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 20:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753784AbbJPS1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2015 14:27:46 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34067 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752860AbbJPS1p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2015 14:27:45 -0400
Received: by padda3 with SMTP id da3so10916231pad.1
        for <git@vger.kernel.org>; Fri, 16 Oct 2015 11:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version
         :content-type;
        bh=l7kANL1aG0UOYVAzV7/+/b1eplalR2Zrf93rQSZOIYY=;
        b=AzrNVTm+pR+Hmr/OaT/B9Xo/j/ULu7IXYEEczjwfSV1tUDQXW55UxWWclJucjtZa1g
         I6WQw7x6ZLHy9HQwPJ5AfMKskqlDGByjrMDJNlvypsd9qCh5ldU/6oCKhEuG+NXtUvsy
         EwBX0V8p1pZFgEB9+T4h1oaN3kShlAyYSYqtpEWbIhWwte3AAsrW7znUvWpysg2O/XcX
         qhQN9kcTVi32kYApTRxYFD0vewK/6sESi0EFJ9mBVJYYQM3h374BYATmY/EADV/xX3E2
         TLOEPHRS3ScHKhLOxYBjJxXyecafEGiY6QG/DTMZFTLeXy4tAn/4IR+nKF2/PSPzkluL
         NSUw==
X-Received: by 10.68.163.194 with SMTP id yk2mr2472883pbb.102.1445020064862;
        Fri, 16 Oct 2015 11:27:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:458e:bb5:8827:32a1])
        by smtp.gmail.com with ESMTPSA id fk8sm22622156pab.33.2015.10.16.11.27.43
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 16 Oct 2015 11:27:43 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279761>

The synopsys text and the usage string of subcommands that read list
of things from the standard input are often shown like this:

	git gostak [--distim] < <list-of-doshes>

This is problematic in a number of ways:

 * The way to use these commands is more often to feed them the
   output from another command, not feed them from a file.

 * Manual pages outside Git, commands that operate on the data read
   from the standard input, e.g "sort", "grep", "sed", etc., are not
   described with such a "< redirection-from-file" in their synopsys
   text.  Our doing so introduces inconsistency.

 * We do not insist on where the output should go, by saying

	git gostak [--distim] < <list-of-doshes> > <output>

 * As it is our convention to enclose placeholders inside <braket>,
   the redirection operator followed by a placeholder filename
   becomes very hard to read, both in the documentation and in the
   help text.

Let's clean them all up, after making sure that the documentation
clearly describes the modes that take information from the standard
input and what kind of things are expected on the input.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * It is very likely that I missed some commands, as I worked from a
   list of files that showed hits from this:

    $ perl -e '
	while (<>) {
		if (/^SYNOPSIS/../^DESCRIPTION/) {
			my $bra = ($_ =~ y/</</);
			my $ket = ($_ =~ y/>/>/);
			if ($bra != $ket) {
				print "$_\n";
			}
		}
	}' Documentation/*.txt

   An unrelated tangent, but we may want to turn show-index.c to a
   built-in (or perhaps deprecate and remove it).

 Documentation/git-cat-file.txt          |  2 +-
 Documentation/git-check-attr.txt        |  4 ++--
 Documentation/git-check-ignore.txt      |  2 +-
 Documentation/git-commit-tree.txt       |  2 +-
 Documentation/git-fmt-merge-msg.txt     |  2 +-
 Documentation/git-get-tar-commit-id.txt | 12 +++++++-----
 Documentation/git-hash-object.txt       |  2 +-
 Documentation/git-mktag.txt             |  5 +++--
 Documentation/git-patch-id.txt          |  4 +++-
 Documentation/git-show-index.txt        |  7 ++++---
 Documentation/git-show-ref.txt          |  2 +-
 Documentation/git-stripspace.txt        |  9 +++++----
 Documentation/git-unpack-objects.txt    |  2 +-
 builtin/cat-file.c                      |  2 +-
 builtin/check-attr.c                    |  2 +-
 builtin/check-ignore.c                  |  2 +-
 builtin/commit-tree.c                   |  2 +-
 builtin/get-tar-commit-id.c             |  2 +-
 builtin/hash-object.c                   |  2 +-
 builtin/mktag.c                         |  2 +-
 builtin/patch-id.c                      |  2 +-
 builtin/show-ref.c                      |  2 +-
 builtin/stripspace.c                    |  4 ++--
 builtin/unpack-objects.c                |  2 +-
 show-index.c                            |  2 +-
 25 files changed, 44 insertions(+), 37 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 3105fc0..eb3d694 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git cat-file' (-t [--allow-unknown-type]| -s [--allow-unknown-type]| -e | -p | <type> | --textconv ) <object>
-'git cat-file' (--batch | --batch-check) [--follow-symlinks] < <list-of-objects>
+'git cat-file' (--batch | --batch-check) [--follow-symlinks]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-check-attr.txt b/Documentation/git-check-attr.txt
index 00e2aa2..07aacf2 100644
--- a/Documentation/git-check-attr.txt
+++ b/Documentation/git-check-attr.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git check-attr' [-a | --all | attr...] [--] pathname...
-'git check-attr' --stdin [-z] [-a | --all | attr...] < <list-of-paths>
+'git check-attr' --stdin [-z] [-a | --all | attr...]
 
 DESCRIPTION
 -----------
@@ -28,7 +28,7 @@ OPTIONS
 	Consider `.gitattributes` in the index only, ignoring the working tree.
 
 --stdin::
-	Read file names from stdin instead of from the command-line.
+	Read pathnames from stdin instead of from the command-line.
 
 -z::
 	The output format is modified to be machine-parseable.
diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-check-ignore.txt
index e35cd04..149b166 100644
--- a/Documentation/git-check-ignore.txt
+++ b/Documentation/git-check-ignore.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git check-ignore' [options] pathname...
-'git check-ignore' [options] --stdin < <list-of-paths>
+'git check-ignore' [options] --stdin
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index a0b5457..48c33d7 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -9,7 +9,7 @@ git-commit-tree - Create a new commit object
 SYNOPSIS
 --------
 [verse]
-'git commit-tree' <tree> [(-p <parent>)...] < changelog
+'git commit-tree' <tree> [(-p <parent>)...]
 'git commit-tree' [(-p <parent>)...] [-S[<keyid>]] [(-m <message>)...]
 		  [(-F <file>)...] <tree>
 
diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
index 55a9a4b..9be6df3 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -9,7 +9,7 @@ git-fmt-merge-msg - Produce a merge commit message
 SYNOPSIS
 --------
 [verse]
-'git fmt-merge-msg' [-m <message>] [--log[=<n>] | --no-log] <$GIT_DIR/FETCH_HEAD
+'git fmt-merge-msg' [-m <message>] [--log[=<n>] | --no-log]
 'git fmt-merge-msg' [-m <message>] [--log[=<n>] | --no-log] -F <file>
 
 DESCRIPTION
diff --git a/Documentation/git-get-tar-commit-id.txt b/Documentation/git-get-tar-commit-id.txt
index 1e2a20d..51804b0 100644
--- a/Documentation/git-get-tar-commit-id.txt
+++ b/Documentation/git-get-tar-commit-id.txt
@@ -9,17 +9,19 @@ git-get-tar-commit-id - Extract commit ID from an archive created using git-arch
 SYNOPSIS
 --------
 [verse]
-'git get-tar-commit-id' < <tarfile>
+'git get-tar-commit-id'
 
 
 DESCRIPTION
 -----------
-Acts as a filter, extracting the commit ID stored in archives created by
-'git archive'.  It reads only the first 1024 bytes of input, thus its
-runtime is not influenced by the size of <tarfile> very much.
+
+Read an archive created by 'git archive' from the standard input and
+extracts the commit ID stored in it.  It reads only the first 1024
+bytes of input, thus its runtime is not influenced by the size of
+the archive very much.
 
 If no commit ID is found, 'git get-tar-commit-id' quietly exists with a
-return code of 1.  This can happen if <tarfile> had not been created
+return code of 1.  This can happen if the archive had not been created
 using 'git archive' or if the first parameter of 'git archive' had been
 a tree ID instead of a commit ID or tag.
 
diff --git a/Documentation/git-hash-object.txt b/Documentation/git-hash-object.txt
index 0c75f3b..45e5ece 100644
--- a/Documentation/git-hash-object.txt
+++ b/Documentation/git-hash-object.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git hash-object' [-t <type>] [-w] [--path=<file>|--no-filters] [--stdin [--literally]] [--] <file>...
-'git hash-object' [-t <type>] [-w] --stdin-paths [--no-filters] < <list-of-paths>
+'git hash-object' [-t <type>] [-w] --stdin-paths [--no-filters]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
index 3ca158b..f4cc202 100644
--- a/Documentation/git-mktag.txt
+++ b/Documentation/git-mktag.txt
@@ -9,7 +9,7 @@ git-mktag - Creates a tag object
 SYNOPSIS
 --------
 [verse]
-'git mktag' < signature_file
+'git mktag'
 
 DESCRIPTION
 -----------
@@ -20,7 +20,8 @@ The output is the new tag's <object> identifier.
 
 Tag Format
 ----------
-A tag signature file has a very simple fixed format: four lines of
+A tag signature file, to be fed from the standard input, has a
+very simple fixed format: four lines of
 
   object <sha1>
   type <typename>
diff --git a/Documentation/git-patch-id.txt b/Documentation/git-patch-id.txt
index 31efc58..7816479 100644
--- a/Documentation/git-patch-id.txt
+++ b/Documentation/git-patch-id.txt
@@ -8,10 +8,12 @@ git-patch-id - Compute unique ID for a patch
 SYNOPSIS
 --------
 [verse]
-'git patch-id' [--stable | --unstable] < <patch>
+'git patch-id' [--stable | --unstable]
 
 DESCRIPTION
 -----------
+Read a patch from the standard input, and compute the patch ID for it.
+
 A "patch ID" is nothing but a sum of SHA-1 of the file diffs associated with a
 patch, with whitespace and line numbers ignored.  As such, it's "reasonably
 stable", but at the same time also reasonably unique, i.e., two patches that
diff --git a/Documentation/git-show-index.txt b/Documentation/git-show-index.txt
index fbdc8ad..b3e7488 100644
--- a/Documentation/git-show-index.txt
+++ b/Documentation/git-show-index.txt
@@ -9,13 +9,14 @@ git-show-index - Show packed archive index
 SYNOPSIS
 --------
 [verse]
-'git show-index' < idx-file
+'git show-index'
 
 
 DESCRIPTION
 -----------
-Reads given idx file for packed Git archive created with
-'git pack-objects' command, and dumps its contents.
+Read an idx file for packed Git archive created with
+'git pack-objects' command from the standard input, and
+dump its contents.
 
 The information it outputs is subset of what you can get from
 'git verify-pack -v'; this command only shows the packfile
diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index 2a6f89b..2c08b08 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 'git show-ref' [-q|--quiet] [--verify] [--head] [-d|--dereference]
 	     [-s|--hash[=<n>]] [--abbrev[=<n>]] [--tags]
 	     [--heads] [--] [<pattern>...]
-'git show-ref' --exclude-existing[=<pattern>] < ref-list
+'git show-ref' --exclude-existing[=<pattern>]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-stripspace.txt b/Documentation/git-stripspace.txt
index 60328d5..2438f76 100644
--- a/Documentation/git-stripspace.txt
+++ b/Documentation/git-stripspace.txt
@@ -9,14 +9,15 @@ git-stripspace - Remove unnecessary whitespace
 SYNOPSIS
 --------
 [verse]
-'git stripspace' [-s | --strip-comments] < input
-'git stripspace' [-c | --comment-lines] < input
+'git stripspace' [-s | --strip-comments]
+'git stripspace' [-c | --comment-lines]
 
 DESCRIPTION
 -----------
 
-Clean the input in the manner used by Git for text such as commit
-messages, notes, tags and branch descriptions.
+Read text, such as commit messages, notes, tags and branch
+descriptions, from the standard input and clean it in the manner
+used by Git.
 
 With no arguments, this will:
 
diff --git a/Documentation/git-unpack-objects.txt b/Documentation/git-unpack-objects.txt
index 07d4329..3e887d1 100644
--- a/Documentation/git-unpack-objects.txt
+++ b/Documentation/git-unpack-objects.txt
@@ -9,7 +9,7 @@ git-unpack-objects - Unpack objects from a packed archive
 SYNOPSIS
 --------
 [verse]
-'git unpack-objects' [-n] [-q] [-r] [--strict] < <packfile>
+'git unpack-objects' [-n] [-q] [-r] [--strict]
 
 
 DESCRIPTION
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 07baad1..c0fd8db 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -426,7 +426,7 @@ static int batch_objects(struct batch_options *opt)
 
 static const char * const cat_file_usage[] = {
 	N_("git cat-file (-t [--allow-unknown-type]|-s [--allow-unknown-type]|-e|-p|<type>|--textconv) <object>"),
-	N_("git cat-file (--batch | --batch-check) [--follow-symlinks] < <list-of-objects>"),
+	N_("git cat-file (--batch | --batch-check) [--follow-symlinks]"),
 	NULL
 };
 
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 21d2bed..265c9ba 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -9,7 +9,7 @@ static int cached_attrs;
 static int stdin_paths;
 static const char * const check_attr_usage[] = {
 N_("git check-attr [-a | --all | <attr>...] [--] <pathname>..."),
-N_("git check-attr --stdin [-z] [-a | --all | <attr>...] < <list-of-paths>"),
+N_("git check-attr --stdin [-z] [-a | --all | <attr>...]"),
 NULL
 };
 
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index dc8d97c..43f3617 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -8,7 +8,7 @@
 static int quiet, verbose, stdin_paths, show_non_matching, no_index;
 static const char * const check_ignore_usage[] = {
 "git check-ignore [<options>] <pathname>...",
-"git check-ignore [<options>] --stdin < <list-of-paths>",
+"git check-ignore [<options>] --stdin",
 NULL
 };
 
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 25aa2cd..8747c0f 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -10,7 +10,7 @@
 #include "utf8.h"
 #include "gpg-interface.h"
 
-static const char commit_tree_usage[] = "git commit-tree [(-p <sha1>)...] [-S[<keyid>]] [-m <message>] [-F <file>] <sha1> <changelog";
+static const char commit_tree_usage[] = "git commit-tree [(-p <sha1>)...] [-S[<keyid>]] [-m <message>] [-F <file>] <sha1>";
 
 static const char *sign_commit;
 
diff --git a/builtin/get-tar-commit-id.c b/builtin/get-tar-commit-id.c
index 6f4147a..e21c541 100644
--- a/builtin/get-tar-commit-id.c
+++ b/builtin/get-tar-commit-id.c
@@ -8,7 +8,7 @@
 #include "quote.h"
 
 static const char builtin_get_tar_commit_id_usage[] =
-"git get-tar-commit-id < <tarfile>";
+"git get-tar-commit-id";
 
 /* ustar header + extended global header content */
 #define RECORDSIZE	(512)
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 07fef3c..43b098b 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -78,7 +78,7 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 {
 	static const char * const hash_object_usage[] = {
 		N_("git hash-object [-t <type>] [-w] [--path=<file> | --no-filters] [--stdin] [--] <file>..."),
-		N_("git hash-object  --stdin-paths < <list-of-paths>"),
+		N_("git hash-object  --stdin-paths"),
 		NULL
 	};
 	const char *type = blob_type;
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 640ab64..031b750 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -154,7 +154,7 @@ int cmd_mktag(int argc, const char **argv, const char *prefix)
 	unsigned char result_sha1[20];
 
 	if (argc != 1)
-		usage("git mktag < signaturefile");
+		usage("git mktag");
 
 	if (strbuf_read(&buf, 0, 4096) < 0) {
 		die_errno("could not read from stdin");
diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index ba34dac..366ce5a 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -165,7 +165,7 @@ static void generate_id_list(int stable)
 	strbuf_release(&line_buf);
 }
 
-static const char patch_id_usage[] = "git patch-id [--stable | --unstable] < patch";
+static const char patch_id_usage[] = "git patch-id [--stable | --unstable]";
 
 static int git_patch_id_config(const char *var, const char *value, void *cb)
 {
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 131ef28..264c392 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -8,7 +8,7 @@
 
 static const char * const show_ref_usage[] = {
 	N_("git show-ref [-q | --quiet] [--verify] [--head] [-d | --dereference] [-s | --hash[=<n>]] [--abbrev[=<n>]] [--tags] [--heads] [--] [<pattern>...]"),
-	N_("git show-ref --exclude-existing[=<pattern>] < <ref-list>"),
+	N_("git show-ref --exclude-existing[=<pattern>]"),
 	NULL
 };
 
diff --git a/builtin/stripspace.c b/builtin/stripspace.c
index 1259ed7..958567a 100644
--- a/builtin/stripspace.c
+++ b/builtin/stripspace.c
@@ -78,8 +78,8 @@ static void comment_lines(struct strbuf *buf)
 }
 
 static const char *usage_msg = "\n"
-"  git stripspace [-s | --strip-comments] < input\n"
-"  git stripspace [-c | --comment-lines] < input";
+"  git stripspace [-s | --strip-comments]\n"
+"  git stripspace [-c | --comment-lines]";
 
 int cmd_stripspace(int argc, const char **argv, const char *prefix)
 {
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 7cc086f..7c3e79c 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -13,7 +13,7 @@
 #include "fsck.h"
 
 static int dry_run, quiet, recover, has_errors, strict;
-static const char unpack_usage[] = "git unpack-objects [-n] [-q] [-r] [--strict] < pack-file";
+static const char unpack_usage[] = "git unpack-objects [-n] [-q] [-r] [--strict]";
 
 /* We always read in 4kB chunks. */
 static unsigned char buffer[4096];
diff --git a/show-index.c b/show-index.c
index 5a9eed7..d9e4903 100644
--- a/show-index.c
+++ b/show-index.c
@@ -2,7 +2,7 @@
 #include "pack.h"
 
 static const char show_index_usage[] =
-"git show-index < <packed archive index>";
+"git show-index";
 
 int main(int argc, char **argv)
 {
-- 
2.6.1-404-gacc2196

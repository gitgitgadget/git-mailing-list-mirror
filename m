From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH 4/5] add --path option to git hash-object
Date: Sun,  3 Aug 2008 18:36:21 +0400
Message-ID: <1217774182-28566-4-git-send-email-dpotapov@gmail.com>
References: <20080803055602.GN7008@dpotapov.dyndns.org>
 <1217774182-28566-1-git-send-email-dpotapov@gmail.com>
 <1217774182-28566-2-git-send-email-dpotapov@gmail.com>
 <1217774182-28566-3-git-send-email-dpotapov@gmail.com>
Cc: Alexander Litvinov <litvinov2004@gmail.com>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>,
	Dmitry Potapov <dpotapov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 03 16:37:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPeia-0007zq-HS
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 16:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755970AbYHCOgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 10:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755915AbYHCOgm
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 10:36:42 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:5157 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755871AbYHCOgl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 10:36:41 -0400
Received: by nf-out-0910.google.com with SMTP id d3so606841nfc.21
        for <git@vger.kernel.org>; Sun, 03 Aug 2008 07:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=R0yBMh/50/R8RTf+Buc4RfFL4eB4XpZ02Da4iL7LJ0c=;
        b=Pus5lrSIuaXZkWJ50X0Moo+2xgv09EpzJ5oPfRjBs9zXFr5G8EtFJEchLFxj7yh969
         fa1+lCIGn+A0QbTHiNFUiMQB+9bYOvcfBdeZ5WIqQq/xbGGfYN9igEmQU7Oq27xPKEE8
         zXgqxexKHk4OkOtliMEXvj+ZBTVStCsfl+kk4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HY9d0i4AFuklda52YkHpfc2KWRAQdymKs1ici16w+b46D6Q/b+lGiSsI5hFG1qHWHA
         JfwFCp8ZiioEPqBS4tBn1Wrfa73jK117QCY71ohEp/RNC/v7UECCO8CcpIlfy/wMIvcj
         mpcy05SaffPSlKaStlp5Ay0Pt/F16pwS4KqKY=
Received: by 10.210.41.1 with SMTP id o1mr12324786ebo.143.1217774199626;
        Sun, 03 Aug 2008 07:36:39 -0700 (PDT)
Received: from localhost ( [85.141.191.110])
        by mx.google.com with ESMTPS id d2sm4600807nfc.31.2008.08.03.07.36.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 03 Aug 2008 07:36:38 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc1.58.gacdf
In-Reply-To: <1217774182-28566-3-git-send-email-dpotapov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91246>

The --path option allows to make filters work as if the file specified
while the actual its location may be different. It is mostly useful for
hashing temporary files outside of the working directory.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
 Documentation/git-hash-object.txt |   12 +++++++++++-
 hash-object.c                     |   19 +++++++++++++------
 t/t1007-hash-object.sh            |   24 ++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-hash-object.txt b/Documentation/git-hash-object.txt
index a4703ec..fececbf 100644
--- a/Documentation/git-hash-object.txt
+++ b/Documentation/git-hash-object.txt
@@ -9,7 +9,7 @@ git-hash-object - Compute object ID and optionally creates a blob from a file
 SYNOPSIS
 --------
 [verse]
-'git hash-object' [-t <type>] [-w] [--stdin] [--] <file>...
+'git hash-object' [-t <type>] [-w] [--path=<file>] [--stdin] [--] <file>...
 'git hash-object' [-t <type>] [-w] --stdin-paths < <list-of-paths>
 
 DESCRIPTION
@@ -37,6 +37,16 @@ OPTIONS
 --stdin-paths::
 	Read file names from stdin instead of from the command-line.
 
+--path::
+	Hash object as it were located at the given path. The location of
+	file does not directly influence on the hash value, but path is
+	used to determine what git filters should be applied to the object
+	before it can be placed to the object database, and, as result of
+	applying filters, the actual blob put into the object database may
+	differ from the given file. This option is mainly useful for hashing
+	temporary files located outside of the working directory or files
+	read from stdin.
+
 Author
 ------
 Written by Junio C Hamano <gitster@pobox.com>
diff --git a/hash-object.c b/hash-object.c
index b658fae..b11f459 100644
--- a/hash-object.c
+++ b/hash-object.c
@@ -21,13 +21,14 @@ static void hash_fd(int fd, const char *type, int write_object, const char *path
 	printf("%s\n", sha1_to_hex(sha1));
 	maybe_flush_or_die(stdout, "hash to stdout");
 }
-static void hash_object(const char *path, const char *type, int write_object)
+static void hash_object(const char *path, const char *type, int write_object,
+			const char *vpath)
 {
 	int fd;
 	fd = open(path, O_RDONLY);
 	if (fd < 0)
 		die("Cannot open %s", path);
-	hash_fd(fd, type, write_object, path);
+	hash_fd(fd, type, write_object, vpath);
 }
 
 static void hash_stdin_paths(const char *type, int write_objects)
@@ -43,14 +44,14 @@ static void hash_stdin_paths(const char *type, int write_objects)
 				die("line is badly quoted");
 			strbuf_swap(&buf, &nbuf);
 		}
-		hash_object(buf.buf, type, write_objects);
+		hash_object(buf.buf, type, write_objects, buf.buf);
 	}
 	strbuf_release(&buf);
 	strbuf_release(&nbuf);
 }
 
 static const char * const hash_object_usage[] = {
-	"git hash-object [-t <type>] [-w] [--stdin] [--] <file>...",
+	"git hash-object [-t <type>] [-w] [--path=<file>] [--stdin] [--] <file>...",
 	"git hash-object  --stdin-paths < <list-of-paths>",
 	NULL
 };
@@ -59,12 +60,14 @@ static const char *type;
 static int write_object;
 static int hashstdin;
 static int stdin_paths;
+static const char *vpath;
 
 static const struct option hash_object_options[] = {
 	OPT_STRING('t', NULL, &type, "type", "object type"),
 	OPT_BOOLEAN('w', NULL, &write_object, "write the object into the object database"),
 	OPT_BOOLEAN( 0 , "stdin", &hashstdin, "read the object from stdin"),
 	OPT_BOOLEAN( 0 , "stdin-paths", &stdin_paths, "read file names from stdin"),
+	OPT_STRING( 0 , "path", &vpath, "file", "process file as it were from this path"),
 	OPT_END()
 };
 
@@ -84,6 +87,8 @@ int main(int argc, const char **argv)
 	if (write_object) {
 		prefix = setup_git_directory();
 		prefix_length = prefix ? strlen(prefix) : 0;
+		if (vpath && prefix)
+			vpath = prefix_filename(prefix, prefix_length, vpath);
 	}
 
 	if (stdin_paths) {
@@ -91,6 +96,8 @@ int main(int argc, const char **argv)
 			errstr = "Can't use --stdin-paths with --stdin";
 		else if (argc)
 			errstr = "Can't specify files with --stdin-paths";
+		else if (vpath)
+			errstr = "Can't use --stdin-paths with --path";
 	}
 	else if (hashstdin > 1)
 		errstr = "Multiple --stdin arguments are not supported";
@@ -101,14 +108,14 @@ int main(int argc, const char **argv)
 	}
 
 	if (hashstdin)
-		hash_fd(0, type, write_object, NULL);
+		hash_fd(0, type, write_object, vpath);
 
 	for (i = 0 ; i < argc; i++) {
 		const char *arg = argv[i];
 
 		if (0 <= prefix_length)
 			arg = prefix_filename(prefix, prefix_length, arg);
-		hash_object(arg, type, write_object);
+		hash_object(arg, type, write_object, vpath ? vpath : arg);
 	}
 
 	if (stdin_paths)
diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index 6d505fa..dbe1f04 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -61,6 +61,10 @@ test_expect_success "Can't pass filenames as arguments with --stdin-paths" '
 	echo example | test_must_fail git hash-object --stdin-paths hello
 '
 
+test_expect_success "Can't use --path with --stdin-paths" '
+	echo example | test_must_fail git hash-object --stdin-paths --path=foo
+'
+
 # Behavior
 
 push_repo
@@ -93,6 +97,26 @@ test_expect_success 'git hash-object --stdin file1 <file0 first operates on file
 	test "$obname1" = "$obname1new"
 '
 
+test_expect_success 'check that approperiate filter is invoke when --path is used' '
+	echo fooQ | tr Q "\\015" > file0 &&
+	cp file0 file1 &&
+	echo "file0 -crlf" > .gitattributes &&
+	echo "file1 crlf" >> .gitattributes &&
+	git config core.autocrlf true &&
+	file0_sha=$(git hash-object file0) &&
+	file1_sha=$(git hash-object file1) &&
+	test "$file0_sha" != "$file1_sha" &&
+	path1_sha=$(git hash-object --path=file1 file0) &&
+	path0_sha=$(git hash-object --path=file0 file1) &&
+	test "$file0_sha" = "$path0_sha" &&
+	test "$file1_sha" = "$path1_sha" &&
+	path1_sha=$(cat file0 | git hash-object --path=file1 --stdin) &&
+	path0_sha=$(cat file1 | git hash-object --path=file0 --stdin) &&
+	test "$file0_sha" = "$path0_sha" &&
+	test "$file1_sha" = "$path1_sha" &&
+	git config --unset core.autocrlf
+'
+
 pop_repo
 
 for args in "-w --stdin" "--stdin -w"; do
-- 
1.6.0.rc1.58.gacdf

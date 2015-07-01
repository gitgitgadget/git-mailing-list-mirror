From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH] fast-import: add a get-mark command
Date: Wed,  1 Jul 2015 17:05:58 +0200
Message-ID: <38cd45cb4930c4af8f8224c44064af99b2900260.1435762878.git.mhagger@alum.mit.edu>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <david.barr@cordelta.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 17:06:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAJae-00031i-Qw
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 17:06:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753572AbbGAPGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 11:06:15 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:42437 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751548AbbGAPGN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jul 2015 11:06:13 -0400
X-AuditID: 12074411-f797e6d000007df3-ac-559401de326a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 99.38.32243.ED104955; Wed,  1 Jul 2015 11:06:06 -0400 (EDT)
Received: from michael.fritz.box (p4FC97DE7.dip0.t-ipconnect.de [79.201.125.231])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t61F639D026210
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 1 Jul 2015 11:06:04 -0400
X-Mailer: git-send-email 2.1.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsUixO6iqHuPcUqowcsNJhannq9hsei60s1k
	0dB7hdni9or5zBbzD01kdWD1+Pv+A5PHnjtzmTwuXlL2+HN+D6vH501yAaxR3DZJiSVlwZnp
	efp2CdwZO2fvYi44aFdx/sdixgbGBqMuRk4OCQETiT+NNxkhbDGJC/fWs3UxcnEICVxmlHjd
	f4wZwjnBJNH97SArSBWbgK7Eop5mJhBbREBNYmLbIRaQImaBhYwSS94eBBslDDR2Q9N8sAYW
	AVWJna0dYDavQJTEmbXTodbJSZw//pN5AiP3AkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW6
	pnq5mSV6qSmlmxghYSK4g3HGSblDjAIcjEo8vBkSk0OFWBPLiitzDzFKcjApifLGfAMK8SXl
	p1RmJBZnxBeV5qQWH2KU4GBWEuG98AUox5uSWFmVWpQPk5LmYFES5+Vbou4nJJCeWJKanZpa
	kFoEk5Xh4FCS4A1mmBIqJFiUmp5akZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ8K9vhiYLiD
	pHiA9iaDtPMWFyTmAkUhWk8xKkqJ8yYA41dIACSRUZoHNxYW/a8YxYG+FOadANLOA0wccN2v
	gAYzAQ1+aT8JZHBJIkJKqoHRM+rcvVcJtdsrFyQ6XT/gffPRr4ei/ivmJYnv7mgO8Tij6/H/
	tamZ27+lJRohS5fpHZsouL/rbc83sSvMv+wqFoV4zZg2N0PqdFPWySk3ZU/r7Z8bxWm82moL
	u+F+Bo7/bWvSDrB1pkx/Wiy86NW/CrV4tcC4OyXKPE0m6eva3X9KbbHsPM+hxFKc 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273154>

It is sometimes useful for importers to be able to read the SHA-1
corresponding to a mark that they have created via fast-import. For
example, they might want to embed the SHA-1 into the commit message of
a later commit. Or it might be useful for internal bookkeeping uses,
or for logging.

Add a "get-mark" command to "git fast-import" that allows the importer
to ask for the value of a mark that has been created earlier.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
This is something that we need for an internal GitHub project, but I
think it will also be of general interest.

 Documentation/git-fast-import.txt | 39 +++++++++++++++++++++++++++++++++------
 fast-import.c                     | 33 +++++++++++++++++++++++++++++----
 t/t9300-fast-import.sh            | 13 +++++++++++++
 3 files changed, 75 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index fd32895..66910aa 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -54,7 +54,7 @@ Options for Frontends
 ~~~~~~~~~~~~~~~~~~~~~
 
 --cat-blob-fd=<fd>::
-	Write responses to `cat-blob` and `ls` queries to the
+	Write responses to `get-mark`, `cat-blob`, and `ls` queries to the
 	file descriptor <fd> instead of `stdout`.  Allows `progress`
 	output intended for the end-user to be separated from other
 	output.
@@ -350,6 +350,11 @@ and control the current import process.  More detailed discussion
 	unless the `done` feature was requested using the
 	`--done` command-line option or `feature done` command.
 
+`get-mark`::
+	Causes fast-import to print the SHA-1 corresponding to a mark
+	to the file descriptor set with `--cat-blob-fd`, or `stdout` if
+	unspecified.
+
 `cat-blob`::
 	Causes fast-import to print a blob in 'cat-file --batch'
 	format to the file descriptor set with `--cat-blob-fd` or
@@ -930,6 +935,25 @@ Placing a `progress` command immediately after a `checkpoint` will
 inform the reader when the `checkpoint` has been completed and it
 can safely access the refs that fast-import updated.
 
+`get-mark`
+~~~~~~~~~~
+Causes fast-import to print the SHA-1 corresponding to a mark to
+stdout or to the file descriptor previously arranged with the
+`--cat-blob-fd` argument. The command otherwise has no impact on the
+current import; its purpose is to retrieve SHA-1s that later commits
+might want to refer to in their commit messages.
+
+....
+	'get-mark' SP ':' <idnum> LF
+....
+
+This command can be used anywhere in the stream that comments are
+accepted.  In particular, the `get-mark` command can be used in the
+middle of a commit but not in the middle of a `data` command.
+
+See ``Responses To Commands'' below for details about how to read
+this output safely.
+
 `cat-blob`
 ~~~~~~~~~~
 Causes fast-import to print a blob to a file descriptor previously
@@ -1000,7 +1024,8 @@ Output uses the same format as `git ls-tree <tree> -- <path>`:
 ====
 
 The <dataref> represents the blob, tree, or commit object at <path>
-and can be used in later 'cat-blob', 'filemodify', or 'ls' commands.
+and can be used in later 'get-mark', 'cat-blob', 'filemodify', or
+'ls' commands.
 
 If there is no file or subtree at that path, 'git fast-import' will
 instead report
@@ -1042,9 +1067,11 @@ import-marks-if-exists::
 	"feature import-marks-if-exists" like a corresponding
 	command-line option silently skips a nonexistent file.
 
+get-mark::
 cat-blob::
 ls::
-	Require that the backend support the 'cat-blob' or 'ls' command.
+	Require that the backend support the 'get-mark', 'cat-blob',
+	or 'ls' command respectively.
 	Versions of fast-import not supporting the specified command
 	will exit with a message indicating so.
 	This lets the import error out early with a clear message,
@@ -1124,11 +1151,11 @@ bidirectional pipes:
 	git fast-import >fast-import-output
 ====
 
-A frontend set up this way can use `progress`, `ls`, and `cat-blob`
-commands to read information from the import in progress.
+A frontend set up this way can use `progress`, `get-mark`, `ls`, and
+`cat-blob` commands to read information from the import in progress.
 
 To avoid deadlock, such frontends must completely consume any
-pending output from `progress`, `ls`, and `cat-blob` before
+pending output from `progress`, `ls`, `get-mark`, and `cat-blob` before
 performing writes to fast-import that might block.
 
 Crash Reports
diff --git a/fast-import.c b/fast-import.c
index 6378726..1ba83d6 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -134,16 +134,17 @@ Format of STDIN stream:
   ts    ::= # time since the epoch in seconds, ascii base10 notation;
   tz    ::= # GIT style timezone;
 
-     # note: comments, ls and cat requests may appear anywhere
-     # in the input, except within a data command.  Any form
-     # of the data command always escapes the related input
-     # from comment processing.
+     # note: comments, get-mark, ls-tree, and cat-blob requests may
+     # appear anywhere in the input, except within a data command. Any
+     # form of the data command always escapes the related input from
+     # comment processing.
      #
      # In case it is not clear, the '#' that starts the comment
      # must be the first character on that line (an lf
      # preceded it).
      #
 
+  get_mark ::= 'get-mark' sp idnum lf;
   cat_blob ::= 'cat-blob' sp (hexsha1 | idnum) lf;
   ls_tree  ::= 'ls' sp (hexsha1 | idnum) sp path_str lf;
 
@@ -372,6 +373,7 @@ static volatile sig_atomic_t checkpoint_requested;
 static int cat_blob_fd = STDOUT_FILENO;
 
 static void parse_argv(void);
+static void parse_get_mark(const char *p);
 static void parse_cat_blob(const char *p);
 static void parse_ls(const char *p, struct branch *b);
 
@@ -1907,6 +1909,10 @@ static int read_next_command(void)
 			rc->prev->next = rc;
 			cmd_tail = rc;
 		}
+		if (skip_prefix(command_buf.buf, "get-mark ", &p)) {
+			parse_get_mark(p);
+			continue;
+		}
 		if (skip_prefix(command_buf.buf, "cat-blob ", &p)) {
 			parse_cat_blob(p);
 			continue;
@@ -2919,6 +2925,23 @@ static void cat_blob(struct object_entry *oe, unsigned char sha1[20])
 		free(buf);
 }
 
+static void parse_get_mark(const char *p)
+{
+	struct object_entry *oe = oe;
+	char output[42];
+
+	/* get-mark SP <object> LF */
+	if (*p != ':')
+		die("Not a mark: %s", p);
+
+	oe = find_mark(parse_mark_ref_eol(p));
+	if (!oe)
+		die("Unknown mark: %s", command_buf.buf);
+
+	snprintf(output, sizeof(output), "%s\n", sha1_to_hex(oe->idx.sha1));
+	cat_blob_write(output, 41);
+}
+
 static void parse_cat_blob(const char *p)
 {
 	struct object_entry *oe = oe;
@@ -3240,6 +3263,8 @@ static int parse_one_feature(const char *feature, int from_stream)
 		option_import_marks(arg, from_stream, 1);
 	} else if (skip_prefix(feature, "export-marks=", &arg)) {
 		option_export_marks(arg);
+	} else if (!strcmp(feature, "get-mark")) {
+		; /* Don't die - this feature is supported */
 	} else if (!strcmp(feature, "cat-blob")) {
 		; /* Don't die - this feature is supported */
 	} else if (!strcmp(feature, "relative-marks")) {
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index aac126f..9984c48 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -2339,6 +2339,19 @@ test_expect_success !MINGW 'R: in-stream cat-blob-fd not respected' '
 	test_cmp expect actual.1
 '
 
+test_expect_success !MINGW 'R: print mark for new blob' '
+	echo "effluentish" | git hash-object --stdin >expect &&
+	git fast-import --cat-blob-fd=6 6>actual <<-\EOF &&
+	blob
+	mark :1
+	data <<BLOB_END
+	effluentish
+	BLOB_END
+	get-mark :1
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success !MINGW 'R: print new blob' '
 	blob=$(echo "yep yep yep" | git hash-object --stdin) &&
 	cat >expect <<-EOF &&
-- 
2.1.4

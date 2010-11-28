From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/4] fast-import: let importers retrieve blobs
Date: Sun, 28 Nov 2010 13:45:01 -0600
Message-ID: <20101128194501.GD19998@burratino>
References: <1287147256-9457-1-git-send-email-david.barr@cordelta.com>
 <1287147256-9457-2-git-send-email-david.barr@cordelta.com>
 <20101128194131.GA19998@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Sun Nov 28 20:45:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMnBT-0003R5-8r
	for gcvg-git-2@lo.gmane.org; Sun, 28 Nov 2010 20:45:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754119Ab0K1TpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Nov 2010 14:45:09 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:59451 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753931Ab0K1TpI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Nov 2010 14:45:08 -0500
Received: by gxk22 with SMTP id 22so1673447gxk.19
        for <git@vger.kernel.org>; Sun, 28 Nov 2010 11:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Pl7oBdYVffJ1HrXgeEOkvDyNvOdu6h6jxLQQONoc/vM=;
        b=u3ohJy4oaVP6D5PWd1vtDvZWwMaJAGFtCM4ND+kmKikDQQByJkzxjZtFlfXGmQ6/SJ
         dLlxy2DlyKVT9gKoQGIHNn4+aiPq+RFEpxZp4d/O3pJ2nkbYKxAlZ8WvCz6GWTfGzFsC
         d9dW1XIKss6zNDx7ZgGF/ca7/CncPhL2/2V0U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=nK2Pnc33LeKQUM9YUKmWieW2WyIjvyZNFkjVUCw3syBYJnHTIIdr9UJ3vH7Ba6XabP
         ATgLbNbdERMU4Ipdbes1+PzjtGbv9UE8uDbA8hje9Lvhh7sKTksGme+mPhOFjsXmX7HX
         yDbRDta1i2whd1vDCC82MHiGIQdwulEi7jsHM=
Received: by 10.100.154.8 with SMTP id b8mr3504502ane.236.1290973507303;
        Sun, 28 Nov 2010 11:45:07 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id b26sm4218367anb.33.2010.11.28.11.45.04
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 28 Nov 2010 11:45:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101128194131.GA19998@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162357>

From: David Barr <david.barr@cordelta.com>

New objects written by fast-import are not available immediately.
Until a checkpoint has been started and finishes writing the pack
index, any new blobs will not be accessible using standard git tools.

So introduce a new way to access them: a "cat-blob" command in the
command stream requests for fast-import to print a blob to stdout or a
file descriptor specified by the argument to --cat-blob-fd.  The value
for cat-blob-fd cannot be specified in the stream because that would
be a layering violation: the decision of where to direct a stream has
to be made when fast-import is started anyway, so we might as well
make the stream format is independent of that detail.

Output uses the same format as "git cat-file --batch".

Thanks to Sverre Rabbelier and Sam Vilain for guidance in designing
the protocol.

Based-on-patch-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
Acked-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
If you use this, you might want to do something like:

	blob 
	mark :1
	data <<EOT
	testing 1 2 3
	EOT
	cat-blob :1

before proceeding with the rest of the stream.  This allows wiring
mistakes to be caught early.

 Documentation/git-fast-import.txt |   41 ++++++++
 fast-import.c                     |   95 ++++++++++++++++++
 t/t9300-fast-import.sh            |  193 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 327 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 3bf04e3..be444da 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -92,6 +92,11 @@ OPTIONS
 	--(no-)-relative-marks= with the --(import|export)-marks=
 	options.
 
+--cat-blob-fd=<fd>::
+	Specify the file descriptor that will be written to
+	when the `cat-blob` command is encountered in the stream.
+	The default behaviour is to write to `stdout`.
+
 --export-pack-edges=<file>::
 	After creating a packfile, print a line of data to
 	<file> listing the filename of the packfile and the last
@@ -320,6 +325,11 @@ and control the current import process.  More detailed discussion
 	standard output.  This command is optional and is not needed
 	to perform an import.
 
+`cat-blob`::
+	Causes fast-import to print a blob in 'cat-file --batch'
+	format to the file descriptor set with `--cat-blob-fd` or
+	`stdout` if unspecified.
+
 `feature`::
 	Require that fast-import supports the specified feature, or
 	abort if it does not.
@@ -872,6 +882,29 @@ Placing a `progress` command immediately after a `checkpoint` will
 inform the reader when the `checkpoint` has been completed and it
 can safely access the refs that fast-import updated.
 
+`cat-blob`
+~~~~~~~~~~
+Causes fast-import to print a blob to a file descriptor previously
+arranged with the `--cat-blob-fd` argument.  The command otherwise
+has no impact on the current import; its main purpose is to
+retrieve blobs that may be in fast-import's memory but not
+accessible from the target repository.
+
+....
+	'cat-blob' SP <dataref> LF
+....
+
+The `<dataref>` can be either a mark reference (`:<idnum>`)
+set previously or a full 40-byte SHA-1 of a Git blob, preexisting or
+ready to be written.
+
+output uses the same format as `git cat-file --batch`:
+
+====
+	<sha1> SP 'blob' SP <size> LF
+	<contents> LF
+====
+
 `feature`
 ~~~~~~~~~
 Require that fast-import supports the specified feature, or abort if
@@ -898,6 +931,13 @@ import-marks::
 	second, an --import-marks= command-line option overrides
 	any "feature import-marks" command in the stream.
 
+cat-blob::
+	Ignored.  Versions of fast-import not supporting the
+	"cat-blob" command will exit with a message indicating so.
+	This lets the import error out early with a clear message,
+	rather than wasting time on the early part of an import
+	before the unsupported command is detected.
+
 `option`
 ~~~~~~~~
 Processes the specified option so that git fast-import behaves in a
@@ -923,6 +963,7 @@ not be passed as option:
 * date-format
 * import-marks
 * export-marks
+* cat-blob-fd
 * force
 
 Crash Reports
diff --git a/fast-import.c b/fast-import.c
index 959afef..88547c6 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -55,6 +55,8 @@ Format of STDIN stream:
     ('from' sp committish lf)?
     lf?;
 
+  cat_blob ::= 'cat-blob' sp (hexsha1 | idnum) lf;
+
   checkpoint ::= 'checkpoint' lf
     lf?;
 
@@ -361,6 +363,9 @@ static uintmax_t next_mark;
 static struct strbuf new_data = STRBUF_INIT;
 static int seen_data_command;
 
+/* Where to write output of cat-blob commands */
+static int cat_blob_fd = STDOUT_FILENO;
+
 static void parse_argv(void);
 
 static void write_branch_report(FILE *rpt, struct branch *b)
@@ -2689,6 +2694,79 @@ static void parse_reset_branch(void)
 		unread_command_buf = 1;
 }
 
+static void cat_blob_write(const char *buf, unsigned long size)
+{
+	if (write_in_full(cat_blob_fd, buf, size) != size)
+		die_errno("Write to frontend failed");
+}
+
+static void cat_blob(struct object_entry *oe, unsigned char sha1[20])
+{
+	struct strbuf line = STRBUF_INIT;
+	unsigned long size;
+	enum object_type type = 0;
+	char *buf;
+
+	if (!oe || oe->pack_id == MAX_PACK_ID) {
+		buf = read_sha1_file(sha1, &type, &size);
+	} else {
+		type = oe->type;
+		buf = gfi_unpack_entry(oe, &size);
+	}
+
+	/*
+	 * Output based on batch_one_object() from cat-file.c.
+	 */
+	if (type <= 0) {
+		strbuf_reset(&line);
+		strbuf_addf(&line, "%s missing\n", sha1_to_hex(sha1));
+		cat_blob_write(line.buf, line.len);
+		free(buf);
+		return;
+	}
+	if (!buf)
+		die("Can't read object %s", sha1_to_hex(sha1));
+	if (type != OBJ_BLOB)
+		die("Object %s is a %s but a blob was expected.",
+		    sha1_to_hex(sha1), typename(type));
+	strbuf_reset(&line);
+	strbuf_addf(&line, "%s %s %lu\n", sha1_to_hex(sha1),
+						typename(type), size);
+	cat_blob_write(line.buf, line.len);
+	cat_blob_write(buf, size);
+	cat_blob_write("\n", 1);
+	free(buf);
+}
+
+static void parse_cat_blob(void)
+{
+	const char *p;
+	struct object_entry *oe = oe;
+	unsigned char sha1[20];
+
+	/* cat-blob SP <object> LF */
+	p = command_buf.buf + strlen("cat-blob ");
+	if (*p == ':') {
+		char *x;
+		oe = find_mark(strtoumax(p + 1, &x, 10));
+		if (x == p + 1)
+			die("Invalid mark: %s", command_buf.buf);
+		if (!oe)
+			die("Unknown mark: %s", command_buf.buf);
+		if (*x)
+			die("Garbage after mark: %s", command_buf.buf);
+		hashcpy(sha1, oe->idx.sha1);
+	} else {
+		if (get_sha1_hex(p, sha1))
+			die("Invalid SHA1: %s", command_buf.buf);
+		if (p[40])
+			die("Garbage after SHA1: %s", command_buf.buf);
+		oe = find_object(sha1);
+	}
+
+	cat_blob(oe, sha1);
+}
+
 static void parse_checkpoint(void)
 {
 	if (object_count) {
@@ -2771,6 +2849,14 @@ static void option_export_marks(const char *marks)
 	export_marks_file = make_fast_import_path(marks);
 }
 
+static void option_cat_blob_fd(const char *fd)
+{
+	unsigned long n = ulong_arg("--cat-blob-fd", fd);
+	if (n > (unsigned long) INT_MAX)
+		die("--cat-blob-fd cannot exceed %d", INT_MAX);
+	cat_blob_fd = (int) n;
+}
+
 static void option_export_pack_edges(const char *edges)
 {
 	if (pack_edges)
@@ -2824,6 +2910,8 @@ static int parse_one_feature(const char *feature, int from_stream)
 		option_import_marks(feature + 13, from_stream);
 	} else if (!prefixcmp(feature, "export-marks=")) {
 		option_export_marks(feature + 13);
+	} else if (!strcmp(feature, "cat-blob")) {
+		; /* Don't die - this feature is supported */
 	} else if (!prefixcmp(feature, "relative-marks")) {
 		relative_marks_paths = 1;
 	} else if (!prefixcmp(feature, "no-relative-marks")) {
@@ -2918,6 +3006,11 @@ static void parse_argv(void)
 		if (parse_one_feature(a + 2, 0))
 			continue;
 
+		if (!prefixcmp(a + 2, "cat-blob-fd=")) {
+			option_cat_blob_fd(a + 2 + strlen("cat-blob-fd="));
+			continue;
+		}
+
 		die("unknown option %s", a);
 	}
 	if (i != global_argc)
@@ -2969,6 +3062,8 @@ int main(int argc, const char **argv)
 			parse_new_tag();
 		else if (!prefixcmp(command_buf.buf, "reset "))
 			parse_reset_branch();
+		else if (!prefixcmp(command_buf.buf, "cat-blob "))
+			parse_cat_blob();
 		else if (!strcmp("checkpoint", command_buf.buf))
 			parse_checkpoint();
 		else if (!prefixcmp(command_buf.buf, "progress "))
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 2c27da6..3e2741b 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -23,11 +23,18 @@ file5_data='an inline file.
 file6_data='#!/bin/sh
 echo "$@"'
 
+>empty
+
 ###
 ### series A
 ###
 
 test_tick
+
+test_expect_success 'empty stream succeeds' '
+	git fast-import </dev/null
+'
+
 cat >input <<INPUT_END
 blob
 mark :2
@@ -1501,6 +1508,190 @@ test_expect_success 'R: feature no-relative-marks should be honoured' '
     test_cmp marks.new non-relative.out
 '
 
+test_expect_success 'R: feature cat-blob supported' '
+	echo "feature cat-blob" |
+	git fast-import
+'
+
+test_expect_success 'R: cat-blob-fd must be a nonnegative integer' '
+	test_must_fail git fast-import --cat-blob-fd=-1 </dev/null
+'
+
+test_expect_success 'R: print old blob' '
+	blob=$(echo "yes it can" | git hash-object -w --stdin) &&
+	cat >expect <<-EOF &&
+	${blob} blob 11
+	yes it can
+
+	EOF
+	echo "cat-blob $blob" |
+	git fast-import --cat-blob-fd=6 6>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'R: in-stream cat-blob-fd not respected' '
+	echo hello >greeting &&
+	blob=$(git hash-object -w greeting) &&
+	cat >expect <<-EOF &&
+	${blob} blob 6
+	hello
+
+	EOF
+	git fast-import --cat-blob-fd=3 3>actual.3 >actual.1 <<-EOF &&
+	cat-blob $blob
+	EOF
+	test_cmp expect actual.3 &&
+	test_cmp empty actual.1 &&
+	git fast-import 3>actual.3 >actual.1 <<-EOF &&
+	option cat-blob-fd=3
+	cat-blob $blob
+	EOF
+	test_cmp empty actual.3 &&
+	test_cmp expect actual.1
+'
+
+test_expect_success 'R: print new blob' '
+	blob=$(echo "yep yep yep" | git hash-object --stdin) &&
+	cat >expect <<-EOF &&
+	${blob} blob 12
+	yep yep yep
+
+	EOF
+	git fast-import --cat-blob-fd=6 6>actual <<-\EOF &&
+	blob
+	mark :1
+	data <<BLOB_END
+	yep yep yep
+	BLOB_END
+	cat-blob :1
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'R: print new blob by sha1' '
+	blob=$(echo "a new blob named by sha1" | git hash-object --stdin) &&
+	cat >expect <<-EOF &&
+	${blob} blob 25
+	a new blob named by sha1
+
+	EOF
+	git fast-import --cat-blob-fd=6 6>actual <<-EOF &&
+	blob
+	data <<BLOB_END
+	a new blob named by sha1
+	BLOB_END
+	cat-blob $blob
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'setup: big file' '
+	(
+		echo "the quick brown fox jumps over the lazy dog" >big &&
+		for i in 1 2 3
+		do
+			cat big big big big >bigger &&
+			cat bigger bigger bigger bigger >big ||
+			exit
+		done
+	)
+'
+
+test_expect_success 'R: print two blobs to stdout' '
+	blob1=$(git hash-object big) &&
+	blob1_len=$(wc -c <big) &&
+	blob2=$(echo hello | git hash-object --stdin) &&
+	{
+		echo ${blob1} blob $blob1_len &&
+		cat big &&
+		cat <<-EOF
+
+		${blob2} blob 6
+		hello
+
+		EOF
+	} >expect &&
+	{
+		cat <<-\END_PART1 &&
+			blob
+			mark :1
+			data <<data_end
+		END_PART1
+		cat big &&
+		cat <<-\EOF
+			data_end
+			blob
+			mark :2
+			data <<data_end
+			hello
+			data_end
+			cat-blob :1
+			cat-blob :2
+		EOF
+	} |
+	git fast-import >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'setup: have pipes?' '
+	rm -f frob &&
+	if mkfifo frob
+	then
+		test_set_prereq PIPE
+	fi
+'
+
+test_expect_success PIPE 'R: copy using cat-file' '
+	expect_id=$(git hash-object big) &&
+	expect_len=$(wc -c <big) &&
+	echo $expect_id blob $expect_len >expect.response &&
+
+	rm -f blobs &&
+	cat >frontend <<-\FRONTEND_END &&
+	#!/bin/sh
+	cat <<EOF &&
+	feature cat-blob
+	blob
+	mark :1
+	data <<BLOB
+	EOF
+	cat big
+	cat <<EOF
+	BLOB
+	cat-blob :1
+	EOF
+
+	read blob_id type size <&3 &&
+	echo "$blob_id $type $size" >response &&
+	dd if=/dev/stdin of=blob bs=$size count=1 <&3 &&
+	read newline <&3 &&
+
+	cat <<EOF &&
+	commit refs/heads/copied
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	copy big file as file3
+	COMMIT
+	M 644 inline file3
+	data <<BLOB
+	EOF
+	cat blob &&
+	cat <<EOF
+	BLOB
+	EOF
+	FRONTEND_END
+
+	mkfifo blobs &&
+	(
+		export GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL GIT_COMMITTER_DATE &&
+		sh frontend 3<blobs |
+		git fast-import --cat-blob-fd=3 3>blobs
+	) &&
+	git show copied:file3 >actual &&
+	test_cmp expect.response response &&
+	test_cmp big actual
+'
+
 cat >input << EOF
 option git quiet
 blob
@@ -1509,8 +1700,6 @@ hi
 
 EOF
 
-touch empty
-
 test_expect_success 'R: quiet option results in no stats being output' '
     cat input | git fast-import 2> output &&
     test_cmp empty output

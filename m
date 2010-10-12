From: David Barr <david.barr@cordelta.com>
Subject: [PATCH 1/7] Teach fast-import to print the id of each imported commit
Date: Wed, 13 Oct 2010 00:50:18 +1100
Message-ID: <1286891424-2067-2-git-send-email-david.barr@cordelta.com>
References: <1286891424-2067-1-git-send-email-david.barr@cordelta.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 12 15:51:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5fGD-0004ii-35
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 15:51:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313Ab0JLNuc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 09:50:32 -0400
Received: from static-198-196.grapevine.transact.net.au ([121.127.198.196]:60854
	"EHLO mailhost.cordelta" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S932219Ab0JLNub (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Oct 2010 09:50:31 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id C6B3AC066;
	Wed, 13 Oct 2010 00:50:32 +1100 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8vTHqHVsL7yV; Wed, 13 Oct 2010 00:50:29 +1100 (EST)
Received: from dba.cordelta (unknown [192.168.123.127])
	by mailhost.cordelta (Postfix) with ESMTP id 80FA4C068;
	Wed, 13 Oct 2010 00:50:29 +1100 (EST)
X-Mailer: git-send-email 1.7.3.1
In-Reply-To: <1286891424-2067-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158845>

From: Jonathan Nieder <jrnieder@gmail.com>

For the svn importer, it would be useful to build a map from
subversion revision numbers to git commits as the import takes place.
This is particularly relevant because the subversion api sometimes
represents as "copy this directory from this revision", and the
importer needs to be able to access the corresponding trees.  So
(optionally) print each commit id when the corresponding object is
written.

Unfortunately when each commit object is written, it is not yet
accessible to the caller until a checkpoint has finished.  A later
patch will teach fast-import to directly pass on the relevant data on
request, using the same channel.

Cc: Shawn O. Pearce <spearce@spearce.org>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-fast-import.txt |   13 +++++++++++++
 fast-import.c                     |   18 ++++++++++++++++++
 t/t9300-fast-import.sh            |   36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 966ba4f..e217635 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -92,6 +92,18 @@ OPTIONS
 	--(no-)-relative-marks= with the --(import|export)-marks=
 	options.
 
+--report-fd=<fd>::
+	Print the 40-character object name for each commit to
+	the specified file descriptor before writing it to the
+	pack.  This information may be useful if the importer
+	needs to maintain a map from revisions in the source
+	repository to commit ids in the target repository
+	during the import.
++
+The described objects are not necessarily accessible
+using standard git plumbing tools until a little while
+after the next checkpoint.
+
 --export-pack-edges=<file>::
 	After creating a packfile, print a line of data to
 	<file> listing the filename of the packfile and the last
@@ -896,6 +908,7 @@ The following features are currently supported:
 * date-format
 * import-marks
 * export-marks
+* report-fd
 * relative-marks
 * no-relative-marks
 * force
diff --git a/fast-import.c b/fast-import.c
index 2317b0f..ef0cee7 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -361,6 +361,9 @@ static uintmax_t next_mark;
 static struct strbuf new_data = STRBUF_INIT;
 static int seen_data_command;
 
+/* Where to report commits */
+static int report_fd = -1;
+
 static void parse_argv(void);
 
 static void write_branch_report(FILE *rpt, struct branch *b)
@@ -2571,6 +2574,11 @@ static void parse_new_commit(void)
 
 	if (!store_object(OBJ_COMMIT, &new_data, NULL, b->sha1, next_mark))
 		b->pack_id = pack_id;
+	if (report_fd != -1) {
+		char *buf = sha1_to_hex(b->sha1);
+		buf[40] = '\n';
+		write_or_die(report_fd, buf, 41);
+	}
 	b->last_commit = object_count_by_type[OBJ_COMMIT];
 }
 
@@ -2755,6 +2763,14 @@ static void option_export_marks(const char *marks)
 	safe_create_leading_directories_const(export_marks_file);
 }
 
+static void option_report_fd(const char *fd)
+{
+	unsigned long n = strtoul(fd, NULL, 0);
+	if (n > (unsigned long) INT_MAX)
+		die("--report-fd cannot exceed %d", INT_MAX);
+	report_fd = (int) n;
+}
+
 static void option_export_pack_edges(const char *edges)
 {
 	if (pack_edges)
@@ -2808,6 +2824,8 @@ static int parse_one_feature(const char *feature, int from_stream)
 		option_import_marks(feature + 13, from_stream);
 	} else if (!prefixcmp(feature, "export-marks=")) {
 		option_export_marks(feature + 13);
+	} else if (!prefixcmp(feature, "report-fd=")) {
+		option_report_fd(feature + strlen("report-fd="));
 	} else if (!prefixcmp(feature, "relative-marks")) {
 		relative_marks_paths = 1;
 	} else if (!prefixcmp(feature, "no-relative-marks")) {
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 7c05920..4371308 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1611,6 +1611,42 @@ test_expect_success 'R: feature no-relative-marks should be honoured' '
     test_cmp marks.new non-relative.out
 '
 
+test_expect_success 'setup: have pipes?' '
+	test_when_finished "rm -f frob" &&
+	if mkfifo frob
+	then
+		test_set_prereq PIPE
+	fi
+'
+
+test_expect_success PIPE 'R: fast-import --report-fd' '
+	cat >frontend <<-\FRONTEND_END &&
+	#!/bin/sh
+	cat <<EOF &&
+	commit refs/heads/printed
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	to be printed
+	COMMIT
+
+	from refs/heads/master
+	D file3
+
+	EOF
+
+	read cid <&3 &&
+	echo "$cid" >received
+	EOF
+	FRONTEND_END
+
+	mkfifo commits &&
+	test_when_finished "rm -f commits" &&
+	sh frontend 3<commits |
+	git fast-import --report-fd=3 3>commits &&
+	git rev-parse --verify printed >real &&
+	test_cmp real received
+'
+
 cat >input << EOF
 option git quiet
 blob
-- 
1.7.3.1

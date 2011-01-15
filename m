From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] fast-import: Introduce --import-marks-if-exists
Date: Sat, 15 Jan 2011 12:01:46 +0530
Message-ID: <1295073106-5779-1-git-send-email-artagnon@gmail.com>
References: <20110111175102.GB15133@burratino>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 15 07:50:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdzyT-0006Ei-3x
	for gcvg-git-2@lo.gmane.org; Sat, 15 Jan 2011 07:50:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839Ab1AOGbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jan 2011 01:31:10 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:64845 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713Ab1AOGbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jan 2011 01:31:09 -0500
Received: by gwj20 with SMTP id 20so1384923gwj.19
        for <git@vger.kernel.org>; Fri, 14 Jan 2011 22:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=ihIRXOywzxGNjT0+0jOag4Eh4Ue5BqyCRl+QtcaOLYM=;
        b=AwHmdjFs15uM/NdRhxUAEfqAkt26Ih7oMMxwCMg+xTpTDoVfH5EJHx9gbOlhUmvvNS
         icaoDaQJ61DtqSxCnFYlzWMMPweEXDpIAdnovLcsLOuze8NrHgekrfURMT66yKVl7uCz
         wquDmQZVRqfEg76ujaqQgsLHX4NcFCRCqxnTw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=wtR8CFzjKk8obFQE75iDaO1FScsRR3nBLG9hbnrprX40FCM3paUeVpR2CFZpZniu0G
         tJXsAKneAK8M/0MYd2z7WxIigDZvrFqzXPkpiaEwB6TCH7YqknbMcC416cUxAWFxO6OK
         M957YKESzZww78Y36f4mBC/bIaffY9cC9ZCvY=
Received: by 10.100.7.14 with SMTP id 14mr1118155ang.233.1295073068778;
        Fri, 14 Jan 2011 22:31:08 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id x36sm2392062anx.34.2011.01.14.22.31.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 Jan 2011 22:31:06 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <20110111175102.GB15133@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165135>

The --import-marks option errors out when the specified marks file
doesn't exist. If a frontend is just using a marks file to ensure its
state persists between runs, it would be simpler if missing marks
files were tolerated.  In some cases, the frontend cannot even check
for the existence of the marks file because with --relative-marks, the
location of the marks file is backend-dependent. This can be solved by
changing the meaning of --import-marks, but will result in trading off
functionality that some frontends might desire. So, add new
command-line option --import-marks-if-exists that's like
--import-marks, except that it tolerates missing marks files.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Changes since last time: Junio suggested making this an optional
 feature, and Jonathan wrote a fixup patch for the same.

 Documentation/git-fast-import.txt |    4 +++
 fast-import.c                     |   16 +++++++++--
 t/t9300-fast-import.sh            |   55 +++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index f56dfca..32a062c 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -78,6 +78,10 @@ OPTIONS
 	set of marks.  If a mark is defined to different values,
 	the last file wins.
 
+--import-marks-if-exists=<file>::
+	Like --import-marks but instead of erroring out, silently
+	skips the file if it does not exist.
+
 --relative-marks::
 	After specifying --relative-marks= the paths specified
 	with --import-marks= and --export-marks= are relative
diff --git a/fast-import.c b/fast-import.c
index 7857760..c525fda 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -329,6 +329,7 @@ static struct mark_set *marks;
 static const char *export_marks_file;
 static const char *import_marks_file;
 static int import_marks_file_from_stream;
+static int import_marks_file_ignore_missing;
 static int relative_marks_paths;
 
 /* Our last blob */
@@ -1795,7 +1796,11 @@ static void read_marks(void)
 {
 	char line[512];
 	FILE *f = fopen(import_marks_file, "r");
-	if (!f)
+	if (f)
+		;
+	else if (import_marks_file_ignore_missing && errno == ENOENT)
+		return; /* Marks file does not exist */
+	else
 		die_errno("cannot read '%s'", import_marks_file);
 	while (fgets(line, sizeof(line), f)) {
 		uintmax_t mark;
@@ -2861,7 +2866,8 @@ static char* make_fast_import_path(const char *path)
 	return strbuf_detach(&abs_path, NULL);
 }
 
-static void option_import_marks(const char *marks, int from_stream)
+static void option_import_marks(const char *marks,
+					int from_stream, int ignore_missing)
 {
 	if (import_marks_file) {
 		if (from_stream)
@@ -2875,6 +2881,7 @@ static void option_import_marks(const char *marks, int from_stream)
 	import_marks_file = make_fast_import_path(marks);
 	safe_create_leading_directories_const(import_marks_file);
 	import_marks_file_from_stream = from_stream;
+	import_marks_file_ignore_missing = ignore_missing;
 }
 
 static void option_date_format(const char *fmt)
@@ -2974,7 +2981,10 @@ static int parse_one_feature(const char *feature, int from_stream)
 	if (!prefixcmp(feature, "date-format=")) {
 		option_date_format(feature + 12);
 	} else if (!prefixcmp(feature, "import-marks=")) {
-		option_import_marks(feature + 13, from_stream);
+		option_import_marks(feature + 13, from_stream, 0);
+	} else if (!prefixcmp(feature, "import-marks-if-exists=")) {
+		option_import_marks(feature + strlen("import-marks-if-exists="),
+					from_stream, 1);
 	} else if (!prefixcmp(feature, "export-marks=")) {
 		option_export_marks(feature + 13);
 	} else if (!strcmp(feature, "cat-blob")) {
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 222d105..870e55b 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1706,6 +1706,61 @@ test_expect_success \
     'cat input | git fast-import --export-marks=other.marks &&
     grep :1 other.marks'
 
+test_expect_success 'R: catch typo in marks file name' '
+	test_must_fail git fast-import --import-marks=nonexistent.marks </dev/null &&
+	echo "feature import-marks=nonexistent.marks" |
+	test_must_fail git fast-import
+'
+
+test_expect_success 'R: import and output marks can be the same file' '
+	rm -f io.marks &&
+	blob=$(echo hi | git hash-object --stdin) &&
+	cat >expect <<-EOF &&
+	:1 $blob
+	:2 $blob
+	EOF
+	git fast-import --export-marks=io.marks <<-\EOF &&
+	blob
+	mark :1
+	data 3
+	hi
+
+	EOF
+	git fast-import --import-marks=io.marks --export-marks=io.marks <<-\EOF &&
+	blob
+	mark :2
+	data 3
+	hi
+
+	EOF
+	test_cmp expect io.marks
+'
+
+test_expect_success 'R: --import-marks=foo --output-marks=foo to create foo fails' '
+	rm -f io.marks &&
+	test_must_fail git fast-import --import-marks=io.marks --export-marks=io.marks <<-\EOF
+	blob
+	mark :1
+	data 3
+	hi
+
+	EOF
+'
+
+test_expect_success 'R: --import-marks-if-exists' '
+	rm -f io.marks &&
+	blob=$(echo hi | git hash-object --stdin) &&
+	echo ":1 $blob" >expect &&
+	git fast-import --import-marks-if-exists=io.marks --export-marks=io.marks <<-\EOF &&
+	blob
+	mark :1
+	data 3
+	hi
+
+	EOF
+	test_cmp expect io.marks
+'
+
 cat >input << EOF
 feature import-marks=marks.out
 feature export-marks=marks.new
-- 
1.7.4.rc1.7.g2cf08.dirty

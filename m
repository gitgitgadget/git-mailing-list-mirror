From: <carlos.duclos@nokia.com>
Subject: [PATCH v2] git-archive: Add new option "--output" to write archive
 to a file instead of stdout.
Date: Mon, 16 Feb 2009 18:37:03 +0100
Message-ID: <599636D7828020419E3AB2DE5CCC8130036BF8B1D5@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 16 18:39:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ7RM-0000Ms-Ii
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 18:39:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbZBPRiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 12:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbZBPRh7
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 12:37:59 -0500
Received: from smtp.nokia.com ([192.100.122.230]:33937 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251AbZBPRh6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Feb 2009 12:37:58 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n1GHbduu018886
	for <git@vger.kernel.org>; Mon, 16 Feb 2009 19:37:55 +0200
Received: from esebh102.NOE.Nokia.com ([172.21.138.183]) by esebh105.NOE.Nokia.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 16 Feb 2009 19:37:06 +0200
Received: from smtp.mgd.nokia.com ([65.54.30.5]) by esebh102.NOE.Nokia.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 16 Feb 2009 19:37:05 +0200
Received: from nok-am1mhub-06.mgdnok.nokia.com (65.54.30.10) by
 NOK-am1MHUB-01.mgdnok.nokia.com (65.54.30.5) with Microsoft SMTP Server (TLS)
 id 8.1.291.1; Mon, 16 Feb 2009 18:37:05 +0100
Received: from NOK-EUMSG-02.mgdnok.nokia.com ([65.54.30.107]) by
 nok-am1mhub-06.mgdnok.nokia.com ([65.54.30.10]) with mapi; Mon, 16 Feb 2009
 18:37:05 +0100
Thread-Topic: [PATCH v2] git-archive: Add new option "--output" to write
 archive to a file instead of stdout.
Thread-Index: AQHJkF0uEvnmBO/Ra0iZllUbqluAJQ==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
X-OriginalArrivalTime: 16 Feb 2009 17:37:05.0899 (UTC) FILETIME=[2F6FE3B0:01C9905D]
X-Nokia-AV: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110216>

NOTE: I can only use a webmail client, so some of the tabs might have overwritten by it. If  that's the case I'll resend the patch as MIME attachment.

When archiving a repository there is no way to specify a file as output. This patch adds a new option "--output" that redirects the output to a file instead of stdout.

Signed-off by: Carlos Manuel Duclos Vergara <carlos.duclos@nokia.com>
---
 Documentation/git-archive.txt |    3 +
 archive-zip.c                 |    1 -
 archive.c                     |   17 +++++
 t/t0024-crlf-archive.sh       |   19 +++++
 t/t5000-tar-tree.sh           |  148 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 187 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 41cbf9c..04b05f3 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -47,6 +47,9 @@ OPTIONS
 --prefix=<prefix>/::
        Prepend <prefix>/ to each filename in the archive.

+--output=<file>::
+       Writes the archive to <file> instead of stdout.
+
 <extra>::
        This can be any options that the archiver backend understand.
        See next section.
diff --git a/archive-zip.c b/archive-zip.c
index cf28504..de5e540 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -266,7 +266,6 @@ int write_zip_archive(struct archiver_args *args)
        int err;

        dos_time(&args->time, &zip_date, &zip_time);
-
        zip_dir = xmalloc(ZIP_DIRECTORY_MIN_SIZE);
        zip_dir_size = ZIP_DIRECTORY_MIN_SIZE;

diff --git a/archive.c b/archive.c
index e6de039..fde8602 100644
--- a/archive.c
+++ b/archive.c
@@ -239,6 +239,18 @@ static void parse_treeish_arg(const char **argv,
        ar_args->time = archive_time;
 }

+static void create_output_file(const char *output_file)
+{
+       int output_fd = creat(output_file, 0666);
+       if (output_fd < 0)
+               die("could not create archive file");
+       if (dup2(output_fd, 1) != 1)
+       {
+               close(output_fd);
+               die("could not redirect output");
+       }
+}
+
 #define OPT__COMPR(s, v, h, p) \
        { OPTION_SET_INT, (s), NULL, (v), NULL, (h), \
          PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, (p) }
@@ -253,6 +265,7 @@ static int parse_archive_args(int argc, const char **argv,
        const char *base = NULL;
        const char *remote = NULL;
        const char *exec = NULL;
+    const char *output = NULL;
        int compression_level = -1;
        int verbose = 0;
        int i;
@@ -262,6 +275,7 @@ static int parse_archive_args(int argc, const char **argv,
                OPT_STRING(0, "format", &format, "fmt", "archive format"),
                OPT_STRING(0, "prefix", &base, "prefix",
                        "prepend prefix to each pathname in the archive"),
+               OPT_STRING(0, "output", &output, "file", "write the results to this file"),
                OPT__VERBOSE(&verbose),
                OPT__COMPR('0', &compression_level, "store only", 0),
                OPT__COMPR('1', &compression_level, "compress faster", 1),
@@ -294,6 +308,9 @@ static int parse_archive_args(int argc, const char **argv,
        if (!base)
                base = "";

+       if(output)
+               create_output_file(output);
+
        if (list) {
                for (i = 0; i < ARRAY_SIZE(archivers); i++)
                        printf("%s\n", archivers[i].name);
diff --git a/t/t0024-crlf-archive.sh b/t/t0024-crlf-archive.sh
index e533039..237a8f6 100755
--- a/t/t0024-crlf-archive.sh
+++ b/t/t0024-crlf-archive.sh
@@ -26,6 +26,15 @@ test_expect_success 'tar archive' '

 '

+test_expect_success 'tar archive output redirected' '
+
+       git archive --format=tar --output=test.tar HEAD &&
+       ( mkdir untarred2 && cd untarred2 && "$TAR" -xf ../test.tar )
+
+       test_cmp sample untarred2/sample
+
+'
+
 "$UNZIP" -v >/dev/null 2>&1
 if [ $? -eq 127 ]; then
        echo "Skipping ZIP test, because unzip was not found"
@@ -43,4 +52,14 @@ test_expect_success 'zip archive' '

 '

+test_expect_success 'zip archive output redirected' '
+
+       git archive --format=zip --output=test.zip HEAD &&
+
+       ( mkdir unzipped2 && cd unzipped2 && unzip ../test.zip ) &&
+
+       test_cmp sample unzipped2/sample
+
+'
+
 test_done
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index c942c8b..b11e504 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -66,6 +66,11 @@ test_expect_success \
     'remove ignored file' \
     'rm a/ignored'

+
+#
+# Tar tests
+#
+
 test_expect_success \
     'git archive' \
     'git archive HEAD >b.tar'
@@ -160,6 +165,91 @@ test_expect_success \
       diff a/substfile2 g/prefix/a/substfile2
 '

+#
+# Same tests as above but now using redirection
+#
+
+test_expect_success \
+    'git archive' \
+    'git archive --output=b20.tar HEAD'
+
+test_expect_success \
+    'git tar-tree' \
+    'git tar-tree HEAD >b21.tar'
+
+test_expect_success \
+    'git archive vs. git tar-tree' \
+    'diff b20.tar b21.tar'
+
+test_expect_success \
+    'git archive in a bare repo' \
+    '(cd bare.git && git archive --output=../b22.tar HEAD)'
+
+test_expect_success \
+    'git archive vs. the same in a bare repo' \
+    'test_cmp b20.tar b22.tar'
+
+test_expect_success \
+    'validate file modification time' \
+    'mkdir extract2 &&
+     "$TAR" xf b20.tar -C extract2 a/a &&
+     test-chmtime -v +0 extract2/a/a |cut -f 1 >b20.mtime &&
+     echo "1117231200" >expected.mtime &&
+     diff expected.mtime b20.mtime'
+
+test_expect_success \
+    'git get-tar-commit-id' \
+    'git get-tar-commit-id <b20.tar >b20.commitid &&
+     diff .git/$(git symbolic-ref HEAD) b20.commitid'
+
+test_expect_success \
+    'extract tar archive' \
+    '(mkdir b20 && cd b20 && "$TAR" xf -) <b20.tar'
+
+test_expect_success \
+    'validate filenames' \
+    '(cd b20/a && find .) | sort >b20.lst &&
+     diff a.lst b20.lst'
+
+test_expect_success \
+    'validate file contents' \
+    'diff -r a b20/a'
+
+test_expect_success \
+    'create archives with substfiles' \
+    'echo "substfile?" export-subst >a/.gitattributes &&
+     git archive --output=f20.tar HEAD &&
+     git archive --prefix=prefix/ --output=g20.tar HEAD &&
+     rm a/.gitattributes'
+
+test_expect_success \
+    'extract substfiles' \
+    '(mkdir f20 && cd f20 && "$TAR" xf -) <f20.tar'
+
+test_expect_success \
+     'validate substfile contents' \
+     'git log --max-count=1 "--pretty=format:A${SUBSTFORMAT}O" HEAD \
+      >f20/a/substfile1.expected &&
+      diff f20/a/substfile1.expected f20/a/substfile1 &&
+      diff a/substfile2 f20/a/substfile2
+'
+
+test_expect_success \
+    'extract substfiles from archive with prefix' \
+    '(mkdir g20 && cd g20 && "$TAR" xf -) <g20.tar'
+
+test_expect_success \
+     'validate substfile contents from archive with prefix' \
+     'git log --max-count=1 "--pretty=format:A${SUBSTFORMAT}O" HEAD \
+      >g20/prefix/a/substfile1.expected &&
+      diff g20/prefix/a/substfile1.expected g20/prefix/a/substfile1 &&
+      diff a/substfile2 g20/prefix/a/substfile2
+'
+
+#
+# Zip tests
+#
+
 test_expect_success \
     'git archive --format=zip' \
     'git archive --format=zip HEAD >d.zip'
@@ -172,6 +262,26 @@ test_expect_success \
     'git archive --format=zip vs. the same in a bare repo' \
     'test_cmp d.zip d1.zip'

+#
+# Same tests as above but now using redirection
+#
+
+test_expect_success \
+    'git archive --format=zip --output=d10.zip' \
+    'git archive --format=zip --output=d10.zip HEAD'
+
+test_expect_success \
+    'git archive --format=zip --output=d11.zip in a bare repo' \
+    '(cd bare.git && git archive --format=zip --output=../d11.zip HEAD)'
+
+test_expect_success \
+    'git archive --format=zip redirected output vs. the same in a bare repo' \
+    'test_cmp d10.zip d11.zip'
+
+#
+# Zip tests
+#
+
 $UNZIP -v >/dev/null 2>&1
 if [ $? -eq 127 ]; then
        echo "Skipping ZIP tests, because unzip was not found"
@@ -213,4 +323,42 @@ test_expect_success \
     'git archive --list outside of a git repo' \
     'GIT_DIR=some/non-existing/directory git archive --list'

+#
+# Same tests as above but now with redirected output
+#
+
+test_expect_success \
+    'extract ZIP archive from redirected output  archive' \
+    '(mkdir d10 && cd d10 && $UNZIP ../d10.zip)'
+
+test_expect_success \
+    'validate filenames from redirected output  archive' \
+    '(cd d10/a && find .) | sort >d10.lst &&
+     diff a.lst d10.lst'
+
+test_expect_success \
+    'validate file contents from redirected output  archive' \
+    'diff -r a d10/a'
+
+test_expect_success \
+    'git archive --format=zip with prefix from redirected output  archive' \
+    'git archive --format=zip --prefix=prefix/ --output=e10.zip HEAD'
+
+test_expect_success \
+    'extract ZIP archive with prefix from redirected output  archive' \
+    '(mkdir e10 && cd e10 && $UNZIP ../e10.zip)'
+
+test_expect_success \
+    'validate filenames with prefix from redirected output  archive' \
+    '(cd e10/prefix/a && find .) | sort >e10.lst &&
+     diff a.lst e10.lst'
+
+test_expect_success \
+    'validate file contents with prefix from redirected output  archive' \
+    'diff -r a e10/prefix/a'
+
+test_expect_success \
+    'git archive --list outside of a git repo' \
+    'GIT_DIR=some/non-existing/directory git archive --list'
+
 test_done
--
1.6.2.rc0.63.g7cbd0.dirty

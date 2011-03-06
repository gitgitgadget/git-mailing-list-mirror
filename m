From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 08/12] vcs-svn: set up channel to read fast-import cat-blob
 response
Date: Sun, 6 Mar 2011 17:11:30 -0600
Message-ID: <20110306231130.GJ24327@elie>
References: <20101210102007.GA26298@burratino>
 <20110306225419.GA24327@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 07 00:11:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwN6z-0000kV-Kp
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 00:11:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754899Ab1CFXLh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2011 18:11:37 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:45305 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754594Ab1CFXLg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2011 18:11:36 -0500
Received: by gyh20 with SMTP id 20so1459736gyh.19
        for <git@vger.kernel.org>; Sun, 06 Mar 2011 15:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=vJtMPZQcI49iyTDhFR8yL135cDJTZPuWJy9EXxO7utY=;
        b=xIo/iTcDKBiZucfCSTeahz/J5/41m/ScvzZ7r0kk0ACPsu/pECFQ8gXOP0KUzB8oL1
         9/7u4nHbrVGj6f5iK+sR+YpgSJzVB5XTQvF1xkhugES4qHbun0gjzVKSvGafWhlFhHVX
         EMi7zT0Ax/Kyb6UEENYBqCY6gcAXJJRDZ42Ko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=yAU+ds7YX6nL5Ub0XqlC1c0U/mFrzmqBOfe/IXKXvtEwRBlJyHWHzv7vnIsMAPv+7T
         VxXHvvxP2F9tJ8popGqwfa12VBZov7Qe52LRBgFN/IOzGBFg1cDPKHfAuqIygqR2Ex79
         WxGbVmYplkL7CKUlizxj/6chzKyyuJiob1thU=
Received: by 10.236.72.168 with SMTP id t28mr2074698yhd.74.1299453095457;
        Sun, 06 Mar 2011 15:11:35 -0800 (PST)
Received: from elie (adsl-69-209-66-207.dsl.chcgil.sbcglobal.net [69.209.66.207])
        by mx.google.com with ESMTPS id j8sm1302831yha.1.2011.03.06.15.11.33
        (version=SSLv3 cipher=OTHER);
        Sun, 06 Mar 2011 15:11:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110306225419.GA24327@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168555>

From: David Barr <david.barr@cordelta.com>
Date: Sat, 5 Mar 2011 13:30:23 +1100

Set up some plumbing: teach the svndump lib to pass a file descriptor
number to the fast_export lib, representing where cat-blob/ls
responses can be read from, and add a get_response_line helper
function to the fast_export lib to read a line from that file.

Unfortunately this means that svn-fe needs file descriptor 3 to be
redirected from somewhere (preferrably the cat-blob stream of a
fast-import backend); otherwise it will fail:

	$ svndump <path> | svn-fe
	fatal: cannot read from file descriptor 3: Bad file descriptor

For the moment, "svn-fe 3</dev/null" works as a workaround but it
will not work for very long.  A fast-import backend that can retrieve
old commits is needed in order to be able to fulfill svn
"Node-copyfrom-rev" requests that refer to revs from a previous run.

[jn: with new change description]

Based-on-patch-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/svn-fe/svn-fe.txt |    6 ++-
 t/t9010-svn-fe.sh         |  118 +++++++++++++++++++++++++-------------------
 vcs-svn/fast_export.c     |   28 +++++++++++
 vcs-svn/fast_export.h     |    4 ++
 vcs-svn/svndump.c         |    5 ++
 5 files changed, 109 insertions(+), 52 deletions(-)

diff --git a/contrib/svn-fe/svn-fe.txt b/contrib/svn-fe/svn-fe.txt
index cd075b9..85f7b83 100644
--- a/contrib/svn-fe/svn-fe.txt
+++ b/contrib/svn-fe/svn-fe.txt
@@ -7,7 +7,11 @@ svn-fe - convert an SVN "dumpfile" to a fast-import stream
 
 SYNOPSIS
 --------
-svnadmin dump --incremental REPO | svn-fe [url] | git fast-import
+[verse]
+mkfifo backchannel &&
+svnadmin dump --incremental REPO |
+	svn-fe [url] 3<backchannel |
+	git fast-import --cat-blob-fd=3 3>backchannel
 
 DESCRIPTION
 -----------
diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index 5a6a4b9..2ae5374 100755
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -5,8 +5,26 @@ test_description='check svn dumpfile importer'
 . ./test-lib.sh
 
 reinit_git () {
+	if ! test_declared_prereq PIPE
+	then
+		echo >&4 "reinit_git: need to declare PIPE prerequisite"
+		return 127
+	fi
 	rm -fr .git &&
-	git init
+	rm -f stream backflow &&
+	git init &&
+	mkfifo stream backflow
+}
+
+try_dump () {
+	input=$1 &&
+	maybe_fail=${2:+test_$2} &&
+
+	{
+		$maybe_fail test-svn-fe "$input" >stream 3<backflow &
+	} &&
+	git fast-import --cat-blob-fd=3 <stream 3>backflow &&
+	wait $!
 }
 
 properties () {
@@ -35,21 +53,27 @@ text_no_props () {
 
 >empty
 
-test_expect_success 'empty dump' '
+test_expect_success 'setup: have pipes?' '
+	rm -f frob &&
+	if mkfifo frob
+	then
+		test_set_prereq PIPE
+	fi
+'
+
+test_expect_success PIPE 'empty dump' '
 	reinit_git &&
 	echo "SVN-fs-dump-format-version: 2" >input &&
-	test-svn-fe input >stream &&
-	git fast-import <stream
+	try_dump input
 '
 
-test_expect_success 'v4 dumps not supported' '
+test_expect_success PIPE 'v4 dumps not supported' '
 	reinit_git &&
 	echo "SVN-fs-dump-format-version: 4" >v4.dump &&
-	test_must_fail test-svn-fe v4.dump >stream &&
-	test_cmp empty stream
+	try_dump v4.dump must_fail
 '
 
-test_expect_failure 'empty revision' '
+test_expect_failure PIPE 'empty revision' '
 	reinit_git &&
 	printf "rev <nobody, nobody@local>: %s\n" "" "" >expect &&
 	cat >emptyrev.dump <<-\EOF &&
@@ -64,13 +88,12 @@ test_expect_failure 'empty revision' '
 	Content-length: 0
 
 	EOF
-	test-svn-fe emptyrev.dump >stream &&
-	git fast-import <stream &&
+	try_dump emptyrev.dump &&
 	git log -p --format="rev <%an, %ae>: %s" HEAD >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success 'empty properties' '
+test_expect_success PIPE 'empty properties' '
 	reinit_git &&
 	printf "rev <nobody, nobody@local>: %s\n" "" "" >expect &&
 	cat >emptyprop.dump <<-\EOF &&
@@ -88,13 +111,12 @@ test_expect_success 'empty properties' '
 
 	PROPS-END
 	EOF
-	test-svn-fe emptyprop.dump >stream &&
-	git fast-import <stream &&
+	try_dump emptyprop.dump &&
 	git log -p --format="rev <%an, %ae>: %s" HEAD >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success 'author name and commit message' '
+test_expect_success PIPE 'author name and commit message' '
 	reinit_git &&
 	echo "<author@example.com, author@example.com@local>" >expect.author &&
 	cat >message <<-\EOF &&
@@ -121,15 +143,14 @@ test_expect_success 'author name and commit message' '
 		echo &&
 		cat props
 	} >log.dump &&
-	test-svn-fe log.dump >stream &&
-	git fast-import <stream &&
+	try_dump log.dump &&
 	git log -p --format="%B" HEAD >actual.log &&
 	git log --format="<%an, %ae>" >actual.author &&
 	test_cmp message actual.log &&
 	test_cmp expect.author actual.author
 '
 
-test_expect_success 'unsupported properties are ignored' '
+test_expect_success PIPE 'unsupported properties are ignored' '
 	reinit_git &&
 	echo author >expect &&
 	cat >extraprop.dump <<-\EOF &&
@@ -149,13 +170,12 @@ test_expect_success 'unsupported properties are ignored' '
 	author
 	PROPS-END
 	EOF
-	test-svn-fe extraprop.dump >stream &&
-	git fast-import <stream &&
+	try_dump extraprop.dump &&
 	git log -p --format=%an HEAD >actual &&
 	test_cmp expect actual
 '
 
-test_expect_failure 'timestamp and empty file' '
+test_expect_failure PIPE 'timestamp and empty file' '
 	echo author@example.com >expect.author &&
 	echo 1999-01-01 >expect.date &&
 	echo file >expect.files &&
@@ -186,8 +206,7 @@ test_expect_failure 'timestamp and empty file' '
 
 		EOF
 	} >emptyfile.dump &&
-	test-svn-fe emptyfile.dump >stream &&
-	git fast-import <stream &&
+	try_dump emptyfile.dump &&
 	git log --format=%an HEAD >actual.author &&
 	git log --date=short --format=%ad HEAD >actual.date &&
 	git ls-tree -r --name-only HEAD >actual.files &&
@@ -198,7 +217,7 @@ test_expect_failure 'timestamp and empty file' '
 	test_cmp empty file
 '
 
-test_expect_success 'directory with files' '
+test_expect_success PIPE 'directory with files' '
 	reinit_git &&
 	printf "%s\n" directory/file1 directory/file2 >expect.files &&
 	echo hi >hi &&
@@ -242,8 +261,7 @@ test_expect_success 'directory with files' '
 		EOF
 		text_no_props hi
 	} >directory.dump &&
-	test-svn-fe directory.dump >stream &&
-	git fast-import <stream &&
+	try_dump directory.dump &&
 
 	git ls-tree -r --name-only HEAD >actual.files &&
 	git checkout HEAD directory &&
@@ -252,7 +270,8 @@ test_expect_success 'directory with files' '
 	test_cmp hi directory/file2
 '
 
-test_expect_success 'node without action' '
+test_expect_success PIPE 'node without action' '
+	reinit_git &&
 	cat >inaction.dump <<-\EOF &&
 	SVN-fs-dump-format-version: 3
 
@@ -269,10 +288,11 @@ test_expect_success 'node without action' '
 
 	PROPS-END
 	EOF
-	test_must_fail test-svn-fe inaction.dump
+	try_dump inaction.dump must_fail
 '
 
-test_expect_success 'action: add node without text' '
+test_expect_success PIPE 'action: add node without text' '
+	reinit_git &&
 	cat >textless.dump <<-\EOF &&
 	SVN-fs-dump-format-version: 3
 
@@ -290,10 +310,10 @@ test_expect_success 'action: add node without text' '
 
 	PROPS-END
 	EOF
-	test_must_fail test-svn-fe textless.dump
+	try_dump textless.dump must_fail
 '
 
-test_expect_failure 'change file mode but keep old content' '
+test_expect_failure PIPE 'change file mode but keep old content' '
 	reinit_git &&
 	cat >expect <<-\EOF &&
 	OBJID
@@ -356,8 +376,7 @@ test_expect_failure 'change file mode but keep old content' '
 
 	PROPS-END
 	EOF
-	test-svn-fe filemode.dump >stream &&
-	git fast-import <stream &&
+	try_dump filemode.dump &&
 	{
 		git rev-list HEAD |
 		git diff-tree --root --stdin |
@@ -370,7 +389,7 @@ test_expect_failure 'change file mode but keep old content' '
 	test_cmp hello actual.target
 '
 
-test_expect_success 'change file mode and reiterate content' '
+test_expect_success PIPE 'change file mode and reiterate content' '
 	reinit_git &&
 	cat >expect <<-\EOF &&
 	OBJID
@@ -382,7 +401,7 @@ test_expect_success 'change file mode and reiterate content' '
 	EOF
 	echo "link hello" >expect.blob &&
 	echo hello >hello &&
-	cat >filemode.dump <<-\EOF &&
+	cat >filemode2.dump <<-\EOF &&
 	SVN-fs-dump-format-version: 3
 
 	Revision-number: 1
@@ -437,8 +456,7 @@ test_expect_success 'change file mode and reiterate content' '
 	PROPS-END
 	link hello
 	EOF
-	test-svn-fe filemode.dump >stream &&
-	git fast-import <stream &&
+	try_dump filemode2.dump &&
 	{
 		git rev-list HEAD |
 		git diff-tree --root --stdin |
@@ -451,7 +469,8 @@ test_expect_success 'change file mode and reiterate content' '
 	test_cmp hello actual.target
 '
 
-test_expect_success 'deltas not supported' '
+test_expect_success PIPE 'deltas not supported' '
+	reinit_git &&
 	{
 		# (old) h + (inline) ello + (old) \n
 		printf "SVNQ%b%b%s" "Q\003\006\005\004" "\001Q\0204\001\002" "ello" |
@@ -511,10 +530,10 @@ test_expect_success 'deltas not supported' '
 		echo PROPS-END &&
 		cat delta
 	} >delta.dump &&
-	test_must_fail test-svn-fe delta.dump
+	test_must_fail try_dump delta.dump
 '
 
-test_expect_success 'property deltas supported' '
+test_expect_success PIPE 'property deltas supported' '
 	reinit_git &&
 	cat >expect <<-\EOF &&
 	OBJID
@@ -570,8 +589,7 @@ test_expect_success 'property deltas supported' '
 		PROPS-END
 		EOF
 	} >propdelta.dump &&
-	test-svn-fe propdelta.dump >stream &&
-	git fast-import <stream &&
+	try_dump propdelta.dump &&
 	{
 		git rev-list HEAD |
 		git diff-tree --stdin |
@@ -580,7 +598,7 @@ test_expect_success 'property deltas supported' '
 	test_cmp expect actual
 '
 
-test_expect_success 'properties on /' '
+test_expect_success PIPE 'properties on /' '
 	reinit_git &&
 	cat <<-\EOF >expect &&
 	OBJID
@@ -625,8 +643,7 @@ test_expect_success 'properties on /' '
 
 	PROPS-END
 	EOF
-	test-svn-fe changeroot.dump >stream &&
-	git fast-import <stream &&
+	try_dump changeroot.dump &&
 	{
 		git rev-list HEAD |
 		git diff-tree --root --always --stdin |
@@ -635,7 +652,7 @@ test_expect_success 'properties on /' '
 	test_cmp expect actual
 '
 
-test_expect_success 'deltas for typechange' '
+test_expect_success PIPE 'deltas for typechange' '
 	reinit_git &&
 	cat >expect <<-\EOF &&
 	OBJID
@@ -711,8 +728,7 @@ test_expect_success 'deltas for typechange' '
 	PROPS-END
 	link testing 321
 	EOF
-	test-svn-fe deleteprop.dump >stream &&
-	git fast-import <stream &&
+	try_dump deleteprop.dump &&
 	{
 		git rev-list HEAD |
 		git diff-tree --root --stdin |
@@ -736,12 +752,12 @@ test_expect_success 'set up svn repo' '
 	fi
 '
 
-test_expect_success SVNREPO 't9135/svn.dump' '
-	git init simple-git &&
-	test-svn-fe "$TEST_DIRECTORY/t9135/svn.dump" >simple.fe &&
+test_expect_success SVNREPO,PIPE 't9135/svn.dump' '
+	mkdir -p simple-git &&
 	(
 		cd simple-git &&
-		git fast-import <../simple.fe
+		reinit_git &&
+		try_dump "$TEST_DIRECTORY/t9135/svn.dump"
 	) &&
 	(
 		cd simple-svnco &&
diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 5a105ad..8786ed2 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -12,6 +12,24 @@
 #define MAX_GITSVN_LINE_LEN 4096
 
 static uint32_t first_commit_done;
+static struct line_buffer report_buffer = LINE_BUFFER_INIT;
+
+void fast_export_init(int fd)
+{
+	if (buffer_fdinit(&report_buffer, fd))
+		die_errno("cannot read from file descriptor %d", fd);
+}
+
+void fast_export_deinit(void)
+{
+	if (buffer_deinit(&report_buffer))
+		die_errno("error closing fast-import feedback stream");
+}
+
+void fast_export_reset(void)
+{
+	buffer_reset(&report_buffer);
+}
 
 void fast_export_delete(uint32_t depth, uint32_t *path)
 {
@@ -69,6 +87,16 @@ void fast_export_commit(uint32_t revision, uint32_t author, char *log,
 	printf("progress Imported commit %"PRIu32".\n\n", revision);
 }
 
+static const char *get_response_line(void)
+{
+	const char *line = buffer_read_line(&report_buffer);
+	if (line)
+		return line;
+	if (buffer_ferror(&report_buffer))
+		die_errno("error reading from fast-import");
+	die("unexpected end of fast-import feedback");
+}
+
 void fast_export_blob(uint32_t mode, uint32_t mark, uint32_t len, struct line_buffer *input)
 {
 	if (mode == REPO_MODE_LNK) {
diff --git a/vcs-svn/fast_export.h b/vcs-svn/fast_export.h
index aff8005..09b2033 100644
--- a/vcs-svn/fast_export.h
+++ b/vcs-svn/fast_export.h
@@ -3,6 +3,10 @@
 
 #include "line_buffer.h"
 
+void fast_export_init(int fd);
+void fast_export_deinit(void);
+void fast_export_reset(void);
+
 void fast_export_delete(uint32_t depth, uint32_t *path);
 void fast_export_modify(uint32_t depth, uint32_t *path, uint32_t mode,
 			uint32_t mark);
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index a384996..3cc4135 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -14,6 +14,8 @@
 #include "obj_pool.h"
 #include "string_pool.h"
 
+#define REPORT_FILENO 3
+
 #define NODEACT_REPLACE 4
 #define NODEACT_DELETE 3
 #define NODEACT_ADD 2
@@ -382,6 +384,7 @@ int svndump_init(const char *filename)
 	if (buffer_init(&input, filename))
 		return error("cannot open %s: %s", filename, strerror(errno));
 	repo_init();
+	fast_export_init(REPORT_FILENO);
 	reset_dump_ctx(~0);
 	reset_rev_ctx(0);
 	reset_node_ctx(NULL);
@@ -392,6 +395,7 @@ int svndump_init(const char *filename)
 void svndump_deinit(void)
 {
 	log_reset();
+	fast_export_deinit();
 	repo_reset();
 	reset_dump_ctx(~0);
 	reset_rev_ctx(0);
@@ -405,6 +409,7 @@ void svndump_deinit(void)
 void svndump_reset(void)
 {
 	log_reset();
+	fast_export_reset();
 	buffer_reset(&input);
 	repo_reset();
 	reset_dump_ctx(~0);
-- 
1.7.4.1

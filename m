From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v3 07/10] vcs-svn,svn-fe: convert REPORT_FILENO to an option
Date: Tue, 16 Aug 2011 15:54:52 +0600
Message-ID: <1313488495-2203-8-git-send-email-divanorama@gmail.com>
References: <1313488495-2203-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 11:54:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtGM4-0008Ps-9H
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 11:54:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155Ab1HPJyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 05:54:18 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33656 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998Ab1HPJyI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 05:54:08 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so3585375bke.19
        for <git@vger.kernel.org>; Tue, 16 Aug 2011 02:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ThMHr9w/7e2rLHrhDP0Y0Ha35Bjsa04v58Fgya0yTRo=;
        b=HsIVioxn+Q52IUwwIdP+nfg/X2JnQ3VuXs9oEIjnuXIlai6G0wmZSAj/JQrIG2AJpJ
         bfBt5drz8jHVSs5qjO33Eoc8EIMf73oOcyf7mRrwgmIvPAQOX6lKuouuK7E1ecVS9C+V
         52c7HBeCPLNWUkBuOLbfeZZHXTjbix3RulBmc=
Received: by 10.204.170.194 with SMTP id e2mr772803bkz.400.1313488447423;
        Tue, 16 Aug 2011 02:54:07 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id zx9sm1841723bkb.61.2011.08.16.02.54.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 16 Aug 2011 02:54:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1313488495-2203-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179421>

svn-fe needs to read fast-import's responses to "ls" and "cat-blob".
These come through a file descriptor number 3.

Descriptor number 3 isn't a standard of any kind and thus there is
no reason to hardcode it. Moreover it may require noticeable effort
to setup this descriptor, if number 3 is already taken for example.

Add an option for this file descriptor number in vcs-svn/ and svn-fe,
add a simple test for it.

To be used like following:
$ svn-fe --read-blob-fd=7 ... 7<somewhere

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 contrib/svn-fe/svn-fe.c   |    3 ++
 contrib/svn-fe/svn-fe.txt |    9 ++++++-
 t/t9010-svn-fe.sh         |   52 ++++++++++++++++++++++++++++++++++++++++++++-
 test-svn-fe.c             |    3 ++
 vcs-svn/svndump.c         |    4 +--
 vcs-svn/svndump.h         |    1 +
 6 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/contrib/svn-fe/svn-fe.c b/contrib/svn-fe/svn-fe.c
index 9dd8336..a4fd7f5 100644
--- a/contrib/svn-fe/svn-fe.c
+++ b/contrib/svn-fe/svn-fe.c
@@ -19,11 +19,14 @@ static struct option svn_fe_options[] = {
 		"add git-svn-id line to log messages, imitating git-svn"),
 	OPT_STRING(0, "ref", &options.ref, "refname",
 		"write to <refname> instead of refs/heads/master"),
+	OPT_INTEGER(0, "read-blob-fd", &options.backflow_fd,
+		"read blobs and trees from this fd instead of 3"),
 	OPT_END()
 };
 
 int main(int argc, const char **argv)
 {
+	options.backflow_fd = 3;
 	argc = parse_options(argc, argv, NULL, svn_fe_options,
 						svn_fe_usage, 0);
 	if (argc > 1)
diff --git a/contrib/svn-fe/svn-fe.txt b/contrib/svn-fe/svn-fe.txt
index 0d19475..7bfc5a6 100644
--- a/contrib/svn-fe/svn-fe.txt
+++ b/contrib/svn-fe/svn-fe.txt
@@ -8,9 +8,9 @@ svn-fe - convert an SVN "dumpfile" to a fast-import stream
 SYNOPSIS
 --------
 [verse]
-mkfifo backchannel &&
+mkfifo backchannel && fd=3 &&
 svnadmin dump --deltas REPO |
-	svn-fe [options] [git-svn-id-url] 3<backchannel |
+	eval "svn-fe [options] [git-svn-id-url] $fd<backchannel" |
 	git fast-import --cat-blob-fd=3 3>backchannel
 
 DESCRIPTION
@@ -37,6 +37,11 @@ OPTIONS
 	Ref to be written by the generated stream.
 	Default is refs/heads/master.
 
+--read-blob-fd=<fd>::
+	Integer number of file descriptor from which
+	responses to 'ls' and 'cat-blob' requests will come.
+	Default is fd=3.
+
 INPUT FORMAT
 ------------
 Subversion's repository dump format is documented in full in
diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index b45527e..efb4925 100755
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -21,9 +21,10 @@ try_dump () {
 	maybe_fail_svnfe=${2:+test_$2} &&
 	maybe_fail_fi=${3:+test_$3} &&
 	args=${4:-} &&
+	fd=${5:-3} &&
 
 	{
-		$maybe_fail_svnfe test-svn-fe $args "$input" >stream 3<backflow &
+		eval "$maybe_fail_svnfe test-svn-fe $args "$input" >stream $fd<backflow" &
 	} &&
 	$maybe_fail_fi git fast-import --cat-blob-fd=3 <stream 3>backflow &&
 	wait $!
@@ -1121,4 +1122,53 @@ test_expect_success SVNREPO,PIPE 't9135/svn.dump' '
 	)
 '
 
+test_expect_success PIPE 'use different backflow fd' '
+	reinit_git &&
+	echo hi >hi &&
+	{
+		properties \
+			svn:author author@example.com \
+			svn:date "1999-02-01T00:01:002.000000Z" \
+			svn:log "add directory with some files in it" &&
+		echo PROPS-END
+	} >props &&
+	{
+		echo Prop-content-length: $(wc -c <props) &&
+		echo Content-length: $(wc -c <props) &&
+		echo &&
+		cat props
+	} >revprops &&
+	{
+		cat <<-EOF &&
+		SVN-fs-dump-format-version: 3
+
+		Revision-number: 1
+		EOF
+		cat revprops &&
+		cat <<-EOF &&
+		Node-path: directory
+		Node-kind: dir
+		Node-action: add
+		Node-path: directory/somefile
+		Node-kind: file
+		Node-action: add
+		EOF
+		text_no_props hi &&
+
+		echo "Revision-number: 2" &&
+		cat revprops &&
+		cat <<-\EOF
+		Node-path: otherfile
+		Node-kind: file
+		Node-action: add
+		Node-copyfrom-rev: 1
+		Node-copyfrom-path: directory/somefile
+		EOF
+	} >directory.dump &&
+	try_dump directory.dump "" "" "--read-blob-fd=7" 7 &&
+
+	git checkout HEAD otherfile &&
+	test_cmp hi otherfile
+'
+
 test_done
diff --git a/test-svn-fe.c b/test-svn-fe.c
index fddd3e8..568e47e 100644
--- a/test-svn-fe.c
+++ b/test-svn-fe.c
@@ -23,6 +23,8 @@ static struct option test_svnfe_options[] = {
 	OPT_SET_INT('d', "apply-delta", &delta_test, "test apply_delta", 1),
 	OPT_STRING(0, "ref", &options.ref, "refname",
 		"write to <refname> instead of refs/heads/master"),
+	OPT_INTEGER(0, "read-blob-fd", &options.backflow_fd,
+		"read blobs and trees from this fd instead of 3"),
 	OPT_END()
 };
 
@@ -54,6 +56,7 @@ static int apply_delta(int argc, const char *argv[])
 
 int main(int argc, const char *argv[])
 {
+	options.backflow_fd = 3;
 	argc = parse_options(argc, argv, NULL, test_svnfe_options,
 						test_svnfe_usage, 0);
 
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 3a64708..847d733 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -20,8 +20,6 @@
  */
 #define constcmp(s, ref) memcmp(s, ref, sizeof(ref) - 1)
 
-#define REPORT_FILENO 3
-
 #define NODEACT_REPLACE 4
 #define NODEACT_DELETE 3
 #define NODEACT_ADD 2
@@ -499,7 +497,7 @@ int svndump_init(const struct svndump_options *o)
 		ref = "refs/heads/master";
 	if (buffer_init(&input, o->dumpfile))
 		return error("cannot open %s: %s", o->dumpfile, strerror(errno));
-	fast_export_init(REPORT_FILENO);
+	fast_export_init(o->backflow_fd);
 	strbuf_init(&dump_ctx.uuid, 4096);
 	strbuf_init(&dump_ctx.url, 4096);
 	strbuf_init(&rev_ctx.log, 4096);
diff --git a/vcs-svn/svndump.h b/vcs-svn/svndump.h
index 0b01ccd..8de9999 100644
--- a/vcs-svn/svndump.h
+++ b/vcs-svn/svndump.h
@@ -7,6 +7,7 @@ struct svndump_options {
 	 */
 	const char *dumpfile, *git_svn_url;
 	const char *ref;
+	int backflow_fd;
 };
 
 int svndump_init(const struct svndump_options *o);
-- 
1.7.3.4

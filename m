From: David Soria Parra <sn_@gmx.net>
Subject: [PATCH v2 1/2] Teach clone to clone just one remote branch using --track
Date: Tue,  1 Dec 2009 23:51:04 +0100
Message-ID: <1259707865-6561-2-git-send-email-sn_@gmx.net>
References: <1259707865-6561-1-git-send-email-sn_@gmx.net>
Cc: David Soria Parra <dsp@php.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 01 23:51:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFbZ4-0005ib-9z
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 23:51:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754632AbZLAWvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 17:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754527AbZLAWvJ
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 17:51:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:42837 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754046AbZLAWvH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 17:51:07 -0500
Received: (qmail invoked by alias); 01 Dec 2009 22:51:12 -0000
Received: from e180068007.adsl.alicedsl.de (EHLO localhost.localdomain) [85.180.68.7]
  by mail.gmx.net (mp049) with SMTP; 01 Dec 2009 23:51:12 +0100
X-Authenticated: #4427663
X-Provags-ID: V01U2FsdGVkX1+dy+EYP0eds8kPcvV8mKiEpl5xtBL/pt+VDNswtD
	QbWLDUlwcKvd0h
X-Mailer: git-send-email 1.6.6.rc0.268.g1c272
In-Reply-To: <1259707865-6561-1-git-send-email-sn_@gmx.net>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134266>

From: David Soria Parra <dsp@php.net>

Add a --track option that can be used to clone just the
given branch from the remote and nothing else. This is done
by setting the remote.<branch>.fetch option before cloning.
This option cannot be used together with --mirror.
For example using

    git clone --track next git://git.kernel.org/pub/scm/git/git.git

will just clone the next branch from the git.git repository.

The option is called --track to ensure clean wording with
'git remote add --track'.

Signed-off-by: David Soria Parra <dsp@php.net>
---
 builtin-clone.c        |   12 +++++++++++-
 t/t5708-clone-track.sh |   43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 1 deletions(-)
 create mode 100755 t/t5708-clone-track.sh

diff --git a/builtin-clone.c b/builtin-clone.c
index 5df8b0f..bc335ee 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -43,6 +43,7 @@ static char *option_template, *option_reference, *option_depth;
 static char *option_origin = NULL;
 static char *option_branch = NULL;
 static char *option_upload_pack = "git-upload-pack";
+static char *option_track = NULL;
 static int option_verbose;
 
 static struct option builtin_clone_options[] = {
@@ -76,6 +77,8 @@ static struct option builtin_clone_options[] = {
 		   "path to git-upload-pack on the remote"),
 	OPT_STRING(0, "depth", &option_depth, "depth",
 		    "create a shallow clone of that depth"),
+	OPT_STRING('t', "track", &option_track, "branch",
+			"remote branche to track"),
 
 	OPT_END()
 };
@@ -483,7 +486,14 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		strbuf_addf(&branch_top, "refs/remotes/%s/", option_origin);
 	}
 
-	strbuf_addf(&value, "+%s*:%s*", src_ref_prefix, branch_top.buf);
+	if (option_track) {
+		if (option_mirror)
+			return error("Cannot use --track together with --mirror");
+		strbuf_addf(&value, "+%s%s:%s%s", src_ref_prefix, option_track, branch_top.buf, option_track);
+		option_branch = option_track;
+	} else {
+		strbuf_addf(&value, "+%s*:%s*", src_ref_prefix, branch_top.buf);
+	}
 
 	if (option_mirror || !option_bare) {
 		/* Configure the remote */
diff --git a/t/t5708-clone-track.sh b/t/t5708-clone-track.sh
new file mode 100755
index 0000000..71b8461
--- /dev/null
+++ b/t/t5708-clone-track.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+
+test_description='clone --track option'
+. ./test-lib.sh
+
+check_HEAD() {
+	echo refs/heads/"$1" >expect &&
+	git symbolic-ref HEAD >actual &&
+	test_cmp expect actual
+}
+
+check_file() {
+	echo "$1" >expect &&
+	test_cmp expect file
+}
+
+test_expect_success 'setup' '
+	mkdir parent &&
+	(cd parent && git init &&
+	 echo one >file && git add file && git commit -m one &&
+	 git checkout -b two &&
+	 echo two >file && git add file && git commit -m two &&
+	 git checkout master)
+'
+
+test_expect_success 'vanilla clone has both branches' '
+	git clone parent clone &&
+	(cd clone &&
+	git branch -r | grep master &&
+	git branch -r | grep two
+	)
+'
+
+test_expect_success 'clone -t chooses specified remote branch' '
+	git clone -t two parent clone-two &&
+	(cd clone-two &&
+	!(git branch -r | grep master) &&
+	git branch -r | grep two &&
+	check_HEAD two
+	)
+'
+
+test_done
-- 
1.6.6.rc0.268.g1c272

From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] remote-curl: Fix push status report when all branches fail
Date: Thu, 19 Jan 2012 19:12:09 -0800
Message-ID: <1327029129-11424-1-git-send-email-spearce@spearce.org>
References: <7vzkdjgv1i.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 20 04:12:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ro4uE-0007Iv-4E
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 04:12:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696Ab2ATDMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jan 2012 22:12:21 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:54494 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751737Ab2ATDMU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jan 2012 22:12:20 -0500
Received: by obcva7 with SMTP id va7so182296obc.19
        for <git@vger.kernel.org>; Thu, 19 Jan 2012 19:12:19 -0800 (PST)
Received: by 10.50.184.227 with SMTP id ex3mr7177344igc.17.1327029139586;
        Thu, 19 Jan 2012 19:12:19 -0800 (PST)
Received: from localhost (sop.mtv.corp.google.com [172.27.69.16])
        by mx.google.com with ESMTPS id g34sm4788858ibk.10.2012.01.19.19.12.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 Jan 2012 19:12:18 -0800 (PST)
X-Mailer: git-send-email 1.7.9.rc2.124.g1c075
In-Reply-To: <7vzkdjgv1i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188848>

From: "Shawn O. Pearce" <spearce@spearce.org>

The protocol between transport-helper.c and remote-curl requires
remote-curl to always print a blank line after the push command
has run. If the blank line is ommitted, transport-helper kills its
container process (the git push the user started) with exit(128)
and no message indicating a problem, assuming the helper already
printed reasonable error text to the console.

However if the remote rejects all branches with "ng" commands in the
report-status reply, send-pack terminates with non-zero status, and
in turn remote-curl exited with non-zero status before outputting
the blank line after the helper status printed by send-pack. No
error messages reach the user.

This caused users to see the following from git push over HTTP
when the remote side's update hook rejected the branch:

  $ git push http://... master
  Counting objects: 4, done.
  Delta compression using up to 6 threads.
  Compressing objects: 100% (2/2), done.
  Writing objects: 100% (3/3), 301 bytes, done.
  Total 3 (delta 0), reused 0 (delta 0)
  $

Always print a blank line after the send-pack process terminates,
ensuring the helper status report (if it was output) will be
correctly parsed by the calling transport-helper.c. This ensures
the helper doesn't abort before the status report can be shown to
the user.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 remote-curl.c        |    9 +++++----
 t/t5541-http-push.sh |   27 +++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 48c20b8..25c1af7 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -805,7 +805,7 @@ static int push(int nr_spec, char **specs)
 static void parse_push(struct strbuf *buf)
 {
 	char **specs = NULL;
-	int alloc_spec = 0, nr_spec = 0, i;
+	int alloc_spec = 0, nr_spec = 0, i, ret;
 
 	do {
 		if (!prefixcmp(buf->buf, "push ")) {
@@ -822,12 +822,13 @@ static void parse_push(struct strbuf *buf)
 			break;
 	} while (1);
 
-	if (push(nr_spec, specs))
-		exit(128); /* error already reported */
-
+	ret = push(nr_spec, specs);
 	printf("\n");
 	fflush(stdout);
 
+	if (ret)
+		exit(128); /* error already reported */
+
  free_specs:
 	for (i = 0; i < nr_spec; i++)
 		free(specs[i]);
diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index 9b85d42..4723930 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -95,6 +95,31 @@ test_expect_success 'create and delete remote branch' '
 	test_must_fail git show-ref --verify refs/remotes/origin/dev
 '
 
+cat >"$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update" <<EOF
+#!/bin/sh
+exit 1
+EOF
+chmod a+x "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update"
+
+cat >exp <<EOF
+remote: error: hook declined to update refs/heads/dev2        
+To http://127.0.0.1:$LIB_HTTPD_PORT/smart/test_repo.git
+ ! [remote rejected] dev2 -> dev2 (hook declined)
+error: failed to push some refs to 'http://127.0.0.1:5541/smart/test_repo.git'
+EOF
+
+test_expect_success 'rejected update prints status' '
+	cd "$ROOT_PATH"/test_repo_clone &&
+	git checkout -b dev2 &&
+	: >path4 &&
+	git add path4 &&
+	test_tick &&
+	git commit -m dev2 &&
+	git push origin dev2 2>act
+	test_cmp exp act
+'
+rm -f "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update"
+
 cat >exp <<EOF
 
 GET  /smart/test_repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
@@ -106,6 +131,8 @@ GET  /smart/test_repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
 POST /smart/test_repo.git/git-receive-pack HTTP/1.1 200
 GET  /smart/test_repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
 POST /smart/test_repo.git/git-receive-pack HTTP/1.1 200
+GET  /smart/test_repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
+POST /smart/test_repo.git/git-receive-pack HTTP/1.1 200
 EOF
 test_expect_success 'used receive-pack service' '
 	sed -e "
-- 
1.7.9.rc2.124.g1c075

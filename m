From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/6] improve httpd auth tests
Date: Fri, 14 Oct 2011 09:40:36 +0200
Message-ID: <5232586c7985e6a420ee741e19e7fd6d040d43f6.1318577792.git.git@drmicha.warpmail.net>
References: <4E9692BF.8040705@drmicha.warpmail.net>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 14 09:40:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REcNu-00061r-Sl
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 09:40:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477Ab1JNHks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 03:40:48 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:34498 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932327Ab1JNHkr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Oct 2011 03:40:47 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id C2A7120B93;
	Fri, 14 Oct 2011 03:40:46 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute5.internal (MEProxy); Fri, 14 Oct 2011 03:40:46 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=vB
	PS2VVioBymoJQTNvWHWNdTCzA=; b=UjaSWNKcA3IK9blqz8w0bbxGalxGjOtVCg
	OGElENo6Go4pxBEI5aqslMgb7ZuwH/7l++yYJZ9VqVwVDVtDMAsLvxupRSEiSJva
	BQHjGL02esBrVTmNlZSIjHUcorpYoF9mXwkjyqSJ/AJsWXTKVno3txro9QN8e23o
	WQORTwHjk=
X-Sasl-enc: YmGeCNMPfDFvdQZNHTviAlZ8JwgIVCN93ZCm86UMuv57 1318578046
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 42BC74833FD;
	Fri, 14 Oct 2011 03:40:46 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.338.g0156b
In-Reply-To: <4E9692BF.8040705@drmicha.warpmail.net>
In-Reply-To: <cover.1318577792.git.git@drmicha.warpmail.net>
References: <cover.1318577792.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183548>

From: Jeff King <peff@peff.net>

These just checked that we could clone a repository when the
username and password were given in the URL; we should also
check that git will prompt when no or partial credentials
are given.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/lib-httpd.sh        |   10 +++++---
 t/t5550-http-fetch.sh |   51 +++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 53 insertions(+), 8 deletions(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index b8996a3..f7dc078 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -81,8 +81,7 @@ prepare_httpd() {
 
 	if test -n "$LIB_HTTPD_SSL"
 	then
-		HTTPD_URL=https://127.0.0.1:$LIB_HTTPD_PORT
-		AUTH_HTTPD_URL=https://user%40host:user%40host@127.0.0.1:$LIB_HTTPD_PORT
+		HTTPD_PROTO=https
 
 		RANDFILE_PATH="$HTTPD_ROOT_PATH"/.rnd openssl req \
 			-config "$TEST_PATH/ssl.cnf" \
@@ -93,9 +92,12 @@ prepare_httpd() {
 		export GIT_SSL_NO_VERIFY
 		HTTPD_PARA="$HTTPD_PARA -DSSL"
 	else
-		HTTPD_URL=http://127.0.0.1:$LIB_HTTPD_PORT
-		AUTH_HTTPD_URL=http://user%40host:user%40host@127.0.0.1:$LIB_HTTPD_PORT
+		HTTPD_PROTO=http
 	fi
+	HTTPD_DEST=127.0.0.1:$LIB_HTTPD_PORT
+	HTTPD_URL=$HTTPD_PROTO://$HTTPD_DEST
+	HTTPD_URL_USER=$HTTPD_PROTO://user%40host@$HTTPD_DEST
+	HTTPD_URL_USER_PASS=$HTTPD_PROTO://user%40host:user%40host@$HTTPD_DEST
 
 	if test -n "$LIB_HTTPD_DAV" -o -n "$LIB_HTTPD_SVN"
 	then
diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
index a1883ca..ed4db09 100755
--- a/t/t5550-http-fetch.sh
+++ b/t/t5550-http-fetch.sh
@@ -35,11 +35,54 @@ test_expect_success 'clone http repository' '
 	test_cmp file clone/file
 '
 
-test_expect_success 'clone http repository with authentication' '
+test_expect_success 'create password-protected repository' '
 	mkdir "$HTTPD_DOCUMENT_ROOT_PATH/auth/" &&
-	cp -Rf "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" "$HTTPD_DOCUMENT_ROOT_PATH/auth/repo.git" &&
-	git clone $AUTH_HTTPD_URL/auth/repo.git clone-auth &&
-	test_cmp file clone-auth/file
+	cp -Rf "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" \
+	       "$HTTPD_DOCUMENT_ROOT_PATH/auth/repo.git"
+'
+
+test_expect_success 'setup askpass helpers' '
+	cat >askpass <<-EOF &&
+	#!/bin/sh
+	echo >>"$PWD/askpass-query" "askpass: \$*" &&
+	cat "$PWD/askpass-response"
+	EOF
+	chmod +x askpass &&
+	GIT_ASKPASS="$PWD/askpass" &&
+	export GIT_ASKPASS &&
+	>askpass-expect-none &&
+	echo "askpass: Password: " >askpass-expect-pass &&
+	{ echo "askpass: Username: " &&
+	  cat askpass-expect-pass
+	} >askpass-expect-both
+'
+
+test_expect_success 'cloning password-protected repository can fail' '
+	>askpass-query &&
+	echo wrong >askpass-response &&
+	test_must_fail git clone "$HTTPD_URL/auth/repo.git" clone-auth-fail &&
+	test_cmp askpass-expect-both askpass-query
+'
+
+test_expect_success 'http auth can use user/pass in URL' '
+	>askpass-query &&
+	echo wrong >askpass-reponse &&
+	git clone "$HTTPD_URL_USER_PASS/auth/repo.git" clone-auth-none &&
+	test_cmp askpass-expect-none askpass-query
+'
+
+test_expect_success 'http auth can use just user in URL' '
+	>askpass-query &&
+	echo user@host >askpass-response &&
+	git clone "$HTTPD_URL_USER/auth/repo.git" clone-auth-pass &&
+	test_cmp askpass-expect-pass askpass-query
+'
+
+test_expect_success 'http auth can request both user and pass' '
+	>askpass-query &&
+	echo user@host >askpass-response &&
+	git clone "$HTTPD_URL/auth/repo.git" clone-auth-both &&
+	test_cmp askpass-expect-both askpass-query
 '
 
 test_expect_success 'fetch changes via http' '
-- 
1.7.7.338.g0156b

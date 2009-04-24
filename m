From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 3/3] http-push: send out fetch requests on queue
Date: Sat, 25 Apr 2009 00:35:57 +0800
Message-ID: <49F1EA6D.8080406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 24 18:41:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxOPs-0007uJ-Pw
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 18:38:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758852AbZDXQgd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 12:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758309AbZDXQgc
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 12:36:32 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:34850 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759465AbZDXQgb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 12:36:31 -0400
Received: by wa-out-1112.google.com with SMTP id j5so597039wah.21
        for <git@vger.kernel.org>; Fri, 24 Apr 2009 09:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=4Q4JiK+7PZZim2xH+926BeFPgh3k7D59GCSl22lG8M4=;
        b=n9HKgSNci51MxMJ2N9DfAAOeW5E8Elti2RFTJ08f8f7DehFzeD4YaXMAhxzePLXukF
         ChGBNXNslOrfVbG9+vvlqdSSSnz93NIUiGBfBhJdv7QYo374Fq2zJhazs+KXu5HRKPO0
         BhxLbQO6buTT0aveIy4pzthZhrn6MaYUf625k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=eM1D9PW2u6TMiNN0Gtz0Y/84jRWrZGgEXcAGlKmztxRFd9JovfQ5qs1rLhTXy4BcFS
         1qIIz6S0GqX20psX6Yk18BWns63O5DMcHcBukXZN7aLkYlEbQHQzQzcgqRtfLCPlT10f
         U+P+P2TAFd2VBmmaAmSSlLJwET6crRGAudctQ=
Received: by 10.114.178.13 with SMTP id a13mr1516330waf.88.1240590989515;
        Fri, 24 Apr 2009 09:36:29 -0700 (PDT)
Received: from ?116.87.149.49? (cm49.zeta149.maxonline.com.sg [116.87.149.49])
        by mx.google.com with ESMTPS id k14sm1950990waf.30.2009.04.24.09.36.28
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Apr 2009 09:36:29 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117468>

Previously, requests for remote files were simply added to the queue
(pointed to by request_queue_head) and no transfer actually took
place[1], even though code that followed may rely on these remote files
to be present (eg. the setup_revisions invocation).

The code that sends out the requests on the request queue is refactored
into the method run_request_queue.

After the get_dav_remote_heads invocation (ie. after fetch requests are
added to the queue), the requests on the queue are sent out through an
invocation to run_request_queue.

This invocation to run_request_queue entails adding a fill function
before pushing checks take place, which may lead to accidental,
unwanted pushes previously.

The flag is_running_queue is introduced to prevent this from occurring.
fill_active_slot is made to check the flag is_running_queue before
the sending of the requests proceeds.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http-push.c          |   37 ++++++++++++++++++++++++++-----------
 t/t5540-http-push.sh |    4 ++--
 2 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/http-push.c b/http-push.c
index 5138224..1ba7987 100644
--- a/http-push.c
+++ b/http-push.c
@@ -843,11 +843,12 @@ static void finish_request(struct transfer_request *request)
 }

 #ifdef USE_CURL_MULTI
+static int is_running_queue;
 static int fill_active_slot(void *unused)
 {
 	struct transfer_request *request;

-	if (aborted)
+	if (aborted || !is_running_queue)
 		return 0;

 	for (request = request_queue_head; request; request = request->next) {
@@ -2167,6 +2168,25 @@ static int delete_remote_branch(char *pattern, int force)
 	return 0;
 }

+void run_request_queue()
+{
+#ifdef USE_CURL_MULTI
+	is_running_queue = 1;
+	fill_active_slots();
+	add_fill_function(NULL, fill_active_slot);
+#endif
+	do {
+		finish_all_active_slots();
+#ifdef USE_CURL_MULTI
+		fill_active_slots();
+#endif
+	} while (request_queue_head && !aborted);
+
+#ifdef USE_CURL_MULTI
+	is_running_queue = 0;
+#endif
+}
+
 int main(int argc, char **argv)
 {
 	struct transfer_request *request;
@@ -2271,6 +2291,8 @@ int main(int argc, char **argv)
 		repo->url = rewritten_url;
 	}

+	is_running_queue = 0;
+
 	/* Verify DAV compliance/lock support */
 	if (!locking_available()) {
 		rc = 1;
@@ -2300,6 +2322,7 @@ int main(int argc, char **argv)
 	local_refs = get_local_heads();
 	fprintf(stderr, "Fetching remote heads...\n");
 	get_dav_remote_heads();
+	run_request_queue();

 	/* Remove a remote branch if -d or -D was specified */
 	if (delete_branch) {
@@ -2429,16 +2452,8 @@ int main(int argc, char **argv)
 		if (objects_to_send)
 			fprintf(stderr, "    sending %d objects\n",
 				objects_to_send);
-#ifdef USE_CURL_MULTI
-		fill_active_slots();
-		add_fill_function(NULL, fill_active_slot);
-#endif
-		do {
-			finish_all_active_slots();
-#ifdef USE_CURL_MULTI
-			fill_active_slots();
-#endif
-		} while (request_queue_head && !aborted);
+
+		run_request_queue();

 		/* Update the remote branch if all went well */
 		if (aborted || !update_remote(ref->new_sha1, ref_lock))
diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index ad0f14b..f4a2cf6 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -67,7 +67,7 @@ test_expect_success ' push to remote repository with unpacked refs' '
 	 test $HEAD = $(git rev-parse --verify HEAD))
 '

-test_expect_failure 'http-push fetches unpacked objects' '
+test_expect_success 'http-push fetches unpacked objects' '
 	cp -R "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git \
 		"$HTTPD_DOCUMENT_ROOT_PATH"/test_repo_unpacked.git &&

@@ -83,7 +83,7 @@ test_expect_failure 'http-push fetches unpacked objects' '
 	 git push -f -v $HTTPD_URL/test_repo_unpacked.git master)
 '

-test_expect_failure 'http-push fetches packed objects' '
+test_expect_success 'http-push fetches packed objects' '
 	cp -R "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git \
 		"$HTTPD_DOCUMENT_ROOT_PATH"/test_repo_packed.git &&

-- 
1.6.3.rc0

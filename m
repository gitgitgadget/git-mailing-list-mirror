From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 04/23] http-push: send out fetch requests on queue
Date: Sat, 6 Jun 2009 00:01:37 +0800
Message-ID: <20090606000137.ff05ba37.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 05 18:09:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCbzA-00053w-Nt
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 18:09:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754767AbZFEQIV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 12:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754570AbZFEQIU
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 12:08:20 -0400
Received: from mail-pz0-f171.google.com ([209.85.222.171]:43072 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754683AbZFEQIT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 12:08:19 -0400
Received: by mail-pz0-f171.google.com with SMTP id 1so944213pzk.33
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 09:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=8FBF1J2kzeHvVoM2Hao2kSTRvwdcXnW0a8mxUBjNpGw=;
        b=Tom57Aad9F4n7PgVm28QK+kE9Kfzkm7IhBg6NHG5lfJZ3HchmGC4ro0JueKU2SM01f
         jpgCwCP0UYe4XpqIEuqfZ922WuB4zOdAkWv3Mg42X79k9GBtgvFrpVWaHr050VVFaUFI
         jiYrUCfbzfYMTj2RuaCzFC7x6lnstWsgOYCdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=HuWChcOpUswe/kzVMvOrO5GIk68pUc7mjZwxaxkSG590zgq8yen0M5lNaQTOrk2ZB2
         cIlIFCOZZqCrmuVdbmHdAxWKCkxy6YdFPzUpBPCsPbwXhV6TAOBcmsHGYvlaSkUYwBRj
         yzAdBAvwBKtt+IuhLFqyS0ssAGkJkHRSWZs4E=
Received: by 10.142.217.3 with SMTP id p3mr1239480wfg.191.1244218101604;
        Fri, 05 Jun 2009 09:08:21 -0700 (PDT)
Received: from your-cukc5e3z5n (cm97.zeta149.maxonline.com.sg [116.87.149.97])
        by mx.google.com with ESMTPS id 9sm436994wfc.16.2009.06.05.09.08.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Jun 2009 09:08:21 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120789>

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
index 0b12ffe..218e263 100644
--- a/http-push.c
+++ b/http-push.c
@@ -846,11 +846,12 @@ static void finish_request(struct transfer_request *request)
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
@@ -2174,6 +2175,25 @@ static int delete_remote_branch(char *pattern, int force)
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
@@ -2278,6 +2298,8 @@ int main(int argc, char **argv)
 		repo->url = rewritten_url;
 	}

+	is_running_queue = 0;
+
 	/* Verify DAV compliance/lock support */
 	if (!locking_available()) {
 		rc = 1;
@@ -2307,6 +2329,7 @@ int main(int argc, char **argv)
 	local_refs = get_local_heads();
 	fprintf(stderr, "Fetching remote heads...\n");
 	get_dav_remote_heads();
+	run_request_queue();

 	/* Remove a remote branch if -d or -D was specified */
 	if (delete_branch) {
@@ -2436,16 +2459,8 @@ int main(int argc, char **argv)
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
1.6.3.1

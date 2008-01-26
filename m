From: Mike Hommey <mh@glandium.org>
Subject: [Resend PATCH] Fix some memory leaks in various places
Date: Sat, 26 Jan 2008 11:50:27 +0100
Message-ID: <1201344627-21609-1-git-send-email-mh@glandium.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 26 11:49:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIibE-0001Lk-AP
	for gcvg-git-2@gmane.org; Sat, 26 Jan 2008 11:49:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbYAZKsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2008 05:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751666AbYAZKsy
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jan 2008 05:48:54 -0500
Received: from vuizook.err.no ([85.19.215.103]:53806 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751530AbYAZKsx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2008 05:48:53 -0500
Received: from aputeaux-153-1-83-190.w86-205.abo.wanadoo.fr ([86.205.41.190] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JIib5-0007z2-DS
	for git@vger.kernel.org; Sat, 26 Jan 2008 11:49:21 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JIicF-0005cv-Lo
	for git@vger.kernel.org; Sat, 26 Jan 2008 11:50:27 +0100
X-Mailer: git-send-email 1.5.4.rc3.30.gb084e
X-Spam-Status: (score 2.2): No, score=2.2 required=5.0 tests=RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71774>


Signed-off-by: Mike Hommey <mh@glandium.org>
---

 I think I sent this already last month, but since I see that nowhere on
 next or master, I'm resending, just in case it got lost.

 builtin-init-db.c |    1 +
 http-walker.c     |   10 ++++++++++
 walker.c          |    2 ++
 3 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index e1393b8..df61758 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -415,6 +415,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	safe_create_dir(path, 1);
 	strcpy(path+len, "/info");
 	safe_create_dir(path, 1);
+	free(path);
 
 	if (shared_repository) {
 		char buf[10];
diff --git a/http-walker.c b/http-walker.c
index 2c37868..1a02f86 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -231,6 +231,8 @@ static void finish_object_request(struct object_request *obj_req)
 {
 	struct stat st;
 
+	free(obj_req->url);
+
 	fchmod(obj_req->local, 0444);
 	close(obj_req->local); obj_req->local = -1;
 
@@ -897,9 +899,17 @@ static int fetch_ref(struct walker *walker, char *ref, unsigned char *sha1)
 static void cleanup(struct walker *walker)
 {
 	struct walker_data *data = walker->data;
+	struct alt_base *prev_altbase, *altbase = data->alt;
+	while (altbase) {
+		free(altbase->base);
+		prev_altbase = altbase;
+		altbase = altbase->next;
+		free(prev_altbase);
+	}
 	http_cleanup();
 
 	curl_slist_free_all(data->no_pragma_header);
+	free(data);
 }
 
 struct walker *get_http_walker(const char *url)
diff --git a/walker.c b/walker.c
index adc3e80..64fc419 100644
--- a/walker.c
+++ b/walker.c
@@ -299,6 +299,7 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 			goto unlock_and_fail;
 	}
 	free(msg);
+	free(sha1);
 
 	return 0;
 
@@ -306,6 +307,7 @@ unlock_and_fail:
 	for (i = 0; i < targets; i++)
 		if (lock[i])
 			unlock_ref(lock[i]);
+	free(sha1);
 
 	return -1;
 }
-- 
1.5.4.rc3.30.gb084e

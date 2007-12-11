From: Mike Hommey <mh@glandium.org>
Subject: [PATCH 2/2] Fix some memory leaks in various places
Date: Tue, 11 Dec 2007 22:19:57 +0100
Message-ID: <1197407997-22945-2-git-send-email-mh@glandium.org>
References: <1197407997-22945-1-git-send-email-mh@glandium.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 11 22:20:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2CWd-0002PV-WD
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 22:20:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647AbXLKVUA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 16:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751553AbXLKVUA
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 16:20:00 -0500
Received: from smtp19.orange.fr ([80.12.242.18]:10158 "EHLO smtp19.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751389AbXLKVT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 16:19:59 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf1926.orange.fr (SMTP Server) with ESMTP id AFC3D1C000DF
	for <git@vger.kernel.org>; Tue, 11 Dec 2007 22:19:57 +0100 (CET)
Received: from namakemono.glandium.org (APuteaux-153-1-79-219.w81-249.abo.wanadoo.fr [81.249.109.219])
	by mwinf1926.orange.fr (SMTP Server) with ESMTP id 92BFE1C0007E;
	Tue, 11 Dec 2007 22:19:57 +0100 (CET)
X-ME-UUID: 20071211211957601.92BFE1C0007E@mwinf1926.orange.fr
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1J2CWD-0005yT-6d; Tue, 11 Dec 2007 22:19:57 +0100
X-Mailer: git-send-email 1.5.3.7.1161.g4a58-dirty
In-Reply-To: <1197407997-22945-1-git-send-email-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67944>


Signed-off-by: Mike Hommey <mh@glandium.org>
---
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
index 397b80d..7473e90 100644
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
1.5.3.7

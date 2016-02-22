From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [RFC PATCH] lmdb: restrict the visibility of some symbols
Date: Mon, 22 Feb 2016 16:41:44 +0000
Message-ID: <56CB3A48.2070904@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 17:42:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXtYf-0007uN-9c
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 17:42:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753775AbcBVQlz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 11:41:55 -0500
Received: from avasout01.plus.net ([84.93.230.227]:43696 "EHLO
	avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755216AbcBVQlu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 11:41:50 -0500
Received: from [10.0.2.15] ([46.208.159.221])
	by avasout01 with smtp
	id MUhm1s0094mu3xa01Uhon2; Mon, 22 Feb 2016 16:41:48 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=bsGxfxui c=1 sm=1 tr=0
 a=Sp5fw55EgyGSOjouSGNDoQ==:117 a=Sp5fw55EgyGSOjouSGNDoQ==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=EBOSESyhAAAA:8 a=3pfkLWkk0EVyDzq6OWAA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286933>


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi David,

If you need to re-roll your 'dt/refs-backend-lmdb' branch, please
consider squashing something like this into the relevant patches.
Note that I marked this as RFC, because I haven't got lmdb
installed, so I can't actually test it! ;-)

So, I've just eyeballed it and, hopefully, it will actually work.

Let me know.

Thanks!

ATB,
Ramsay Jones

 refs.c                   | 2 +-
 refs.h                   | 5 ----- 
 refs/refs-internal.h     | 3 +++
 test-refs-lmdb-backend.c | 5 +++--
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index 56960b5..337f110 100644
--- a/refs.c
+++ b/refs.c
@@ -22,7 +22,7 @@ static struct ref_storage_be *refs_backends = NULL;
 
 const char *ref_storage_backend = "files";
 
-void register_ref_storage_backend(struct ref_storage_be *be)
+static void register_ref_storage_backend(struct ref_storage_be *be)
 {
 	be->next = refs_backends;
 	refs_backends = be;
diff --git a/refs.h b/refs.h
index ad6d097..9cc3a37 100644
--- a/refs.h
+++ b/refs.h
@@ -515,9 +515,6 @@ extern int reflog_expire(const char *refname, const unsigned char *sha1,
  */
 int ref_storage_backend_config(const char *var, const char *value, void *ptr);
 
-struct ref_storage_be;
-
-extern struct ref_storage_be refs_be_lmdb;
 /*
  * Switch to an alternate ref storage backend.
  */
@@ -525,8 +522,6 @@ int set_ref_storage_backend(const char *name);
 
 int ref_storage_backend_exists(const char *name);
 
-void register_ref_storage_backend(struct ref_storage_be *be);
-
 void register_ref_storage_backends(void);
 
 #endif /* REFS_H */
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 0337d2e..ced6af4 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -308,5 +308,8 @@ struct ref_storage_be {
 };
 
 extern struct ref_storage_be refs_be_files;
+#ifdef USE_LIBLMDB
+extern struct ref_storage_be refs_be_lmdb;
+#endif
 
 #endif /* REFS_REFS_INTERNAL_H */
diff --git a/test-refs-lmdb-backend.c b/test-refs-lmdb-backend.c
index 5cf61e6..9703e5a 100644
--- a/test-refs-lmdb-backend.c
+++ b/test-refs-lmdb-backend.c
@@ -43,8 +43,9 @@ int main(int argc, const char **argv)
 
 	git_config(git_default_config, NULL);
 
-	register_ref_storage_backend(&refs_be_lmdb);
-	set_ref_storage_backend("lmdb");
+	register_ref_storage_backends();
+	if (!set_ref_storage_backend("lmdb"))
+		die("could not set lmdb reference backend");
 
 	if (clear_reflog) {
 		test_refdb_raw_delete_reflog(argv[0]);
-- 
2.7.0

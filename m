From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/3] refs: convert parameter of create_dir_entry() to length-limited
 string
Date: Tue, 22 May 2012 20:50:52 +0200
Message-ID: <4FBBE00C.9020104@lsrfire.ath.cx>
References: <1337692566-3718-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue May 22 20:51:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWuAi-0000G8-Id
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 20:51:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760142Ab2EVSvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 14:51:00 -0400
Received: from india601.server4you.de ([85.25.151.105]:33064 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752278Ab2EVSu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 14:50:58 -0400
Received: from [192.168.2.105] (p579BE06F.dip.t-dialin.net [87.155.224.111])
	by india601.server4you.de (Postfix) with ESMTPSA id 42C112F811C;
	Tue, 22 May 2012 20:50:56 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <1337692566-3718-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198224>

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 refs.c |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index c028333..c5e167b 100644
--- a/refs.c
+++ b/refs.c
@@ -294,12 +294,13 @@ static void clear_ref_dir(struct ref_dir *dir)
  * "refs/heads/") or "" for the top-level directory.
  */
 static struct ref_entry *create_dir_entry(struct ref_cache *ref_cache,
-					  const char *dirname, int incomplete)
+					  const char *dirname, size_t len,
+					  int incomplete)
 {
 	struct ref_entry *direntry;
-	int len = strlen(dirname);
 	direntry = xcalloc(1, sizeof(struct ref_entry) + len + 1);
-	memcpy(direntry->name, dirname, len + 1);
+	memcpy(direntry->name, dirname, len);
+	direntry->name[len] = '\0';
 	direntry->u.subdir.ref_cache = ref_cache;
 	direntry->flag = REF_DIR | (incomplete ? REF_INCOMPLETE : 0);
 	return direntry;
@@ -364,7 +365,7 @@ static struct ref_dir *search_for_subdir(struct ref_dir *dir,
 		 * therefore, create an empty record for it but mark
 		 * the record complete.
 		 */
-		entry = create_dir_entry(dir->ref_cache, subdirname, 0);
+		entry = create_dir_entry(dir->ref_cache, subdirname, len, 0);
 		add_entry_to_dir(dir, entry);
 	}
 	return get_ref_dir(entry);
@@ -823,7 +824,7 @@ static struct ref_dir *get_packed_refs(struct ref_cache *refs)
 		const char *packed_refs_file;
 		FILE *f;
 
-		refs->packed = create_dir_entry(refs, "", 0);
+		refs->packed = create_dir_entry(refs, "", 0, 0);
 		if (*refs->name)
 			packed_refs_file = git_path_submodule(refs->name, "packed-refs");
 		else
@@ -888,7 +889,8 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
 		} else if (S_ISDIR(st.st_mode)) {
 			strbuf_addch(&refname, '/');
 			add_entry_to_dir(dir,
-					 create_dir_entry(refs, refname.buf, 1));
+					 create_dir_entry(refs, refname.buf,
+							  refname.len, 1));
 		} else {
 			if (*refs->name) {
 				hashclr(sha1);
@@ -918,12 +920,12 @@ static struct ref_dir *get_loose_refs(struct ref_cache *refs)
 		 * are about to read the only subdirectory that can
 		 * hold references:
 		 */
-		refs->loose = create_dir_entry(refs, "", 0);
+		refs->loose = create_dir_entry(refs, "", 0, 0);
 		/*
 		 * Create an incomplete entry for "refs/":
 		 */
 		add_entry_to_dir(get_ref_dir(refs->loose),
-				 create_dir_entry(refs, "refs/", 1));
+				 create_dir_entry(refs, "refs/", 5, 1));
 	}
 	return get_ref_dir(refs->loose);
 }
-- 
1.7.10.2

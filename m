Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9489520248
	for <e@80x24.org>; Fri,  5 Apr 2019 16:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731102AbfDEQ6p (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 12:58:45 -0400
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:49820
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726643AbfDEQ6p (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 5 Apr 2019 12:58:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1554483523;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=b13COOocibGqqYasUHKatxnFJWtw3oqRgToPW2ehbYo=;
        b=ZYQZho3Sl4PbU+PbQ7fvjKAvwXsAGEjFtHo2x2cnJqh9SaCOrWMvvukgKuDV34or
        NE9jGfq6bmrP79oNUS6nqeCqAyHPU9mSTPOqnue6x38wCGLV1Nocv7jlZ/noke+0eHN
        6eMxOn2HjoBfUw1/87D6zm90AYSVspom9XyX/iWA=
From:   UTKARSH RAI <utkarsh.rai60@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020169ee702e51-e9c8d564-10f5-49e9-a411-fd7ceaef7afc-000000@eu-west-1.amazonses.com>
Subject: =?UTF-8?Q?[[GSoC][PATCH_=E2=80=A6]]_In_notes-merg?=
 =?UTF-8?Q?e.c_updated_notes=5Fmerge=5Fcommit()?=
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 5 Apr 2019 16:58:43 +0000
X-SES-Outgoing: 2019.04.05-54.240.7.19
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Updated notes_merge_commit() by replacing readdir() ,opendir() apis by replacing them with dir_iterator_advance() and dir_iterator_begin() respectively.
Signed-off-by: ur10 <utkarsh.rai60@gmail.com>
---
 notes-merge.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/notes-merge.c b/notes-merge.c
index 280aa8e6c1b04..dc4e2cce7151a 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -13,6 +13,8 @@
 #include "strbuf.h"
 #include "notes-utils.h"
 #include "commit-reach.h"
+#include "dir-iterator.h"
+#include "iterator.h"
 
 struct notes_merge_pair {
 	struct object_id obj, base, local, remote;
@@ -673,8 +675,8 @@ int notes_merge_commit(struct notes_merge_options *o,
 	 * commit message and parents from 'partial_commit'.
 	 * Finally store the new commit object OID into 'result_oid'.
 	 */
-	DIR *dir;
-	struct dirent *e;
+	struct dir_iterator *iter;
+	int ok;
 	struct strbuf path = STRBUF_INIT;
 	const char *buffer = get_commit_buffer(partial_commit, NULL);
 	const char *msg = strstr(buffer, "\n\n");
@@ -689,27 +691,27 @@ int notes_merge_commit(struct notes_merge_options *o,
 		die("partial notes commit has empty message");
 	msg += 2;
 
-	dir = opendir(path.buf);
-	if (!dir)
+	iter = dir_iterator_begin(path.buf);
+	if (!iter)
 		die_errno("could not open %s", path.buf);
 
 	strbuf_addch(&path, '/');
 	baselen = path.len;
-	while ((e = readdir(dir)) != NULL) {
+	while ((ok = dir_iterator_advance(iter) )== ITER_OK) {
 		struct stat st;
 		struct object_id obj_oid, blob_oid;
 
-		if (is_dot_or_dotdot(e->d_name))
+		if (is_dot_or_dotdot(iter->basename))
 			continue;
 
-		if (get_oid_hex(e->d_name, &obj_oid)) {
+		if (get_oid_hex(iter->basename, &obj_oid)) {
 			if (o->verbosity >= 3)
 				printf("Skipping non-SHA1 entry '%s%s'\n",
-					path.buf, e->d_name);
+					path.buf, iter->basename);
 			continue;
 		}
 
-		strbuf_addstr(&path, e->d_name);
+		strbuf_addstr(&path,iter->basename);
 		/* write file as blob, and add to partial_tree */
 		if (stat(path.buf, &st))
 			die_errno("Failed to stat '%s'", path.buf);
@@ -731,7 +733,7 @@ int notes_merge_commit(struct notes_merge_options *o,
 		printf("Finalized notes merge commit: %s\n",
 			oid_to_hex(result_oid));
 	strbuf_release(&path);
-	closedir(dir);
+	
 	return 0;
 }
 

--
https://github.com/git/git/pull/594

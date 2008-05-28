From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH] builtin-fetch.c (store_updated_refs): Honor update_local_ref() return value
Date: Wed, 28 May 2008 19:29:36 +0400
Message-ID: <20080528152936.GA5687@wo.int.altlinux.org>
References: <20080527205348.GC32722@wo.int.altlinux.org> <7v4p8jx9uf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 28 17:31:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1Nbr-000059-Nc
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 17:30:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbYE1P3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 11:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbYE1P3i
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 11:29:38 -0400
Received: from vint.altlinux.org ([194.107.17.35]:34400 "EHLO
	vint.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbYE1P3h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 11:29:37 -0400
Received: from wo.int.altlinux.org (wo.int.altlinux.org [192.168.1.4])
	by vint.altlinux.org (Postfix) with ESMTP id 3537BB489C8;
	Wed, 28 May 2008 19:29:36 +0400 (MSD)
Received: by wo.int.altlinux.org (Postfix, from userid 508)
	id 2927CB44BCF; Wed, 28 May 2008 19:29:36 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <7v4p8jx9uf.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83100>

Sync with builtin-fetch--tool.c where append_fetch_head()
honors update_local_ref() return value.

This fixes non fast forward fetch exit status,
http://bugzilla.altlinux.org/show_bug.cgi?id=15037

Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 builtin-fetch.c              |    6 +++---
 t/t5518-fetch-exit-status.sh |   37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 3 deletions(-)
 create mode 100644 t/t5518-fetch-exit-status.sh

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 167f948..db60966 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -292,7 +292,7 @@ static int store_updated_refs(const char *url, struct ref *ref_map)
 {
 	FILE *fp;
 	struct commit *commit;
-	int url_len, i, note_len, shown_url = 0;
+	int rc = 0, url_len, i, note_len, shown_url = 0;
 	char note[1024];
 	const char *what, *kind;
 	struct ref *rm;
@@ -359,7 +359,7 @@ static int store_updated_refs(const char *url, struct ref *ref_map)
 			note);
 
 		if (ref)
-			update_local_ref(ref, what, verbose, note);
+			rc |= update_local_ref(ref, what, verbose, note);
 		else if (verbose)
 			sprintf(note, "* %-*s %-*s -> FETCH_HEAD",
 				SUMMARY_WIDTH, *kind ? kind : "branch",
@@ -376,7 +376,7 @@ static int store_updated_refs(const char *url, struct ref *ref_map)
 		}
 	}
 	fclose(fp);
-	return 0;
+	return rc;
 }
 
 /*
diff --git a/t/t5518-fetch-exit-status.sh b/t/t5518-fetch-exit-status.sh
new file mode 100644
index 0000000..c6bc65f
--- /dev/null
+++ b/t/t5518-fetch-exit-status.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Dmitry V. Levin
+#
+
+test_description='fetch exit status test'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+
+	>file &&
+	git add file &&
+	git commit -m initial &&
+
+	git checkout -b side &&
+	echo side >file &&
+	git commit -a -m side &&
+
+	git checkout master &&
+	echo next >file &&
+	git commit -a -m next
+'
+
+test_expect_success 'non fast forward fetch' '
+
+	test_must_fail git fetch . master:side
+
+'
+
+test_expect_success 'forced update' '
+
+	git fetch . +master:side
+
+'
+
+test_done

-- 
ldv

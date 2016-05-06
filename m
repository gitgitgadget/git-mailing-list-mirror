From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 02/33] commit_ref(): if there is an empty dir in the way, delete it
Date: Fri,  6 May 2016 18:13:43 +0200
Message-ID: <5387c0d8839e366c44838c808ccc20eb7f9bd358.1462550456.git.mhagger@alum.mit.edu>
References: <cover.1462550456.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 06 18:16:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayiQF-0000eH-ID
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 18:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbcEFQP7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 12:15:59 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:58915 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758570AbcEFQOk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 12:14:40 -0400
X-AuditID: 1207440f-8a7ff700000008e4-d0-572cc2e1ed4f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 2E.C5.02276.1E2CC275; Fri,  6 May 2016 12:14:25 -0400 (EDT)
Received: from michael.fritz.box (p508EA663.dip0.t-ipconnect.de [80.142.166.99])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u46GEHUi031758
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 6 May 2016 12:14:23 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1462550456.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsUixO6iqPvwkE64QdNsCYv5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxq7cDu8ff9ByaPnbPusns8693D6HHxkrLH/qXb2DwW
	PL/P7vF5k1wAexS3TVJiSVlwZnqevl0Cd8bkk31sBRf4K04v1WlgvMbTxcjJISFgIrFq60lm
	EFtIYCujxJ0jYV2MXED2cSaJjZ3XGEESbAK6Eot6mplAbBGBCImGVy1AcQ4OZoHPjBIruUHC
	wgJhEj8/9bGB2CwCqhIfHu9gBynhFYiSaF/BArFKTuLy9AdgJZwCFhKHeo8zQaw1l+hYe4N9
	AiPPAkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW6Jnq5mSV6qSmlmxghocW/g7FrvcwhRgEO
	RiUe3oyT2uFCrIllxZW5hxglOZiURHm/F+iEC/El5adUZiQWZ8QXleakFh9ilOBgVhLhvbIP
	KMebklhZlVqUD5OS5mBREudVX6LuJySQnliSmp2aWpBaBJOV4eBQkuA9dBCoUbAoNT21Ii0z
	pwQhzcTBCTKcS0qkODUvJbUosbQkIx4U+vHFwOAHSfEA7ZUHaectLkjMBYpCtJ5i1OU4sv/e
	WiYhlrz8vFQpcd65IEUCIEUZpXlwK2CJ5BWjONDHwrzcwLQixANMQnCTXgEtYQJa8n6uJsiS
	kkSElFQDo6GlXq7Ijp1eLwrmr3/8ecWDP5cmPDxWf6Hh8wvjWStM5XzaCj/w1GdYmavZhGVq
	GUkl/P3f8mDqpy/8HwzX9ixWevnt9997J86H8r2ZUNxtHRnpv/TSwQ26PDoJ+/Ye 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293824>

Part of the bug revealed in the last commit is that resolve_ref_unsafe()
incorrectly returns EISDIR if it finds a directory in the place where it
is looking for a loose reference, even if the corresponding packed
reference exists. lock_ref_sha1_basic() notices the bogus EISDIR, and
use it as an indication that it should call remove_empty_directories()
and call resolve_ref_unsafe() again.

But resolve_ref_unsafe() shouldn't report EISDIR in this case. If we
would simply make that change, then remove_empty_directories() wouldn't
get called anymore, and the empty directory would get in the way when
commit_ref() calls commit_lock_file() to rename the lockfile into place.

So instead of relying on lock_ref_sha1_basic() to delete empty
directories, teach commit_ref(), just before calling commit_lock_file(),
to check whether a directory is in the way, and if so, try to delete it.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1f38076..ad9cd86 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2457,6 +2457,30 @@ static int close_ref(struct ref_lock *lock)
 
 static int commit_ref(struct ref_lock *lock)
 {
+	char *path = get_locked_file_path(lock->lk);
+	struct stat st;
+
+	if (!lstat(path, &st) && S_ISDIR(st.st_mode)) {
+		/*
+		 * There is a directory at the path we want to rename
+		 * the lockfile to. Hopefully it is empty; try to
+		 * delete it.
+		 */
+		size_t len = strlen(path);
+		struct strbuf sb_path = STRBUF_INIT;
+
+		strbuf_attach(&sb_path, path, len, len);
+
+		/*
+		 * If this fails, commit_lock_file() will also fail
+		 * and will report the problem.
+		 */
+		remove_empty_directories(&sb_path);
+		strbuf_release(&sb_path);
+	} else {
+		free(path);
+	}
+
 	if (commit_lock_file(lock->lk))
 		return -1;
 	return 0;
-- 
2.8.1

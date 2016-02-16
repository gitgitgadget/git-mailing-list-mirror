From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 03/20] raceproof_create_file(): new function
Date: Tue, 16 Feb 2016 14:22:16 +0100
Message-ID: <338201e98a16f6c53ed1ee447de10c206f2acc33.1455626201.git.mhagger@alum.mit.edu>
References: <cover.1455626201.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 14:30:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfhY-0002e8-Ml
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:30:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbcBPN34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 08:29:56 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:64164 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932280AbcBPN3x (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2016 08:29:53 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Feb 2016 08:29:53 EST
X-AuditID: 1207440d-6b7ff7000000068f-14-56c322aa7a59
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id E4.B2.01679.AA223C65; Tue, 16 Feb 2016 08:22:50 -0500 (EST)
Received: from michael.fritz.box (p548D6919.dip0.t-ipconnect.de [84.141.105.25])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1GDMfOP028717
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Feb 2016 08:22:49 -0500
X-Mailer: git-send-email 2.7.0
In-Reply-To: <cover.1455626201.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqLtK6XCYwZrjxhbzN51gtOi60s1k
	0dB7hdniw9pDbBa9k3tZLW6vmM9s8aOlh9mB3ePv+w9MHk+3T2H2eHG+wuNZ7x5Gj4uXlD0W
	PL/P7vF5k1wAexS3TVJiSVlwZnqevl0Cd0b3stOsBTNUKxYtmcPawHhTtouRk0NCwETiSddv
	9i5GLg4hga2MEpc/zmeEcE4wSUw+2MsIUsUmoCuxqKeZCcQWEVCTmNh2iAWkiFngEaNE1/7t
	YEXCAjYSd+cfZwOxWQRUJfofNLOA2LwCURKfV95mg1gnJ9HyYzcriM0pYCFxsqUXrEZIwFzi
	zpc9TBMYeRYwMqxilEvMKc3VzU3MzClOTdYtTk7My0st0jXSy80s0UtNKd3ECAky3h2M/9fJ
	HGIU4GBU4uHl8DgUJsSaWFZcmXuIUZKDSUmUl4f7cJgQX1J+SmVGYnFGfFFpTmrxIUYJDmYl
	Ed5/r4DKeVMSK6tSi/JhUtIcLErivGpL1P2EBNITS1KzU1MLUotgsjIcHEoSvB2KQEMFi1LT
	UyvSMnNKENJMHJwgw7mkRIpT81JSixJLSzLiQVEQXwyMA5AUD9DeNJB23uKCxFygKETrKUZF
	KXFeF5CEAEgiozQPbiwsdbxiFAf6Upj3OEgVDzDtwHW/AhrMBDQ45xLIQ8UliQgpqQbG1puN
	U9suX/nva3zz5I3d69rr6uPOnbvRM02W/8xNk7UPGnaw6TfEfc06uPuInGy7eOOnTW5z6tWj
	T7UJ9Xlv2S4n/exKV5mB8Yudy2U+/2jZfuuMx732q637C/aKNtk+k/h56ORExSPz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286367>

Add a function that tries to create a file and any containing
directories in a way that is robust against races with other processes
that might be cleaning up empty directories at the same time.

The actual file creation is done by a callback function, which, if it
fails, should set errno to EISDIR or ENOENT according to the convention
of open(). raceproof_create_file() detects such failures, and
respectively either tries to delete empty directories that might be in
the way of the file or tries to create the containing directories. Then
it retries the callback function.

This function is not yet used.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
The actual file creation is done by a callback function, so I think
this function is flexible enough to be applicable in other
circumstances where similar races might occur. Perhaps when creating
loose object files in the ODB?

I was thinking about moving this function, along with
safe_create_leading_directories() and
safe_create_leading_directories_const(), to a more general module like
path.c. But it didn't seem worth the code churn.

 cache.h     | 16 ++++++++++++++
 sha1_file.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/cache.h b/cache.h
index 7d3f80c..6e53cc8 100644
--- a/cache.h
+++ b/cache.h
@@ -976,6 +976,22 @@ enum scld_error {
 enum scld_error safe_create_leading_directories(char *path);
 enum scld_error safe_create_leading_directories_const(const char *path);
 
+typedef int create_file_fn(const char *path, void *cb);
+
+/*
+ * Create a file at path using fn, creating leading directories if
+ * necessary. If fn fails with errno==ENOENT, then try to create the
+ * containing directory and call fn again. If fn fails with
+ * errno==EISDIR, then delete the directory that is in the way if it
+ * is empty and call fn again. Retry a few times in case we are racing
+ * with another process that is trying to clean up the directory
+ * that contains path.
+ *
+ * In any case, the return value of this function and the errno that
+ * it sets are those resulting from the last call of fn.
+ */
+int raceproof_create_file(const char *path, create_file_fn fn, void *cb);
+
 int mkdir_in_gitdir(const char *path);
 extern char *expand_user_path(const char *path);
 const char *enter_repo(const char *path, int strict);
diff --git a/sha1_file.c b/sha1_file.c
index a1ac646..31dcfe8 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -177,6 +177,75 @@ enum scld_error safe_create_leading_directories_const(const char *path)
 	return result;
 }
 
+int raceproof_create_file(const char *path, create_file_fn fn, void *cb)
+{
+	/*
+	 * The number of times we will try to remove empty directories
+	 * in the way of path. This is only 1 because if another
+	 * process is racily creating directories that conflict with
+	 * us, we don't want to fight against them.
+	 */
+	int remove_directories_remaining = 1;
+
+	/*
+	 * The number of times that we will try to create the
+	 * directories containing path. We are willing to attempt this
+	 * more than once, because another process could be trying to
+	 * clean up empty directories at the same time as we are
+	 * trying to create them.
+	 */
+	int create_directories_remaining = 3;
+
+	/* A scratch copy of path, filled lazily if we need it: */
+	struct strbuf path_copy = STRBUF_INIT;
+
+	int save_errno;
+	int ret;
+
+retry_fn:
+	ret = fn(path, cb);
+	save_errno = errno;
+	if (!ret)
+		goto out;
+
+	if (errno == EISDIR && remove_directories_remaining > 0) {
+		/*
+		 * A directory is in the way. Maybe it is empty; try
+		 * to remove it:
+		 */
+		if (!path_copy.len)
+			strbuf_addstr(&path_copy, path);
+
+		if (!remove_dir_recursively(&path_copy, REMOVE_DIR_EMPTY_ONLY)) {
+			remove_directories_remaining--;
+			goto retry_fn;
+		}
+	} else if (errno == ENOENT && create_directories_remaining > 0) {
+		/*
+		 * Maybe the containing directory didn't exist, or
+		 * maybe it was just deleted by a process that is
+		 * racing with us to clean up empty directories. Try
+		 * to create it:
+		 */
+		enum scld_error scld_result;
+
+		if (!path_copy.len)
+			strbuf_addstr(&path_copy, path);
+
+		do {
+			create_directories_remaining--;
+			scld_result = safe_create_leading_directories(path_copy.buf);
+			if (scld_result == SCLD_OK)
+				goto retry_fn;
+		} while (scld_result == SCLD_VANISHED && create_directories_remaining > 0);
+	}
+
+out:
+	strbuf_release(&path_copy);
+	errno = save_errno;
+	return ret;
+}
+
 static void fill_sha1_path(char *pathbuf, const unsigned char *sha1)
 {
 	int i;
-- 
2.7.0

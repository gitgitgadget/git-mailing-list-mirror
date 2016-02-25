From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 03/20] raceproof_create_file(): new function
Date: Thu, 25 Feb 2016 14:16:02 +0100
Message-ID: <70ffbbd27e47b65af5d93d3cc6a2ac38d5e78984.1456405698.git.mhagger@alum.mit.edu>
References: <cover.1456405698.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 14:23:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYvtO-00084a-8V
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 14:23:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760672AbcBYNXj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 08:23:39 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:62930 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760665AbcBYNXi (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2016 08:23:38 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Feb 2016 08:23:37 EST
X-AuditID: 1207440c-99fff700000008b4-65-56cefeb29cf6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 54.3F.02228.2BEFEC65; Thu, 25 Feb 2016 08:16:34 -0500 (EST)
Received: from michael.fritz.box (p548D63F1.dip0.t-ipconnect.de [84.141.99.241])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1PDGPrh024973
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 25 Feb 2016 08:16:32 -0500
X-Mailer: git-send-email 2.7.0
In-Reply-To: <cover.1456405698.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsUixO6iqLvp37kwg2WLpSzmbzrBaNF1pZvJ
	oqH3CrPFh7WH2Cx6J/eyWtxeMZ/Z4kdLD7MDu8ff9x+YPJ5un8Ls8eJ8hcez3j2MHhcvKXss
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7oyFe2axFHRqV7xZOIWpgfG7YhcjJ4eEgInEgvtt
	LF2MXBxCAlsZJQ79fMwK4Zxgktj3bgITSBWbgK7Eop5mMFtEQE1iYtshsA5mgUeMEl37tzN2
	MXJwCAvYS1x9mQdSwyKgKvH8fxsbiM0rECXxcOICRohtchItP3azgticAhYSF09OZwaxhQTM
	JVbd2MM+gZFnASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdQ73czBK91JTSTYyQEOPZwfht
	ncwhRgEORiUeXoafZ8OEWBPLiitzDzFKcjApifLueX4uTIgvKT+lMiOxOCO+qDQntfgQowQH
	s5II74q/QDnelMTKqtSifJiUNAeLkjiv6hJ1PyGB9MSS1OzU1ILUIpisDAeHkgTvJpBGwaLU
	9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFAMxBcDowAkxQO0V/EfyN7igsRcoChE6ylG
	RSlx3uUgcwVAEhmleXBjYYnjFaM40JfCvC0gVTzApAPX/QpoMBPQ4JkbwAaXJCKkpBoYw0Sf
	b/oTcvPiUqPWN2snyP85Xt70V/mv69W1WZmO66UEhdS9VnLf0U8yLxVZsjH4t9q7lDJ7Kf9n
	0QdZpnvMVCnbe9o54cg6n7lJzyoMPV6xeZ9YfvTQ2w/SoRW7uerXiT87/JxzK4/4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287381>

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
 cache.h     | 42 +++++++++++++++++++++++++++++++++++++
 sha1_file.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 111 insertions(+)

diff --git a/cache.h b/cache.h
index 7d3f80c..36b9c8b 100644
--- a/cache.h
+++ b/cache.h
@@ -976,6 +976,48 @@ enum scld_error {
 enum scld_error safe_create_leading_directories(char *path);
 enum scld_error safe_create_leading_directories_const(const char *path);
 
+/*
+ * Callback function for raceproof_create_file(). This function is
+ * expected to do something that makes dirname(path) permanent despite
+ * the fact that other processes might be cleaning up empty
+ * directories at the same time. Usually it will create a file named
+ * path, but alternatively it could create another file in that
+ * directory, or even chdir() into that directory. The function should
+ * return 0 if the action was completed successfully. On error, it
+ * should return a nonzero result and set errno.
+ * raceproof_create_file() treats two errno values specially:
+ *
+ * - ENOENT -- dirname(path) does not exist. In this case,
+ *             raceproof_create_file() tries creating dirname(path)
+ *             (and any parent directories, if necessary) and calls
+ *             the function again.
+ *
+ * - EISDIR -- the file already exists and is a directory. In this
+ *             case, raceproof_create_file() deletes the directory
+ *             (recursively) if it is empty and calls the function
+ *             again.
+ *
+ * Any other errno causes raceproof_create_file() to fail with the
+ * same return value and errno.
+ *
+ * Obviously, this function should be OK with being called again if it
+ * fails with ENOENT or EISDIR. In other scenarios it will not be
+ * called again.
+ */
+typedef int create_file_fn(const char *path, void *cb);
+
+/*
+ * Create a file in dirname(path) by calling fn, creating leading
+ * directories if necessary. Retry a few times in case we are racing
+ * with another process that is trying to clean up the directory that
+ * contains path. See the documentation for create_file_fn for more
+ * details.
+ *
+ * Return the value and set the errno that resulted from the most
+ * recent call of fn.
+ */
+int raceproof_create_file(const char *path, create_file_fn fn, void *cb);
+
 int mkdir_in_gitdir(const char *path);
 extern char *expand_user_path(const char *path);
 const char *enter_repo(const char *path, int strict);
diff --git a/sha1_file.c b/sha1_file.c
index 94c6779..344aeeb 100644
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

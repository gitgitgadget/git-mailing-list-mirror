From: "Bradford C. Smith" <bradford.carl.smith@gmail.com>
Subject: [PATCH 1/2] resolve symlinks when creating lockfiles
Date: Wed, 25 Jul 2007 12:49:52 -0400
Message-ID: <11853821951367-git-send-email-bradford.carl.smith@gmail.com>
References: <7vps2s2chy.fsf@assigned-by-dhcp.cox.net>
 <11853821932079-git-send-email-bradford.carl.smith@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	"Bradford C. Smith" <bradford.carl.smith@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 25 18:50:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDk3s-0004AA-E9
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 18:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755001AbXGYQt7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 12:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758745AbXGYQt6
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 12:49:58 -0400
Received: from ag-out-0708.google.com ([72.14.246.246]:34716 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755001AbXGYQt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 12:49:57 -0400
Received: by ag-out-0708.google.com with SMTP id 35so2199451aga
        for <git@vger.kernel.org>; Wed, 25 Jul 2007 09:49:56 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WVFwhT+wotAtjqY51uvW3enXcfyb4r6tu/DgmIJSwXiO9549mQql4xH7/5t0Ws8LwaojisoeOL18738/ABlbBMyBd6Bm4cdWGXqJDQdteeJsoGIjy344wa5AGyJhfP3UnbWgT4SnewMn6CUo3PV8xdHpb911oAi8ujHV2vqlbos=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PvJ8407IwUfnGCyIpgOsVjwAS/SMgN+q9w+kQQKnLejikMCBDhJyitcNUC2zbcaKBWrRhX+qEEfeiVMRjcNOf8uFvrwAY72mYbWf/p2VlrHmmw93zH3AmtxYFdkxZgLfGtyHvAWFmCmp4lrz/n2NpOD8Ot6Njd+lfx95wZFSxEQ=
Received: by 10.100.138.2 with SMTP id l2mr465936and.1185382196552;
        Wed, 25 Jul 2007 09:49:56 -0700 (PDT)
Received: from localhost ( [160.36.232.47])
        by mx.google.com with ESMTPS id d38sm1018324and.2007.07.25.09.49.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 Jul 2007 09:49:56 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.rc2.30.g1c06-dirty
In-Reply-To: <11853821932079-git-send-email-bradford.carl.smith@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53698>

From: Bradford C. Smith <bradford.carl.smith@gmail.com>

Without this fix, the lockfile code will replace a symlink with a real file.

Signed-off-by: "Bradford C. Smith" <bradford.carl.smith@gmail.com>
---
 lockfile.c |   87 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 86 insertions(+), 1 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index fb8f13b..4c35224 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -25,10 +25,95 @@ static void remove_lock_file_on_signal(int signo)
 	raise(signo);
 }
 
+/**
+ * p = absolute or relative path name
+ *
+ * Return a pointer into p showing the beginning of the last path name
+ * element.  If p is empty or the root directory ("/"), just return p.
+ */
+static char * last_path_elm(char * p)
+{
+	int	p_len = strlen(p);
+	char *	r;
+
+	if (p_len < 1) return p;
+	/* r points to last non-null character in p */
+	r = p + p_len - 1;
+	/* first skip any trailing slashes */
+	while (*r == '/' && r > p) r--;
+	/* then go back to the first non-slash */
+	while (r > p && *(r-1) != '/') r--;
+	return r;
+}
+
+/**
+ * p = char array containing path to existing file or symlink
+ * s = size of p
+ *
+ * If p indicates a valid symlink to an existing file, overwrite p with
+ * the path to the real file.  Otherwise, leave p unmodified.
+ *
+ * Always returns p in any case.
+ *
+ * NOTE: This is a best-effort routine.  It will give no indication of
+ * failure if it is unable to fully resolve p.  However, it is
+ * guaranteed to leave p in one of the following states if there isn't
+ * enough room in p or some other failure occurs:
+ *
+ * 1. unmodified
+ *      OR
+ * 2. path to a different symlink in a chain that eventually leads to a
+ *    real file or directory.
+ */
+static char * resolve_symlink(char * p, size_t s)
+{
+	struct stat st;
+	char link[PATH_MAX];
+	int link_len;
+
+	/* To avoid an infinite loop of symlinks, try a normal stat()
+	 * first.  This will fail if p is a symlink that cannot be
+	 * resolved, so we won't waste our time following a bad link. */
+	if (stat(p, &st)) return p;
+	/* if I can stat() the file, I sure ought to be able to lstat()
+	 * it, but if something bizarre happens, just return p.  */
+	if (lstat(p, &st)) return p;
+	/* if not a link, return p unmodified */
+	if (!S_ISLNK(st.st_mode)) return p;
+	link_len = st.st_size;
+	/* link is too big, so just return p */
+	if (link_len >= sizeof(link)) return p;
+	/* fail if readlink fails, and just return p */
+	if (link_len != readlink(p, link, sizeof(link))) return p;
+	/* readlink never null-terminates */
+	link[link_len] = '\0';
+	if (link[0] == '/') {
+		/* absolute path simply replaces p */
+		/* fail if link won't fit in p */
+		if (link_len >= s) return p;
+		strcpy(p, link);
+	} else {
+		/* link is relative path, so we must replace the last
+		 * element of p with it. */
+		char * r = last_path_elm(p);
+		/* make sure there's room in p for us to replace the
+		 * last element with the link contents */
+		if (r - p + link_len >= s) return p;
+		strcpy(r, link);
+	}
+	/* try again in case we've resolved to another symlink */
+	return resolve_symlink(p, s);
+}
+
 static int lock_file(struct lock_file *lk, const char *path)
 {
 	int fd;
-	sprintf(lk->filename, "%s.lock", path);
+	if (strlen(path) >= sizeof(lk->filename)) return -1;
+	strcpy(lk->filename, path);
+	/* subtract 5 from size to make sure there's room for adding
+	 * ".lock" for the lock file name */
+	resolve_symlink(lk->filename, sizeof(lk->filename)-5);
+	strcat(lk->filename, ".lock");
 	fd = open(lk->filename, O_RDWR | O_CREAT | O_EXCL, 0666);
 	if (0 <= fd) {
 		if (!lock_file_list) {
-- 
1.5.3.rc2.30.g1c06-dirty

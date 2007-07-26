From: "Bradford C. Smith" <bradford.carl.smith@gmail.com>
Subject: [PATCH] fully resolve symlinks when creating lockfiles
Date: Thu, 26 Jul 2007 13:34:14 -0400
Message-ID: <11854712542350-git-send-email-bradford.carl.smith@gmail.com>
References: <7vbqe0cazy.fsf@assigned-by-dhcp.cox.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	"Bradford C. Smith" <bradford.carl.smith@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 26 19:34:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IE7EI-0003oQ-W8
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 19:34:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762853AbXGZReX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 13:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761056AbXGZReX
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 13:34:23 -0400
Received: from qb-out-0506.google.com ([72.14.204.234]:40927 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107AbXGZReW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 13:34:22 -0400
Received: by qb-out-0506.google.com with SMTP id e11so335513qbe
        for <git@vger.kernel.org>; Thu, 26 Jul 2007 10:34:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=g/fIQJzMGNzid71H7P+GgcLaFYJWZLtPRZkxT3efmKaDbLyLn0DrdItcGeroyHv6AdjGkMp6CsQ+sD6yxs8IpGjRG8UaagmxLcZMW8fzWL/235rAdb6F6spSOL/Ahz8jqcW5ColnytQfB9vtWWmw/qzIa8PZu/1dfTeE+qyc3aI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WkLc4F3Z5D5Qy2dopCjPdELBBVCKaQCtZQpY6073mmvKQNioTt2qPuIRStV7mUoNCuMyzzisiJwVinKmDvcIJ6hddqzQPvqt6sJ3hHay+IL+z+vUEFX5oc6he8BVWxzhILU2JXN36xUg2IYvS64sDkLIQi4KDA84MQEjm5jRO8k=
Received: by 10.100.32.1 with SMTP id f1mr1713004anf.1185471255321;
        Thu, 26 Jul 2007 10:34:15 -0700 (PDT)
Received: from localhost ( [160.36.232.47])
        by mx.google.com with ESMTPS id c39sm2864870anc.2007.07.26.10.34.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 26 Jul 2007 10:34:14 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.rc3.9.g1b487
In-Reply-To: <7vbqe0cazy.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53847>

Make the code for resolving symlinks in lockfile.c more robust as
follows:

1. Handle relative symlinks
2. recursively resolve symlink chains up to OS limit

Signed-off-by: Bradford C. Smith <bradford.carl.smith@gmail.com>
---

I have updated this patch as follows based partly on Junio's comments.

	1. Made comment and coding style consistent with existing git
	   code base.
	2. improved readability
	3. rebased to latest version of master (2007-07-26) and updated
	   commit message appropriately
	4. added warning messages for error conditions
	5. resolve symlinks to non-existent files

 lockfile.c |  128 +++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 114 insertions(+), 14 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 9202472..864ce73 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -25,23 +25,123 @@ static void remove_lock_file_on_signal(int signo)
 	raise(signo);
 }
 
+/*
+ * p = absolute or relative path name
+ *
+ * Return a pointer into p showing the beginning of the last path name
+ * element.  If p is empty or the root directory ("/"), just return p.
+ */
+static const char *last_path_elm(const char *p)
+{
+	/* r starts pointing to null at the end of the string */
+	const char *r = strchr(p, '\0');
+
+	if (r == p)
+		return p; /* just return empty string */
+
+	r--; /* back up to last non-null character */
+
+	/* back up past trailing slashes, if any */
+	while (r > p && *r == '/') {
+		r--;
+	}
+	/*
+	 * then go backwards until I hit a slash, or the beginning of
+	 * the string
+	 */
+	while (r > p && *(r-1) != '/') {
+		r--;
+	}
+	return r;
+}
+
+
+/*
+ * p = path that may be a symlink
+ * s = full size of p
+ *
+ * If p is a symlink, attempt to overwrite p with a path to the real
+ * file or directory (which may or may not exist), following a chain of
+ * symlinks if necessary.  Otherwise, leave p unmodified.
+ *
+ * This is a best-effort routine.  If an error occurs, p will either be
+ * left unmodified or will name a different symlink in a symlink chain
+ * that started with p's initial contents.
+ *
+ * Always returns p.
+ */
+static char *resolve_symlink(char * p, size_t s)
+{
+	struct stat stb;
+	char link[PATH_MAX];
+	int link_len;
+
+	/*
+	 * leave p unchanged if it doesn't appear to be a valid path to
+	 * a symlink.
+	 */
+	if (lstat(p, &stb) != 0 || !S_ISLNK(stb.st_mode)) {
+		return p;
+	}
+	/*
+	 * don't attempt to resolve a chain or loop of symlinks the OS
+	 * cannot resolve.
+	 */
+	if (stat(p, &stb) != 0 && ELOOP == errno) {
+		warning("%s: %s", p, strerror(ELOOP));
+		return p;
+	}
+
+	link_len = readlink(p, link, sizeof(link));
+	if (link_len < 0) {
+		warning("%s: %s", p, strerror(errno));
+		return p;
+	} else if (link_len < sizeof(link)) {
+		/* readlink() never null-terminates */
+		link[link_len] = '\0';
+	} else {
+		warning("%s: symlink too long", p);
+		return p;
+	}
+
+	if (link[0] == '/') {
+		/* absolute path simply replaces p */
+		if (link_len < s) {
+			strcpy(p, link);
+		} else {
+			warning("%s: symlink too long", p);
+			return p;
+		}
+	} else {
+		/*
+		 * link is a relative path, so I must replace the last
+		 * element of p with it.
+		 */
+		char *r = (char*)last_path_elm(p);
+		if (r - p + link_len < s) {
+			strcpy(r, link);
+		} else {
+			warning("%s: symlink too long", p);
+			return p;
+		}
+	}
+	/* try again in case we've resolved to another symlink */
+	return resolve_symlink(p, s);
+}
+
+
 static int lock_file(struct lock_file *lk, const char *path)
 {
 	int fd;
-	struct stat st;
-
-	if ((!lstat(path, &st)) && S_ISLNK(st.st_mode)) {
-		ssize_t sz;
-		static char target[PATH_MAX];
-		sz = readlink(path, target, sizeof(target));
-		if (sz < 0)
-			warning("Cannot readlink %s", path);
-		else if (target[0] != '/')
-			warning("Cannot lock target of relative symlink %s", path);
-		else
-			path = target;
-	}
-	sprintf(lk->filename, "%s.lock", path);
+
+	if (strlen(path) >= sizeof(lk->filename)) return -1;
+	strcpy(lk->filename, path);
+	/*
+	 * subtract 5 from size to make sure there's room for adding
+	 * ".lock" for the lock file name
+	 */
+	resolve_symlink(lk->filename, sizeof(lk->filename)-5);
+	strcat(lk->filename, ".lock");
 	fd = open(lk->filename, O_RDWR | O_CREAT | O_EXCL, 0666);
 	if (0 <= fd) {
 		if (!lock_file_list) {
-- 
1.5.3.rc3.9.g1b487

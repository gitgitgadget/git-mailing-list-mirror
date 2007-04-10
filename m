From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 3/6] Add 'resolve_gitlink_ref()' helper function
Date: Mon, 9 Apr 2007 21:14:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704092114010.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 10 09:17:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hb7kY-0006cl-Qc
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 06:14:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933058AbXDJEOb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 00:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933075AbXDJEOb
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 00:14:31 -0400
Received: from smtp.osdl.org ([65.172.181.24]:42950 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933058AbXDJEOa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 00:14:30 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3A4ERPD025572
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 9 Apr 2007 21:14:27 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3A4ER0v031016;
	Mon, 9 Apr 2007 21:14:27 -0700
In-Reply-To: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.953 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44113>


This new function resolves a ref in *another* git repository.  It's
named for its intended use: to look up the git link to a subproject.

It's not actually wired up to anything yet, but we're getting closer to
having fundamental plumbing support for "links" from one git directory
to another, which is the basis of subproject support.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 refs.c |   79 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 refs.h |    3 ++
 2 files changed, 82 insertions(+), 0 deletions(-)

diff --git a/refs.c b/refs.c
index d2b7b7f..229da74 100644
--- a/refs.c
+++ b/refs.c
@@ -215,6 +215,85 @@ static struct ref_list *get_loose_refs(void)
 
 /* We allow "recursive" symbolic refs. Only within reason, though */
 #define MAXDEPTH 5
+#define MAXREFLEN (1024)
+
+static int resolve_gitlink_packed_ref(char *name, int pathlen, const char *refname, unsigned char *result)
+{
+	FILE *f;
+	struct cached_refs refs;
+	struct ref_list *ref;
+	int retval;
+
+	strcpy(name + pathlen, "packed-refs");
+	f = fopen(name, "r");
+	if (!f)
+		return -1;
+	read_packed_refs(f, &refs);
+	ref = refs.packed;
+	retval = -1;
+	while (ref) {
+		if (!strcmp(ref->name, refname)) {
+			retval = 0;
+			memcpy(result, ref->sha1, 20);
+			break;
+		}
+		ref = ref->next;
+	}
+	free_ref_list(refs.packed);
+	return retval;
+}
+
+static int resolve_gitlink_ref_recursive(char *name, int pathlen, const char *refname, unsigned char *result, int recursion)
+{
+	int fd, len = strlen(refname);
+	char buffer[128], *p;
+
+	if (recursion > MAXDEPTH || len > MAXREFLEN)
+		return -1;
+	memcpy(name + pathlen, refname, len+1);
+	fd = open(name, O_RDONLY);
+	if (fd < 0)
+		return resolve_gitlink_packed_ref(name, pathlen, refname, result);
+
+	len = read(fd, buffer, sizeof(buffer)-1);
+	close(fd);
+	if (len < 0)
+		return -1;
+	while (len && isspace(buffer[len-1]))
+		len--;
+	buffer[len] = 0;
+
+	/* Was it a detached head or an old-fashioned symlink? */
+	if (!get_sha1_hex(buffer, result))
+		return 0;
+
+	/* Symref? */
+	if (strncmp(buffer, "ref:", 4))
+		return -1;
+	p = buffer + 4;
+	while (isspace(*p))
+		p++;
+
+	return resolve_gitlink_ref_recursive(name, pathlen, p, result, recursion+1);
+}
+
+int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *result)
+{
+	int len = strlen(path), retval;
+	char *gitdir;
+
+	while (len && path[len-1] == '/')
+		len--;
+	if (!len)
+		return -1;
+	gitdir = xmalloc(len + MAXREFLEN + 8);
+	memcpy(gitdir, path, len);
+	memcpy(gitdir + len, "/.git/", 7);
+
+	retval = resolve_gitlink_ref_recursive(gitdir, len+6, refname, result, 0);
+	free(gitdir);
+	return retval;
+}
 
 const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *flag)
 {
diff --git a/refs.h b/refs.h
index acedffc..f61f6d9 100644
--- a/refs.h
+++ b/refs.h
@@ -60,4 +60,7 @@ extern int check_ref_format(const char *target);
 /** rename ref, return 0 on success **/
 extern int rename_ref(const char *oldref, const char *newref, const char *logmsg);
 
+/** resolve ref in nested "gitlink" repository */
+extern int resolve_gitlink_ref(const char *name, const char *refname, unsigned char *result);
+
 #endif /* REFS_H */
-- 
1.5.1.110.g1e4c

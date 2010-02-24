From: Andreas Gruenbacher <agruen@suse.de>
Subject: [PATCH 3/3] Different views on a repository: HEAD mapping
Date: Wed, 24 Feb 2010 17:14:03 +0100
Message-ID: <d4ad6b45786def21cbe484c97723aa573b069175.1267029680.git.agruen@suse.de>
References: <cover.1267029680.git.agruen@suse.de>
	<f409d0cde7939a833708ed92f86605dbbdd64a49.1267029680.git.agruen@suse.de>
	<92fea2335b73265b04d64fcc217055e1170f5e16.1267029680.git.agruen@suse.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 18:10:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkKkq-0001b5-CV
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 18:10:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757363Ab0BXRK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 12:10:27 -0500
Received: from cantor.suse.de ([195.135.220.2]:51325 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757340Ab0BXRK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 12:10:26 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 65D8C9417A
	for <git@vger.kernel.org>; Wed, 24 Feb 2010 18:10:25 +0100 (CET)
In-Reply-To: <92fea2335b73265b04d64fcc217055e1170f5e16.1267029680.git.agruen@suse.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140956>

The HEAD ref is not located under .git/refs/heads/, so the trivial
view mapping doesn't work.  Fix this by making refs/heads/<view>HEAD
appear as HEAD on the client when --view=<view> is used in upload-pack
and receive-pack.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
---
 Documentation/git-receive-pack.txt |    7 ++++---
 Documentation/git-upload-pack.txt  |    9 +++++----
 refs.c                             |   21 ++++++++++++++++++---
 refs.h                             |    1 +
 upload-pack.c                      |    9 +++++++--
 5 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 09d7d0c..07e0159 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -36,9 +36,10 @@ OPTIONS
 -------
 --view=<prefix>::
 	Prepend <prefix> to all ref names.  For example, --view=one/ will
-	turn refs/tags/v1 into refs/tags/one/v1 on the receiving end.  Together
-	with the --view option of linkgit:git-upload-pack[1], this allows to
-	make one respository look like multiple independent repositories.
+	turn refs/tags/v1 into refs/tags/one/v1 and HEAD into refs/heads/one/HEAD
+	on the receiving end.  Together with the --view option of
+	linkgit:git-upload-pack[1], this allows to make one respository look like
+	multiple independent repositories.
 
 <directory>::
 	The repository to sync into.
diff --git a/Documentation/git-upload-pack.txt b/Documentation/git-upload-pack.txt
index 0eee0ba..1e8b76b 100644
--- a/Documentation/git-upload-pack.txt
+++ b/Documentation/git-upload-pack.txt
@@ -32,10 +32,11 @@ OPTIONS
 
 --view=<prefix>::
 	Only upload refs which start with <prefix>, and hide <prefix> from the
-	remote side.  For example, --view=one/ will skip refs/heads/master
-	and turn refs/tags/one/v1 into refs/tags/v1.  Together with the --view
-	option of linkgit:git-receive-pack, this allows to make one respository
-	look like multiple independent repositories.
+	remote side.  For example, --view=one/ will skip refs/heads/master,
+	turn refs/tags/one/v1 into refs/tags/v1, and refs/heads/one/HEAD into
+	HEAD.  Together with the --view option of linkgit:git-receive-pack,
+	this allows to make one respository look like multiple independent
+	repositories.
 
 <directory>::
 	The repository to sync from.
diff --git a/refs.c b/refs.c
index b1f3951..77a6267 100644
--- a/refs.c
+++ b/refs.c
@@ -650,16 +650,21 @@ end_each:
 	return retval;
 }
 
-int head_ref(each_ref_fn fn, void *cb_data)
+int one_ref(each_ref_fn fn, void *cb_data, const char *refname)
 {
 	unsigned char sha1[20];
 	int flag;
 
-	if (resolve_ref("HEAD", sha1, 1, &flag))
-		return fn("HEAD", sha1, flag, cb_data);
+	if (resolve_ref(refname, sha1, 1, &flag))
+		return fn(refname, sha1, flag, cb_data);
 	return 0;
 }
 
+int head_ref(each_ref_fn fn, void *cb_data)
+{
+	return one_ref(fn, cb_data, "HEAD");
+}
+
 int for_each_ref(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref("refs/", fn, 0, 0, cb_data);
@@ -1846,6 +1851,10 @@ const char *ref_to_view(const char *refname, const char *view)
 	if (strncmp(r, view, view_len))
 		return NULL;
 	suffix = r + view_len;
+	if (!strncmp(refname + 5, "heads/", 6) &&
+	    !strcmp(suffix, "HEAD"))
+		return "HEAD";
+
 	prefix_len = r - refname;
 	suffix_len = strlen(suffix);
 	buffer = xrealloc(buffer, prefix_len + suffix_len + 1);
@@ -1860,6 +1869,12 @@ const char *view_to_ref(const char *refname, const char *view)
 	const char *r, *suffix;
 
 	view_len = strlen(view);
+	if (!strcmp(refname, "HEAD")) {
+		buffer = xrealloc(buffer, view_len + 16);
+		sprintf(buffer, "refs/heads/%sHEAD", view);
+		return buffer;
+	}
+
 	if (prefixcmp(refname, "refs/"))
 		return NULL;
 	r = strchr(refname + 5, '/');
diff --git a/refs.h b/refs.h
index 390e812..addcc2d 100644
--- a/refs.h
+++ b/refs.h
@@ -18,6 +18,7 @@ struct ref_lock {
  * and returns the value
  */
 typedef int each_ref_fn(const char *refname, const unsigned char *sha1, int flags, void *cb_data);
+extern int one_ref(each_ref_fn, void *, const char *);
 extern int head_ref(each_ref_fn, void *);
 extern int for_each_ref(each_ref_fn, void *);
 extern int for_each_ref_in(const char *, each_ref_fn, void *);
diff --git a/upload-pack.c b/upload-pack.c
index bc72471..b3bf20f 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -668,13 +668,18 @@ static int mark_our_ref(const char *refname, const unsigned char *sha1, int flag
 
 static void upload_pack(void)
 {
+	const char *head = "HEAD";
+
+	if (view)
+		head = view_to_ref(head, view);
+
 	if (advertise_refs || !stateless_rpc) {
 		reset_timeout();
-		head_ref(send_ref, NULL);
+		one_ref(send_ref, NULL, head);
 		for_each_ref(send_ref, NULL);
 		packet_flush(1);
 	} else {
-		head_ref(mark_our_ref, NULL);
+		one_ref(mark_our_ref, NULL, head);
 		for_each_ref(mark_our_ref, NULL);
 	}
 	if (advertise_refs)
-- 
1.6.6.243.gff6d2

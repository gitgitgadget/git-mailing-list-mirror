From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [tig: PATCH] Decorate replaced commits
Date: Mon, 29 Aug 2011 11:08:30 +0200
Message-ID: <f2c76a759d9e39c32b90033cb64f677b7a2602d8.1314608820.git.git@drmicha.warpmail.net>
Cc: Jonas Fonseca <fonseca@diku.dk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 29 11:08:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qxxpf-0001IC-Bw
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 11:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768Ab1H2JIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 05:08:34 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:39794 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750998Ab1H2JId (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Aug 2011 05:08:33 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id C982620BA4;
	Mon, 29 Aug 2011 05:08:32 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Mon, 29 Aug 2011 05:08:32 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id; s=
	smtpout; bh=MhRwWA5zfyU2k6WbiMSIV7fc4ZA=; b=EhP+aHAHb5E9Vv7SdwYs
	5rmZ2lr/1U75A6jE5dsnTCk+CSmeiiIOjKKaANGKPVVOGWDm/zhFB6d8BREPs1WP
	9ZWoFurUj3FMsqntkfAIOdA73bZVYxY+XQea+l8ZFWynbM/SW/cbGwm0FIf9t4SL
	tFI8G9AnD9CTUSyBZISfpLo=
X-Sasl-enc: /uR7p9M0gWcQw+dZ1kH35f0mY9Zl0Gyu2d7/KPpr5920 1314608912
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 41868A001C1;
	Mon, 29 Aug 2011 05:08:32 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.rc0.328.g9d6c7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180306>

Decorate replaced commits by "replaced" analogous to git.git's
5267d29 (log: decorate "replaced" on to replaced commits, 2011-08-19).
---
Should probably follow this up with graft decorations.

 tig.c |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/tig.c b/tig.c
index 92091ab..c9e8d1d 100644
--- a/tig.c
+++ b/tig.c
@@ -26,6 +26,7 @@ struct ref {
 	unsigned int tag:1;	/* Is it a tag? */
 	unsigned int ltag:1;	/* If so, is the tag local? */
 	unsigned int remote:1;	/* Is it a remote ref? */
+	unsigned int replace:1;	/* Is it a replace ref? */
 	unsigned int tracked:1;	/* Is it the remote for the current HEAD? */
 	char name[1];		/* Ref name; tag or head names are shortened. */
 };
@@ -444,6 +445,7 @@ LINE(MAIN_COMMIT,  "",			COLOR_DEFAULT,	COLOR_DEFAULT,	0), \
 LINE(MAIN_TAG,     "",			COLOR_MAGENTA,	COLOR_DEFAULT,	A_BOLD), \
 LINE(MAIN_LOCAL_TAG,"",			COLOR_MAGENTA,	COLOR_DEFAULT,	0), \
 LINE(MAIN_REMOTE,  "",			COLOR_YELLOW,	COLOR_DEFAULT,	0), \
+LINE(MAIN_REPLACE, "",			COLOR_CYAN,	COLOR_DEFAULT,	0), \
 LINE(MAIN_TRACKED, "",			COLOR_YELLOW,	COLOR_DEFAULT,	A_BOLD), \
 LINE(MAIN_REF,     "",			COLOR_CYAN,	COLOR_DEFAULT,	0), \
 LINE(MAIN_HEAD,    "",			COLOR_CYAN,	COLOR_DEFAULT,	A_BOLD), \
@@ -521,6 +523,8 @@ get_line_type_from_ref(const struct ref *ref)
 		return LINE_MAIN_TRACKED;
 	else if (ref->remote)
 		return LINE_MAIN_REMOTE;
+	else if (ref->replace)
+		return LINE_MAIN_REPLACE;
 
 	return LINE_MAIN_REF;
 }
@@ -6748,6 +6752,8 @@ compare_refs(const void *ref1_, const void *ref2_)
 		return ref2->head - ref1->head;
 	if (ref1->tracked != ref2->tracked)
 		return ref2->tracked - ref1->tracked;
+	if (ref1->replace != ref2->replace)
+		return ref2->replace - ref1->replace;
 	/* Order remotes last. */
 	if (ref1->remote != ref2->remote)
 		return ref1->remote - ref2->remote;
@@ -6809,6 +6815,7 @@ read_ref(char *id, size_t idlen, char *name, size_t namelen, void *data)
 	bool tag = FALSE;
 	bool ltag = FALSE;
 	bool remote = FALSE;
+	bool replace = FALSE;
 	bool tracked = FALSE;
 	bool head = FALSE;
 	int from = 0, to = refs_size - 1;
@@ -6831,6 +6838,13 @@ read_ref(char *id, size_t idlen, char *name, size_t namelen, void *data)
 		name	+= STRING_SIZE("refs/remotes/");
 		tracked  = !strcmp(opt_remote, name);
 
+	} else if (!prefixcmp(name, "refs/replace/")) {
+		replace = TRUE;
+		id	= name + strlen("refs/replace/");
+		idlen	= namelen - strlen("refs/replace/");
+		name	= "replaced";
+		namelen	= strlen(name);
+
 	} else if (!prefixcmp(name, "refs/heads/")) {
 		namelen -= STRING_SIZE("refs/heads/");
 		name	+= STRING_SIZE("refs/heads/");
@@ -6849,7 +6863,7 @@ read_ref(char *id, size_t idlen, char *name, size_t namelen, void *data)
 	 * previous SHA1 with the resolved commit id; relies on the fact
 	 * git-ls-remote lists the commit id of an annotated tag right
 	 * before the commit id it points to. */
-	while (from <= to) {
+	while ((from <= to) && !replace) {
 		size_t pos = (to + from) / 2;
 		int cmp = strcmp(name, refs[pos]->name);
 
@@ -6881,6 +6895,7 @@ read_ref(char *id, size_t idlen, char *name, size_t namelen, void *data)
 	ref->tag = tag;
 	ref->ltag = ltag;
 	ref->remote = remote;
+	ref->replace = replace;
 	ref->tracked = tracked;
 	string_copy_rev(ref->id, id);
 
-- 
1.7.7.rc0.328.g9d6c7

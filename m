From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/7] sha1_name: factor out die_no_upstream()
Date: Thu, 23 May 2013 20:42:45 +0530
Message-ID: <1369321970-7759-3-git-send-email-artagnon@gmail.com>
References: <1369321970-7759-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 23 17:11:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfXB3-0003im-46
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 17:11:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759235Ab3EWPLP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 11:11:15 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:61940 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759063Ab3EWPLM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 11:11:12 -0400
Received: by mail-pb0-f44.google.com with SMTP id wz12so3011524pbc.31
        for <git@vger.kernel.org>; Thu, 23 May 2013 08:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=nWS0yzY6r4y6oExjV1zU4kprBPISKUnxMLsA54L+3Ms=;
        b=fSCL5l2qANkzcAT+8Cd48y/byioFdITHbyrpjpnfXwu+u364bh5LyO8B5Ntq/WRAcS
         D4OtUXR9fRLqUVfBRFwZku8C27izIkCmOE0H7bvMKKED3g4stTUjMEMBWXEOBvlc2nql
         WXXaGB81N7NS772luWRKsuhSx8eAUZCFgbyoCXX8iIYsk7QeztQu7AZctuFNQ6vQDvZA
         +naD0pMyDqhObL4T/qB4fuxV0qVVOv/ii6yYIIu6OQfBO+OkgHzuYh+Cl4VfMuYeBlIM
         SXbYWr0NMz0VtWbGF0hQrNUL3Q+SEkpvjYKfy476CGoZZPOoLCO0cmLxHuJd7mSBs+CG
         hU3Q==
X-Received: by 10.68.178.161 with SMTP id cz1mr13174067pbc.27.1369321871765;
        Thu, 23 May 2013 08:11:11 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id vb8sm12099173pbc.11.2013.05.23.08.11.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 23 May 2013 08:11:11 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.17.gd95ec6c.dirty
In-Reply-To: <1369321970-7759-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225256>

Currently interpret_branch_name() tries to parse various things, and
finally falls back to parsing <branch>@{u[pstream]}.  It dies if the
input string contained an "@{u[pstream]}" but an upstream could not be
found.  The logic can be generalized to check for any branch property
after branch_get().  In preparation for introducing more special @{...}
forms, factor out die_no_upstream().

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 sha1_name.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 766e4e9..7aabd94 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -998,6 +998,24 @@ int get_sha1_mb(const char *name, unsigned char *sha1)
 	return st;
 }
 
+static void die_no_upstream(struct branch *upstream, char *name) {
+	/*
+	 * Upstream can be NULL only if cp refers to HEAD and HEAD
+	 * points to something different than a branch.
+	 */
+	if (!upstream)
+		die(_("HEAD does not point to a branch"));
+	if (!upstream->merge || !upstream->merge[0]->dst) {
+		if (!ref_exists(upstream->refname))
+			die(_("No such branch: '%s'"), name);
+		if (!upstream->merge)
+			die(_("No upstream configured for branch '%s'"),
+				upstream->name);
+		die(_("Upstream branch '%s' not stored as a remote-tracking branch"),
+			upstream->merge[0]->src);
+	}
+}
+
 /*
  * This reads short-hand syntax that not only evaluates to a commit
  * object name, but also can act as if the end user spelled the name
@@ -1022,7 +1040,7 @@ int get_sha1_mb(const char *name, unsigned char *sha1)
 int interpret_branch_name(const char *name, struct strbuf *buf)
 {
 	char *cp;
-	struct branch *upstream;
+	struct branch *branch;
 	int namelen = strlen(name);
 	int len = interpret_nth_prior_checkout(name, buf);
 	int tmp_len;
@@ -1059,24 +1077,10 @@ int interpret_branch_name(const char *name, struct strbuf *buf)
 		return -1;
 	len = cp + tmp_len - name;
 	cp = xstrndup(name, cp - name);
-	upstream = branch_get(*cp ? cp : NULL);
-	/*
-	 * Upstream can be NULL only if cp refers to HEAD and HEAD
-	 * points to something different than a branch.
-	 */
-	if (!upstream)
-		die(_("HEAD does not point to a branch"));
-	if (!upstream->merge || !upstream->merge[0]->dst) {
-		if (!ref_exists(upstream->refname))
-			die(_("No such branch: '%s'"), cp);
-		if (!upstream->merge)
-			die(_("No upstream configured for branch '%s'"),
-				upstream->name);
-		die(_("Upstream branch '%s' not stored as a remote-tracking branch"),
-			upstream->merge[0]->src);
-	}
+	branch = branch_get(*cp ? cp : NULL);
+	die_no_upstream(branch, cp);
 	free(cp);
-	cp = shorten_unambiguous_ref(upstream->merge[0]->dst, 0);
+	cp = shorten_unambiguous_ref(branch->merge[0]->dst, 0);
 	strbuf_reset(buf);
 	strbuf_addstr(buf, cp);
 	free(cp);
-- 
1.8.3.rc3.17.gd95ec6c.dirty

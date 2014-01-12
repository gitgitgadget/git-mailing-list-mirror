From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/3] interpret_branch_name: factor out upstream handling
Date: Sun, 12 Jan 2014 22:41:05 +0530
Message-ID: <1389546666-17438-3-git-send-email-artagnon@gmail.com>
References: <1389546666-17438-1-git-send-email-artagnon@gmail.com>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 12 18:11:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2OZ3-0007wh-UW
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jan 2014 18:11:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbaALRKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jan 2014 12:10:55 -0500
Received: from mail-pd0-f179.google.com ([209.85.192.179]:38597 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318AbaALRKu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jan 2014 12:10:50 -0500
Received: by mail-pd0-f179.google.com with SMTP id y13so4001882pdi.38
        for <git@vger.kernel.org>; Sun, 12 Jan 2014 09:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nneYwBS7047zuQW/bHqejbb+8cjuN7RTc3ZPnpgLBd8=;
        b=hAH/nkeHLCll6WcsDytvkR7fcZw61ToTKA2Co7b+oHH8W16z8GCcgFAc59QnUn1VD1
         1TWWOLJWhEpPQHRWFeQguaB6xfhs37ThICSTnvbZxwb7EAmzfTp6LIP8E3YGz/l+Xgbk
         e9VnZuzpad+pmdpvRojIm/tJi+wbcHO75k96qpstcahjFu5k7GIgEJW28CEpAEPnDy9X
         ubfHTsnoKa1W9hRk7B7PlPkCkQXCf8j3WY8AQMuP6lF7PqyXXhhGp6/xBiNcteLSVovu
         onwaUdmtkNIBYJpbHx9uxPpQQFTvO/M7HUrIaLo8WDk3bfizNDHdYNHjTtlvNDA6Cjn0
         eprg==
X-Received: by 10.66.139.8 with SMTP id qu8mr2478647pab.157.1389546650009;
        Sun, 12 Jan 2014 09:10:50 -0800 (PST)
Received: from localhost.localdomain ([122.164.134.24])
        by mx.google.com with ESMTPSA id gn5sm14690070pbc.29.2014.01.12.09.10.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 12 Jan 2014 09:10:49 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2.313.g5abf4c0.dirty
In-Reply-To: <1389546666-17438-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240351>

From: Jeff King <peff@peff.net>

This function checks a few different @{}-constructs. The
early part checks for and dispatches us to helpers for each
construct, but the code for handling @{upstream} is inline.

Let's factor this out into its own function. This makes
interpret_branch_name more readable, and will make it much
simpler to add more constructs in future patches.

While we're at it, let's also break apart the refactored
code into a few helper functions. These will be useful when
we implement similar @{upstream}-like constructs.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 sha1_name.c | 83 ++++++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 52 insertions(+), 31 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index b1873d8..7ebb8ee 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1046,6 +1046,54 @@ static int reinterpret(const char *name, int namelen, int len, struct strbuf *bu
 	return ret - used + len;
 }
 
+static void set_shortened_ref(struct strbuf *buf, const char *ref)
+{
+	char *s = shorten_unambiguous_ref(ref, 0);
+	strbuf_reset(buf);
+	strbuf_addstr(buf, s);
+	free(s);
+}
+
+static const char *get_upstream_branch(const char *branch_buf, int len)
+{
+	char *branch = xstrndup(branch_buf, len);
+	struct branch *upstream = branch_get(*branch ? branch : NULL);
+
+	/*
+	 * Upstream can be NULL only if branch refers to HEAD and HEAD
+	 * points to something different than a branch.
+	 */
+	if (!upstream)
+		die(_("HEAD does not point to a branch"));
+	if (!upstream->merge || !upstream->merge[0]->dst) {
+		if (!ref_exists(upstream->refname))
+			die(_("No such branch: '%s'"), branch);
+		if (!upstream->merge) {
+			die(_("No upstream configured for branch '%s'"),
+				upstream->name);
+		}
+		die(
+			_("Upstream branch '%s' not stored as a remote-tracking branch"),
+			upstream->merge[0]->src);
+	}
+	free(branch);
+
+	return upstream->merge[0]->dst;
+}
+
+static int interpret_upstream_mark(const char *name, int namelen,
+				   int at, struct strbuf *buf)
+{
+	int len;
+
+	len = upstream_mark(name + at, namelen - at);
+	if (!len)
+		return -1;
+
+	set_shortened_ref(buf, get_upstream_branch(name, at));
+	return len + at;
+}
+
 /*
  * This reads short-hand syntax that not only evaluates to a commit
  * object name, but also can act as if the end user spelled the name
@@ -1070,9 +1118,7 @@ static int reinterpret(const char *name, int namelen, int len, struct strbuf *bu
 int interpret_branch_name(const char *name, int namelen, struct strbuf *buf)
 {
 	char *cp;
-	struct branch *upstream;
 	int len = interpret_nth_prior_checkout(name, buf);
-	int tmp_len;
 
 	if (!namelen)
 		namelen = strlen(name);
@@ -1094,36 +1140,11 @@ int interpret_branch_name(const char *name, int namelen, struct strbuf *buf)
 	if (len > 0)
 		return reinterpret(name, namelen, len, buf);
 
-	tmp_len = upstream_mark(cp, namelen - (cp - name));
-	if (!tmp_len)
-		return -1;
+	len = interpret_upstream_mark(name, namelen, cp - name, buf);
+	if (len > 0)
+		return len;
 
-	len = cp + tmp_len - name;
-	cp = xstrndup(name, cp - name);
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
-		if (!upstream->merge) {
-			die(_("No upstream configured for branch '%s'"),
-				upstream->name);
-		}
-		die(
-			_("Upstream branch '%s' not stored as a remote-tracking branch"),
-			upstream->merge[0]->src);
-	}
-	free(cp);
-	cp = shorten_unambiguous_ref(upstream->merge[0]->dst, 0);
-	strbuf_reset(buf);
-	strbuf_addstr(buf, cp);
-	free(cp);
-	return len;
+	return -1;
 }
 
 int strbuf_branchname(struct strbuf *sb, const char *name)
-- 
1.8.5.2.313.g5abf4c0.dirty

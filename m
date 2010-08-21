From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 2/4] rev-parse: suppress duplicate log limit exceeded message.
Date: Sat, 21 Aug 2010 11:43:40 +1000
Message-ID: <1282355022-17795-3-git-send-email-jon.seymour@gmail.com>
References: <AANLkTi=m7+h0nVg+EAmiir-rnrjoBwbpLtztcNNBVxiz@mail.gmail.com>
Cc: gitster@pobox.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 21 03:44:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Omd8f-0005HQ-Lx
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 03:44:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234Ab0HUBo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 21:44:28 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:50220 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152Ab0HUBoT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 21:44:19 -0400
Received: by mail-px0-f174.google.com with SMTP id 10so1444133pxi.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 18:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=9lFXkfZ3/gofYDVQds2uif0xeZByaSwG7mjC2qRGIL4=;
        b=huQlOyA8iOmlsUxxrU51NBqaEZvIRzyY3sa+4ozHzvTdImXHJJljlOeG7hd8iy0iVU
         IlzmvWYaDqz8CZv7uziHAWQi/gZ9+TfbZ5kHiwcZejZVQJHEbVcbFc32LTUdMF7jo5+D
         vC7L6uFOWPu93qHq2qmYuiseC5VhsXwEmQjwI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vd/PhdHJJRwLWUOMGbqNSaso+yY+MNS+eQACKG08YMKBVGWfpIZt5jMPluDU4hdJnD
         kWFWfEcnq/1Xu6H5Dx7udpfJUWvNZ9o2+H8rbpaDZMoblfhwF1I1f6UlOciPeBbfTBBG
         SCEZ3hXdzOnAw7kOb8ceOT/gXEw5pG6C1w008=
Received: by 10.114.12.14 with SMTP id 14mr2429019wal.23.1282355058974;
        Fri, 20 Aug 2010 18:44:18 -0700 (PDT)
Received: from localhost.localdomain (124-169-98-91.dyn.iinet.net.au [124.169.98.91])
        by mx.google.com with ESMTPS id d38sm6038069wam.8.2010.08.20.18.44.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 18:44:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.156.gf148c
In-Reply-To: <AANLkTi=m7+h0nVg+EAmiir-rnrjoBwbpLtztcNNBVxiz@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154090>

Modifies get_sha1_basic to accept a gently parameter to indicate
whether error should be used to report the log limit exceeded
condition.

Prior to this change, git rev-parse master@{99999} reported:

  error: Log for 'master' only has 166 entries.
  master@{99999}
  error: Log for 'master' only has 166 entries.
  fatal: ambiguous argument 'master@{99999}': unknown revision or path not in the working tree.
  Use '--' to separate paths from revisions

With this change, git rev-parse master@{99999} reports:

  master@{99999}
  error: Log for 'master' only has 166 entries.
  fatal: ambiguous argument 'master@{99999}': unknown revision or path not in the working tree.
  Use '--' to separate paths from revisions

Note: git rev-parse --verify master@{99999} now does not report
the error message although it does still exit with a non-zero
status code. This is fixed by the next commit.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 sha1_name.c |   31 ++++++++++++++++---------------
 1 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 82ad0f9..6e706eb 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -338,9 +338,9 @@ static inline int upstream_mark(const char *string, int len)
 	return 0;
 }
 
-static int get_sha1_1(const char *name, int len, unsigned char *sha1);
+static int get_sha1_1(const char *name, int len, unsigned char *sha1, int gently);
 
-static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
+static int get_sha1_basic(const char *str, int len, unsigned char *sha1, int gently)
 {
 	static const char *warn_msg = "warning: refname '%.*s' is ambiguous.";
 	char *real_ref = NULL;
@@ -375,7 +375,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 		ret = interpret_branch_name(str+at, &buf);
 		if (ret > 0) {
 			/* substitute this branch name and restart */
-			return get_sha1_1(buf.buf, buf.len, sha1);
+			return get_sha1_1(buf.buf, buf.len, sha1, 1);
 		} else if (ret == 0) {
 			return -1;
 		}
@@ -430,10 +430,11 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 					"back to %s.", len, str,
 					show_date(co_time, co_tz, DATE_RFC2822));
 			else {
-				error("Log for '%.*s' only has %d entries.",
-					len,
-					str,
-					co_cnt);
+				if (!gently)
+					error("Log for '%.*s' only has %d entries.",
+						len,
+						str,
+						co_cnt);
 				free(real_ref);
 				return -1;
 			}
@@ -448,7 +449,7 @@ static int get_parent(const char *name, int len,
 		      unsigned char *result, int idx)
 {
 	unsigned char sha1[20];
-	int ret = get_sha1_1(name, len, sha1);
+	int ret = get_sha1_1(name, len, sha1, 1);
 	struct commit *commit;
 	struct commit_list *p;
 
@@ -481,7 +482,7 @@ static int get_nth_ancestor(const char *name, int len,
 	struct commit *commit;
 	int ret;
 
-	ret = get_sha1_1(name, len, sha1);
+	ret = get_sha1_1(name, len, sha1, 1);
 	if (ret)
 		return ret;
 	commit = lookup_commit_reference(sha1);
@@ -504,7 +505,7 @@ struct object *peel_to_type(const char *name, int namelen,
 		namelen = strlen(name);
 	if (!o) {
 		unsigned char sha1[20];
-		if (get_sha1_1(name, namelen, sha1))
+		if (get_sha1_1(name, namelen, sha1, 1))
 			return NULL;
 		o = parse_object(sha1);
 	}
@@ -566,7 +567,7 @@ static int peel_onion(const char *name, int len, unsigned char *sha1)
 	else
 		return -1;
 
-	if (get_sha1_1(name, sp - name - 2, outer))
+	if (get_sha1_1(name, sp - name - 2, outer, 1))
 		return -1;
 
 	o = parse_object(outer);
@@ -614,7 +615,7 @@ static int get_describe_name(const char *name, int len, unsigned char *sha1)
 	return -1;
 }
 
-static int get_sha1_1(const char *name, int len, unsigned char *sha1)
+static int get_sha1_1(const char *name, int len, unsigned char *sha1, int gently)
 {
 	int ret, has_suffix;
 	const char *cp;
@@ -650,7 +651,7 @@ static int get_sha1_1(const char *name, int len, unsigned char *sha1)
 	if (!ret)
 		return 0;
 
-	ret = get_sha1_basic(name, len, sha1);
+	ret = get_sha1_basic(name, len, sha1, gently);
 	if (!ret)
 		return 0;
 
@@ -1059,7 +1060,7 @@ int get_sha1_with_context_1(const char *name, unsigned char *sha1,
 
 	memset(oc, 0, sizeof(*oc));
 	oc->mode = S_IFINVALID;
-	ret = get_sha1_1(name, namelen, sha1);
+	ret = get_sha1_1(name, namelen, sha1, gently);
 	if (!ret)
 		return ret;
 	/* sha1:path --> object name of path in ent sha1
@@ -1122,7 +1123,7 @@ int get_sha1_with_context_1(const char *name, unsigned char *sha1,
 			strncpy(object_name, name, cp-name);
 			object_name[cp-name] = '\0';
 		}
-		if (!get_sha1_1(name, cp-name, tree_sha1)) {
+		if (!get_sha1_1(name, cp-name, tree_sha1, 1)) {
 			const char *filename = cp+1;
 			ret = get_tree_entry(tree_sha1, filename, sha1, &oc->mode);
 			if (!gently) {
-- 
1.7.2.1.156.gf148c

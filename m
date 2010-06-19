From: Nazri Ramliy <ayiehere@gmail.com>
Subject: [PATCH 2/4] log-tree.c: Use struct name_decoration's type for classifying decoration
Date: Sat, 19 Jun 2010 09:37:34 +0800
Message-ID: <1276911456-18466-2-git-send-email-ayiehere@gmail.com>
References: <7vtyp11k9x.fsf@alter.siamese.dyndns.org>
Cc: Nazri Ramliy <ayiehere@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 19 03:38:03 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPn0U-0005qs-GN
	for gcvg-git-2@lo.gmane.org; Sat, 19 Jun 2010 03:38:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754556Ab0FSBh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jun 2010 21:37:56 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49688 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754540Ab0FSBhz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jun 2010 21:37:55 -0400
Received: by pwi1 with SMTP id 1so660303pwi.19
        for <git@vger.kernel.org>; Fri, 18 Jun 2010 18:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=MDe1pLyHVg2YePedDLx/P5nV02M1wAylgO3BssvU9Ug=;
        b=v53hBVSoQtPO+uaLewNcYjO2rmEHAvg9XnPUeNJxUSIdJbvdwtGK8mHoYs2dW9qP1n
         +HqUte3Yv00xZL72qS/HaTPn4lpGRYcB87arl2um1Xi93gyheL0UhA+6rNKGdd4lFalx
         tLzfywON1LriD62sYirrAfxfMkURnEsBLE31w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=r/03/Eb9QIGLMb3R3CUPMiER8KWcgpvsa/7QAe6Tlr4nPDHcypoSdf+mTAQORFkKQA
         wAGH6g2DUMoRuLtc4Ak1Yn/ms7tdaDxmyBoScbH3jS8dGF8N235YvICpw2WTNhD2eMk8
         y5s6dHvmTkp/AJtRGSRmsYX2nj/JVVRNur1iU=
Received: by 10.141.53.8 with SMTP id f8mr1527927rvk.5.1276911474820;
        Fri, 18 Jun 2010 18:37:54 -0700 (PDT)
Received: from localhost.localdomain ([115.132.104.117])
        by mx.google.com with ESMTPS id s9sm3587164rvl.5.2010.06.18.18.37.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Jun 2010 18:37:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.245.g7c42e.dirty
In-Reply-To: <7vtyp11k9x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149370>

The "tag: " prefix is no longer prepended to the name of the decoration.
It is now printed conditionally by show_decorations if the decoration
type is DECORATION_REF_TAG.

Signed-off-by: Nazri Ramliy <ayiehere@gmail.com>
---
 log-tree.c |   40 ++++++++++++++++++++++++++++++++--------
 1 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index d3ae969..2d804ee 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -10,29 +10,50 @@
 
 struct decoration name_decoration = { "object names" };
 
-static void add_name_decoration(const char *prefix, const char *name, struct object *obj)
+enum decoration_type {
+	DECORATION_NONE = 0,
+	DECORATION_REF_LOCAL,
+	DECORATION_REF_REMOTE,
+	DECORATION_REF_TAG,
+	DECORATION_REF_STASH,
+	DECORATION_REF_HEAD,
+};
+
+static void add_name_decoration(enum decoration_type type, const char *name, struct object *obj)
 {
-	int plen = strlen(prefix);
 	int nlen = strlen(name);
-	struct name_decoration *res = xmalloc(sizeof(struct name_decoration) + plen + nlen);
-	memcpy(res->name, prefix, plen);
-	memcpy(res->name + plen, name, nlen + 1);
+	struct name_decoration *res = xmalloc(sizeof(struct name_decoration) + nlen);
+	memcpy(res->name, name, nlen + 1);
+	res->type = type;
 	res->next = add_decoration(&name_decoration, obj, res);
 }
 
 static int add_ref_decoration(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
 {
 	struct object *obj = parse_object(sha1);
+	enum decoration_type type = DECORATION_NONE;
 	if (!obj)
 		return 0;
+
+	if (!prefixcmp(refname, "refs/heads"))
+		type = DECORATION_REF_LOCAL;
+	else if (!prefixcmp(refname, "refs/remotes"))
+		type = DECORATION_REF_REMOTE;
+	else if (!prefixcmp(refname, "refs/tags"))
+		type = DECORATION_REF_TAG;
+	else if (!prefixcmp(refname, "refs/stash"))
+		type = DECORATION_REF_STASH;
+	else if (!prefixcmp(refname, "HEAD"))
+		type = DECORATION_REF_HEAD;
+
 	if (!cb_data || *(int *)cb_data == DECORATE_SHORT_REFS)
 		refname = prettify_refname(refname);
-	add_name_decoration("", refname, obj);
+	add_name_decoration(type, refname, obj);
 	while (obj->type == OBJ_TAG) {
 		obj = ((struct tag *)obj)->tagged;
 		if (!obj)
 			break;
-		add_name_decoration("tag: ", refname, obj);
+		add_name_decoration(DECORATION_REF_TAG, refname, obj);
 	}
 	return 0;
 }
@@ -70,7 +91,10 @@ void show_decorations(struct rev_info *opt, struct commit *commit)
 		return;
 	prefix = " (";
 	while (decoration) {
-		printf("%s%s", prefix, decoration->name);
+		printf("%s", prefix);
+		if (decoration->type == DECORATION_REF_TAG)
+			printf("tag: ");
+		printf("%s", decoration->name);
 		prefix = ", ";
 		decoration = decoration->next;
 	}
-- 
1.7.1.245.g7c42e.dirty

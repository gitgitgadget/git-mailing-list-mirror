From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [WIP PATCH 07/22] Add range clone functions
Date: Sat, 24 Jul 2010 23:13:39 +0800
Message-ID: <1279984434-28933-8-git-send-email-struggleyb.nku@gmail.com>
References: <1279984434-28933-1-git-send-email-struggleyb.nku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 24 17:15:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcgRV-0001lN-2Z
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 17:15:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755901Ab0GXPOz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 11:14:55 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:40733 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754992Ab0GXPOy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 11:14:54 -0400
Received: by pzk26 with SMTP id 26so499993pzk.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 08:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=XbTpTme5h1ZiW2iNZHm5rRyttAPOAclV++VxbTUr/TU=;
        b=sIgXf8sLklbjyBHVgRwEfW53WHDNX4CcIA/DhEg6sq1uGLyws3e3G6KnvT6hOTsFww
         rQ4CWV89EpfYBp3DSuBd3okIEHRfP8wZn1mbDLdXVLEvwghKpLCA1lVkdYJgTuIhklW6
         hiNf/e+SbOLBJviASmQr3H7O0GR3oYRmR6ZSg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=qbkLi56FCmKKhQ0+48XpM9XVH742fxi4OpNbHsXpdWa/kO8KXqfZXYb9yXMe+y4+9E
         fbt2YzBPH+g0oWBSns3GlFYwG++BxFBHmmK1nmO3ENPVWQA38xChWuFK0E2CBS95MqSU
         II3yyPQLnq7pfWURQyTbNR53aSxSvxRLE7Aig=
Received: by 10.142.158.13 with SMTP id g13mr5882555wfe.232.1279984491031;
        Sat, 24 Jul 2010 08:14:51 -0700 (PDT)
Received: from localhost.localdomain ([58.68.143.121])
        by mx.google.com with ESMTPS id w8sm1705169wfd.19.2010.07.24.08.14.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 08:14:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc3.80.g6f8ea9.dirty
In-Reply-To: <1279984434-28933-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151639>

Since diff_line_range can form a single list through its
'next' pointer, we provide two kind of clone.

diff_line_range_clone:
	used to clone only the element node and set the
	element's 'next' pointer to NULL.
diff_line_range_clone_deeply:
	used to clone the whole list of ranges.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 line.c |   39 +++++++++++++++++++++++++++++++++++++++
 line.h |    4 ++++
 2 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/line.c b/line.c
index 4314cee..c9ff934 100644
--- a/line.c
+++ b/line.c
@@ -382,6 +382,45 @@ void diff_line_range_append(struct diff_line_range *r, const char *arg)
 	r->ranges[r->nr - 1].arg = arg;
 }
 
+struct diff_line_range *diff_line_range_clone(struct diff_line_range *r)
+{
+	struct diff_line_range *ret = xmalloc(sizeof(*ret));
+	int i = 0;
+
+	DIFF_LINE_RANGE_INIT(ret);
+	ret->ranges = xcalloc(r->nr, sizeof(struct range));
+	memcpy(ret->ranges, r->ranges, sizeof(struct range) * r->nr);
+
+	ret->alloc = ret->nr = r->nr;
+
+	for (; i < ret->nr; i++)
+		PRINT_PAIR_INIT(&ret->ranges[i].pair);
+
+	ret->spec = r->spec;
+	assert(ret->spec);
+	ret->spec->count++;
+
+	return ret;
+}
+
+struct diff_line_range *diff_line_range_clone_deeply(struct diff_line_range *r)
+{
+	struct diff_line_range *ret = NULL;
+	struct diff_line_range *tmp = NULL, *prev = NULL;
+
+	assert(r);
+	ret = tmp = prev = diff_line_range_clone(r);
+	r = r->next;
+	while (r) {
+		tmp = diff_line_range_clone(r);
+		prev->next = tmp;
+		prev = tmp;
+		r = r->next;
+	}
+
+	return ret;
+}
+
 struct diff_line_range *diff_line_range_merge(struct diff_line_range *out,
 		struct diff_line_range *other)
 {
diff --git a/line.h b/line.h
index 8b30ada..7563536 100644
--- a/line.h
+++ b/line.h
@@ -119,6 +119,10 @@ extern struct diff_line_range *diff_line_range_merge(
 		struct diff_line_range *out,
 		struct diff_line_range *other);
 
+extern struct diff_line_range *diff_line_range_clone(struct diff_line_range *r);
+
+extern struct diff_line_range *diff_line_range_clone_deeply(struct diff_line_range *r);
+
 extern void setup_line(struct rev_info *rev, struct diff_line_range *r);
 
 extern void add_line_range(struct rev_info *revs, struct commit *commit,
-- 
1.7.0.2.273.gc2413.dirty

From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH v4 07/18] Add range clone functions
Date: Fri,  6 Aug 2010 00:11:46 +0800
Message-ID: <1281024717-7855-8-git-send-email-struggleyb.nku@gmail.com>
References: <1281024717-7855-1-git-send-email-struggleyb.nku@gmail.com>
Cc: trast@student.ethz.ch, Jens.Lehmann@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 05 18:14:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh35G-0001XF-0n
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 18:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759836Ab0HEQNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 12:13:07 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57614 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758946Ab0HEQND (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 12:13:03 -0400
Received: by mail-pz0-f46.google.com with SMTP id 26so2533376pzk.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 09:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=hhqm9Bd8cTn1lr2ACz8cXj4BLpcEoml6hnM+Tfx+BAo=;
        b=MkPp+KG8Hee346gJ8qS6504b3DEog0/rJCm8mmx+gdEv400BnLs5Q0IqmFLirfh7PG
         YyzLl7orRsTmhjkvHa1uz+opdk97FvXZRJqtAU3y4FAYqcQYa03LphCYyJbffqCN0bFp
         62zAx1y3j4hO4vks1UqXB3ZPWEJXRuWhDzXV0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=wtmGnCyC7ayecPmyks/tLRmSdAt0xSro/y6zOwF7ZchSN02lVgFG9ALLNwz4mHmkDE
         hggHcHxVBFBcKraPqmiA68GgXzjRKraqryhQkT2fRHR9qq1j1oxPjRmtsOhnY9hfTfs/
         AXHQOh1+6OMRpz+14dVPhZ4viuvExRfgRusQU=
Received: by 10.143.28.18 with SMTP id f18mr9266721wfj.99.1281024778394;
        Thu, 05 Aug 2010 09:12:58 -0700 (PDT)
Received: from localhost.localdomain ([222.35.120.192])
        by mx.google.com with ESMTPS id w8sm343653wfd.19.2010.08.05.09.12.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 09:12:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.20.g388bbb
In-Reply-To: <1281024717-7855-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152672>

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
1.7.2.20.g388bbb

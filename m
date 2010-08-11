From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH V5 07/17] Add range clone functions
Date: Wed, 11 Aug 2010 23:03:32 +0800
Message-ID: <1281539022-31616-8-git-send-email-struggleyb.nku@gmail.com>
References: <1281539022-31616-1-git-send-email-struggleyb.nku@gmail.com>
Cc: Jens.Lehmann@web.de, trast@student.ethz.ch, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 11 17:05:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjCrv-0005GU-Ro
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 17:05:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753598Ab0HKPFB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 11:05:01 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:46611 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753559Ab0HKPFA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 11:05:00 -0400
Received: by mail-px0-f174.google.com with SMTP id 10so75091pxi.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 08:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=iuDnxKw/ld2QVx2u0FzFRREXtw3bDzUXPY4+LykTN24=;
        b=dj9gFvsyISJ57/62/UszQl9x7H8C4eU10+ZmyUNz3UUTQQnkfxHgqA9AO+ipy75J1C
         Y9DsIcgSpOAVt5kA5J4IqkgyGKflSkBSwyHUhCuidyKBpFNefrNCNzMOgWFvQQaJoyik
         9UrRDgHekJzrGdEq3WdSP7LFi2wkNMqGm8pww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=SlB3euuYD8zxmRXoUKEfaPq+vHabhcdGpdTW5k/PRPpEKc8DOvGPDX14P8za4buMMG
         K784IOFXyCYSDFdfEsP6o1bt/gTNNh7D0vUsVWS/SZiHrLPTEe/TXsfK/o+BJGGz9eO2
         Luw6jAiV27yuvMgs5d/TTP4i30Ffrnt6yudok=
Received: by 10.114.25.5 with SMTP id 5mr22121540way.78.1281539099814;
        Wed, 11 Aug 2010 08:04:59 -0700 (PDT)
Received: from localhost.localdomain ([116.226.85.245])
        by mx.google.com with ESMTPS id c10sm356199wam.1.2010.08.11.08.04.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 08:04:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.19.g79e5d
In-Reply-To: <1281539022-31616-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153245>

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
index 6c5f69e..1b77172 100644
--- a/line.c
+++ b/line.c
@@ -384,6 +384,45 @@ void diff_line_range_append(struct diff_line_range *r, const char *arg)
 	r->ranges[r->nr - 1].arg = arg;
 }
 
+struct diff_line_range *diff_line_range_clone(struct diff_line_range *r)
+{
+	struct diff_line_range *ret = xmalloc(sizeof(*ret));
+	int i = 0;
+
+	DIFF_LINE_RANGE_INIT(ret);
+	ret->ranges = xcalloc(r->nr, sizeof(struct line_range));
+	memcpy(ret->ranges, r->ranges, sizeof(struct line_range) * r->nr);
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
index 5bde828..e03eff0 100644
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
1.7.2.19.g79e5d

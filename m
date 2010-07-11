From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH v3 07/13] add range clone functions
Date: Sun, 11 Jul 2010 14:18:55 +0800
Message-ID: <1278829141-11900-7-git-send-email-struggleyb.nku@gmail.com>
References: <1278829141-11900-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 11 08:21:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXpvA-00025x-D5
	for gcvg-git-2@lo.gmane.org; Sun, 11 Jul 2010 08:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366Ab0GKGVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jul 2010 02:21:36 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:45345 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532Ab0GKGVc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jul 2010 02:21:32 -0400
Received: by pxi14 with SMTP id 14so1400905pxi.19
        for <git@vger.kernel.org>; Sat, 10 Jul 2010 23:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=lPUH6lNGFLpCC7ps6rorFxuzuAdOh93AFQj5LgTPmQo=;
        b=TDsjfIQx+iwAzNWICmtzGJADwEeZIXjWNwTHLVL7REEhToaOIMjLONRH6bUlBbFVo5
         4a06Ba4SBcrVMDgzXqiIZyqP0s+TYchfv1m2qImyK7C3Qgm+qduEy48U0ov7r28Pr2nU
         HzKmLMK3zpqRRxss/1P9V1j/lCXdqtvQZvUdY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=gYO42NxJ+FAzwjjPkwy86ILbvxBsPZmz5e/sK0W1j1Gg2QGXkO5WnfGLZiRglEwPo9
         hXlDacYomOHtea7eBF2J0PpHi8f4WinlGgsbnDgJ8SxaH6WkSuI8a/J9Pr6+CvJU0LBK
         qAT/MOVpnEl47/cGMAsQkj1E2ESh8Z8fkFleA=
Received: by 10.142.171.7 with SMTP id t7mr14396120wfe.211.1278829291801;
        Sat, 10 Jul 2010 23:21:31 -0700 (PDT)
Received: from localhost.localdomain ([222.35.175.242])
        by mx.google.com with ESMTPS id c15sm2927911rvi.11.2010.07.10.23.21.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Jul 2010 23:21:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc2.18.g2bc49
In-Reply-To: <1278829141-11900-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150750>

Both single range clone and deeply clone are supported.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 line.c |   39 +++++++++++++++++++++++++++++++++++++++
 line.h |    4 ++++
 2 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/line.c b/line.c
index a6bcbdf..ba96d7d 100644
--- a/line.c
+++ b/line.c
@@ -378,6 +378,45 @@ void diff_line_range_append(struct diff_line_range *r, const char *arg)
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
index 0eb03bd..885e985 100644
--- a/line.h
+++ b/line.h
@@ -112,6 +112,10 @@ extern void diff_line_range_append(struct diff_line_range *r, const char *arg);
 
 extern void diff_line_range_clear(struct diff_line_range *r);
 
+extern struct diff_line_range *diff_line_range_clone(struct diff_line_range *r);
+
+extern struct diff_line_range *diff_line_range_clone_deeply(struct diff_line_range *r);
+
 extern struct diff_line_range *diff_line_range_merge(struct diff_line_range *out,
 	struct diff_line_range *other);
 
-- 
1.7.0.2.273.gc2413.dirty

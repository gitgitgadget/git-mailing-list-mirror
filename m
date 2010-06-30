From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH v2 07/13] add range clone functions
Date: Wed, 30 Jun 2010 23:25:20 +0800
Message-ID: <1277911526-12105-7-git-send-email-struggleyb.nku@gmail.com>
References: <1277911526-12105-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 30 17:30:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTzEb-0000eO-1Y
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 17:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089Ab0F3P3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jun 2010 11:29:52 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:40393 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932074Ab0F3P3u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jun 2010 11:29:50 -0400
Received: by pvc7 with SMTP id 7so411990pvc.19
        for <git@vger.kernel.org>; Wed, 30 Jun 2010 08:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=hy7yS6scB/WdNDK2Fu4JnPiSbwd29t2PNwCC+JAPCtg=;
        b=eZXKZwK/iqGjWDkc6XntFwQM72VWSVoKYxYru4Qywve8bjVrOUXw26mcrGSaFubxc8
         XGPxqAFwIDpApHwurEE0RWAiE1ldEeksRZ3LBPyNLzvA5rm+hRnoNuyv6C44pszsaJju
         yIX3PIEp913goz+ZtihBPr/Wz3UQnxasNqKoU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AKuFWb1+Hm0+p7CaCLAcyYgDiyR7cxt77dVxoO7ZFTkDq/9riLwe/TvRG5qw7G3h0S
         o2FYoIGaCgw3eEcGNHaO4cHtXOCwNzAs9JYZEKxFqxAQ4mL4TEEAbbIQSxRbjiqsUbCr
         /SRtFnM9Yx5ehSLCj5vl73tNPiq8F58N92w10=
Received: by 10.114.30.6 with SMTP id d6mr10000152wad.135.1277911789564;
        Wed, 30 Jun 2010 08:29:49 -0700 (PDT)
Received: from localhost.localdomain ([117.15.79.69])
        by mx.google.com with ESMTPS id d38sm75050850wam.20.2010.06.30.08.29.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 30 Jun 2010 08:29:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc0.27.g1c5fd
In-Reply-To: <1277911526-12105-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149970>

Both single range clone and deeply clone are supported.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 line.c |   35 +++++++++++++++++++++++++++++++++++
 line.h |    4 ++++
 2 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/line.c b/line.c
index 0855d29..904d0c2 100644
--- a/line.c
+++ b/line.c
@@ -377,6 +377,41 @@ void diff_line_range_append(struct diff_line_range *r, const char *arg)
 	r->ranges[r->nr - 1].arg = arg;
 }
 
+struct diff_line_range *diff_line_range_clone(struct diff_line_range *r)
+{
+	struct diff_line_range *ret = xmalloc(sizeof(*ret));
+
+	DIFF_LINE_RANGE_INIT(ret);
+	ret->ranges = xcalloc(r->nr, sizeof(struct range));
+	memcpy(ret->ranges, r->ranges, sizeof(struct range) * r->nr);
+
+	ret->alloc = ret->nr = r->nr;
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

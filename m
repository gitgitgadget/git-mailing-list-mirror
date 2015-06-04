From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 1/2] extract setting of wt_status.commitable flag out of wt_status_print_updated()
Date: Fri,  5 Jun 2015 01:56:30 +0800
Message-ID: <1433440591-30917-2-git-send-email-rctay89@gmail.com>
References: <1433440591-30917-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 04 19:57:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0ZO9-0000Wv-5G
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 19:57:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbbFDR5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 13:57:04 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:34076 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932156AbbFDR5A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2015 13:57:00 -0400
Received: by pdbki1 with SMTP id ki1so35580763pdb.1
        for <git@vger.kernel.org>; Thu, 04 Jun 2015 10:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N2FBAygG6hA1T9b2nPpc+AbzWNBM6YuWkIFchxtBBVk=;
        b=U20LA5lJE/pPM2lJZJ5/+Bt7Ufkf+7wsiWoIV9O/NlQrmJWq1sIWbwLfIoLLVOncer
         Kx3nP1hRyTwHkp0cBiqf1ivnIRulmklvOHtClNy3dy80w5Y4N5vQWO8VwyRc7mKFE5Kd
         iVXYB9N2yuGLo6pfqZo/iTlPDDpy/OvKoaViesUjQp7wsfiXg9cXaXWqExGpO5lbn6De
         n4xASuw8BpG497YHM7dgbGJlW2/staCvcOke/XKxekFCc4h6/H3rPYNkce5gaA7DOEqU
         LKk69irK5NYh1tTZx7HOEyMRRyTikoZYl6hrQHCOzJ/UoUG25mJlJTycWUsMHQBMDQcM
         UNHg==
X-Received: by 10.70.92.164 with SMTP id cn4mr8236974pdb.106.1433440619933;
        Thu, 04 Jun 2015 10:56:59 -0700 (PDT)
Received: from localhost.localdomain ([202.156.104.43])
        by mx.google.com with ESMTPSA id j9sm4453566pdm.53.2015.06.04.10.56.58
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 04 Jun 2015 10:56:59 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.581.g64f2558
In-Reply-To: <1433440591-30917-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270791>

It may not be obvious from its name that wt_status_print_updated() that
it also sets wt_status.commitable, which affects commit functionality.
Extract this out into a separate function for improved clarity, though
at the expense of executing another loop.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

Changed since v1
- move call to _mark_committable() to match original control-flow

  Originally, our placement of the call perhaps befitted aesthetics /
  logical grouping. But perhaps it is a better idea to match the original
  control flow to dispel any suspicion that this patch changed behaviour
  unintendedly.

 wt-status.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/wt-status.c b/wt-status.c
index c56c78f..87550ae 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -626,6 +626,21 @@ void wt_status_collect(struct wt_status *s)
 	wt_status_collect_untracked(s);
 }
 
+void wt_status_mark_commitable(struct wt_status *s)
+{
+	int i;
+
+	for (i = 0; i < s->change.nr; i++) {
+		struct wt_status_change_data *d;
+		d = s->change.items[i].util;
+		if (!d->index_status ||
+		    d->index_status == DIFF_STATUS_UNMERGED)
+			continue;
+		s->commitable = 1;
+		break;
+	}
+}
+
 static void wt_status_print_unmerged(struct wt_status *s)
 {
 	int shown_header = 0;
@@ -664,7 +679,6 @@ static void wt_status_print_updated(struct wt_status *s)
 			continue;
 		if (!shown_header) {
 			wt_status_print_cached_header(s);
-			s->commitable = 1;
 			shown_header = 1;
 		}
 		wt_status_print_change_data(s, WT_STATUS_UPDATED, it);
@@ -1360,6 +1374,7 @@ void wt_status_print(struct wt_status *s)
 
 	wt_status_print_updated(s);
 	wt_status_print_unmerged(s);
+	wt_status_mark_commitable(s);
 	wt_status_print_changed(s);
 	if (s->submodule_summary &&
 	    (!s->ignore_submodule_arg ||
-- 
2.0.0.581.g64f2558

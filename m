From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 2/3] extract setting of wt_status.commitable flag out of wt_status_print_updated()
Date: Sat, 22 Feb 2014 03:09:21 +0800
Message-ID: <1393009762-31133-3-git-send-email-rctay89@gmail.com>
References: <1393009762-31133-1-git-send-email-rctay89@gmail.com>
 <1393009762-31133-2-git-send-email-rctay89@gmail.com>
Cc: Tay Ray Chuan <rctay89@gmail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 21 20:10:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGvU4-0000a9-4u
	for gcvg-git-2@plane.gmane.org; Fri, 21 Feb 2014 20:10:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754582AbaBUTJ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Feb 2014 14:09:56 -0500
Received: from mail-pd0-f176.google.com ([209.85.192.176]:36350 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754457AbaBUTJz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Feb 2014 14:09:55 -0500
Received: by mail-pd0-f176.google.com with SMTP id w10so3665244pde.35
        for <git@vger.kernel.org>; Fri, 21 Feb 2014 11:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XHEVJs7ZJKSrp/fA2MSStVFhSp/t6lgP4yxmHWCcGOo=;
        b=QPzaGhGRduDNBlT/NSAu3slu2EDZlbFmLX+ax6yrqqbrSPGFmGnS6OEqI4wbAjbQwJ
         Zl32FIC0PjGQAAYFFdqkOBCJ+JGVzXBPf9392GnmwMJRGGbzkbYFPkaYWdfrnSxakDO1
         AsPXN7wsNdddFZSU8pNqnvVq0GDXSUqD7WDnU8L+EwVrxrm5B0MBJh9NFhRbUZU3agGB
         hC6sQ0O2D9/B4Ug5BB+IPawEArFbdG3kvVCuurPERvbmcnElHKuL1/vbJgGHmKhEx5yt
         S+fE1o1FqWcmYbeUPlch9PGxG3PxLmujQtzif63cF1u6GLD31F5g3MlPnLwvqW+yMKby
         4TrA==
X-Received: by 10.66.119.172 with SMTP id kv12mr10823273pab.34.1393009795496;
        Fri, 21 Feb 2014 11:09:55 -0800 (PST)
Received: from chiliad.localdomain (cm245.gamma242.maxonline.com.sg. [202.156.242.245])
        by mx.google.com with ESMTPSA id vf7sm23887999pbc.5.2014.02.21.11.09.49
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Feb 2014 11:09:54 -0800 (PST)
X-Mailer: git-send-email 1.9.0.291.g027825b
In-Reply-To: <1393009762-31133-2-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242489>

At first glance, wt_status_print_updated() appears to be doing a bunch
of printing (as its name implies), and it may not be immediately obvious
that it also sets the vital wt_status.commitable flag. Extract this out
into a separate function; it is hoped that the improved clarity to
future Git contributors would outweigh the performance penalty.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 wt-status.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/wt-status.c b/wt-status.c
index a452407..9b0189c 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -589,6 +589,21 @@ void wt_status_collect(struct wt_status *s)
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
@@ -627,7 +642,6 @@ static void wt_status_print_updated(struct wt_status *s)
 			continue;
 		if (!shown_header) {
 			wt_status_print_cached_header(s);
-			s->commitable = 1;
 			shown_header = 1;
 		}
 		wt_status_print_change_data(s, WT_STATUS_UPDATED, it);
@@ -1309,6 +1323,7 @@ void wt_status_print(struct wt_status *s)
 		status_printf_ln(s, color(WT_STATUS_HEADER, s), "");
 	}
 
+	wt_status_mark_commitable(s);
 	wt_status_print_updated(s);
 	wt_status_print_unmerged(s);
 	wt_status_print_changed(s);
-- 
1.9.0.291.g027825b

From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 3/8] wt-status: move wt_status_colors[] into wt_status
 structure
Date: Mon, 10 Aug 2009 01:54:20 -0700
Message-ID: <1249894465-11018-4-git-send-email-gitster@pobox.com>
References: <1249894465-11018-1-git-send-email-gitster@pobox.com>
 <1249894465-11018-2-git-send-email-gitster@pobox.com>
 <1249894465-11018-3-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 10:54:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaQeU-0007fg-N1
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 10:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752884AbZHJIyg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 04:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752849AbZHJIyf
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 04:54:35 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38528 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834AbZHJIyd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 04:54:33 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7C7A424662
	for <git@vger.kernel.org>; Mon, 10 Aug 2009 04:54:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CA68524661 for
 <git@vger.kernel.org>; Mon, 10 Aug 2009 04:54:33 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.173.g72959
In-Reply-To: <1249894465-11018-3-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 6D15BDB0-858B-11DE-97E2-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125417>

The benefit of this one alone is somewhat iffy, but for completeness this
moves the wt_status_colors[] color palette to the wt_status structure to
complete what the previous commit started.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 wt-status.c |    9 +++++----
 wt-status.h |    2 ++
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index c84a18a..a2a7257 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1,6 +1,5 @@
 #include "cache.h"
 #include "wt-status.h"
-#include "color.h"
 #include "object.h"
 #include "dir.h"
 #include "commit.h"
@@ -11,7 +10,7 @@
 #include "run-command.h"
 #include "remote.h"
 
-static char wt_status_colors[][COLOR_MAXLEN] = {
+static char default_wt_status_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_NORMAL, /* WT_STATUS_HEADER */
 	GIT_COLOR_GREEN,  /* WT_STATUS_UPDATED */
 	GIT_COLOR_RED,    /* WT_STATUS_CHANGED */
@@ -40,7 +39,7 @@ static int parse_status_slot(const char *var, int offset)
 
 static const char *color(int slot, struct wt_status *s)
 {
-	return s->wt_status_use_color > 0 ? wt_status_colors[slot] : "";
+	return s->wt_status_use_color > 0 ? s->wt_status_colors[slot] : "";
 }
 
 void wt_status_prepare(struct wt_status *s)
@@ -49,6 +48,8 @@ void wt_status_prepare(struct wt_status *s)
 	const char *head;
 
 	memset(s, 0, sizeof(*s));
+	memcpy(s->wt_status_colors, default_wt_status_colors,
+	       sizeof(default_wt_status_colors));
 	s->show_untracked_files = SHOW_NORMAL_UNTRACKED_FILES;
 	s->wt_status_use_color = -1;
 	s->wt_status_relative_paths = 1;
@@ -613,7 +614,7 @@ int git_status_config(const char *k, const char *v, void *cb)
 		int slot = parse_status_slot(k, 13);
 		if (!v)
 			return config_error_nonbool(k);
-		color_parse(v, k, wt_status_colors[slot]);
+		color_parse(v, k, s->wt_status_colors[slot]);
 		return 0;
 	}
 	if (!strcmp(k, "status.relativepaths")) {
diff --git a/wt-status.h b/wt-status.h
index 3d7fe30..f22c3c1 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -3,6 +3,7 @@
 
 #include <stdio.h>
 #include "string-list.h"
+#include "color.h"
 
 enum color_wt_status {
 	WT_STATUS_HEADER,
@@ -37,6 +38,7 @@ struct wt_status {
 	int wt_status_relative_paths;
 	int wt_status_submodule_summary;
 	enum untracked_status_type show_untracked_files;
+	char wt_status_colors[6][COLOR_MAXLEN];
 
 	/* These are computed during processing of the individual sections */
 	int commitable;
-- 
1.6.4.173.g72959

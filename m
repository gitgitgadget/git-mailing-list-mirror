From: Neil Horman <nhorman@tuxdriver.com>
Subject: [PATCH 1/5] argv-array: Add argv_array_pop function [v2]
Date: Thu,  5 Apr 2012 15:39:01 -0400
Message-ID: <1333654745-7898-2-git-send-email-nhorman@tuxdriver.com>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1333654745-7898-1-git-send-email-nhorman@tuxdriver.com>
Cc: Neil Horman <nhorman@tuxdriver.com>, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 05 21:40:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFsXk-0007vM-Rt
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 21:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755969Ab2DETkX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 15:40:23 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:57266 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753854Ab2DETja (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 15:39:30 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SFsWk-0005Vn-7w; Thu, 05 Apr 2012 15:39:28 -0400
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <1333654745-7898-1-git-send-email-nhorman@tuxdriver.com>
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194796>

As a convienience, it would be nice if we could pop entries off the argv_array
structs so that if they had multiple uses in a function, we wouldn't have to
clear them and repopulate common entries.  This patch adds the argv_array_pop
function to do just that.  Common entries can be added to an argv_array first,
then useage specific ones can be added on the end and removed later on.

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
CC: Jeff King <peff@peff.net>
CC: Phil Hord <phil.hord@gmail.com>
CC: Junio C Hamano <gitster@pobox.com>
---
 argv-array.c |   12 ++++++++++++
 argv-array.h |    1 +
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/argv-array.c b/argv-array.c
index a4e0420..ce24a48 100644
--- a/argv-array.c
+++ b/argv-array.c
@@ -39,6 +39,18 @@ void argv_array_pushf(struct argv_array *array, const char *fmt, ...)
 	argv_array_push_nodup(array, strbuf_detach(&v, NULL));
 }
 
+int argv_array_pop(struct argv_array *array, unsigned int num)
+{
+	if (num > array->argc)
+		return -1;
+
+	for(num--; num>0; num--) {
+		free((char **)array->argv[num]);
+		array->argv[num] = NULL;
+	}
+	return 0;
+}
+
 void argv_array_clear(struct argv_array *array)
 {
 	if (array->argv != empty_argv) {
diff --git a/argv-array.h b/argv-array.h
index 74dd2b1..8233243 100644
--- a/argv-array.h
+++ b/argv-array.h
@@ -15,6 +15,7 @@ void argv_array_init(struct argv_array *);
 void argv_array_push(struct argv_array *, const char *);
 __attribute__((format (printf,2,3)))
 void argv_array_pushf(struct argv_array *, const char *fmt, ...);
+int argv_array_pop(struct argv_array *, unsigned int num);
 void argv_array_clear(struct argv_array *);
 
 #endif /* ARGV_ARRAY_H */
-- 
1.7.7.6

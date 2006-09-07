From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] diff: support custom callbacks for output
Date: Thu, 7 Sep 2006 02:35:42 -0400
Message-ID: <20060907063542.GA17083@coredump.intra.peff.net>
References: <<20060907062917.GA16969@coredump.intra.peff.net>>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 08:35:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLDUJ-0005Ne-3p
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 08:35:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWIGGfo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 02:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWIGGfo
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 02:35:44 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:17285 "HELO
	peff.net") by vger.kernel.org with SMTP id S1750782AbWIGGfo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Sep 2006 02:35:44 -0400
Received: (qmail 25110 invoked from network); 7 Sep 2006 02:35:08 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 7 Sep 2006 02:35:08 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu,  7 Sep 2006 02:35:42 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060907062917.GA16969@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26600>

Users can request the DIFF_FORMAT_CALLBACK output format to get a callback
consisting of the whole diff_queue_struct.
---
 diff.c |    3 +++
 diff.h |    8 ++++++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index 9dcbda3..a3ebc62 100644
--- a/diff.c
+++ b/diff.c
@@ -2587,6 +2587,9 @@ void diff_flush(struct diff_options *opt
 		}
 	}
 
+	if (output_format & DIFF_FORMAT_CALLBACK)
+		options->format_callback(q, options, options->format_callback_data);
+
 	for (i = 0; i < q->nr; i++)
 		diff_free_filepair(q->queue[i]);
 free_queue:
diff --git a/diff.h b/diff.h
index b007240..b60a02e 100644
--- a/diff.h
+++ b/diff.h
@@ -8,6 +8,7 @@ #include "tree-walk.h"
 
 struct rev_info;
 struct diff_options;
+struct diff_queue_struct;
 
 typedef void (*change_fn_t)(struct diff_options *options,
 		 unsigned old_mode, unsigned new_mode,
@@ -20,6 +21,9 @@ typedef void (*add_remove_fn_t)(struct d
 		    const unsigned char *sha1,
 		    const char *base, const char *path);
 
+typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
+		struct diff_options *options, void *data);
+
 #define DIFF_FORMAT_RAW		0x0001
 #define DIFF_FORMAT_DIFFSTAT	0x0002
 #define DIFF_FORMAT_SUMMARY	0x0004
@@ -35,6 +39,8 @@ #define DIFF_FORMAT_CHECKDIFF	0x0040
  */
 #define DIFF_FORMAT_NO_OUTPUT	0x0080
 
+#define DIFF_FORMAT_CALLBACK	0x0100
+
 struct diff_options {
 	const char *filter;
 	const char *orderfile;
@@ -68,6 +74,8 @@ struct diff_options {
 	int *pathlens;
 	change_fn_t change;
 	add_remove_fn_t add_remove;
+	diff_format_fn_t format_callback;
+	void *format_callback_data;
 };
 
 enum color_diff {
-- 
1.4.2.ge490e-dirty

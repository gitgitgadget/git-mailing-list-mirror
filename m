From: Kris Shannon <kris@shannon.id.au>
Subject: [RFC PATCH] diff: use $COLUMNS if available for default stat_width
Date: Fri, 26 Aug 2011 15:47:27 +1000
Message-ID: <1314337647-29270-1-git-send-email-kris@shannon.id.au>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 26 07:48:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwpHL-0003hg-2T
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 07:48:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714Ab1HZFrk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 01:47:40 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:65419 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124Ab1HZFrj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2011 01:47:39 -0400
Received: by gya6 with SMTP id 6so2469592gya.19
        for <git@vger.kernel.org>; Thu, 25 Aug 2011 22:47:38 -0700 (PDT)
Received: by 10.100.35.1 with SMTP id i1mr610808ani.139.1314337658530;
        Thu, 25 Aug 2011 22:47:38 -0700 (PDT)
Received: from localhost.localdomain (thoth.sisgroup.com.au [122.252.0.61])
        by mx.google.com with ESMTPS id w2sm518241anm.21.2011.08.25.22.47.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 25 Aug 2011 22:47:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180151>

If the COLUMNS environment variable is set use it's value
as the default stat_width.

Also set the stat_name_width default to 2/3 of the full width.

This does change the default from 50 to 53 when using the
original 80 column stat_width fallback.

Signed-off-by: Kris Shannon <kris@shannon.id.au>
---
 diff.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

This has bugged me for a long time.  I finally decided to see how hard it would
be to fix.

I thought about getting the COLUMNS value once but I'm not sure it's worth the
extra code.

diff --git a/diff.c b/diff.c
index 9038f19..6954134 100644
--- a/diff.c
+++ b/diff.c
@@ -1329,8 +1329,16 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		line_prefix = msg->buf;
 	}
 
-	width = options->stat_width ? options->stat_width : 80;
-	name_width = options->stat_name_width ? options->stat_name_width : 50;
+	width = options->stat_width;
+	if (!width) {
+		char *cols = getenv("COLUMNS");
+
+		if (cols)
+			width = strtoul(cols, NULL, 10);
+		if (!width)
+			width = 80;
+	}
+	name_width = options->stat_name_width ? options->stat_name_width : ((width * 2 + 1) / 3);
 
 	/* Sanity: give at least 5 columns to the graph,
 	 * but leave at least 10 columns for the name.
-- 
1.7.6.1

From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 21/56] merge-recursive: Avoid working directory changes during recursive case
Date: Thu, 11 Aug 2011 23:19:54 -0600
Message-ID: <1313126429-17368-22-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:21:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkBR-0004nj-BN
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753231Ab1HLFVV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:21:21 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:39648 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752994Ab1HLFVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:21:16 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so835125iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=8gaewRL3y/OnI0eR6p2f2us4ApBp5r8cB1GXvEq9wLc=;
        b=T+M0OQqdtp4S9Lkzq3O3OZkeLMsvBdweCfrxTptb1Gwko2NX7EDW73gZ5lBIXFzKQo
         qdSJvKPgA0dKojLBLnHnBrw0DQdT4PfFwpwf5C8PcprSSyAKHkY3Rdpl86k11/Rl+Pz7
         hsG0cTWf0CgXChVohOesRKXlBO8L3OHDMvdm0=
Received: by 10.42.18.132 with SMTP id x4mr498865ica.443.1313126476562;
        Thu, 11 Aug 2011 22:21:16 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.21.14
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:21:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179175>

make_room_for_directories_of_df_conflicts() is about making sure necessary
working directory changes can succeed.  When o->call_depth > 0 (i.e. the
recursive case), we do not want to make any working directory changes so
this function should be skipped.

Note that make_room_for_directories_of_df_conflicts() is broken as has
been pointed out by Junio; it should NOT be unlinking files.  What it
should do is keep track of files that could be unlinked if a directory
later needs to be written in their place.  However, that work also is only
relevant in the non-recursive case, so this change is helpful either way.

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
No changes since v1.

 merge-recursive.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index b5a8f17..8863b02 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -355,6 +355,13 @@ static void make_room_for_directories_of_df_conflicts(struct merge_options *o,
 	int last_len = 0;
 	int i;
 
+	/*
+	 * If we're merging merge-bases, we don't want to bother with
+	 * any working directory changes.
+	 */
+	if (o->call_depth)
+		return;
+
 	for (i = 0; i < entries->nr; i++) {
 		const char *path = entries->items[i].string;
 		int len = strlen(path);
-- 
1.7.6.100.gac5c1

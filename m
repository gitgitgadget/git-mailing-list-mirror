From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 20/48] merge-recursive: Avoid working directory changes during recursive case
Date: Wed,  8 Jun 2011 01:30:50 -0600
Message-ID: <1307518278-23814-21-git-send-email-newren@gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Cc: jgfouca@sandia.gov, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:30:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUDDM-0005pC-0H
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 09:30:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754931Ab1FHH3m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 03:29:42 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49887 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754565Ab1FHH3g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 03:29:36 -0400
Received: by mail-pv0-f174.google.com with SMTP id 12so118724pvg.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=ujzKNWZdx7vGaJ91rdWYNdi8+CmeXE7EBQVsULximjk=;
        b=XmvePQ7CUkGgNWJih59EBBtCvhvfWlLOoAoUMwxQIf/OK+tglnM/89Ai9f6gcTYyVI
         fnbSKbjbeAT5L6fa0/CBebYkTa4kQvc162aD71s6iAB7sgQsKS2AqiRjH65CG40rSwpx
         Fw4KIo8qPs1Oow47PRL5WcindBY+koEm1Xbik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=EHG8LiQmiRttYP4rzVJrHcbxYVsIcUdcM9R109zW5J9RsR5YDkSogOkCIRPc0Dwb9G
         xWS6lNGPBwYxSxdGNWjUtwM9EiA3j9oz2M4ESXutN3XWtIku4A1GRx1fbUIlfojWma1n
         jLLJqr1ZoiDXgpFUOIJ4WlAtE2XEvrKUkF7II=
Received: by 10.68.37.65 with SMTP id w1mr564794pbj.341.1307518175828;
        Wed, 08 Jun 2011 00:29:35 -0700 (PDT)
Received: from localhost.localdomain ([216.222.84.34])
        by mx.google.com with ESMTPS id k4sm296286pbl.59.2011.06.08.00.29.33
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 00:29:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.62.g2d69f
In-Reply-To: <1307518278-23814-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175310>

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
---
 merge-recursive.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 45675b6..7da6aa0 100644
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
1.7.6.rc0.62.g2d69f

From: Faiz Kothari <faiz.off93@gmail.com>
Subject: [PATCH] GSoC2014 Microproject rewrite finish_bulk_checkin()
Date: Fri, 28 Feb 2014 00:32:20 +0530
Message-ID: <1393527740-16765-1-git-send-email-faiz.off93@gmail.com>
Cc: Faiz Kothari <faiz.off93@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 27 20:03:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ6Ep-0005YO-9U
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 20:03:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753638AbaB0TDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 14:03:10 -0500
Received: from mail-pd0-f169.google.com ([209.85.192.169]:37858 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753375AbaB0TDG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 14:03:06 -0500
Received: by mail-pd0-f169.google.com with SMTP id fp1so1748591pdb.0
        for <git@vger.kernel.org>; Thu, 27 Feb 2014 11:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=4Pn4XqScHnFEkkz/uVrWUCzMI4TQIWlT5+KQmlXs3mw=;
        b=UjxmHlW59zEJx30Kb3wb/ylhPSyXVPNmhLys9jo6dCV/ptFWdp0/gkAtMMdkgfpM39
         eMAVv7u2frzFs85uLTwO8ghidQivgZrcpShZGGNw6Wyeef1Vu0fNvyauziLaZQ6eE63K
         cn3/EO/gepdA6b1n2tS48URd0OI7zq1TvlwSQWev3x6arU2pLt9KxkvqWM6GwKzgV7qC
         eJB3WiR8nwuKnHFrWCqo4mJM50a51ezzn/udszs+bFTXr5rIkOSlDULZr8bgkkdbcZGu
         lMLTNujQJRGi5QtOtznw2TyQcwWJ/sFXivvpYLWKzO98OSrccu9Tia2gLLhf0jPlCzx1
         j4RQ==
X-Received: by 10.68.129.201 with SMTP id ny9mr15093765pbb.70.1393527786009;
        Thu, 27 Feb 2014 11:03:06 -0800 (PST)
Received: from dj-pc.bits-goa.ac.in ([115.248.130.148])
        by mx.google.com with ESMTPSA id sy2sm15982783pbc.28.2014.02.27.11.03.02
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 27 Feb 2014 11:03:04 -0800 (PST)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242837>

Signed-off-by: Faiz Kothari <faiz.off93@gmail.com>
---
 bulk-checkin.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 118c625..feeff9f 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -23,7 +23,7 @@ static struct bulk_checkin_state {
 static void finish_bulk_checkin(struct bulk_checkin_state *state)
 {
 	unsigned char sha1[20];
-	char packname[PATH_MAX];
+	struct strbuf packname;
 	int i;
 
 	if (!state->f)
@@ -42,9 +42,11 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
 					 state->offset);
 		close(fd);
 	}
-
-	sprintf(packname, "%s/pack/pack-", get_object_directory());
-	finish_tmp_packfile(packname, state->pack_tmp_name,
+	
+	packname.len = packname.alloc = 64 + strlen(get_object_directory());
+	packname.buf = (char *)malloc(packname.len * sizeof(char));
+	sprintf(packname.buf, "%s/pack/pack-", get_object_directory());
+	finish_tmp_packfile(packname.buf, state->pack_tmp_name,
 			    state->written, state->nr_written,
 			    &state->pack_idx_opts, sha1);
 	for (i = 0; i < state->nr_written; i++)
@@ -53,7 +55,7 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
 clear_exit:
 	free(state->written);
 	memset(state, 0, sizeof(*state));
-
+	free(packname.buf);
 	/* Make objects we just wrote available to ourselves */
 	reprepare_packed_git();
 }
-- 
1.7.9.5

> Rewrite bulk-checkin.c:finish_bulk_checkin() to use a strbuf for handling packname, and explain why this is useful.
> Also check if the first argument of pack-write.c:finish_tmp_packfile() can be made const.

Adding 64 to strlen(get_object_directory()) to accomodate sha1_to_hex(sha1) and itself.
Using the APIs for strbuf is giving me test failures(12/15) during t1050-large.sh 
So, I used the malloc() and free() instead.
Instead of having packname on stack and cause stackoverflow because of MAX_PATH ~ 4KB, have it on heap.
Can have first parameter to pack-write.c:finish_tmp_packfile() as const because packname is not required to be modified.

I apologise for my two earlier patches not being in proper format. I have finally got it working properly. Will make sure,
it does not happen again.

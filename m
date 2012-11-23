From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH] diff: Fixes shortstat number of files
Date: Fri, 23 Nov 2012 22:27:12 +0100
Message-ID: <1353706032-15223-1-git-send-email-apelisse@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Nov 23 22:27:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tc0mp-0002Mp-2W
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 22:27:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756406Ab2KWV1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 16:27:32 -0500
Received: from mail-wi0-f170.google.com ([209.85.212.170]:35781 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756322Ab2KWV1b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 16:27:31 -0500
Received: by mail-wi0-f170.google.com with SMTP id hq7so1659402wib.1
        for <git@vger.kernel.org>; Fri, 23 Nov 2012 13:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=ljh82yfLj11aZUnx421yusNej7QOndBWrYtwMpyC3JA=;
        b=LTE+WM9xhJY8YT/nf37w7oco2NjMD90jO/70g93vPxDCmjVJ+u1JHIZiEM2A6h5q5l
         dOGRiKWGgjHVWQTrVj3UNM1KOedbZJrgyYDXf/n/oBOickXqWuvWitqrsKQ5CUevPBLR
         O4/EDN4rWpHxqtMtlYs2DkFw2MuZAh1DQ9MEflhFiO7EODRSjVZ75G/xe8TxwsnPMenW
         TJFjbYIHN0OODifNTa5IK3Xfx2MV/fgMpDJz7huJHR0RumIF0xQCD9/u9lxypy5gEXl4
         FYKXTpFBFjwi6kkPNxxsYA3lJXQbOsSvBLzWx1dVTyl6Oj/NXkyRUYFAGbG+z0Jw9yjx
         gAkQ==
Received: by 10.180.101.68 with SMTP id fe4mr9808021wib.7.1353706050484;
        Fri, 23 Nov 2012 13:27:30 -0800 (PST)
Received: from localhost.localdomain (vau06-3-82-247-80-218.fbx.proxad.net. [82.247.80.218])
        by mx.google.com with ESMTPS id en20sm11429707wid.4.2012.11.23.13.27.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Nov 2012 13:27:29 -0800 (PST)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210273>

There is a discrepancy between the last line of `git diff --stat`
and `git diff --shortstat` in case of a merge.
The unmerged files are actually counted twice, thus doubling the
value of "file changed".

In fact, while stat decrements number of files when seeing an unmerged
file, shortstat doesn't.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 diff.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index e89a201..5c6bcbd 100644
--- a/diff.c
+++ b/diff.c
@@ -1704,9 +1704,8 @@ static void show_shortstats(struct diffstat_t *data, struct diff_options *option
 		int added = data->files[i]->added;
 		int deleted= data->files[i]->deleted;
 
-		if (data->files[i]->is_unmerged)
-			continue;
-		if (!data->files[i]->is_renamed && (added + deleted == 0)) {
+		if (data->files[i]->is_unmerged ||
+		  (!data->files[i]->is_renamed && (added + deleted == 0))) {
 			total_files--;
 		} else if (!data->files[i]->is_binary) { /* don't count bytes */
 			adds += added;
-- 
1.7.9.5

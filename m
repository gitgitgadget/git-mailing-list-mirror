From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH] diff: Fixes shortstat number of files
Date: Wed, 21 Nov 2012 22:26:49 +0100
Message-ID: <1353533210-29684-1-git-send-email-apelisse@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 22 20:03:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tbc3Q-0004A7-QP
	for gcvg-git-2@plane.gmane.org; Thu, 22 Nov 2012 20:03:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756227Ab2KVTCs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2012 14:02:48 -0500
Received: from mail-wi0-f178.google.com ([209.85.212.178]:47130 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753908Ab2KVTCr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 14:02:47 -0500
Received: by mail-wi0-f178.google.com with SMTP id hm6so1021168wib.1
        for <git@vger.kernel.org>; Thu, 22 Nov 2012 11:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=ljh82yfLj11aZUnx421yusNej7QOndBWrYtwMpyC3JA=;
        b=o09pu+RxZb6FFgz6xuXRQvfOJb5EeE9XDz5FBP0NSt8Eq5MJB5r8U244uRdKNe/StL
         pvQ4iK75HIX3zPLbwyYJE0HEwtvJZhiOUjAWou4vYH/vduGtF34l8vf3g9/luo1Yr+8X
         OQmot+6+SbLRK7lUoMMZwbi/H/nXc76vD2rnqoUNHfSz3zcjFKzs2gdb/7CxMTag2egh
         tUPaYl5SO1VJPGasaftSGwWBI4S8YdKBWeMiyiNZkyypWYdRzyPnMYFTvPg0QMT8M5Fo
         WnA9nVJynfSlkPikOKtuNE8RMjlIQb21iGH0hv8Zn0nFLMwXcLYV0Tzmh3nbL8LJPeQV
         XVlQ==
Received: by 10.180.87.40 with SMTP id u8mr1379029wiz.3.1353533224510;
        Wed, 21 Nov 2012 13:27:04 -0800 (PST)
Received: from localhost.localdomain (vau06-3-82-247-80-218.fbx.proxad.net. [82.247.80.218])
        by mx.google.com with ESMTPS id d9sm1474296wiw.0.2012.11.21.13.27.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 21 Nov 2012 13:27:03 -0800 (PST)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210188>

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

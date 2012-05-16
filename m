From: Bobby Powers <bobbypowers@gmail.com>
Subject: [PATCH] diff --no-index: reset temporary buffer lengths on directory iteration
Date: Wed, 16 May 2012 00:14:53 -0400
Message-ID: <1337141693-3515-1-git-send-email-bobbypowers@gmail.com>
Cc: Bobby Powers <bobbypowers@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 16 06:15:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUVeO-0000xy-8W
	for gcvg-git-2@plane.gmane.org; Wed, 16 May 2012 06:15:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842Ab2EPEPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 May 2012 00:15:05 -0400
Received: from mail-qa0-f49.google.com ([209.85.216.49]:38090 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828Ab2EPEPD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2012 00:15:03 -0400
Received: by qabj40 with SMTP id j40so458748qab.1
        for <git@vger.kernel.org>; Tue, 15 May 2012 21:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=CWHqbEajpmAE8jw9CIQX0Mm+zn7roKrGMC5LIXwFbHU=;
        b=0pzXOMIdVG9X7/DMWl+qaTzW1dwymCfMAyH73A9M/znlxS/exY+oRhX0Dfl4YSXStN
         RHQEOpeHjWkxgsrKlyg3WV+00N0GDh0lW2VSNZ29b+2EB6jiYrpxLubOGmejEHAZ69Tn
         IhWrYURlEpSgYBRa+zObFXW00vnB8CmH7RzM9BZkmeWTTZTPzzUjBaVBpHyj6YGk8FGB
         zzLj1C9TtSxy2RSyJftlM5BQQy5x83j7w1F4qamCEf52ew3QSQnVGdPcQXdU29TJAMLa
         99iUIGQQyDMsvTsB+alWOPMyNXwINQkdE7uYwRtYon6q01BV9aRwB3LpvkzjRMB70Sh9
         Sy7Q==
Received: by 10.229.137.135 with SMTP id w7mr724824qct.62.1337141702798;
        Tue, 15 May 2012 21:15:02 -0700 (PDT)
Received: from fina.localdomain (pool-96-255-98-6.washdc.fios.verizon.net. [96.255.98.6])
        by mx.google.com with ESMTPS id ch15sm6790940qab.18.2012.05.15.21.15.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 May 2012 21:15:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197863>

Commit 875b91b3 introduced a regression when using diff --no-index
with directories.  When iterating through a directory, the switch to
strbuf from heap-allocated char arrays caused paths to form like
'dir/file1', 'dir/file1file2', rather than 'dir/file1', 'dir/file2' as
expected.  By resetting the length on each iteration (but not
buf.alloc), we avoid this.

Signed-off-by: Bobby Powers <bobbypowers@gmail.com>
---
 diff-no-index.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index b44473e..bec3ea4 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -67,7 +67,7 @@ static int queue_diff(struct diff_options *o,
 		struct strbuf buffer2 = STRBUF_INIT;
 		struct string_list p1 = STRING_LIST_INIT_DUP;
 		struct string_list p2 = STRING_LIST_INIT_DUP;
-		int i1, i2, ret = 0;
+		int len1 = 0, len2 = 0, i1, i2, ret = 0;
 
 		if (name1 && read_directory(name1, &p1))
 			return -1;
@@ -80,18 +80,23 @@ static int queue_diff(struct diff_options *o,
 			strbuf_addstr(&buffer1, name1);
 			if (buffer1.len && buffer1.buf[buffer1.len - 1] != '/')
 				strbuf_addch(&buffer1, '/');
+			len1 = buffer1.len;
 		}
 
 		if (name2) {
 			strbuf_addstr(&buffer2, name2);
 			if (buffer2.len && buffer2.buf[buffer2.len - 1] != '/')
 				strbuf_addch(&buffer2, '/');
+			len2 = buffer2.len;
 		}
 
 		for (i1 = i2 = 0; !ret && (i1 < p1.nr || i2 < p2.nr); ) {
 			const char *n1, *n2;
 			int comp;
 
+			buffer1.len = len1;
+			buffer2.len = len2;
+
 			if (i1 == p1.nr)
 				comp = 1;
 			else if (i2 == p2.nr)
-- 
1.7.10.2

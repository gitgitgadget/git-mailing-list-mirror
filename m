From: Bobby Powers <bobbypowers@gmail.com>
Subject: [PATCH] diff --no-index: don't leak buffers in queue_diff
Date: Wed, 16 May 2012 10:50:31 -0400
Message-ID: <1337179831-23461-1-git-send-email-bobbypowers@gmail.com>
Cc: Bobby Powers <bobbypowers@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 16 16:50:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUfZ0-0003II-5z
	for gcvg-git-2@plane.gmane.org; Wed, 16 May 2012 16:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753764Ab2EPOuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 May 2012 10:50:46 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:56326 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753747Ab2EPOuo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2012 10:50:44 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so1080004dad.19
        for <git@vger.kernel.org>; Wed, 16 May 2012 07:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=gOT1Y3I6pzRAWRkD9oFJjdo5CjIHaL/DKvXW0hqGUZE=;
        b=J0h4zD/uFme16qLs+ELhiQpNXwoLWglac/EuymktEjxmMS4ZIIEHT3j2sbSWWCgQvE
         GBPRwQlCKgUaVPA5Fw2l+o8qFXCEvbyYmG/AHIw7RW4XBJUimLXBrKXuLJLwGOtfGs4d
         BwC7IDUxH0+Ump0TEEtbWIoQU+fimY2MNEQhh+cip8KlK1AOaoh1agOe4eX5kB+TJ9fQ
         2t4zj9RabHKbQJFguvuTG5fXqAukmMP2z2n9tcCvfnKBbse080xTiD1OGNpJwgiODm6P
         lDDkqr06NThP/2TX0nup9eHrwpxKmKb66mlxeMIikwy77Qj3B6mKyvA5uSiibM+p5rdT
         bi2w==
Received: by 10.68.132.102 with SMTP id ot6mr40031pbb.6.1337179843686;
        Wed, 16 May 2012 07:50:43 -0700 (PDT)
Received: from eduardo.slate.com ([64.125.223.146])
        by mx.google.com with ESMTPS id qq2sm1342072pbc.27.2012.05.16.07.50.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 May 2012 07:50:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.521.g8ddb639
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197883>

queue_diff uses two strbufs, and at the end of the function
strbuf_reset was called.  This only reset the length of the buffer -
any allocated memory was leaked.  Using strbuf_release fixes this.

Signed-off-by: Bobby Powers <bobbypowers@gmail.com>
---
 diff-no-index.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 3080b66..f0b0010 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -123,8 +123,8 @@ static int queue_diff(struct diff_options *o,
 		}
 		string_list_clear(&p1, 0);
 		string_list_clear(&p2, 0);
-		strbuf_reset(&buffer1);
-		strbuf_reset(&buffer2);
+		strbuf_release(&buffer1);
+		strbuf_release(&buffer2);
 
 		return ret;
 	} else {
-- 
1.7.10.2.521.g8ddb639

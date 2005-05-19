From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] fix strbuf take #2
Date: Wed, 18 May 2005 23:34:03 -0700
Message-ID: <7vhdgzn2qs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 08:34:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYeb2-0005lO-UL
	for gcvg-git@gmane.org; Thu, 19 May 2005 08:33:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262404AbVESGeI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 02:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262399AbVESGeI
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 02:34:08 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:54729 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S262404AbVESGeF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2005 02:34:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050519063403.DKCP8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 19 May 2005 02:34:03 -0400
To: torvalds@osdl.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I just remembered why I placed that bogus "sb->len ==0 implies
sb->eof" condition there.  We need at least something like this
to catch the normal EOF (that is, line termination immediately
followed by EOF) case.  "if (feof(fp))" fires when we have
already read the eof, not when we are about read it.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
git-diff-cache -r -z 0 | ./git-diff-helper -z
diff --git a/strbuf.c b/strbuf.c
--- a/strbuf.c
+++ b/strbuf.c
@@ -37,6 +37,8 @@ void read_line(struct strbuf *sb, FILE *
 			break;
 		strbuf_add(sb, ch);
 	}
+	if (ch == EOF && sb->len == 0)
+		sb->eof = 1;
 	strbuf_end(sb);
 }
 



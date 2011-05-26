From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] diagnose a corrupt MERGE_RR when hitting EOF between TAB and '\0'
Date: Thu, 26 May 2011 15:54:18 +0200
Message-ID: <87boyp7ek5.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 15:54:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPb1J-0007Hl-Rn
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 15:54:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757778Ab1EZNyd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 09:54:33 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:45104 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757533Ab1EZNyc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 09:54:32 -0400
Received: from mx.meyering.net (unknown [82.230.74.64])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 4B144940266
	for <git@vger.kernel.org>; Thu, 26 May 2011 15:54:20 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id DBFAF60355; Thu, 26 May 2011 15:54:18 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174508>

I ran coverity against git and it warned about the truncation
inherent in the "buf[i] = fgetc(in);" assignment below.
With that hint, it's easy to see that failing fgetc (returning EOF)
was not handled at all.  The patch below fixes it.

You could probably accomplish the same thing on fewer lines
by declaring "c" earlier and assigning to both c and buf[i]
inside the for-stmt,

		for (i = 0; i < sizeof(buf) && (buf[i] = c = fgetc(in)); i++)
			if (c < 0)
				die("corrupt MERGE_RR");

But that doesn't placate this particular static analyzer, while
the patch below does.

-- >8 --
Subject: [PATCH] diagnose a corrupt MERGE_RR when hitting EOF between TAB and
 '\0'

* rerere.c (read_rr): If we reach EOF after the SHA1-then-TAB,
yet before the NUL that terminates each file name, before we would
fill the file name buffer with \255 bytes resulting from the
repeatedly-failing fgetc (returns EOF/-1) and ultimately complain
about "filename too long", because no NUL was encountered.
---
 rerere.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/rerere.c b/rerere.c
index dee2cb1..cb8e5ba 100644
--- a/rerere.c
+++ b/rerere.c
@@ -47,8 +47,14 @@ static void read_rr(struct string_list *rr)
 		name = xstrdup(buf);
 		if (fgetc(in) != '\t')
 			die("corrupt MERGE_RR");
-		for (i = 0; i < sizeof(buf) && (buf[i] = fgetc(in)); i++)
-			; /* do nothing */
+		for (i = 0; i < sizeof(buf); i++) {
+			int c = fgetc(in);
+			if (c < 0)
+				die("corrupt MERGE_RR");
+			buf[i] = c;
+			if (c == 0)
+				 break;
+		}
 		if (i == sizeof(buf))
 			die("filename too long");
 		string_list_insert(rr, buf)->util = name;
--
1.7.5.2.660.g9f46c

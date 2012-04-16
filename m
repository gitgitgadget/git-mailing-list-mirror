From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] diff: avoid stack-buffer-read-overrun for very long name
Date: Mon, 16 Apr 2012 17:20:02 +0200
Message-ID: <87ty0jbt5p.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 16 17:20:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJnj1-0004gX-P5
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 17:20:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753949Ab2DPPUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 11:20:12 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:34410 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753715Ab2DPPUL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 11:20:11 -0400
Received: from mx.meyering.net (unknown [88.168.87.75])
	by smtp5-g21.free.fr (Postfix) with ESMTP id E4982D48135
	for <git@vger.kernel.org>; Mon, 16 Apr 2012 17:20:03 +0200 (CEST)
Received: from rho.meyering.net (localhost.localdomain [127.0.0.1])
	by rho.meyering.net (Acme Bit-Twister) with ESMTP id 6DB6A60055
	for <git@vger.kernel.org>; Mon, 16 Apr 2012 17:20:02 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195645>


Due to the use of strncpy without explicit NUL termination,
we could end up passing names n1 or n2 that are not NUL-terminated
to queue_diff, which requires NUL-terminated strings.
Ensure that each is NUL terminated.

Signed-off-by: Jim Meyering <meyering@redhat.com>
---
After finding strncpy problems in other projects, I audited
git for the same and found only these two.

 diff-no-index.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/diff-no-index.c b/diff-no-index.c
index 3a36144..5cd3ff5 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -109,6 +109,7 @@ static int queue_diff(struct diff_options *o,
 				n1 = buffer1;
 				strncpy(buffer1 + len1, p1.items[i1++].string,
 						PATH_MAX - len1);
+				buffer1[PATH_MAX-1] = 0;
 			}

 			if (comp < 0)
@@ -117,6 +118,7 @@ static int queue_diff(struct diff_options *o,
 				n2 = buffer2;
 				strncpy(buffer2 + len2, p2.items[i2++].string,
 						PATH_MAX - len2);
+				buffer2[PATH_MAX-1] = 0;
 			}

 			ret = queue_diff(o, n1, n2);
--
1.7.10.169.g146fe

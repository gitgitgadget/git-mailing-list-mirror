From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] Fix a comparison bug in diff-delta.c
Date: Wed, 23 Aug 2006 04:32:48 +0200
Message-ID: <1156300368160-git-send-email-madcoder@debian.org>
Reply-To: Pierre Habouzit <madcoder@debian.org>
Cc: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Aug 23 04:32:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFiY1-0006Se-ST
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 04:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbWHWCcu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 22:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbWHWCcu
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 22:32:50 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:12978 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S932290AbWHWCcu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Aug 2006 22:32:50 -0400
Received: from olympe.madism.org (olympe.madism.org [82.243.245.108])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 388853F0A3;
	Wed, 23 Aug 2006 04:32:49 +0200 (CEST)
Received: from olympe.madism.org (localhost [127.0.0.1])
	by olympe.madism.org (Postfix) with ESMTP id 0148DBC7B0;
	Wed, 23 Aug 2006 04:32:49 +0200 (CEST)
Received: from hades.madism.org (hades.madism.org [192.168.0.10])
	by olympe.madism.org (Postfix) with ESMTP id A9697BC7AE;
	Wed, 23 Aug 2006 04:32:48 +0200 (CEST)
Received: by hades.madism.org (Postfix, from userid 1000)
	id 8E1A662126; Wed, 23 Aug 2006 04:32:48 +0200 (CEST)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.1.1
X-Virus-Scanned: by ClamAV (using ClamSMTP) at hermes.madism.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25888>

(1 << i) < hspace is compared in the `int` space rather that in the unsigned one.
the result will be wrong if hspace is between  0x40000000 and 0x80000000.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---

  I'm currently trying to make git compile with more strict gcc flags
(-g -O2 -Wall -Wextra -Wno-unused -Werror to be precise) and I've
spotted a first bug due to a signed/unsigned comparison.

  If I do understand that bit of code, it should not bite a lot of
people, but this is still a bug ;)


 diff-delta.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/diff-delta.c b/diff-delta.c
index 7da9205..a1fadc9 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -152,7 +152,7 @@ struct delta_index * create_delta_index(
 	   initialization in create_delta(). */
 	entries = (bufsize - 1)  / RABIN_WINDOW;
 	hsize = entries / 4;
-	for (i = 4; (1 << i) < hsize && i < 31; i++);
+	for (i = 4; (unsigned)(1 << i) < hsize && i < 31; i++);
 	hsize = 1 << i;
 	hmask = hsize - 1;
 
-- 
1.4.1.1

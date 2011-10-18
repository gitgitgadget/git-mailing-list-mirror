From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH 1/4] pack-objects: mark add_to_write_order() as inline
Date: Tue, 18 Oct 2011 00:21:21 -0500
Message-ID: <1318915284-6361-1-git-send-email-dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 18 07:21:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RG27N-0001Ah-HP
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 07:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752785Ab1JRFV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 01:21:27 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:65245 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694Ab1JRFV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 01:21:27 -0400
Received: by iaek3 with SMTP id k3so290439iae.19
        for <git@vger.kernel.org>; Mon, 17 Oct 2011 22:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        bh=jPHS2omk0PS0U5qtiTANAM3EDFB32Pkyxuxhhi7DDAk=;
        b=VlcM12fKU6RdDRS1m1u3g+VByOP9MYtkFhn3aY04fBB2i+q267imEmBhdwLyWH2iMP
         xgxghveVuRG+pKSHdIMNOnFV6cZphNGPzNyBPE6Hs0BBAPtIWBtVNiyodbhzKDlwrzFz
         lO1463Q5O3JLwdaI4nV9a4nGTZTPyDw29MSfA=
Received: by 10.42.154.7 with SMTP id o7mr1482067icw.48.1318915286456;
        Mon, 17 Oct 2011 22:21:26 -0700 (PDT)
Received: from localhost (c-71-194-41-240.hsd1.il.comcast.net. [71.194.41.240])
        by mx.google.com with ESMTPS id eh34sm2500477ibb.5.2011.10.17.22.21.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 17 Oct 2011 22:21:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183854>

This function is a whole 26 bytes when compiled on x86_64, but is
currently invoked over 1.037 billion times when running pack-objects on
the Linux kernel git repository. This is hitting the point where
micro-optimizations do make a difference, and inlining it only increases
the object file size by 38 bytes.

As reported by perf, this dropped task-clock from 84183 to 83373 ms, and
total cycles from 223.5 billion to 221.6 billion. Not astronomical, but
worth getting for adding one word.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 builtin/pack-objects.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 2b18de5..0ab3a3b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -454,7 +454,7 @@ static int mark_tagged(const char *path, const unsigned char *sha1, int flag,
 	return 0;
 }
 
-static void add_to_write_order(struct object_entry **wo,
+static inline void add_to_write_order(struct object_entry **wo,
 			       int *endp,
 			       struct object_entry *e)
 {
-- 
1.7.7

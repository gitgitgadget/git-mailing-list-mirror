From: Stefan Beller <stefanbeller@gmail.com>
Subject: [PATCH] unpack-tree.c: remove dead code
Date: Mon, 11 Aug 2014 21:44:28 +0200
Message-ID: <1407786268-15249-1-git-send-email-stefanbeller@gmail.com>
Cc: Stefan Beller <stefanbeller@gmail.com>
To: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	barkalow@iabervon.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 11 21:44:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGvWG-0000dK-TS
	for gcvg-git-2@plane.gmane.org; Mon, 11 Aug 2014 21:44:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754746AbaHKTod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2014 15:44:33 -0400
Received: from mail-wg0-f48.google.com ([74.125.82.48]:44132 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752825AbaHKToc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2014 15:44:32 -0400
Received: by mail-wg0-f48.google.com with SMTP id x13so9043211wgg.7
        for <git@vger.kernel.org>; Mon, 11 Aug 2014 12:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=mUztvrKlWM+X7EnsvWTXeDpJXXz00fFBWdHDPt37ZCo=;
        b=CHCUKTj4xIWv5QtJkcX7xgH3Ds+pnFY/sx9igidnGxZW3x1Y1mIca+pfTNE7tx6ais
         PEpNK/eP6rHmr6G8wMF/i5yMDqjp8AWl2xsPKAOkULZ0idUz5VURQtWQGvpzcUeiTPvG
         +aMlBLxj8AAgsdbXSw1/pVD3KwNi3Fuyb7GumfUp4Ey+wFFTxlIHX5FRqd9FsIGSj7gs
         mAyFOqc/qXpbjWnKtBRakGikxuUvLORj2owlvxgLFb+vAY5b5/w6d/Kf5umOo0j7kcyg
         dRboUTFT0xxaPtT+a7Z266w6UpRqk6e+dGbWBXIABpONu5seqSAC4tsqXxoMn8wsackc
         5+QQ==
X-Received: by 10.180.20.40 with SMTP id k8mr22851591wie.38.1407786271523;
        Mon, 11 Aug 2014 12:44:31 -0700 (PDT)
Received: from localhost (ip-109-91-30-58.hsi12.unitymediagroup.de. [109.91.30.58])
        by mx.google.com with ESMTPSA id es9sm3880884wjd.1.2014.08.11.12.44.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 11 Aug 2014 12:44:30 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.rc2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255135>

In line 1763 of unpack-tree.c we have a condition on the current tree
	if (current) {
		...
Within this block of code we can assume current to be non NULL, hence
the code after the statement in line 1796:
	if (current)
		return ...

cannot be reached.

The proposed patch here changes the order of the current tree and the
newtree part. I'm not sure if that's the right way to handle it.

All referenced lines have been introduced in the same commit
076b0adc (2006-07-30, read-tree: move merge functions to the library),
which was just moving the code around.
The outer condition on the current tree (now in line 1763) was introduced
in c859600954df4c292e, June 2005, [PATCH] read-tree: save more user hassles during fast-forward.
The inner condition on the current tree was introduced in
ee6566e8d70da682ac4926d, Sept. 2005, [PATCH] Rewrite read-tree

This issue was found by coverity, Id:290002

Signed-off-by: Stefan Beller <stefanbeller@gmail.com>
---
 unpack-trees.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index c6aa8fb..e6d37ff 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1793,11 +1793,10 @@ int twoway_merge(const struct cache_entry * const *src,
 			/* all other failures */
 			if (oldtree)
 				return o->gently ? -1 : reject_merge(oldtree, o);
-			if (current)
-				return o->gently ? -1 : reject_merge(current, o);
 			if (newtree)
 				return o->gently ? -1 : reject_merge(newtree, o);
-			return -1;
+			/* current is definitely exists here */
+			return o->gently ? -1 : reject_merge(current, o);
 		}
 	}
 	else if (newtree) {
-- 
2.1.0.rc2

From: Stefan Beller <stefanbeller@gmail.com>
Subject: [PATCH] unpack-tree.c: remove dead code
Date: Tue, 12 Aug 2014 23:15:07 +0200
Message-ID: <1407878107-22850-1-git-send-email-stefanbeller@gmail.com>
References: <xmqqha1h60fy.fsf@gitster.dls.corp.google.com>
Cc: Stefan Beller <stefanbeller@gmail.com>
To: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	barkalow@iabervon.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 12 23:15:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHJPe-0000eM-Ts
	for gcvg-git-2@plane.gmane.org; Tue, 12 Aug 2014 23:15:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705AbaHLVPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2014 17:15:13 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:36573 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699AbaHLVPM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2014 17:15:12 -0400
Received: by mail-wi0-f179.google.com with SMTP id f8so6419507wiw.12
        for <git@vger.kernel.org>; Tue, 12 Aug 2014 14:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LLMKOYIJ5gWoeaDweSa2wbmBE9AdCF8jeU3D42MrIb4=;
        b=AbFFIHMeWyGcyN3KsxaYzNjG/3gKs8kDAH7qqVcQK0XvfgzJKWyNv/g9g9J09A1STm
         Vb1zVzit//kiY5bQxVyh3/tX4063umP8AqFNMaY8jli1bzUGwbt4YvR1mxeGQYWK/637
         ELLXQ4a6nVZ5sha4I76Q103lTYYsRVzux3YN+ZUDONzV7VgraYSpujZJVJ3YLP6aWWxR
         JrYtnDNaTEWRU1TMzIFsojOEWwk/Gbvk6Em0n38Cw5lrj/TWMuZ9M49afAYiIr4X2Ytc
         +SEqyORLhAFqOnCPLb9760bCBFut179Y6cdU5jPae1EhAVWl1oSXA9YkIHlWvh44xRk8
         FnLA==
X-Received: by 10.194.63.37 with SMTP id d5mr283111wjs.92.1407878111078;
        Tue, 12 Aug 2014 14:15:11 -0700 (PDT)
Received: from localhost (ip-109-91-30-58.hsi12.unitymediagroup.de. [109.91.30.58])
        by mx.google.com with ESMTPSA id 20sm11769365wjt.42.2014.08.12.14.15.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 Aug 2014 14:15:10 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.rc2
In-Reply-To: <xmqqha1h60fy.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255165>

In line 1763 of unpack-tree.c we have a condition on the current tree
	if (current) {
		...
Within this block of code we can assume current to be non NULL, hence
the code after the statement in line 1796:
	if (current)
		return ...

cannot be reached.

current/newtree/oldtree are used in the
call to reject_merge() *only* for their path aka ce->name, and they
all point at the same name (there is no rename funkies here); hence
"all other failures" code path should just rely on current always
being present.

All referenced lines have been introduced in the same commit
076b0adc (2006-07-30, read-tree: move merge functions to the library),
which was just moving the code around.
The outer condition on the current tree (now in line 1763) was introduced
in c859600954df4c292e, June 2005, [PATCH] read-tree: save more user hassles during fast-forward.
The inner condition on the current tree was introduced in
ee6566e8d70da682ac4926d, Sept. 2005, [PATCH] Rewrite read-tree

This issue was found by coverity, Id:290002

Signed-off-by: Stefan Beller <stefanbeller@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
---
 unpack-trees.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

Did I understand you right, when changing to this one?

diff --git a/unpack-trees.c b/unpack-trees.c
index c6aa8fb..42ee84e 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1789,15 +1789,11 @@ int twoway_merge(const struct cache_entry * const *src,
 			/* 20 or 21 */
 			return merged_entry(newtree, current, o);
 		}
+		else if (o->gently) {
+			return  -1 ;
+		}
 		else {
-			/* all other failures */
-			if (oldtree)
-				return o->gently ? -1 : reject_merge(oldtree, o);
-			if (current)
-				return o->gently ? -1 : reject_merge(current, o);
-			if (newtree)
-				return o->gently ? -1 : reject_merge(newtree, o);
-			return -1;
+			reject_merge(current, o);
 		}
 	}
 	else if (newtree) {
-- 
2.1.0.rc2

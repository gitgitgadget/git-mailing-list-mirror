From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH] oneway_merge(): only lstat() when told to update worktree
Date: Thu, 20 Dec 2012 09:37:47 -0800
Message-ID: <1356025067-5396-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 20 18:45:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlkBp-0004PX-A6
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 18:45:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975Ab2LTRpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 12:45:32 -0500
Received: from mail-gg0-f202.google.com ([209.85.161.202]:53139 "EHLO
	mail-gg0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969Ab2LTRp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 12:45:29 -0500
Received: by mail-gg0-f202.google.com with SMTP id k1so385907ggn.1
        for <git@vger.kernel.org>; Thu, 20 Dec 2012 09:45:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer
         :x-gm-message-state;
        bh=7pYnmoH37uap7QQ7bHO/BeNKJQBfzr0Xor3Iax3spxE=;
        b=AtLQ1VAGTlraCi4JyMIIu6iDPNlDHvAd9f/fitcuYRWYl5Ewv6W1/7L8fNxTgb2/y/
         /eh8+zNuXUoDE5DbPuWJyHJayu7TDBG2IOWGZLqgR1MyintHKF9j0ZoQ1u5TahDjK5v9
         wDCNPkGVk2oKCvdcw0o6iLhXszdVeJB2M8NgTaRUj+S9EsDVrlXu818qZtYEbNU3N3Ty
         gHIFm0UvnqKSwAHKlZhgr43DsVmZMu9dvyp3ZrsDuAc9Uw2bcCIaut2K+zPz69M3P38o
         mCxjgZXqJlPB8P1E3YU692BqOzWTlMe8I4x2fGXTARsaSODkyzTEbRLd5gf1osX3bV0S
         Wpxg==
X-Received: by 10.236.193.106 with SMTP id j70mr4545498yhn.11.1356025096659;
        Thu, 20 Dec 2012 09:38:16 -0800 (PST)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id i27si806377yhb.0.2012.12.20.09.38.16
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Thu, 20 Dec 2012 09:38:16 -0800 (PST)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id 8C47682004A;
	Thu, 20 Dec 2012 09:38:16 -0800 (PST)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 38F08101A7B; Thu, 20 Dec 2012 09:38:16 -0800 (PST)
X-Mailer: git-send-email 1.8.0.1.240.ge8a1f5a
X-Gm-Message-State: ALoCoQmgfOv+sYGJG6Gu108nfwDa5UibYhsxTREwp5F77riLHP7DT2qATBxfV4Xbl6jnQ8g9upzDbRTtRoyjW09e4WQnMrptTtSokW32w0FTgU+ZgbVgSIUGMc93VRIBB5ZttSCvl2Z03pJWv+xI1JtZG9Zvcx7ChnVm5NifUrq2Tg3PmPjIgxKvLmrSPRtrTmIkm/J+beKS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211908>

Although the subject line of 613f027 (read-tree -u one-way merge fix
to check out locally modified paths., 2006-05-15) mentions "read-tree
-u", it did not seem to check whether -u was in effect. Not checking
whether -u is in effect makes e.g. "read-tree --reset" lstat() the
worktree, even though the worktree stat should not matter for that
operation.

This speeds up e.g. "git reset" a little on the linux-2.6 repo (best
of five, warm cache):

        Before      After
real    0m0.288s    0m0.233s
user    0m0.190s    0m0.150s
sys     0m0.090s    0m0.080s
---

I am very unfamiliar with this part of git, so my attempt at a
motivation may be totally off.

I have another twenty-or-so patches to reset.c coming up that take the
timings down to around 90 ms, but this patch was quite unrelated to
that. Those other patches actually make this patch pointless for "git
reset" (it takes another path), but I hope this is still a good change
for other operations that use oneway_merge.

 unpack-trees.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 6d96366..61acc5e 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1834,7 +1834,7 @@ int oneway_merge(struct cache_entry **src, struct unpack_trees_options *o)
 
 	if (old && same(old, a)) {
 		int update = 0;
-		if (o->reset && !ce_uptodate(old) && !ce_skip_worktree(old)) {
+		if (o->reset && o->update && !ce_uptodate(old) && !ce_skip_worktree(old)) {
 			struct stat st;
 			if (lstat(old->name, &st) ||
 			    ie_match_stat(o->src_index, old, &st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE))
-- 
1.8.0.1.240.ge8a1f5a

From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] revision.c: Correctly dereference interesting_cache
Date: Fri, 19 Jun 2015 12:01:23 -0700
Message-ID: <1434740483-31730-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: peff@peff.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 19 21:01:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z61Xg-0007Oc-W3
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 21:01:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753168AbbFSTB3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 15:01:29 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:34179 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669AbbFSTB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 15:01:27 -0400
Received: by igboe5 with SMTP id oe5so22992264igb.1
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 12:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=5xlAdSsjxVaeNqqmjY/XJTGl2m7119zVSrgncvKjWS4=;
        b=P2107JhtOr+q1g1sLo8sF9DX+DSjnOIYWrhdkjEa6fRx+IiChsZUYOYb19M4JYyilE
         RmkSRjlDCnxgnZK0DclitR0YYVOVwvPkzh6iEAJXDcRXEEJIPRdknhkzAZr/YdXPVjAZ
         ceM7R8IkMOZEmE/PWvZY+BZN6piFhueujOc6AmZjZlhQ89WOsdrLEkpQvJ5xVDFrhVPG
         fBBi9fbjFW3kppljuOKs1oPd/2qqRKbTHpv6klUISqa/IMnN+gC3LgCi28Of99khcSyI
         MLfKC/+oye26p/EPsgEcOx3sGN8mHMz8W/YVAjZ2R20tpQwBLL2hqoYXC4G41Ydf8Omm
         /5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5xlAdSsjxVaeNqqmjY/XJTGl2m7119zVSrgncvKjWS4=;
        b=N0+kw1nCZHhQWVCS471Rt2xQP2PCeUBg6HcEtx+1QwKFUycyr8X7wOFS9hAyBRMjuL
         PGvyxejEdFVjQgTtV3Y7POacqlnvuniKSyR2RP+2dIO5ohfFMKcM5I6CsM5kWo1gmY+L
         LLkk3r9vMveOTqWO36Pf5kozlWkK1VDzIaoKHPXxHZMCymwJxrm5Y8ThpHyCbPtNo5Wa
         SBAU8HSnNBziJHz+F6ZVEWsT0BQfxN3Woif9t1kHrRGJwOaAPG0Tek0BsE8r2fohWzsy
         empz4fdGBXVhgfW5SsVlMJT2+h+MsMvvIRaCSfEiUGiA6I1vVkllaJflQvOePwn1e+06
         hZSA==
X-Gm-Message-State: ALoCoQlcAFW+CPex10O0+SM3zGpqqk/FbMx3pyvloEAga61mT+P1To/1K/Jp8lZ9mBgxdDFcSIa6
X-Received: by 10.107.148.144 with SMTP id w138mr24553905iod.12.1434740486566;
        Fri, 19 Jun 2015 12:01:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:ec94:864a:dce4:d3cd])
        by mx.google.com with ESMTPSA id o2sm2241609igr.9.2015.06.19.12.01.25
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jun 2015 12:01:26 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.345.gab207b6.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272183>

This was introduced at b6e8a3b5 (2015-04-17, limit_list: avoid
quadratic behavior from still_interesting), which
also introduced the check a few lines before, which already dereferences
`interesting_cache`. So at this point `interesting_cache` is guaranteed to
be not NULL. The code is called referencing the address of a local
variable, so `interesting_cache` can actually never be NULL and trigger a
segmentation fault by dereferencing it a few lines before this.

I think the right thing is to check for `*interesting_cache` as that
can become NULL actually.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Hi Jeff,

I found this possible defect via coverity id 1295352.
As I have had limited exposure to revision.c code until now,
the commit message may or may not be bogus.

Thanks,
Stefan


 revision.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 3ff8723..d1f0f07 100644
--- a/revision.c
+++ b/revision.c
@@ -347,35 +347,35 @@ static struct commit *handle_commit(struct rev_info *revs,
 
 static int everybody_uninteresting(struct commit_list *orig,
 				   struct commit **interesting_cache)
 {
 	struct commit_list *list = orig;
 
 	if (*interesting_cache) {
 		struct commit *commit = *interesting_cache;
 		if (!(commit->object.flags & UNINTERESTING))
 			return 0;
 	}
 
 	while (list) {
 		struct commit *commit = list->item;
 		list = list->next;
 		if (commit->object.flags & UNINTERESTING)
 			continue;
-		if (interesting_cache)
+		if (*interesting_cache)
 			*interesting_cache = commit;
 		return 0;
 	}
 	return 1;
 }
 
 /*
  * A definition of "relevant" commit that we can use to simplify limited graphs
  * by eliminating side branches.
  *
  * A "relevant" commit is one that is !UNINTERESTING (ie we are including it
  * in our list), or that is a specified BOTTOM commit. Then after computing
  * a limited list, during processing we can generally ignore boundary merges
  * coming from outside the graph, (ie from irrelevant parents), and treat
  * those merges as if they were single-parent. TREESAME is defined to consider
  * only relevant parents, if any. If we are TREESAME to our on-graph parents,
  * we don't care if we were !TREESAME to non-graph parents.
-- 
2.4.1.345.gab207b6.dirty

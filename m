From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/3] revision: append to list instead of insert and reverse
Date: Wed, 25 Apr 2012 22:35:41 +0200
Message-ID: <4F98601D.3070303@lsrfire.ath.cx>
References: <CANV9Rr_ev+34Wd030cps0UbgjRYD0=L2DQhbrCOkBVWG-2xaug@mail.gmail.com> <20120425111435.GA21579@sigill.intra.peff.net> <4F985D0A.9020100@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Michael Mueller <mmueller@vigilantsw.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 25 22:36:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SN8wY-00020l-Vp
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 22:36:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758866Ab2DYUgB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Apr 2012 16:36:01 -0400
Received: from india601.server4you.de ([85.25.151.105]:57254 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758847Ab2DYUgA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2012 16:36:00 -0400
Received: from [192.168.2.105] (p4FFDBB95.dip.t-dialin.net [79.253.187.149])
	by india601.server4you.de (Postfix) with ESMTPSA id 049442F8047;
	Wed, 25 Apr 2012 22:35:58 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120420 Thunderbird/12.0
In-Reply-To: <4F985D0A.9020100@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196336>

By using commit_list_insert(), we added new items to the top of the
list and, since this is not the order we want, reversed it afterwards.
Simplify this process by adding new items at the bottom instead,
getting rid of the reversal step.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 revision.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index edb225d..9e63baa 100644
--- a/revision.c
+++ b/revision.c
@@ -2071,6 +2071,7 @@ int prepare_revision_walk(struct rev_info *revs)
 {
 	int nr = revs->pending.nr;
 	struct object_array_entry *e, *list;
+	struct commit_list **next = &revs->commits;
 
 	e = list = revs->pending.objects;
 	revs->pending.nr = 0;
@@ -2081,12 +2082,11 @@ int prepare_revision_walk(struct rev_info *revs)
 		if (commit) {
 			if (!(commit->object.flags & SEEN)) {
 				commit->object.flags |= SEEN;
-				commit_list_insert(commit, &revs->commits);
+				next = commit_list_append(commit, next);
 			}
 		}
 		e++;
 	}
-	commit_list_reverse(&revs->commits);
 	commit_list_sort_by_date(&revs->commits);
 	if (!revs->leak_pending)
 		free(list);
-- 
1.7.10

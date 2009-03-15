From: Benjamin Kramer <benny.kra@googlemail.com>
Subject: [PATCH] Fix various dead stores found by the clang static analyzer
Date: Sun, 15 Mar 2009 22:01:20 +0100
Message-ID: <49BD6CA0.6040909@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 22:06:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LixU2-0004MV-Pn
	for gcvg-git-2@gmane.org; Sun, 15 Mar 2009 22:02:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758094AbZCOVB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2009 17:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758065AbZCOVB1
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Mar 2009 17:01:27 -0400
Received: from mu-out-0910.google.com ([209.85.134.189]:33537 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755744AbZCOVB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2009 17:01:26 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1112650mue.1
        for <git@vger.kernel.org>; Sun, 15 Mar 2009 14:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=yB1fuT/LnXlr4TKpRFxx6kjIFjW0fh4RFqDsbSXnB7U=;
        b=hrNijpz6DPaXXPj8ux8mE/N/ur7EmrMMunKNsOVFrtaNoOk8yQbYmpNEdCjq7IqroL
         MZljKGHHS5osY9pDi1TEsSYxP4SOlw+AGCqF5hE+Pxn5NBxxHFi6jlqW3XxzmnSCRbR0
         YaQK6d7o9KFCBVXwTBm8pvUkLU7pL2oJFI8h8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=n6z7XF19T2qe0NIA4jukqX29at/B+RPCgNWuCTiqCuffbWNbu6fffShn7dtWv8WBg8
         Rokjn0rFs+yh0YIYI4JVqVQe6X/Bb1G3s37Kk/6U3Ptda5XDCJRQADSK3NADYdOuYA7h
         AvAJbuD1MRsBiiIza1Ax4HvauwpBwAlCjoPh4=
Received: by 10.103.175.8 with SMTP id c8mr1803215mup.117.1237150882383;
        Sun, 15 Mar 2009 14:01:22 -0700 (PDT)
Received: from golden.local (p5B01FDC3.dip.t-dialin.net [91.1.253.195])
        by mx.google.com with ESMTPS id u26sm8861749mug.58.2009.03.15.14.01.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Mar 2009 14:01:21 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.19 (Macintosh/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113298>

http-push.c::finish_request(): request is initialized by the for loop
index-pack.c::free_base_data(): b is initialized by the for loop

merge-recursive.c::process_renames(): move compare, remove unused
                                      assigns
merge-recursive.c::process_renames(): remove unused variable renames2

xdiff/xdiffi.c::xdl_recs_cmp(): ec was unused
xdiff/xemit.c::xdl_emit_diff(): xche is always overwritten

Signed-off-by: Benjamin Kramer <benny.kra@googlemail.com>
---
 http-push.c       |    2 +-
 index-pack.c      |    2 +-
 merge-recursive.c |   11 +++--------
 xdiff/xdiffi.c    |    5 ++---
 xdiff/xemit.c     |    2 +-
 5 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/http-push.c b/http-push.c
index 30d2d34..6715695 100644
--- a/http-push.c
+++ b/http-push.c
@@ -816,7 +816,7 @@ static void finish_request(struct transfer_request *request)
 #ifdef USE_CURL_MULTI
 static int fill_active_slot(void *unused)
 {
-	struct transfer_request *request = request_queue_head;
+	struct transfer_request *request;
 
 	if (aborted)
 		return 0;
diff --git a/index-pack.c b/index-pack.c
index 7fee872..7546822 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -232,7 +232,7 @@ static void free_base_data(struct base_data *c)
 
 static void prune_base_data(struct base_data *retain)
 {
-	struct base_data *b = base_cache;
+	struct base_data *b;
 	for (b = base_cache;
 	     base_cache_used > delta_base_cache_limit && b;
 	     b = b->child) {
diff --git a/merge-recursive.c b/merge-recursive.c
index ee853b9..3e1bc3e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -801,22 +801,19 @@ static int process_renames(struct merge_options *o,
 	}
 
 	for (i = 0, j = 0; i < a_renames->nr || j < b_renames->nr;) {
-		int compare;
 		char *src;
-		struct string_list *renames1, *renames2, *renames2Dst;
+		struct string_list *renames1, *renames2Dst;
 		struct rename *ren1 = NULL, *ren2 = NULL;
 		const char *branch1, *branch2;
 		const char *ren1_src, *ren1_dst;
 
 		if (i >= a_renames->nr) {
-			compare = 1;
 			ren2 = b_renames->items[j++].util;
 		} else if (j >= b_renames->nr) {
-			compare = -1;
 			ren1 = a_renames->items[i++].util;
 		} else {
-			compare = strcmp(a_renames->items[i].string,
-					b_renames->items[j].string);
+			int compare = strcmp(a_renames->items[i].string,
+					     b_renames->items[j].string);
 			if (compare <= 0)
 				ren1 = a_renames->items[i++].util;
 			if (compare >= 0)
@@ -826,14 +823,12 @@ static int process_renames(struct merge_options *o,
 		/* TODO: refactor, so that 1/2 are not needed */
 		if (ren1) {
 			renames1 = a_renames;
-			renames2 = b_renames;
 			renames2Dst = &b_by_dst;
 			branch1 = o->branch1;
 			branch2 = o->branch2;
 		} else {
 			struct rename *tmp;
 			renames1 = b_renames;
-			renames2 = a_renames;
 			renames2Dst = &a_by_dst;
 			branch1 = o->branch2;
 			branch2 = o->branch1;
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 3e97462..02184d9 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -293,15 +293,14 @@ int xdl_recs_cmp(diffdata_t *dd1, long off1, long lim1,
 		for (; off1 < lim1; off1++)
 			rchg1[rindex1[off1]] = 1;
 	} else {
-		long ec;
 		xdpsplit_t spl;
 		spl.i1 = spl.i2 = 0;
 
 		/*
 		 * Divide ...
 		 */
-		if ((ec = xdl_split(ha1, off1, lim1, ha2, off2, lim2, kvdf, kvdb,
-				    need_min, &spl, xenv)) < 0) {
+		if (xdl_split(ha1, off1, lim1, ha2, off2, lim2, kvdf, kvdb,
+			      need_min, &spl, xenv) < 0) {
 
 			return -1;
 		}
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 05bfa41..c4bedf0 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -132,7 +132,7 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 	if (xecfg->flags & XDL_EMIT_COMMON)
 		return xdl_emit_common(xe, xscr, ecb, xecfg);
 
-	for (xch = xche = xscr; xch; xch = xche->next) {
+	for (xch = xscr; xch; xch = xche->next) {
 		xche = xdl_get_hunk(xch, xecfg);
 
 		s1 = XDL_MAX(xch->i1 - xecfg->ctxlen, 0);
-- 
1.6.2.173.g9e85

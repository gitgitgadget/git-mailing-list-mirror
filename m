From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [RFC PATCH] unpack-trees: add the dry_run flag to unpack_trees_options
Date: Tue, 24 May 2011 23:07:05 +0200
Message-ID: <4DDC1DF9.9030109@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 23:07:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOyoq-0001L3-W2
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 23:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755571Ab1EXVHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 17:07:09 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:58091 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757559Ab1EXVHH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2011 17:07:07 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate01.web.de (Postfix) with ESMTP id 43CAC18F7C7F6;
	Tue, 24 May 2011 23:07:06 +0200 (CEST)
Received: from [93.246.53.235] (helo=[192.168.178.43])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QOyok-0002Z3-00; Tue, 24 May 2011 23:07:06 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+bvdh9tPkt/U66UdcsxkAfEP/EQUZEDOJztR4R
	EbC5a4QQNAjhnfFvlTZiwXF5mDQTui1SqbBw+Z9EoVu2pGaKpn
	r889GqH05PcEla4KQ7EA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174341>

Until now there was no way to test if unpack_trees() with update=1 would
succeed without really updating the work tree. The reason for that is that
setting update to 0 does skip the tests for new files and deactivates the
sparse handling, thereby making that unsuitable as a dry run.

Add the new dry_run flag to struct unpack_trees_options unpack_trees().
Setting that together with the update flag will check if the work tree
update would be successful without doing it for real.

The only class of problems that is not detected at the moment are file
system conditions like ENOSPC or missing permissions. Also the index
entries of updated files are not as they would be after a real checkout
because lstat() isn't run as the files aren't updated for real.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

AFAICS this patch enables the user to achieve a dry run by calling
unpack_trees() with both update and dry_run set.

My "Teach read-tree the -n|--dry-run option" adapted to this new flag
runs all tests successfully ...


 unpack-trees.c |    4 ++--
 unpack-trees.h |    3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 500ebcf..e26a710 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -203,7 +203,7 @@ static int check_updates(struct unpack_trees_options *o)

 		if (ce->ce_flags & CE_WT_REMOVE) {
 			display_progress(progress, ++cnt);
-			if (o->update)
+			if (o->update && !o->dry_run)
 				unlink_entry(ce);
 			continue;
 		}
@@ -217,7 +217,7 @@ static int check_updates(struct unpack_trees_options *o)
 		if (ce->ce_flags & CE_UPDATE) {
 			display_progress(progress, ++cnt);
 			ce->ce_flags &= ~CE_UPDATE;
-			if (o->update) {
+			if (o->update && !o->dry_run) {
 				errs |= checkout_entry(ce, &state, NULL);
 			}
 		}
diff --git a/unpack-trees.h b/unpack-trees.h
index cd11a08..64f02cb 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -46,7 +46,8 @@ struct unpack_trees_options {
 		     debug_unpack,
 		     skip_sparse_checkout,
 		     gently,
-		     show_all_errors;
+		     show_all_errors,
+		     dry_run;
 	const char *prefix;
 	int cache_bottom;
 	struct dir_struct *dir;
-- 
1.7.5.1.340.g7f395.dirty

From: Elijah Newren <newren@gmail.com>
Subject: [PATCH] merge-recursive: Avoid excessive output for and reprocessing of renames
Date: Fri, 20 Aug 2010 06:55:40 -0600
Message-ID: <1282308940-3527-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 20 14:54:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmR6n-0008Pl-KC
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 14:54:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508Ab0HTMyE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 08:54:04 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:35668 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970Ab0HTMyC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 08:54:02 -0400
Received: by pvg2 with SMTP id 2so1183647pvg.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 05:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=2wpEZp4J5q/7LrOW5v/kxolVXI0NO3AcBlVjsf3ho4M=;
        b=LV+Yb5js/1JhZInNSsPJZ9hbzj/hKm5J608Pjow4cbwWM1wtn/kIkNBKzuAPndHS18
         T1diqzwjcsl6NFl1fMKl9WN+lj2uI6NTmSFiIK3pL3H/HAId1aZFsN3Hp4j65RHXtbne
         8xUir+jTl6puRDZBfiSwbmHZYD4bURLwq2GiM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=PgaphbzOYJhcUS/67dtDms3TlLNKNCBTYqqyoIdGnxomh8jn/UXQFKebDQF2Ab6LvA
         DvYKs7jQILQM0fPybJP1dTS+VYc6B1fc4azVKqeSShSlXBmSQQZcwp+Etq1PvNcy3SWS
         kFDtVaO1syMkMv3AKYDu03ntK/2WrI4lAYmEo=
Received: by 10.142.141.8 with SMTP id o8mr1091220wfd.53.1282308842136;
        Fri, 20 Aug 2010 05:54:02 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id w31sm3202970wfd.20.2010.08.20.05.54.00
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 05:54:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.365.gf72e17
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154028>

In 5a2580d (merge_recursive: Fix renames across paths below D/F conflicts
2010-07-09) and ae74548 (merge-recursive: Fix multiple file rename across
D/F conflict 2010-08-17), renames across D/F conflicts were fixed by
making process_renames() consider as unprocessed renames whose dst_entry
"still" had higher stage entries.  The assumption was that those higher
stage entries would have been cleared out of dst_entry by that point in
cases where the conflict could be resolved (normal renames with no D/F
conflicts).  That is not the case -- higher stage entries will remain in
all cases.

Fix this by checking for higher stage entries corresponding to D/F
conflicts, namely that stages 2 and 3 have exactly one nonzero mode between
them.  The nonzero mode stage corresponds to a file at the path, while the
stage with a zero mode will correspond to a directory at that path (since
rename/delete conflicts will have already been handled before this codepath
is reached.)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
What a mess, sorry for flubbing up the D/F series so badly and the need
for so many fixups after it already hit next.  I hope this finally fixes
things and that there's no more embarrasing bugs (or even
non-embarrasing ones).  Also, it looks like Alex was right about this
(http://article.gmane.org/gmane.comp.version-control.git/149948), though
I just didn't quite understand him at the time.  

 merge-recursive.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index a3fc443..aadd48c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1020,7 +1020,6 @@ static int process_renames(struct merge_options *o,
 				if (mfi.clean &&
 				    sha_eq(mfi.sha, ren1->pair->two->sha1) &&
 				    mfi.mode == ren1->pair->two->mode) {
-					int i;
 					/*
 					 * This message is part of
 					 * t6022 test. If you change
@@ -1032,12 +1031,9 @@ static int process_renames(struct merge_options *o,
 					 * in the index (e.g. due to a D/F
 					 * conflict) that need to be resolved.
 					 */
-					for (i = 1; i <= 3; i++) {
-						if (!ren1->dst_entry->stages[i].mode)
-							continue;
+					if (!ren1->dst_entry->stages[2].mode !=
+					    !ren1->dst_entry->stages[3].mode)
 						ren1->dst_entry->processed = 0;
-						break;
-					}
 				} else {
 					if (mfi.merge || !mfi.clean)
 						output(o, 1, "Renaming %s => %s", ren1_src, ren1_dst);
-- 
1.7.2.1.365.gf72e17

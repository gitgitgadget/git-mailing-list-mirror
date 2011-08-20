From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 1/2] fast-import: count and report # of calls to diff_delta in stats
Date: Sun, 21 Aug 2011 01:04:11 +0600
Message-ID: <1313867052-11993-2-git-send-email-divanorama@gmail.com>
References: <1313867052-11993-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 20 21:02:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Quqoc-0007dG-Ds
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 21:02:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754652Ab1HTTCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Aug 2011 15:02:32 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34260 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754135Ab1HTTC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Aug 2011 15:02:29 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so2884431bke.19
        for <git@vger.kernel.org>; Sat, 20 Aug 2011 12:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=tt2PbDNEDjnCmnR+CQEPSdR5p44i1wrDnvv8WgRYhPc=;
        b=tSKKUGFEz10wnYWdvr4imUHlJIWSDJRUPPqXB/PxtvGwPjErBci3iq9Hb7J2RnayaA
         BfHfc49gJV3Reiu2OKDIi7GDFBZyCZUh+PYzLzaekHn4LLtVGpw08T77knDhGl6bXg1Y
         f5O2E8sS1F0Pp/lUxKvZtqpjuhMPH8uYy84hg=
Received: by 10.204.132.18 with SMTP id z18mr270938bks.29.1313866949175;
        Sat, 20 Aug 2011 12:02:29 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id z7sm1402615bkt.6.2011.08.20.12.02.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 20 Aug 2011 12:02:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1313867052-11993-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179773>

It's an interesting number, how often do we try to deltify each type of
objects and how often do we succeed. So do add it to stats.

Success doesn't mean much gain in pack size though. As we allow delta to
be as big as (data.len - 20). And delta close to data.len gains nothing
compared to no delta at all even after zlib compression (delta is pretty
much the same as data, just with few modifications).

We should try to make less attempts that result in huge deltas as these
consume more cpu than trivial small deltas. Either by choosing a better
delta base or reducing delta size upper bound or doing less delta attempts
at all.

Currently, delta base for blobs is a waste literally. Each blob delta
base is chosen as a previously stored blob. Disabling deltas for blobs
doesn't increase pack size and reduce import time, or at least doesn't
increase time for all fast-import streams I've tried.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 fast-import.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 7cc2262..2b069e3 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -284,6 +284,7 @@ static uintmax_t marks_set_count;
 static uintmax_t object_count_by_type[1 << TYPE_BITS];
 static uintmax_t duplicate_count_by_type[1 << TYPE_BITS];
 static uintmax_t delta_count_by_type[1 << TYPE_BITS];
+static uintmax_t delta_count_attempts_by_type[1 << TYPE_BITS];
 static unsigned long object_count;
 static unsigned long branch_count;
 static unsigned long branch_load_count;
@@ -1045,6 +1046,7 @@ static int store_object(
 	}
 
 	if (last && last->data.buf && last->depth < max_depth && dat->len > 20) {
+		delta_count_attempts_by_type[type]++;
 		delta = diff_delta(last->data.buf, last->data.len,
 			dat->buf, dat->len,
 			&deltalen, dat->len - 20);
@@ -3338,10 +3340,10 @@ int main(int argc, const char **argv)
 		fprintf(stderr, "---------------------------------------------------------------------\n");
 		fprintf(stderr, "Alloc'd objects: %10" PRIuMAX "\n", alloc_count);
 		fprintf(stderr, "Total objects:   %10" PRIuMAX " (%10" PRIuMAX " duplicates                  )\n", total_count, duplicate_count);
-		fprintf(stderr, "      blobs  :   %10" PRIuMAX " (%10" PRIuMAX " duplicates %10" PRIuMAX " deltas)\n", object_count_by_type[OBJ_BLOB], duplicate_count_by_type[OBJ_BLOB], delta_count_by_type[OBJ_BLOB]);
-		fprintf(stderr, "      trees  :   %10" PRIuMAX " (%10" PRIuMAX " duplicates %10" PRIuMAX " deltas)\n", object_count_by_type[OBJ_TREE], duplicate_count_by_type[OBJ_TREE], delta_count_by_type[OBJ_TREE]);
-		fprintf(stderr, "      commits:   %10" PRIuMAX " (%10" PRIuMAX " duplicates %10" PRIuMAX " deltas)\n", object_count_by_type[OBJ_COMMIT], duplicate_count_by_type[OBJ_COMMIT], delta_count_by_type[OBJ_COMMIT]);
-		fprintf(stderr, "      tags   :   %10" PRIuMAX " (%10" PRIuMAX " duplicates %10" PRIuMAX " deltas)\n", object_count_by_type[OBJ_TAG], duplicate_count_by_type[OBJ_TAG], delta_count_by_type[OBJ_TAG]);
+		fprintf(stderr, "      blobs  :   %10" PRIuMAX " (%10" PRIuMAX " duplicates %10" PRIuMAX " deltas of %10" PRIuMAX" attempts)\n", object_count_by_type[OBJ_BLOB], duplicate_count_by_type[OBJ_BLOB], delta_count_by_type[OBJ_BLOB], delta_count_attempts_by_type[OBJ_BLOB]);
+		fprintf(stderr, "      trees  :   %10" PRIuMAX " (%10" PRIuMAX " duplicates %10" PRIuMAX " deltas of %10" PRIuMAX" attempts)\n", object_count_by_type[OBJ_TREE], duplicate_count_by_type[OBJ_TREE], delta_count_by_type[OBJ_TREE], delta_count_attempts_by_type[OBJ_TREE]);
+		fprintf(stderr, "      commits:   %10" PRIuMAX " (%10" PRIuMAX " duplicates %10" PRIuMAX " deltas of %10" PRIuMAX" attempts)\n", object_count_by_type[OBJ_COMMIT], duplicate_count_by_type[OBJ_COMMIT], delta_count_by_type[OBJ_COMMIT], delta_count_attempts_by_type[OBJ_COMMIT]);
+		fprintf(stderr, "      tags   :   %10" PRIuMAX " (%10" PRIuMAX " duplicates %10" PRIuMAX " deltas of %10" PRIuMAX" attempts)\n", object_count_by_type[OBJ_TAG], duplicate_count_by_type[OBJ_TAG], delta_count_by_type[OBJ_TAG], delta_count_attempts_by_type[OBJ_TAG]);
 		fprintf(stderr, "Total branches:  %10lu (%10lu loads     )\n", branch_count, branch_load_count);
 		fprintf(stderr, "      marks:     %10" PRIuMAX " (%10" PRIuMAX " unique    )\n", (((uintmax_t)1) << marks->shift) * 1024, marks_set_count);
 		fprintf(stderr, "      atoms:     %10u\n", atom_cnt);
-- 
1.7.3.4

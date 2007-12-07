From: Mike Hommey <mh@glandium.org>
Subject: [RFC/PATCH] Add a --nosort option to pack-objects
Date: Fri,  7 Dec 2007 22:10:32 +0100
Message-ID: <1197061832-8489-1-git-send-email-mh@glandium.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 07 22:11:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0kTM-0000vo-Dx
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 22:11:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752763AbXLGVKk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 16:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752733AbXLGVKk
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 16:10:40 -0500
Received: from smtp28.orange.fr ([80.12.242.100]:9991 "EHLO smtp28.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752690AbXLGVKj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 16:10:39 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2814.orange.fr (SMTP Server) with ESMTP id 2E85B70000A2
	for <git@vger.kernel.org>; Fri,  7 Dec 2007 22:10:38 +0100 (CET)
Received: from namakemono.glandium.org (APuteaux-153-1-79-219.w81-249.abo.wanadoo.fr [81.249.109.219])
	by mwinf2814.orange.fr (SMTP Server) with ESMTP id E9F4E70000A0;
	Fri,  7 Dec 2007 22:10:37 +0100 (CET)
X-ME-UUID: 20071207211037958.E9F4E70000A0@mwinf2814.orange.fr
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1J0kSv-0002Dn-ST; Fri, 07 Dec 2007 22:10:34 +0100
X-Mailer: git-send-email debian.1.5.3.7.1-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67457>

While most of the time the heuristics used by pack-objects to sort the
given object list are satisfying enough, there are cases where it can be
useful for the user to sort the list with heuristics that would be better
suited.

The --nosort option disabled the internal sorting used by pack-objects,
and runs the sliding window along the object list litterally as given on
stdin.

Signed-off-by: Mike Hommey <mh@glandium.org>
---

  I would obviously add the appropriate documentation for this flag if this
  is accepted. I'll also try to send another documentation patch for
  pack-objects with some information compiled from Linus's explanation to my
  last message about pack-objects.

 builtin-pack-objects.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 4f44658..8bc2d5f 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -21,7 +21,7 @@
 
 static const char pack_usage[] = "\
 git-pack-objects [{ -q | --progress | --all-progress }] \n\
-	[--max-pack-size=N] [--local] [--incremental] \n\
+	[--max-pack-size=N] [--local] [--incremental] [--nosort]\n\
 	[--window=N] [--window-memory=N] [--depth=N] \n\
 	[--no-reuse-delta] [--no-reuse-object] [--delta-base-offset] \n\
 	[--threads=N] [--non-empty] [--revs [--unpacked | --all]*] [--reflog] \n\
@@ -64,6 +64,7 @@ static int non_empty;
 static int no_reuse_delta, no_reuse_object, keep_unreachable;
 static int local;
 static int incremental;
+static int nosort;
 static int allow_ofs_delta;
 static const char *base_name;
 static int progress = 1;
@@ -1715,7 +1716,9 @@ static void prepare_pack(int window, int depth)
 		if (progress)
 			progress_state = start_progress("Compressing objects",
 							nr_deltas);
-		qsort(delta_list, n, sizeof(*delta_list), type_size_sort);
+		if (! nosort)
+			qsort(delta_list, n, sizeof(*delta_list),
+				type_size_sort);
 		ll_find_deltas(delta_list, n, window+1, depth, &nr_done);
 		stop_progress(&progress_state);
 		if (nr_done != nr_deltas)
@@ -1988,6 +1991,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			incremental = 1;
 			continue;
 		}
+		if (!strcmp("--nosort", arg)) {
+			nosort = 1;
+			continue;
+		}
 		if (!prefixcmp(arg, "--compression=")) {
 			char *end;
 			int level = strtoul(arg+14, &end, 0);
-- 
1.5.3.7

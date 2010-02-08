From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH] Revert
 "pack-objects: fix pack generation when using pack_size_limit"
Date: Mon, 08 Feb 2010 10:39:01 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002081032530.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 16:43:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeVlp-0007wE-Nv
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 16:43:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752775Ab0BHPnY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 10:43:24 -0500
Received: from relais.videotron.ca ([24.201.245.36]:39059 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752157Ab0BHPnX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 10:43:23 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KXJ00D2D4T11H00@VL-MR-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 08 Feb 2010 10:39:01 -0500 (EST)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139293>


This reverts most of commit a2430dde8ceaaaabf05937438249397b883ca77a.

That commit made the situation better for repositories with relatively
small number of objects.  However with many objects and a small pack size
limit, the time required to complete the repack tends towards O(n^2),
or even much worse with long delta chains.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---

Fixing this doesn't appear to be as trivial as I initially thought.
Although I do have some ideas, they're not appropriate so late in 
the -rc period.

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index dcfe62a..e1d3adf 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -445,13 +445,9 @@ static int write_one(struct sha1file *f,
 	if (e->idx.offset || e->preferred_base)
 		return -1;
 
-	/*
-	 * If we are deltified, attempt to write out base object first.
-	 * If that fails due to the pack size limit then the current
-	 * object might still possibly fit undeltified within that limit.
-	 */
-	if (e->delta)
-	       write_one(f, e->delta, offset);
+	/* if we are deltified, write out base object first. */
+	if (e->delta && !write_one(f, e->delta, offset))
+		return 0;
 
 	e->idx.offset = *offset;
 	size = write_object(f, e, *offset);
@@ -505,9 +501,11 @@ static void write_pack_file(void)
 		sha1write(f, &hdr, sizeof(hdr));
 		offset = sizeof(hdr);
 		nr_written = 0;
-		for (i = 0; i < nr_objects; i++)
-			if (write_one(f, objects + i, &offset) == 1)
-				display_progress(progress_state, written);
+		for (; i < nr_objects; i++) {
+			if (!write_one(f, objects + i, &offset))
+				break;
+			display_progress(progress_state, written);
+		}
 
 		/*
 		 * Did we write the wrong # entries in the header?
@@ -582,7 +580,7 @@ static void write_pack_file(void)
 			written_list[j]->offset = (off_t)-1;
 		}
 		nr_remaining -= nr_written;
-	} while (nr_remaining);
+	} while (nr_remaining && i < nr_objects);
 
 	free(written_list);
 	stop_progress(&progress_state);
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 1058d98..7649b81 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -389,7 +389,7 @@ test_expect_success 'verify resulting packs' '
 test_expect_success 'tolerate packsizelimit smaller than biggest object' '
 	git config pack.packSizeLimit 1 &&
 	packname_11=$(git pack-objects test-11 <obj-list) &&
-	test 3 = $(ls test-11-*.pack | wc -l)
+	test 5 = $(ls test-11-*.pack | wc -l)
 '
 
 test_expect_success 'verify resulting packs' '

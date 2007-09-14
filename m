From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/2] Fix the rename detection limit checking
Date: Fri, 14 Sep 2007 10:39:48 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0709141017450.16478@woody.linux-foundation.org>
References: <20070905234941.GA643@nomad.office.altlinux.org>
 <20070906022539.GG18160@spearce.org> <20070906101648.GD6665@basalt.office.altlinux.org>
 <20070909044648.GH18160@spearce.org> <7vir6fjmuv.fsf@gitster.siamese.dyndns.org>
 <20070913035137.GM3099@spearce.org> <7vr6l2gxyw.fsf@gitster.siamese.dyndns.org>
 <20070914000108.GE3619@basalt.office.altlinux.org> <7vr6l2f6k1.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.999.0709131850060.16478@woody.linux-foundation.org>
 <20070914024303.GH3619@basalt.office.altlinux.org>
 <alpine.LFD.0.999.0709132123570.16478@woody.linux-foundation.org>
 <alpine.LFD.0.999.0709141002360.16478@woody.linux-foundation.org>
 <alpine.LFD.0.999.0709141014130.16478@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: "Dmitry V. Levin" <ldv@altlinux.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 14 19:59:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWF9v-0001Sk-IK
	for gcvg-git-2@gmane.org; Fri, 14 Sep 2007 19:40:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752373AbXINRkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2007 13:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755938AbXINRkm
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 13:40:42 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:40778 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756315AbXINRkk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Sep 2007 13:40:40 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l8EHdf8N015537
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 14 Sep 2007 10:39:42 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l8EHdeHb016572;
	Fri, 14 Sep 2007 10:39:41 -0700
In-Reply-To: <alpine.LFD.0.999.0709141014130.16478@woody.linux-foundation.org>
X-Spam-Status: No, hits=-6.239 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.34__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58169>


This adds more proper rename detection limits. Instead of just checking 
the limit against the number of potential rename destinations, we verify 
that the rename matrix (which is what really matters) doesn't grow 
ridiculously large, and we also make sure that we don't overflow when 
doing the matrix size calculation.

This also changes the default limits from unlimited, to a rename matrix 
that is limited to 100 entries on a side. You can raise it with the config 
entry, or by using the "-l<n>" command line flag, but at least the default 
is now a sane number that avoids spending lots of time (and memory) in 
situations that likely don't merit it.

The choice of default value is of course very debatable. Limiting the 
rename matrix to a 100x100 size will mean that even if you have just one 
obvious rename, but you also create (or delete) 10,000 files, the rename 
matrix will be so big that we disable the heuristics. Sounds reasonable to 
me, but let's see if people hit this (and, perhaps more importantly, 
actually *care*) in real life.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

Due to the overflow issue (and yes, Dmitry's test-case actually triggered 
an overflow even on 64-bit machines, because the math was done on "int" 
types), I really think this was a real bug.

Now, whether this is necessarily the right way to fix it, I dunno, but it 
also *does* fix the old broken limit handling that was based just on the 
number of target files, and didn't take the number of potential source 
files into account.

But the fix to that logic also means that the meaning of "-l<n>" changes 
subtly. For the better, I think, but changes nonetheless.

I'd also like to apologize to the change in wt-status.c, but that code 
doesn't use the regular diffopt setup logic, so it really is a special 
case and needs to be handled as such. Do we want to teach "git runstatus" 
to actually honor command line flags for diff generation etc? That's a 
separate question, this patch just makes it use the same rename default as 
the normal diffs now do.

 diff.c            |    2 +-
 diffcore-rename.c |   19 +++++++++++++++++--
 wt-status.c       |    1 +
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 1aca5df..0ee9ea1 100644
--- a/diff.c
+++ b/diff.c
@@ -17,7 +17,7 @@
 #endif
 
 static int diff_detect_rename_default;
-static int diff_rename_limit_default = -1;
+static int diff_rename_limit_default = 100;
 static int diff_use_color_default;
 int diff_auto_refresh_index = 1;
 
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 6bde439..41b35c3 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -298,10 +298,25 @@ void diffcore_rename(struct diff_options *options)
 		else if (detect_rename == DIFF_DETECT_COPY)
 			register_rename_src(p->one, 1, p->score);
 	}
-	if (rename_dst_nr == 0 || rename_src_nr == 0 ||
-	    (0 < rename_limit && rename_limit < rename_dst_nr))
+	if (rename_dst_nr == 0 || rename_src_nr == 0)
 		goto cleanup; /* nothing to do */
 
+	/*
+	 * This basically does a test for the rename matrix not
+	 * growing larger than a "rename_limit" square matrix, ie:
+	 *
+	 *    rename_dst_nr * rename_src_nr > rename_limit * rename_limit
+	 *
+	 * but handles the potential overflow case specially (and we
+	 * assume at least 32-bit integers)
+	 */
+	if (rename_limit <= 0 || rename_limit > 32767)
+		rename_limit = 32767;
+	if (rename_dst_nr > rename_limit && rename_src_nr > rename_limit)
+		goto cleanup;
+	if (rename_dst_nr * rename_src_nr > rename_limit * rename_limit)
+		goto cleanup;
+
 	/* We really want to cull the candidates list early
 	 * with cheap tests in order to avoid doing deltas.
 	 * The first round matches up the up-to-date entries,
diff --git a/wt-status.c b/wt-status.c
index 5205420..10ce6ee 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -227,6 +227,7 @@ static void wt_status_print_updated(struct wt_status *s)
 	rev.diffopt.format_callback = wt_status_print_updated_cb;
 	rev.diffopt.format_callback_data = s;
 	rev.diffopt.detect_rename = 1;
+	rev.diffopt.rename_limit = 100;
 	wt_read_cache(s);
 	run_diff_index(&rev, 1);
 }

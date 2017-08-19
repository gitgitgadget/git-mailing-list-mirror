Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B53FF1F667
	for <e@80x24.org>; Sat, 19 Aug 2017 17:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751655AbdHSRjp (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Aug 2017 13:39:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61498 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751613AbdHSRjo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Aug 2017 13:39:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5284AB2C34;
        Sat, 19 Aug 2017 13:39:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=75ui9PvwaTBuYnHh6HBylNPblIY=; b=x8RwS4
        QjI3OmUmzfJP78MW53ykTD/VptzbOV59gZ1dEDSdsyI/vdIafdSi9/zwPFvNw+p8
        Q/0+jXu6JaVWt7A2ggRukdFaJxruL4s1TozvV5FE/Bv2butzT/ViCsc3xL88V4+4
        3vi4g3gU7I6bDG2e2+t03ZS93gAgLIV51mxS4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=itTuncbluK31RHNLJashV9zPcPcO0gVi
        0l1rzv3JHn4s70RENOYCpbiRWtSdwHePHJlSrRSLkXAaAeFM39jH/aXI3cvK2Hpd
        AL3fEFbu++EkC+r0t+YHCldUtQR1oZlPu3kxYL1ltng5ZO8HBRTIttrsZhZ14QAf
        i9Y1mqrDKOA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A683B2C33;
        Sat, 19 Aug 2017 13:39:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 99993B2C32;
        Sat, 19 Aug 2017 13:39:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Philip Oakley <philipoakley@iee.org>,
        Kevin Willford <kcwillford@gmail.com>,
        Kevin Willford <kewillf@microsoft.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH] progress: simplify "delayed" progress API
References: <20170531150427.7820-1-kewillf@microsoft.com>
        <20170810183256.12668-2-kewillf@microsoft.com>
        <20170810232033.46ujnozvnodkguog@sigill.intra.peff.net>
        <xmqqwp69ycim.fsf@gitster.mtv.corp.google.com>
        <EA124B72FA7542DBA1C31213235F1B94@PhilipOakley>
        <20170813043940.muj7z3dvl3nh4k6a@sigill.intra.peff.net>
        <xmqqpobyw11t.fsf@gitster.mtv.corp.google.com>
        <xmqqshguuhe2.fsf@gitster.mtv.corp.google.com>
        <20170814222947.edvuz7b2hxuwcsqj@sigill.intra.peff.net>
Date:   Sat, 19 Aug 2017 10:39:41 -0700
In-Reply-To: <20170814222947.edvuz7b2hxuwcsqj@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 14 Aug 2017 18:29:47 -0400")
Message-ID: <xmqqy3qf8nj6.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 622BA0B8-8505-11E7-AEE2-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We used to expose the full power of the delayed progress API to the
callers, so that they can specify, not just the message to show and
expected total amount of work that is used to compute the percentage
of work performed so far, the percent-threshold parameter P and the
delay-seconds parameter N.  The progress meter starts to show at N
seconds into the operation only if the amount of work completed
exceeds P.

Most callers used either (0%, 2s) or (50%, 1s) as (P, N), but there
are oddballs that chose more random-looking values like 95%.

For a smoother workload, (50%, 1s) would allow us to start showing
the progress meter earlier than (0%, 2s), while keeping the chance
of not showing progress meter for long running operation the same as
the latter.  For a task that would take 2s or more to complete, it
is likely that less than half of it would complete within the first
second, if the workload is smooth.  But for a spiky workload whose
earlier part is easier, such a setting is likely to fail to show the
progress meter entirely and (0%, 2s) is more appropriate.

But that is merely a theory.  Realistically, it is of dubious value
to ask each codepath to carefully consider smoothness of their
workload and specify their own setting by passing two extra
parameters.  Let's simplify the API by dropping both parameters and
have everybody use (0%, 2s).

Oh, by the way, the percent-threshold parameter and the structure
member were consistently misspelled, which also is now fixed ;-)

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * So before I forget all about this topic, here is a patch to
   actually do this.

   > So I'd vote to drop that parameter entirely. And if 1 second seems
   > noticeably snappier, then we should probably just move everything to a 1
   > second delay (I don't have a strong feeling either way).

   I was also tempted to do this, but decided to keep it closer to
   the original for majority of callers by leaving the delay at 2s.
   With this patch, such a change as a follow-up is made a lot
   easier (somebody may want to even make a configuration out of it,
   but that would not be me).

 builtin/blame.c        |  3 +--
 builtin/fsck.c         |  2 +-
 builtin/prune-packed.c |  3 +--
 builtin/prune.c        |  2 +-
 builtin/rev-list.c     |  2 +-
 diffcore-rename.c      |  4 ++--
 progress.c             | 15 ++++++++++-----
 progress.h             |  3 +--
 unpack-trees.c         |  3 +--
 9 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index bda1a78726..e0daf17548 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -925,8 +925,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	sb.found_guilty_entry = &found_guilty_entry;
 	sb.found_guilty_entry_data = &pi;
 	if (show_progress)
-		pi.progress = start_progress_delay(_("Blaming lines"),
-						   sb.num_lines, 50, 1);
+		pi.progress = start_delayed_progress(_("Blaming lines"), sb.num_lines);
 
 	assign_blame(&sb, opt);
 
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 99dea7adf6..0031439fc4 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -188,7 +188,7 @@ static int traverse_reachable(void)
 	unsigned int nr = 0;
 	int result = 0;
 	if (show_progress)
-		progress = start_progress_delay(_("Checking connectivity"), 0, 0, 2);
+		progress = start_delayed_progress(_("Checking connectivity"), 0);
 	while (pending.nr) {
 		struct object_array_entry *entry;
 		struct object *obj;
diff --git a/builtin/prune-packed.c b/builtin/prune-packed.c
index ac978ad401..8f41f7c20e 100644
--- a/builtin/prune-packed.c
+++ b/builtin/prune-packed.c
@@ -37,8 +37,7 @@ static int prune_object(const struct object_id *oid, const char *path,
 void prune_packed_objects(int opts)
 {
 	if (opts & PRUNE_PACKED_VERBOSE)
-		progress = start_progress_delay(_("Removing duplicate objects"),
-			256, 95, 2);
+		progress = start_delayed_progress(_("Removing duplicate objects"), 256);
 
 	for_each_loose_file_in_objdir(get_object_directory(),
 				      prune_object, NULL, prune_subdir, &opts);
diff --git a/builtin/prune.c b/builtin/prune.c
index c378690545..cddabf26a9 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -138,7 +138,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	if (show_progress == -1)
 		show_progress = isatty(2);
 	if (show_progress)
-		progress = start_progress_delay(_("Checking connectivity"), 0, 0, 2);
+		progress = start_delayed_progress(_("Checking connectivity"), 0);
 
 	mark_reachable_objects(&revs, 1, expire, progress);
 	stop_progress(&progress);
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 95d84d5cda..dfad8e847a 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -364,7 +364,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		revs.limited = 1;
 
 	if (show_progress)
-		progress = start_progress_delay(show_progress, 0, 0, 2);
+		progress = start_delayed_progress(show_progress, 0);
 
 	if (use_bitmap_index && !revs.prune) {
 		if (revs.count && !revs.left_right && !revs.cherry_mark) {
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 786f389498..0d8c3d2ee4 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -532,9 +532,9 @@ void diffcore_rename(struct diff_options *options)
 	}
 
 	if (options->show_rename_progress) {
-		progress = start_progress_delay(
+		progress = start_delayed_progress(
 				_("Performing inexact rename detection"),
-				rename_dst_nr * rename_src_nr, 50, 1);
+				rename_dst_nr * rename_src_nr);
 	}
 
 	mx = xcalloc(st_mult(NUM_CANDIDATE_PER_DST, num_create), sizeof(*mx));
diff --git a/progress.c b/progress.c
index 73e36d4a42..289678d43d 100644
--- a/progress.c
+++ b/progress.c
@@ -34,7 +34,7 @@ struct progress {
 	unsigned total;
 	unsigned last_percent;
 	unsigned delay;
-	unsigned delayed_percent_treshold;
+	unsigned delayed_percent_threshold;
 	struct throughput *throughput;
 	uint64_t start_ns;
 };
@@ -88,7 +88,7 @@ static int display(struct progress *progress, unsigned n, const char *done)
 			return 0;
 		if (progress->total) {
 			unsigned percent = n * 100 / progress->total;
-			if (percent > progress->delayed_percent_treshold) {
+			if (percent > progress->delayed_percent_threshold) {
 				/* inhibit this progress report entirely */
 				clear_progress_signal();
 				progress->delay = -1;
@@ -205,8 +205,8 @@ int display_progress(struct progress *progress, unsigned n)
 	return progress ? display(progress, n, NULL) : 0;
 }
 
-struct progress *start_progress_delay(const char *title, unsigned total,
-				       unsigned percent_treshold, unsigned delay)
+static struct progress *start_progress_delay(const char *title, unsigned total,
+					     unsigned percent_threshold, unsigned delay)
 {
 	struct progress *progress = malloc(sizeof(*progress));
 	if (!progress) {
@@ -219,7 +219,7 @@ struct progress *start_progress_delay(const char *title, unsigned total,
 	progress->total = total;
 	progress->last_value = -1;
 	progress->last_percent = -1;
-	progress->delayed_percent_treshold = percent_treshold;
+	progress->delayed_percent_threshold = percent_threshold;
 	progress->delay = delay;
 	progress->throughput = NULL;
 	progress->start_ns = getnanotime();
@@ -227,6 +227,11 @@ struct progress *start_progress_delay(const char *title, unsigned total,
 	return progress;
 }
 
+struct progress *start_delayed_progress(const char *title, unsigned total)
+{
+	return start_progress_delay(title, total, 0, 2);
+}
+
 struct progress *start_progress(const char *title, unsigned total)
 {
 	return start_progress_delay(title, total, 0, 0);
diff --git a/progress.h b/progress.h
index 611e4c4d42..6392b63371 100644
--- a/progress.h
+++ b/progress.h
@@ -6,8 +6,7 @@ struct progress;
 void display_throughput(struct progress *progress, off_t total);
 int display_progress(struct progress *progress, unsigned n);
 struct progress *start_progress(const char *title, unsigned total);
-struct progress *start_progress_delay(const char *title, unsigned total,
-				       unsigned percent_treshold, unsigned delay);
+struct progress *start_delayed_progress(const char *title, unsigned total);
 void stop_progress(struct progress **progress);
 void stop_progress_msg(struct progress **progress, const char *msg);
 
diff --git a/unpack-trees.c b/unpack-trees.c
index dd535bc849..e5ae7fe183 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -343,8 +343,7 @@ static struct progress *get_progress(struct unpack_trees_options *o)
 			total++;
 	}
 
-	return start_progress_delay(_("Checking out files"),
-				    total, 50, 1);
+	return start_delayed_progress(_("Checking out files"), total);
 }
 
 static int check_updates(struct unpack_trees_options *o)
-- 
2.14.1-396-gef255185d2


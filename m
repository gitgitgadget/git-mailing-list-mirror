Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 342C820899
	for <e@80x24.org>; Mon, 14 Aug 2017 18:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751196AbdHNSfo (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 14:35:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50524 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750910AbdHNSfm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 14:35:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 584CFAB219;
        Mon, 14 Aug 2017 14:35:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7RWjK9QA8yBZ9juOF1AE1IwCLlY=; b=DycAON
        FMces4/7jJGhDkDyAPRvB/4kSBUKPoN2o3YbQ1t/Pn1GHkJewB34sbti2xzlSajF
        BtfokVrAXPAKxYMhEj3FS2wjZJhiUSDQYDp1PVbzi7Uh82iYcxYesdJCW5yKTiJC
        YTxA0CI2ChtyfXXGHBM51S3Yvf22yQzpuUxSE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MXErJVw8f59geYwFNfcr55Lb0ejXD6eb
        ugslGe2tVMNYrw2nyRfYMpWRUqBTnY2C4ZxeDWvKdo6Fo/zbldLKrXDqqS9ZimQC
        6P9Ma2sKC7LHIeDxEoJ1/76Q+1XdblDt7PQVrZFSsvlLwIXBLjFSm57LfLfpMvHc
        bChwojgpSIA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 50F09AB218;
        Mon, 14 Aug 2017 14:35:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B8231AB216;
        Mon, 14 Aug 2017 14:35:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Kevin Willford <kcwillford@gmail.com>, git@vger.kernel.org,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH v2 1/2] format-patch: have progress option while generating patches
References: <20170531150427.7820-1-kewillf@microsoft.com>
        <20170810183256.12668-2-kewillf@microsoft.com>
        <20170810232033.46ujnozvnodkguog@sigill.intra.peff.net>
        <xmqqwp69ycim.fsf@gitster.mtv.corp.google.com>
        <EA124B72FA7542DBA1C31213235F1B94@PhilipOakley>
        <20170813043940.muj7z3dvl3nh4k6a@sigill.intra.peff.net>
        <xmqqpobyw11t.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 14 Aug 2017 11:35:33 -0700
In-Reply-To: <xmqqpobyw11t.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 14 Aug 2017 09:45:34 -0700")
Message-ID: <xmqqshguuhe2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C2099BA-811F-11E7-8089-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Perhaps we may want to replace the calls to progress_delay() with a
> call to a simpler wrapper that does not let the callers give their
> own delay threashold to simplify the API.

... which does not look too bad, but because it makes me wonder if
we even need to make the delay-threshold customizable per callers,
I'll wait further discussions before committing to the approach.

For example, I do not quite understand why 95 is a good value for
prune-packed while 0 is a good value for prune.  

The rename detection in diffcore-rename, delay in blame, and
checkout (via unpack-trees) all of which use 50-percent threshold
with 1 second delay, sort of make sense to me in that if we
completed 50 percent within 1 second, it is likely we will finish
all in 2 seconds (which is the norm for everybody else), perhaps as
a better version of 0-percent 2 seconds rule.

 builtin/blame.c        |  3 +--
 builtin/fsck.c         |  2 +-
 builtin/prune-packed.c |  4 ++--
 builtin/prune.c        |  2 +-
 builtin/rev-list.c     |  2 +-
 diffcore-rename.c      |  4 ++--
 progress.c             | 10 ++++++++--
 progress.h             |  4 ++--
 unpack-trees.c         |  3 +--
 9 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index bda1a78726..05115900f3 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -925,8 +925,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	sb.found_guilty_entry = &found_guilty_entry;
 	sb.found_guilty_entry_data = &pi;
 	if (show_progress)
-		pi.progress = start_progress_delay(_("Blaming lines"),
-						   sb.num_lines, 50, 1);
+		pi.progress = start_delayed_progress(_("Blaming lines"), sb.num_lines, 50);
 
 	assign_blame(&sb, opt);
 
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 99dea7adf6..6a26079ebc 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -188,7 +188,7 @@ static int traverse_reachable(void)
 	unsigned int nr = 0;
 	int result = 0;
 	if (show_progress)
-		progress = start_progress_delay(_("Checking connectivity"), 0, 0, 2);
+		progress = start_delayed_progress(_("Checking connectivity"), 0, 0);
 	while (pending.nr) {
 		struct object_array_entry *entry;
 		struct object *obj;
diff --git a/builtin/prune-packed.c b/builtin/prune-packed.c
index ac978ad401..4fc6b175de 100644
--- a/builtin/prune-packed.c
+++ b/builtin/prune-packed.c
@@ -37,8 +37,8 @@ static int prune_object(const struct object_id *oid, const char *path,
 void prune_packed_objects(int opts)
 {
 	if (opts & PRUNE_PACKED_VERBOSE)
-		progress = start_progress_delay(_("Removing duplicate objects"),
-			256, 95, 2);
+		progress = start_delayed_progress(_("Removing duplicate objects"),
+						  256, 95);
 
 	for_each_loose_file_in_objdir(get_object_directory(),
 				      prune_object, NULL, prune_subdir, &opts);
diff --git a/builtin/prune.c b/builtin/prune.c
index c378690545..f32adaa0e9 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -138,7 +138,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	if (show_progress == -1)
 		show_progress = isatty(2);
 	if (show_progress)
-		progress = start_progress_delay(_("Checking connectivity"), 0, 0, 2);
+		progress = start_delayed_progress(_("Checking connectivity"), 0, 0);
 
 	mark_reachable_objects(&revs, 1, expire, progress);
 	stop_progress(&progress);
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 95d84d5cda..5cfc4b35f4 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -364,7 +364,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		revs.limited = 1;
 
 	if (show_progress)
-		progress = start_progress_delay(show_progress, 0, 0, 2);
+		progress = start_delayed_progress(show_progress, 0, 0);
 
 	if (use_bitmap_index && !revs.prune) {
 		if (revs.count && !revs.left_right && !revs.cherry_mark) {
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 786f389498..0eafa43618 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -532,9 +532,9 @@ void diffcore_rename(struct diff_options *options)
 	}
 
 	if (options->show_rename_progress) {
-		progress = start_progress_delay(
+		progress = start_delayed_progress(
 				_("Performing inexact rename detection"),
-				rename_dst_nr * rename_src_nr, 50, 1);
+				rename_dst_nr * rename_src_nr, 50);
 	}
 
 	mx = xcalloc(st_mult(NUM_CANDIDATE_PER_DST, num_create), sizeof(*mx));
diff --git a/progress.c b/progress.c
index 73e36d4a42..eeebe15b6f 100644
--- a/progress.c
+++ b/progress.c
@@ -205,8 +205,8 @@ int display_progress(struct progress *progress, unsigned n)
 	return progress ? display(progress, n, NULL) : 0;
 }
 
-struct progress *start_progress_delay(const char *title, unsigned total,
-				       unsigned percent_treshold, unsigned delay)
+static struct progress *start_progress_delay(const char *title, unsigned total,
+					     unsigned percent_treshold, unsigned delay)
 {
 	struct progress *progress = malloc(sizeof(*progress));
 	if (!progress) {
@@ -227,6 +227,12 @@ struct progress *start_progress_delay(const char *title, unsigned total,
 	return progress;
 }
 
+struct progress *start_delayed_progress(const char *title,
+					unsigned total,	unsigned percent_treshold)
+{
+	return start_progress_delay(title, total, percent_treshold, 2);
+}
+
 struct progress *start_progress(const char *title, unsigned total)
 {
 	return start_progress_delay(title, total, 0, 0);
diff --git a/progress.h b/progress.h
index 611e4c4d42..c7fc431989 100644
--- a/progress.h
+++ b/progress.h
@@ -6,8 +6,8 @@ struct progress;
 void display_throughput(struct progress *progress, off_t total);
 int display_progress(struct progress *progress, unsigned n);
 struct progress *start_progress(const char *title, unsigned total);
-struct progress *start_progress_delay(const char *title, unsigned total,
-				       unsigned percent_treshold, unsigned delay);
+struct progress *start_delayed_progress(const char *title, unsigned total,
+					unsigned percent_treshold);
 void stop_progress(struct progress **progress);
 void stop_progress_msg(struct progress **progress, const char *msg);
 
diff --git a/unpack-trees.c b/unpack-trees.c
index dd535bc849..03d1b37578 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -343,8 +343,7 @@ static struct progress *get_progress(struct unpack_trees_options *o)
 			total++;
 	}
 
-	return start_progress_delay(_("Checking out files"),
-				    total, 50, 1);
+	return start_delayed_progress(_("Checking out files"), total, 50);
 }
 
 static int check_updates(struct unpack_trees_options *o)


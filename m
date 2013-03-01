From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v8 4/5] Implement line-history search (git log -L)
Date: Fri, 1 Mar 2013 15:59:21 +0100
Message-ID: <87ppzjxj1y.fsf@pctrast.inf.ethz.ch>
References: <cover.1362069310.git.trast@student.ethz.ch>
	<9af548b2a7e4a4da9eb30e99b0223f20788b4fc1.1362069310.git.trast@student.ethz.ch>
	<7vbob4iaxh.fsf@alter.siamese.dyndns.org>
	<7vmwuogjsm.fsf@alter.siamese.dyndns.org>
	<87vc9b1p48.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Bo Yang <struggleyb.nku@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Will Palmer <wmpalmer@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 01 15:59:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBRR8-0001wV-3a
	for gcvg-git-2@plane.gmane.org; Fri, 01 Mar 2013 15:59:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887Ab3CAO7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Mar 2013 09:59:24 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:38417 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750696Ab3CAO7X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Mar 2013 09:59:23 -0500
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 1 Mar
 2013 15:59:11 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.153.233) by
 CAS21.d.ethz.ch (172.31.51.111) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Fri, 1 Mar 2013 15:59:20 +0100
In-Reply-To: <87vc9b1p48.fsf@pctrast.inf.ethz.ch> (Thomas Rast's message of
	"Fri, 1 Mar 2013 09:49:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217278>

Thomas Rast <trast@student.ethz.ch> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> I notice that "careful and slow" is just "too slow
>> to be usable" even on a small tree like ours.  Try running
>>
>>     $ git log -M -L:get_name:builtin/describe.c
>>
>> and see how long you have to wait until you hit the first line of
>> output.
>
> I'll dig some more.  It *should* be essentially the following times
> taken together:
>
>   $ time git log --raw -M --topo-order >/dev/null
>   real    0m5.448s
[...]
>   $ time git log -L:get_name:builtin/describe.c >/dev/null
>   real    0m0.832s
[...]
>   $ time git log -L:get_name:builtin-describe.c 81b50f3ce40^ >/dev/null
>   real    0m0.489s
[...]
> So I'm losing a factor of about 4 somewhere, which I can't explain right
> now.

It seems I still don't understand half of this code.

log -M --raw in the above somehow appears to use and optimize for
-M100%, whereas the log -L code is currently written for general args.

However, I couldn't pin down where this happens; I only know from call
graph profiling[1] that log -M --raw never goes through diffcore_std().
And indeed according to the same sort of profiling, log -M -L spends
most of its time within diffcore_std() unpacking blobs to find renames.

Even more confusingly, try_to_follow_renames() _does_ call into
diffcore_std, so there seems to be some merit to calling it after all.

With the hacky patch below,  I get something more reasonable:

  $ time ./git-log -M -L:get_name:builtin/describe.c  >/dev/null

  real    0m3.794s
  user    0m3.734s
  sys     0m0.045s

That's compared to about 35s on my machine without the patch.  It still
calls diffcore_std(), but before that it discards all diff pairs except
those affecting the path(s) we're interested in and any deletions (so
that they can be used as rename sources).  After diffcore_std() it
discards all pairs that we're not interested in.

[1]  valgrind --tool=callgrind --trace-children=yes

-- >8 --
Subject: [PATCH] WIP: speed up log -L... -M

---
 line-log.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 54 insertions(+), 4 deletions(-)

diff --git a/line-log.c b/line-log.c
index a74bbaf..b03cc0b 100644
--- a/line-log.c
+++ b/line-log.c
@@ -997,7 +997,52 @@ static void move_diff_queue(struct diff_queue_struct *dst,
 	DIFF_QUEUE_CLEAR(src);
 }
 
-static void queue_diffs(struct diff_options *opt,
+static void filter_diffs_for_paths(struct line_log_data *range, int keep_deletions)
+{
+	int i;
+	struct diff_queue_struct outq;
+	DIFF_QUEUE_CLEAR(&outq);
+
+	/* fprintf(stderr, "-- filtering:\n"); */
+
+	for (i = 0; i < diff_queued_diff.nr; i++) {
+		struct diff_filepair *p = diff_queued_diff.queue[i];
+		struct line_log_data *rg = NULL;
+		/* fprintf(stderr, "%-38s\t%-38s\n", (p->one ? p->one->path : "<none>"), (p->two ? p->two->path : "<none>")); */
+		if (!DIFF_FILE_VALID(p->two)) {
+			if (keep_deletions)
+				diff_q(&outq, p);
+			else
+				diff_free_filepair(p);
+			continue;
+		}
+		for (rg = range; rg; rg = rg->next) {
+			if (!strcmp(rg->spec->path, p->two->path))
+				break;
+		}
+		if (rg)
+			diff_q(&outq, p);
+		else
+			diff_free_filepair(p);
+	}
+	free(diff_queued_diff.queue);
+	diff_queued_diff = outq;
+}
+
+static inline int diff_might_be_rename(void)
+{
+	int i;
+	for (i = 0; i < diff_queued_diff.nr; i++)
+		if (!DIFF_FILE_VALID(diff_queued_diff.queue[i]->one)) {
+			/* fprintf(stderr, "diff_might_be_rename found creation of: %s\n", */
+			/* 	diff_queued_diff.queue[i]->two->path); */
+			return 1;
+		}
+	return 0;
+}
+
+static void queue_diffs(struct line_log_data *range,
+			struct diff_options *opt,
 			struct diff_queue_struct *queue,
 			struct commit *commit, struct commit *parent)
 {
@@ -1013,7 +1058,12 @@ static void queue_diffs(struct diff_options *opt,
 
 	DIFF_QUEUE_CLEAR(&diff_queued_diff);
 	diff_tree(&desc1, &desc2, "", opt);
-	diffcore_std(opt);
+	if (opt->detect_rename) {
+		filter_diffs_for_paths(range, 1);
+		if (diff_might_be_rename())
+			diffcore_std(opt);
+		filter_diffs_for_paths(range, 0);
+	}
 	move_diff_queue(queue, &diff_queued_diff);
 
 	if (tree1)
@@ -1297,7 +1347,7 @@ static int process_ranges_ordinary_commit(struct rev_info *rev, struct commit *c
 	if (commit->parents)
 		parent = commit->parents->item;
 
-	queue_diffs(&rev->diffopt, &queue, commit, parent);
+	queue_diffs(range, &rev->diffopt, &queue, commit, parent);
 	changed = process_all_files(&parent_range, rev, &queue, range);
 	if (parent)
 		add_line_range(rev, parent, parent_range);
@@ -1322,7 +1372,7 @@ static int process_ranges_merge_commit(struct rev_info *rev, struct commit *comm
 	for (i = 0; i < nparents; i++) {
 		parents[i] = p->item;
 		p = p->next;
-		queue_diffs(&rev->diffopt, &diffqueues[i], commit, parents[i]);
+		queue_diffs(range, &rev->diffopt, &diffqueues[i], commit, parents[i]);
 	}
 
 	for (i = 0; i < nparents; i++) {
-- 
1.8.2.rc1.391.g6a988e5.dirty

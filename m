From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] push: Don't push a repository with unpushed
 submodules
Date: Fri, 19 Aug 2011 23:32:51 -0700
Message-ID: <7vippszj70.fsf@alter.siamese.dyndns.org>
References: <1313791728-11328-1-git-send-email-iveqy@iveqy.com>
 <1313791728-11328-2-git-send-email-iveqy@iveqy.com>
 <7vwre9yodc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, hvoigt@hvoigt.net, jens.lehmann@web.de
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Sat Aug 20 08:33:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Quf7B-0002To-O9
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 08:33:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697Ab1HTGcz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Aug 2011 02:32:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58567 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751011Ab1HTGcz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Aug 2011 02:32:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E23632AAD;
	Sat, 20 Aug 2011 02:32:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7+Do9Lfo5OBQ/aM1KKPMftFK38E=; b=vkI0+4
	lVWW14kMBqGOMuoLgaOXtoYQfAhe/AxSx/asIappwDPLCHBpxGj9v9pKxJCocqTW
	f7AtDoxH5cuYyUA7U2AXE6F2tbxe1bcnQZlpLQ+oqqE0JbKMW+sJ/hBglnKWt0qI
	EcuZNn7c1h2eh5PLUfOvMurKvMO8kKDllET4k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TOg/4PI+/7gj3MYxxtvs2c+j+/Ujoe1u
	N35wKqsYwbKMVFPIk5AzEYxtsE9JAM2nq4dLfFoorVgloetshdPmdRTxWHF1TyzC
	yjw304pG1876Ftr5cuKbEN7bqLAgcI5JfTaE6nD54dunOdW8dQwystr5d8qE6i5T
	pYBJNprPXUQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D726A2AAC;
	Sat, 20 Aug 2011 02:32:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 32F7A2AAB; Sat, 20 Aug 2011
 02:32:53 -0400 (EDT)
In-Reply-To: <7vwre9yodc.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 19 Aug 2011 16:26:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3B9FA158-CAF6-11E0-A70A-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179753>

Junio C Hamano <gitster@pobox.com> writes:

> What I meant was more along the lines of the following, but I think we
> would need a new kind of callback that can take N-way parents (which is
> not depicted here).
>
> Let me cook up something and get back to you later tonight.

And here is a two-patch series to do just that.

The first one is meant for you to use, and the second one is a sample
application of the new machinery.

-- >8 --
Subject: [PATCH 1/2] combine-diff: support format_callback

This teaches combine-diff machinery to feed a combined merge to a callback
function when DIFF_FORMAT_CALLBACK is specified.

So far, format callback functions are not used for anything but 2-way
diffs. A callback is given a diff_queue_struct, which is an array of
diff_filepair. As its name suggests, a diff_filepair is a _pair_ of
diff_filespec that represents a single preimage and a single postimage.

Since "diff -c" is to compare N parents with a single merge result and
filter out any paths whose result match one (or more) of the parent(s),
its output has to be able to represent N preimages and 1 postimage. For
this reason, a callback function that inspects a diff_filepair that
results from this new infrastructure can and is expected to view the
preimage side (i.e. pair->one) as an array of diff_filespec. Each element
in the array, except for the last one, is marked with "has_more_entries"
bit, so that the same callback function can be used for 2-way diffs and
combined diffs.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 combine-diff.c |   69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 diffcore.h     |    2 +-
 2 files changed, 70 insertions(+), 1 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 655fa89..de88186 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -970,6 +970,72 @@ void show_combined_diff(struct combine_diff_path *p,
 		show_patch_diff(p, num_parent, dense, rev);
 }
 
+static void free_combined_pair(struct diff_filepair *pair)
+{
+	free(pair->two);
+	free(pair);
+}
+
+/*
+ * A combine_diff_path expresses N parents on the LHS against 1 merge
+ * result. Synthesize a diff_filepair that has N entries on the "one"
+ * side and 1 entry on the "two" side.
+ *
+ * In the future, we might want to add more data to combine_diff_path
+ * so that we can fill fields we are ignoring (most notably, size) here,
+ * but currently nobody uses it, so this should suffice for now.
+ */
+static struct diff_filepair *combined_pair(struct combine_diff_path *p,
+					   int num_parent)
+{
+	int i;
+	struct diff_filepair *pair;
+	struct diff_filespec *pool;
+
+	pair = xmalloc(sizeof(*pair));
+	pool = xcalloc(num_parent + 1, sizeof(struct diff_filespec));
+	pair->one = pool + 1;
+	pair->two = pool;
+
+	for (i = 0; i < num_parent; i++) {
+		pair->one[i].path = p->path;
+		pair->one[i].mode = p->parent[i].mode;
+		hashcpy(pair->one[i].sha1, p->parent[i].sha1);
+		pair->one[i].sha1_valid = !is_null_sha1(p->parent[i].sha1);
+		pair->one[i].has_more_entries = 1;
+	}
+	pair->one[num_parent - 1].has_more_entries = 0;
+
+	pair->two->path = p->path;
+	pair->two->mode = p->mode;
+	hashcpy(pair->two->sha1, p->sha1);
+	pair->two->sha1_valid = !is_null_sha1(p->sha1);
+	return pair;
+}
+
+static void handle_combined_callback(struct diff_options *opt,
+				     struct combine_diff_path *paths,
+				     int num_parent,
+				     int num_paths)
+{
+	struct combine_diff_path *p;
+	struct diff_queue_struct q;
+	int i;
+
+	q.queue = xcalloc(num_paths, sizeof(struct diff_filepair *));
+	q.alloc = num_paths;
+	q.nr = num_paths;
+	for (i = 0, p = paths; p; p = p->next) {
+		if (!p->len)
+			continue;
+		q.queue[i++] = combined_pair(p, num_parent);
+	}
+	opt->format_callback(&q, opt, opt->format_callback_data);
+	for (i = 0; i < num_paths; i++)
+		free_combined_pair(q.queue[i]);
+	free(q.queue);
+}
+
 void diff_tree_combined(const unsigned char *sha1,
 			const unsigned char parent[][20],
 			int num_parent,
@@ -1029,6 +1095,9 @@ void diff_tree_combined(const unsigned char *sha1,
 		else if (opt->output_format &
 			 (DIFF_FORMAT_NUMSTAT|DIFF_FORMAT_DIFFSTAT))
 			needsep = 1;
+		else if (opt->output_format & DIFF_FORMAT_CALLBACK)
+			handle_combined_callback(opt, paths, num_parent, num_paths);
+
 		if (opt->output_format & DIFF_FORMAT_PATCH) {
 			if (needsep)
 				putchar(opt->line_termination);
diff --git a/diffcore.h b/diffcore.h
index b8f1fde..8f32b82 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -45,7 +45,7 @@ struct diff_filespec {
 	unsigned dirty_submodule : 2;  /* For submodules: its work tree is dirty */
 #define DIRTY_SUBMODULE_UNTRACKED 1
 #define DIRTY_SUBMODULE_MODIFIED  2
-
+	unsigned has_more_entries : 1; /* only appear in combined diff */
 	struct userdiff_driver *driver;
 	/* data should be considered "binary"; -1 means "don't know yet" */
 	int is_binary;
-- 
1.7.6.557.gcee42

 

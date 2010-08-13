From: Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG: git log: fatal: internal error in diff-resolve-rename-copy
Date: Fri, 13 Aug 2010 12:12:54 -0700
Message-ID: <7vpqxmjphl.fsf@alter.siamese.dyndns.org>
References: <AANLkTikPhWgeeLBV3dbLZ5UM3UDmkOmpqrmwqPmGfn7Z@mail.gmail.com>
 <7vhbiyl8ji.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Constantine Plotnikov <constantine.plotnikov@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 13 21:13:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ojzgo-0008LA-6U
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 21:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762065Ab0HMTNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Aug 2010 15:13:09 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38046 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754565Ab0HMTNG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 15:13:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C4063CB3F7;
	Fri, 13 Aug 2010 15:13:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0739HovK063gHfDWS0Gh+tv6FwY=; b=rnM29w
	9n70Yrke11JKrcdUhsGUWVpiCQ1SXp6CWFrbXLlEPQn9xY1ofzG1NOxudEM46wTi
	5DlF24oBfipzVijiC671flnuIuYxRIv8uR8+qgAXVNCU8yrEYfzIlzn36NpnLBpK
	IP/ENx5FAJzCZa2zAnCnGboQLUePQ5CTTfMjo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WCAhwz1LFG9eLeXu5NwjjYMffXwhMxhz
	EudyZ8FVddjCED9IZyg3+Usel+38ERuM2WH10cI4s4m0BloZVrpiho/+fe7vSGmv
	EjUY+Bb0XYtw8qNL94UqHO5QnhHspRDnVRXESQGsg9Yvu8C55AA2QZpQJd5y/jq5
	S00WkFmJdsQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F4DECB3F5;
	Fri, 13 Aug 2010 15:13:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 05D43CB3E5; Fri, 13 Aug
 2010 15:12:55 -0400 (EDT)
In-Reply-To: <7vhbiyl8ji.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri\, 13 Aug 2010 10\:36\:01 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CA867192-A70E-11DF-92D7-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153486>

Junio C Hamano <gitster@pobox.com> writes:

> Constantine Plotnikov <constantine.plotnikov@gmail.com> writes:
>
>> Somewhere between the git 1.7.0.2 and the git 1.7.2.0 the rename
>> detection started to fail with fatal error on some files in our
>> repository. The bug could be seen on the public IntelliJ IDEA
>> repository (about 760M in size), but our users have reported it as
>> well.
> ...
> But what 1da6175 (Make diffcore_std only can run once before a diff_flush,
> 2010-05-06) did is clearly wrong.  Not wanting to call resolve-rename-copy
> does not mean we do not want to run the rest of what diffcore_std() does
> at all!  For example, "-S" and "--diff-filter=" options are processed in
> that function; the exit status of the command based on the presense of
> difference is computed in the function, too.

This reverts 1da6175 (Make diffcore_std only can run once before a
diff_flush, 2010-05-06) and replaces it with an uglier looking but
hopefully correct fix.

Constantine, does it fix your issue?

 diff.c      |   27 +++++++++++++--------------
 diff.h      |    3 +++
 diffcore.h  |    2 --
 tree-diff.c |   12 ++++++++++++
 4 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/diff.c b/diff.c
index bf65892..9300492 100644
--- a/diff.c
+++ b/diff.c
@@ -4064,25 +4064,24 @@ void diffcore_fix_diff_index(struct diff_options *options)
 
 void diffcore_std(struct diff_options *options)
 {
-	/* We never run this function more than one time, because the
-	 * rename/copy detection logic can only run once.
-	 */
-	if (diff_queued_diff.run)
-		return;
-
 	if (options->skip_stat_unmatch)
 		diffcore_skip_stat_unmatch(options);
-	if (options->break_opt != -1)
-		diffcore_break(options->break_opt);
-	if (options->detect_rename)
-		diffcore_rename(options);
-	if (options->break_opt != -1)
-		diffcore_merge_broken();
+	if (!options->found_follow) {
+		/* See try_to_follow_renames() in tree-diff.c */
+		if (options->break_opt != -1)
+			diffcore_break(options->break_opt);
+		if (options->detect_rename)
+			diffcore_rename(options);
+		if (options->break_opt != -1)
+			diffcore_merge_broken();
+	}
 	if (options->pickaxe)
 		diffcore_pickaxe(options->pickaxe, options->pickaxe_opts);
 	if (options->orderfile)
 		diffcore_order(options->orderfile);
-	diff_resolve_rename_copy();
+	if (!options->found_follow)
+		/* See try_to_follow_renames() in tree-diff.c */
+		diff_resolve_rename_copy();
 	diffcore_apply_filter(options->filter);
 
 	if (diff_queued_diff.nr && !DIFF_OPT_TST(options, DIFF_FROM_CONTENTS))
@@ -4090,7 +4089,7 @@ void diffcore_std(struct diff_options *options)
 	else
 		DIFF_OPT_CLR(options, HAS_CHANGES);
 
-	diff_queued_diff.run = 1;
+	options->found_follow = 0;
 }
 
 int diff_result_code(struct diff_options *opt, int status)
diff --git a/diff.h b/diff.h
index 063d10a..6fff024 100644
--- a/diff.h
+++ b/diff.h
@@ -126,6 +126,9 @@ struct diff_options {
 	/* this is set by diffcore for DIFF_FORMAT_PATCH */
 	int found_changes;
 
+	/* to support internal diff recursion by --follow hack*/
+	int found_follow;
+
 	FILE *file;
 	int close_file;
 
diff --git a/diffcore.h b/diffcore.h
index 05ebc11..8b3241a 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -91,13 +91,11 @@ struct diff_queue_struct {
 	struct diff_filepair **queue;
 	int alloc;
 	int nr;
-	int run;
 };
 #define DIFF_QUEUE_CLEAR(q) \
 	do { \
 		(q)->queue = NULL; \
 		(q)->nr = (q)->alloc = 0; \
-		(q)->run = 0; \
 	} while (0)
 
 extern struct diff_queue_struct diff_queued_diff;
diff --git a/tree-diff.c b/tree-diff.c
index 5b68c08..293cc91 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -350,6 +350,7 @@ static void try_to_follow_renames(struct tree_desc *t1, struct tree_desc *t2, co
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diff_opts.single_follow = opt->paths[0];
 	diff_opts.break_opt = opt->break_opt;
+
 	paths[0] = NULL;
 	diff_tree_setup_paths(paths, &diff_opts);
 	if (diff_setup_done(&diff_opts) < 0)
@@ -359,6 +360,7 @@ static void try_to_follow_renames(struct tree_desc *t1, struct tree_desc *t2, co
 	diff_tree_release_paths(&diff_opts);
 
 	/* Go through the new set of filepairing, and see if we find a more interesting one */
+	opt->found_follow = 0;
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 
@@ -376,6 +378,16 @@ static void try_to_follow_renames(struct tree_desc *t1, struct tree_desc *t2, co
 			diff_tree_release_paths(opt);
 			opt->paths[0] = xstrdup(p->one->path);
 			diff_tree_setup_paths(opt->paths, opt);
+
+			/*
+			 * The caller expects us to return a set of vanilla
+			 * filepairs to let a later call to diffcore_std()
+			 * it makes to sort the renames out (among other
+			 * things), but we already have found renames
+			 * ourselves; signal diffcore_std() not to muck with
+			 * rename information.
+			 */
+			opt->found_follow = 1;
 			break;
 		}
 	}

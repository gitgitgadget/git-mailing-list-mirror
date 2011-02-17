From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-gui: give more advice when detaching HEAD
Date: Thu, 17 Feb 2011 15:13:27 -0800
Message-ID: <7vvd0i8dbc.fsf@alter.siamese.dyndns.org>
References: <20110212070538.GA2459@sigill.intra.peff.net>
 <7v8vxlzojs.fsf@alter.siamese.dyndns.org>
 <20110212080456.GA18380@sigill.intra.peff.net>
 <7vzkq1y8dv.fsf@alter.siamese.dyndns.org>
 <20110212082108.GA19656@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 18 00:13:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqD2f-00029r-Mc
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 00:13:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755976Ab1BQXNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 18:13:41 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44411 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752807Ab1BQXNk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 18:13:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A349C48E0;
	Thu, 17 Feb 2011 18:14:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=685ifRjgypE1z8xACuvBnSNp6l8=; b=sMVKxc
	gvAgd2Fhuj1lc1fFJQKBAI6nxHMN51eLDWWHl+6+XCdQ/noASULtkfKaUR+3nAcK
	WOFmWdGoWPIH1WFzAh2bDVXJ4th39s7ntpql9t+yJbv4HUfIAN0/HivziUzH9ev3
	RqKgow72L+W5ZNkR0W97RXOViy47wXcCr74bQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fn0Dcy9jx93iSjmg3vuMLh8rSKrYigSN
	OVa0AsZajYD+HWYZ0bSw4O6YxE7xrYWatDaOpvLZZgzu7FvuR+QsAUTrlYtiHVj7
	BSNKWj8by0K+YAjSdy12pFQvxZAyxnzdAeICsF56RCnWBj7cokAdki2G4rDoCXjR
	VzkrZQnumnw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 711F048DF;
	Thu, 17 Feb 2011 18:14:41 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 963D448DE; Thu, 17 Feb 2011
 18:14:36 -0500 (EST)
In-Reply-To: <20110212082108.GA19656@sigill.intra.peff.net> (Jeff King's
 message of "Sat\, 12 Feb 2011 03\:21\:08 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B2C0A05C-3AEB-11E0-9CAC-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167133>

Jeff King <peff@peff.net> writes:

> Want to do a proof-of-concept patch? Then we can get some real timings.

This was about 

> >   2. When leaving the detached state, notice that we have commits not
> >      contained in any other ref and pop up an "are you sure you want to
> >      lose these commits" dialog, with an option to create a branch. This
> >      is something we considered and rejected for the CLI, but I wonder
> >      if it makes more sense for git-gui.

I thought about counting remaining commits, but decided against it.  The
cost has already paid (the "limited" traversal already has happend), so it
may not be too bad to show each of them in oneline format if somebody
really wanted to to tell the user "here are the stuff you are about to
lose".

Also it might make sense to have a training wheel option of forcing
"checkout -f branch-I-wanted-to-go" in this case as an extra safety valve,
and it would be even Ok to enable the training wheel by default, as long
as annoyed experts can turn it off via configuration.

 builtin/checkout.c |   66 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 60 insertions(+), 6 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index cd7f56e..1f5376f 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -503,6 +503,17 @@ static void detach_advice(const char *old_path, const char *new_name)
 	fprintf(stderr, fmt, new_name);
 }
 
+static void suggest_reattach(struct commit *commit)
+{
+	const char fmt[] =
+	"Note: you are about to abandon commit %1$s\n\n"
+	"None of your branches nor tags refer to this commit. If you want to\n"
+	"keep this commit, you can do so by creating a new branch. Example:\n\n"
+	" git branch new_branch_name %1$s\n\n";
+
+	fprintf(stderr, fmt, sha1_to_hex(commit->object.sha1));
+}
+
 static void update_refs_for_switch(struct checkout_opts *opts,
 				   struct branch_info *old,
 				   struct branch_info *new)
@@ -578,6 +589,54 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 		report_tracking(new);
 }
 
+struct rev_list_args {
+	int argc;
+	int alloc;
+	const char **argv;
+};
+
+static void add_one_rev_list_arg(struct rev_list_args *args, const char *s)
+{
+	ALLOC_GROW(args->argv, args->argc + 1, args->alloc);
+	args->argv[args->argc++] = s;
+}
+
+static int add_one_ref_to_rev_list_arg(const char *refname,
+				       const unsigned char *sha1,
+				       int flags,
+				       void *cb_data)
+{
+	add_one_rev_list_arg(cb_data, refname);
+	return 0;
+}
+
+/*
+ * We are about to leave commit that was at the tip of a detached
+ * HEAD.  If it is not reachable from any ref, this is the last chance
+ * for the user to do so without resorting to reflog.
+ */
+static void orphaned_commit_warning(struct commit *commit)
+{
+	struct rev_list_args args = { 0, 0, NULL };
+	struct rev_info revs;
+
+	add_one_rev_list_arg(&args, "(internal)");
+	add_one_rev_list_arg(&args, sha1_to_hex(commit->object.sha1));
+	add_one_rev_list_arg(&args, "--not");
+	for_each_ref(add_one_ref_to_rev_list_arg, &args);
+	add_one_rev_list_arg(&args, "--");
+	add_one_rev_list_arg(&args, NULL);
+
+	init_revisions(&revs, NULL);
+	if (setup_revisions(args.argc - 1, args.argv, &revs, NULL) != 1)
+		die("internal error: only -- alone should have been left");
+	if (prepare_revision_walk(&revs))
+		die("internal error in revision walk");
+	if (!(commit->object.flags & UNINTERESTING))
+		suggest_reattach(commit);
+	describe_detached_head("Previous HEAD position was", commit);
+}
+
 static int switch_branches(struct checkout_opts *opts, struct branch_info *new)
 {
 	int ret = 0;
@@ -605,13 +664,8 @@ static int switch_branches(struct checkout_opts *opts, struct branch_info *new)
 	if (ret)
 		return ret;
 
-	/*
-	 * If we were on a detached HEAD, but have now moved to
-	 * a new commit, we want to mention the old commit once more
-	 * to remind the user that it might be lost.
-	 */
 	if (!opts->quiet && !old.path && old.commit && new->commit != old.commit)
-		describe_detached_head("Previous HEAD position was", old.commit);
+		orphaned_commit_warning(old.commit);
 
 	update_refs_for_switch(opts, &old, new);
 

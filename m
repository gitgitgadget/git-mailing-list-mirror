From: Junio C Hamano <gitster@pobox.com>
Subject: Re: get upstream branch
Date: Mon, 08 Dec 2008 21:35:08 -0800
Message-ID: <7vljup6hdf.fsf@gitster.siamese.dyndns.org>
References: <3ab397d0812082052j6a45d05dr1c863aa260826f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jeff Whiteside" <jeff.m.whiteside@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 09 06:36:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9vH0-0006mo-1D
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 06:36:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbYLIFfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 00:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbYLIFfQ
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 00:35:16 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44946 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880AbYLIFfP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 00:35:15 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5614E85E21;
	Tue,  9 Dec 2008 00:35:13 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2E93785E20; Tue,
  9 Dec 2008 00:35:10 -0500 (EST)
In-Reply-To: <3ab397d0812082052j6a45d05dr1c863aa260826f4@mail.gmail.com>
 (Jeff Whiteside's message of "Mon, 8 Dec 2008 20:52:03 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 26E5F3FC-C5B3-11DD-86D9-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102597>

"Jeff Whiteside" <jeff.m.whiteside@gmail.com> writes:

> Does anyone know how to programmatically get the upstream/parent
> branch of a branch?

I do not think there is any plumbing facility to get that information, as
such "upstream/parent" concept did not exist back then when building the
whole Porcelain by scripting was the norm.

This should give "git branch -v -v it" to show the remote tracking
branch that is merged when "git pull" without any other parameters is
issued while on branch "it".

Obviously untested.

 builtin-branch.c |   26 +++++++++++++++-----------
 1 files changed, 15 insertions(+), 11 deletions(-)

diff --git c/builtin-branch.c w/builtin-branch.c
index 494cbac..565d99c 100644
--- c/builtin-branch.c
+++ w/builtin-branch.c
@@ -279,11 +279,15 @@ static int ref_cmp(const void *r1, const void *r2)
 	return strcmp(c1->name, c2->name);
 }
 
-static void fill_tracking_info(struct strbuf *stat, const char *branch_name)
+static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
+			       int verbosity)
 {
 	int ours, theirs;
 	struct branch *branch = branch_get(branch_name);
 
+	if (verbosity > 1 && branch->merge[0]->dst)
+		strbuf_addf(stat, "(follows %s) ", branch->merge[0]->dst);
+
 	if (!stat_tracking_info(branch, &ours, &theirs) || (!ours && !theirs))
 		return;
 	if (!ours)
@@ -305,7 +309,7 @@ static int matches_merge_filter(struct commit *commit)
 	return (is_merged == (merge_filter == SHOW_MERGED));
 }
 
-static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
+static void print_ref_item(struct ref_item *item, int maxwidth, int verbosity,
 			   int abbrev, int current)
 {
 	char c;
@@ -333,7 +337,7 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 		color = COLOR_BRANCH_CURRENT;
 	}
 
-	if (verbose) {
+	if (verbosity > 0) {
 		struct strbuf subject = STRBUF_INIT, stat = STRBUF_INIT;
 		const char *sub = " **** invalid ref ****";
 
@@ -345,7 +349,7 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 		}
 
 		if (item->kind == REF_LOCAL_BRANCH)
-			fill_tracking_info(&stat, item->name);
+			fill_tracking_info(&stat, item->name, verbosity);
 
 		printf("%c %s%-*s%s %s %s%s\n", c, branch_get_color(color),
 		       maxwidth, item->name,
@@ -373,7 +377,7 @@ static int calc_maxwidth(struct ref_list *refs)
 	return w;
 }
 
-static void print_ref_list(int kinds, int detached, int verbose, int abbrev, struct commit_list *with_commit)
+static void print_ref_list(int kinds, int detached, int verbosity, int abbrev, struct commit_list *with_commit)
 {
 	int i;
 	struct ref_list ref_list;
@@ -393,7 +397,7 @@ static void print_ref_list(int kinds, int detached, int verbose, int abbrev, str
 				   (struct object *) filter, "");
 		ref_list.revs.limited = 1;
 		prepare_revision_walk(&ref_list.revs);
-		if (verbose)
+		if (verbosity > 0)
 			ref_list.maxwidth = calc_maxwidth(&ref_list);
 	}
 
@@ -407,7 +411,7 @@ static void print_ref_list(int kinds, int detached, int verbose, int abbrev, str
 		item.commit = head_commit;
 		if (strlen(item.name) > ref_list.maxwidth)
 			ref_list.maxwidth = strlen(item.name);
-		print_ref_item(&item, ref_list.maxwidth, verbose, abbrev, 1);
+		print_ref_item(&item, ref_list.maxwidth, verbosity, abbrev, 1);
 		free(item.name);
 	}
 
@@ -415,7 +419,7 @@ static void print_ref_list(int kinds, int detached, int verbose, int abbrev, str
 		int current = !detached &&
 			(ref_list.list[i].kind == REF_LOCAL_BRANCH) &&
 			!strcmp(ref_list.list[i].name, head);
-		print_ref_item(&ref_list.list[i], ref_list.maxwidth, verbose,
+		print_ref_item(&ref_list.list[i], ref_list.maxwidth, verbosity,
 			       abbrev, current);
 	}
 
@@ -498,7 +502,7 @@ static int opt_parse_merge_filter(const struct option *opt, const char *arg, int
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
 	int delete = 0, rename = 0, force_create = 0;
-	int verbose = 0, abbrev = DEFAULT_ABBREV, detached = 0;
+	int verbosity = 0, abbrev = DEFAULT_ABBREV, detached = 0;
 	int reflog = 0;
 	enum branch_track track;
 	int kinds = REF_LOCAL_BRANCH;
@@ -506,7 +510,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 	struct option options[] = {
 		OPT_GROUP("Generic options"),
-		OPT__VERBOSE(&verbose),
+		OPT__VERBOSITY(&verbosity),
 		OPT_SET_INT( 0 , "track",  &track, "set up tracking mode (see git-pull(1))",
 			BRANCH_TRACK_EXPLICIT),
 		OPT_BOOLEAN( 0 , "color",  &branch_use_color, "use colored output"),
@@ -577,7 +581,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (delete)
 		return delete_branches(argc, argv, delete > 1, kinds);
 	else if (argc == 0)
-		print_ref_list(kinds, detached, verbose, abbrev, with_commit);
+		print_ref_list(kinds, detached, verbosity, abbrev, with_commit);
 	else if (rename && (argc == 1))
 		rename_branch(head, argv[0], rename > 1);
 	else if (rename && (argc == 2))

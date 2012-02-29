From: Junio C Hamano <gitster@pobox.com>
Subject: Re: filtering out mode-change-only changes
Date: Wed, 29 Feb 2012 14:17:39 -0800
Message-ID: <7v7gz5s2rg.fsf@alter.siamese.dyndns.org>
References: <jik2le$2lb$1@dough.gmane.org>
 <7vmx82wbmr.fsf@alter.siamese.dyndns.org>
 <7vipiqwb2g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Neal Kreitzinger" <neal@rsss.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 29 23:18:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2rqV-00021s-18
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 23:18:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257Ab2B2WR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 17:17:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40758 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932240Ab2B2WRo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 17:17:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D875865E8;
	Wed, 29 Feb 2012 17:17:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vLWydWvKZ3NUj993G7fnzrqtU6Y=; b=Ln5cf5
	BUOgNg1ZaoruWAbycPkOAhVfSUQk3LzHHx+igCl3tzTv7U4BgN4W/4FWiHG8rc9H
	dqZF2NVSPlXmS8qzrTTpdcevcV5dwJZ+4T2UKTBqwbA4DiyxTMLhSluSLsm9IxVH
	T9nJZ0RO+byk6fEmYfAj+MY+6Egk6y64Cf7KE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nfESXkVlabqL4RTnIDshRpK7yzJAeyIE
	Zlhp2E0GorlJkmmha5w3cWwtX3/HF2+WDkWnCqcM4YuV8R9rbQUa6ptOWVGlZe5a
	elteb3WGit+qPCRB9mpDgFgbae7GJx15/w8YtMU00lEnaU1O+qE+wLbCXrjR7zMu
	MygURFN5ebU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D116A65E7;
	Wed, 29 Feb 2012 17:17:42 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ECDDD65E1; Wed, 29 Feb 2012
 17:17:40 -0500 (EST)
In-Reply-To: <7vipiqwb2g.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 28 Feb 2012 19:52:23 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 31E3629C-6323-11E1-8A03-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191861>

Junio C Hamano <gitster@pobox.com> writes:

> Having said that, if we _were_ to do this built-in, an obvious logical
> place to do so is to define a new DIFF_OPT_IGNORE_EXECUTABLE_BIT, teach
> "--ignore-executable-bit" command line option to diff_opt_parse(), and
> then teach diff_resolve_rename_copy() to consider this bit when the code
> originally set DIFF_STATUS_MODIFIED.  Instead, the updated code that is
> working under --ignore-executable-bit option would drop such a filepair
> from diff_queued_diff.

A patch to do so may look like this (untested, of course).  A few things
to note on the changes:

 - The "header" strbuf holds the lines starting from "diff --git" and the
   meta-information lines such as mode change, similarity, etc.  It is
   passed to the the interface code fn_out_consume() via the xdiff
   machinery when an actual diff is found and emitted before the first
   hunk of the diff.

 - The must_show_header toggle is set at the strategic places when
   information is added to the "header" strbuf that makes the output for
   this filepair a must, even if it turns out that xdiff machinery does
   not find any content changes.  Before this patch, we flipped this
   toggle when we noticed a mode change, so that the header is shown even
   if there is no content change. The patch has to make make it
   conditional, which is what the first hunk is about.

 - The second hunk is not related but I think it is a worthy bit-rot fix.
   The original code before "must_show_header" was introduced showed the
   header upfront unless we are ignoring any whitespace changes, the
   reasoning behind it being that two different blobs may produce no patch
   under --ignore-space-change and in such a case we do not want to show
   anything for the filepair.  When 296c6bb (diff: fix "git show -C -C"
   output when renaming a binary file, 2010-05-26) introduced
   "must_show_header", it retained that logic.

   But I think it was a mistake.  If xdiff machinery decides there is no
   patch to show, taking the --ignore-space-change into account, our
   fn_out_consume() won't be called so we won't show the header
   unnecessarily.  And when we do see a line of patch, fn_out_consume()
   will show the header.



 diff.c |   31 +++++++++++++++++++++++++++++--
 diff.h |    1 +
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
old mode 100644
new mode 100755
diff --git a/diff.c b/diff.c
index a1c06b5..acf7232 100644
--- a/diff.c
+++ b/diff.c
@@ -2152,7 +2152,8 @@ static void builtin_diff(const char *name_a,
 		if (one->mode != two->mode) {
 			strbuf_addf(&header, "%s%sold mode %06o%s\n", line_prefix, set, one->mode, reset);
 			strbuf_addf(&header, "%s%snew mode %06o%s\n", line_prefix, set, two->mode, reset);
-			must_show_header = 1;
+			if (!DIFF_OPT_TST(o, IGNORE_MODE_CHANGE))
+				must_show_header = 1;
 		}
 		if (xfrm_msg)
 			strbuf_addstr(&header, xfrm_msg);
@@ -2207,7 +2208,7 @@ static void builtin_diff(const char *name_a,
 		struct emit_callback ecbdata;
 		const struct userdiff_funcname *pe;
 
-		if (!DIFF_XDL_TST(o, WHITESPACE_FLAGS) || must_show_header) {
+		if (must_show_header) {
 			fprintf(o->file, "%s", header.buf);
 			strbuf_reset(&header);
 		}
@@ -3446,6 +3447,8 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	}
 	else if (!strcmp(arg, "--no-renames"))
 		options->detect_rename = 0;
+	else if (!strcmp(arg, "--ignore-mode-change"))
+		DIFF_OPT_SET(options, IGNORE_MODE_CHANGE);
 	else if (!strcmp(arg, "--relative"))
 		DIFF_OPT_SET(options, RELATIVE_NAME);
 	else if (!prefixcmp(arg, "--relative=")) {
@@ -4509,10 +4512,34 @@ void diffcore_fix_diff_index(struct diff_options *options)
 	qsort(q->queue, q->nr, sizeof(q->queue[0]), diffnamecmp);
 }
 
+static void diffcore_ignore_mode_change(struct diff_options *diffopt)
+{
+	int i;
+	struct diff_queue_struct *q = &diff_queued_diff;
+	struct diff_queue_struct outq;
+	DIFF_QUEUE_CLEAR(&outq);
+
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+
+		if (DIFF_FILE_VALID(p->one) &&
+		    DIFF_FILE_VALID(p->two) &&
+		    (p->one->sha1_valid && p->two->sha1_valid) &&
+		    !hashcmp(p->one->sha1, p->two->sha1))
+			diff_free_filepair(p); /* skip this */
+		else
+			diff_q(&outq, p);
+	}
+	free(q->queue);
+	*q = outq;
+}
+
 void diffcore_std(struct diff_options *options)
 {
 	if (options->skip_stat_unmatch)
 		diffcore_skip_stat_unmatch(options);
+	if (DIFF_OPT_TST(options, IGNORE_MODE_CHANGE))
+		diffcore_ignore_mode_change(options);
 	if (!options->found_follow) {
 		/* See try_to_follow_renames() in tree-diff.c */
 		if (options->break_opt != -1)
diff --git a/diff.h b/diff.h
index 7af5f1e..fabcc96 100644
--- a/diff.h
+++ b/diff.h
@@ -82,6 +82,7 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
 #define DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG (1 << 27)
 #define DIFF_OPT_DIRSTAT_BY_LINE     (1 << 28)
 #define DIFF_OPT_FUNCCONTEXT         (1 << 29)
+#define DIFF_OPT_IGNORE_MODE_CHANGE  (1 << 30)
 
 #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
 #define DIFF_OPT_SET(opts, flag)    ((opts)->flags |= DIFF_OPT_##flag)

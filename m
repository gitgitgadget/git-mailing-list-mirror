From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] combine-diff: use diff_opts->a_prefix
Date: Wed, 26 Dec 2007 16:57:49 -0800
Message-ID: <7vodcdkl82.fsf@gitster.siamese.dyndns.org>
References: <477109A5.9040000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Salikh Zakirov <salikh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 27 01:58:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J7h51-000118-4t
	for gcvg-git-2@gmane.org; Thu, 27 Dec 2007 01:58:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746AbXL0A6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2007 19:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751698AbXL0A6F
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Dec 2007 19:58:05 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49790 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127AbXL0A6E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2007 19:58:04 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D2D4AAE8;
	Wed, 26 Dec 2007 19:57:59 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8354EAAE6;
	Wed, 26 Dec 2007 19:57:55 -0500 (EST)
In-Reply-To: <477109A5.9040000@gmail.com> (Salikh Zakirov's message of "Tue,
	25 Dec 2007 22:46:13 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69253>

Salikh Zakirov <salikh@gmail.com> writes:

> The introduction of configurable dir prefix for diff headers in commit
> eab9a40b 'Teach diff machinery to display other prefixes than "a/" and "b/"'
> missed combined diff generation.
>
> Signed-off-by: Salikh Zakirov <salikh@gmail.com>
> ---
>
> I realize that this fix is ugly, so I am all ears for a suggestion
> of a better fix.

It is not so ugly, but I think the original code is broken wrt
its calling of quote_c_style().  It will output "a/" literally
and then would spit out the path with quoting.  IOW, you would
get something like:

	--- a/"foo\tbar"
        +++ b/"foo\tbar"

when it should show:

	--- "a/foo\tbar"
        +++ "b/foo\tbar"

Incidentally, I just noticed that diff.c::emit_rewrite_diff()
has the same bug.

Here is a fix to combine-diff.c

-- >8 -- 
[PATCH] combine-diff: Fix path quoting

Earlier when showing combined diff, the filenames on the ---/+++
header lines were quoted incorrectly.  a/ (or b/) prefix was
output literally and then the path was output, with c-quoting.

This fixes the quoting logic, and while at it, adjusts the code
to use the customizable prefix (a_prefix and b_prefix)
introduced recently.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 combine-diff.c |   41 +++++++++++++++++++++++++++++++----------
 1 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index e22db89..7d71033 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -646,12 +646,28 @@ static void reuse_combine_diff(struct sline *sline, unsigned long cnt,
 	sline->p_lno[i] = sline->p_lno[j];
 }
 
-static void dump_quoted_path(const char *prefix, const char *path,
+static void dump_quoted_path(const char *head,
+			     const char *prefix,
+			     const char *path,
 			     const char *c_meta, const char *c_reset)
 {
-	printf("%s%s", c_meta, prefix);
-	quote_c_style(path, NULL, stdout, 0);
-	printf("%s\n", c_reset);
+	static struct strbuf buf = STRBUF_INIT;
+
+	strbuf_reset(&buf);
+	strbuf_addstr(&buf, c_meta);
+	strbuf_addstr(&buf, head);
+	if (quote_c_style(prefix, NULL, NULL, 0) ||
+	    quote_c_style(path, NULL, NULL, 0)) {
+		strbuf_addch(&buf, '"');
+		quote_c_style(prefix, &buf, NULL, 1);
+		quote_c_style(path, &buf, NULL, 1);
+		strbuf_addch(&buf, '"');
+	} else {
+		strbuf_addstr(&buf, prefix);
+		strbuf_addstr(&buf, path);
+	}
+	strbuf_addstr(&buf, c_reset);
+	puts(buf.buf);
 }
 
 static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
@@ -793,7 +809,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 		if (rev->loginfo && !rev->no_commit_id)
 			show_log(rev, opt->msg_sep);
 		dump_quoted_path(dense ? "diff --cc " : "diff --combined ",
-				 elem->path, c_meta, c_reset);
+				 "", elem->path, c_meta, c_reset);
 		printf("%sindex ", c_meta);
 		for (i = 0; i < num_parent; i++) {
 			abb = find_unique_abbrev(elem->parent[i].sha1,
@@ -829,14 +845,19 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			printf("%s\n", c_reset);
 		}
 		if (added)
-			dump_quoted_path("--- /dev/", "null", c_meta, c_reset);
+			dump_quoted_path("--- ", "", "/dev/null",
+					 c_meta, c_reset);
 		else
-			dump_quoted_path("--- a/", elem->path, c_meta, c_reset);
+			dump_quoted_path("--- ", opt->a_prefix, elem->path,
+					 c_meta, c_reset);
 		if (deleted)
-			dump_quoted_path("+++ /dev/", "null", c_meta, c_reset);
+			dump_quoted_path("+++ ", "", "/dev/null",
+					 c_meta, c_reset);
 		else
-			dump_quoted_path("+++ b/", elem->path, c_meta, c_reset);
-		dump_sline(sline, cnt, num_parent, DIFF_OPT_TST(opt, COLOR_DIFF));
+			dump_quoted_path("+++ ", opt->b_prefix, elem->path,
+					 c_meta, c_reset);
+		dump_sline(sline, cnt, num_parent,
+			   DIFF_OPT_TST(opt, COLOR_DIFF));
 	}
 	free(result);
 
-- 
1.5.4.rc1.23.g3a969

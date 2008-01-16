From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] Do not show "diff --git" metainfo with --no-prefix
Date: Tue, 15 Jan 2008 18:08:54 -0800
Message-ID: <7v7iiabjyh.fsf_-_@gitster.siamese.dyndns.org>
References: <c0f2d4110801150559x155ffabaj6bea52715522a070@mail.gmail.com>
	<alpine.DEB.1.00.0801151444180.5289@eeepc-johanness>
	<c0f2d4110801150758t68714570y83e1e74acbb67325@mail.gmail.com>
	<alpine.LNX.1.00.0801151728120.13593@iabervon.org>
	<7vhched3kw.fsf@gitster.siamese.dyndns.org>
	<7v4pded1rk.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Ortman <chrisortman@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jan 16 03:09:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JExim-000221-Qi
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 03:09:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbYAPCJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 21:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbYAPCJL
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 21:09:11 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49069 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220AbYAPCJK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 21:09:10 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D2DB081FD;
	Tue, 15 Jan 2008 21:09:08 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id BB54981A7;
	Tue, 15 Jan 2008 21:09:01 -0500 (EST)
In-Reply-To: <7v4pded1rk.fsf_-_@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 15 Jan 2008 16:58:55 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70603>

If a non-standard prefix is used by --no-prefix, --src-prefix,
or --dst-prefix options, the resulting diff becomes something
git-apply would not grok.  In such a case, we should not trigger
the more strict check git-apply does for patches in "diff --git"
format.

This checks the prefix specified when generating diff.  If src
and dst prefix are not one-level of directory name followed by a
slash (i.e. the standard "diff --git a/foo b/foo" is fine, a
custom "diff --git l/foo k/foo" is Ok, but "diff --git foo foo"
is NOT Ok), we are generating with a custom prefix that would
fail git-apply's stricter check.  In such a case, we do not say
"diff --git" but just say "diff" in the header.

Metainformation (e.g. "index", "similarity", etc.) lines will
safely be ignored by patch and git-apply (even when the latter
parses a non-git diff output), so this patch does not bother
stripping them away.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I am signing this off, but I am not thinking straight today
   and did not test it, so I will not commit it for now and
   leave it in the list archive, to be commented on.

 diff.c |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index b18c140..8321492 100644
--- a/diff.c
+++ b/diff.c
@@ -1233,6 +1233,18 @@ static const char *diff_funcname_pattern(struct diff_filespec *one)
 	return NULL;
 }
 
+static int with_standard_prefix(struct diff_options *o)
+{
+	const char *slash;
+	slash = strchr(o->a_prefix, '/');
+	if (!slash || slash[1])
+		return 0;
+	slash = strchr(o->b_prefix, '/');
+	if (!slash || slash[1])
+		return 0;
+	return 1;
+}
+
 static void builtin_diff(const char *name_a,
 			 const char *name_b,
 			 struct diff_filespec *one,
@@ -1246,12 +1258,15 @@ static void builtin_diff(const char *name_a,
 	char *a_one, *b_two;
 	const char *set = diff_get_color_opt(o, DIFF_METAINFO);
 	const char *reset = diff_get_color_opt(o, DIFF_RESET);
+	const char *gitdiff;
+
+	gitdiff = with_standard_prefix(o) ? " --git" : "";
 
 	a_one = quote_two(o->a_prefix, name_a + (*name_a == '/'));
 	b_two = quote_two(o->b_prefix, name_b + (*name_b == '/'));
 	lbl[0] = DIFF_FILE_VALID(one) ? a_one : "/dev/null";
 	lbl[1] = DIFF_FILE_VALID(two) ? b_two : "/dev/null";
-	printf("%sdiff --git %s %s%s\n", set, a_one, b_two, reset);
+	printf("%sdiff%s %s %s%s\n", set, gitdiff, a_one, b_two, reset);
 	if (lbl[0][0] == '/') {
 		/* /dev/null */
 		printf("%snew file mode %06o%s\n", set, two->mode, reset);

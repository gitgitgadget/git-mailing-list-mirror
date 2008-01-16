From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH/RFC] Do not show "diff --git" metainfo with --no-prefix
Date: Tue, 15 Jan 2008 16:58:55 -0800
Message-ID: <7v4pded1rk.fsf_-_@gitster.siamese.dyndns.org>
References: <c0f2d4110801150559x155ffabaj6bea52715522a070@mail.gmail.com>
	<alpine.DEB.1.00.0801151444180.5289@eeepc-johanness>
	<c0f2d4110801150758t68714570y83e1e74acbb67325@mail.gmail.com>
	<alpine.LNX.1.00.0801151728120.13593@iabervon.org>
	<7vhched3kw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Ortman <chrisortman@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jan 16 02:00:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEwdM-0002Uo-Kj
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 02:00:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbYAPA73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 19:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbYAPA73
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 19:59:29 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44230 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757215AbYAPA7U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 19:59:20 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AAB652A2;
	Tue, 15 Jan 2008 19:59:17 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 459B13B38;
	Tue, 15 Jan 2008 19:59:10 -0500 (EST)
In-Reply-To: <7vhched3kw.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 15 Jan 2008 16:19:43 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70588>

If a non-standard prefix is used by --no-prefix, --src-prefix,
or --dst-prefix options, the resulting diff becomes something
git-apply would not grok.  In such a case, we should not trigger
the more strict check git-apply does for "diff --git" format. 

This checks the prefix specified when generating diff and if src
and dst prefix are not one-level of directory name followed by a
slash (i.e. the standard "diff --git a/foo b/foo" is fine, a
custom "diff --git l/foo k/foo" is Ok, but "diff --git foo foo"
is NOT Ok).

---
 diff.c |   52 ++++++++++++++++++++++++++++++++++++++++------------
 1 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/diff.c b/diff.c
index b18c140..8126a74 100644
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
@@ -1246,30 +1258,46 @@ static void builtin_diff(const char *name_a,
 	char *a_one, *b_two;
 	const char *set = diff_get_color_opt(o, DIFF_METAINFO);
 	const char *reset = diff_get_color_opt(o, DIFF_RESET);
+	int is_git_diff = with_standard_prefix(o);
 
 	a_one = quote_two(o->a_prefix, name_a + (*name_a == '/'));
 	b_two = quote_two(o->b_prefix, name_b + (*name_b == '/'));
 	lbl[0] = DIFF_FILE_VALID(one) ? a_one : "/dev/null";
 	lbl[1] = DIFF_FILE_VALID(two) ? b_two : "/dev/null";
-	printf("%sdiff --git %s %s%s\n", set, a_one, b_two, reset);
+
+	if (!is_git_diff)
+		printf("%sIndex: %s%s\n", set, b_two, reset);
+	else
+		printf("%sdiff --git %s %s%s\n", set, a_one, b_two, reset);
+
 	if (lbl[0][0] == '/') {
 		/* /dev/null */
-		printf("%snew file mode %06o%s\n", set, two->mode, reset);
-		if (xfrm_msg && xfrm_msg[0])
-			printf("%s%s%s\n", set, xfrm_msg, reset);
+		if (is_git_diff) {
+			printf("%snew file mode %06o%s\n",
+			       set, two->mode, reset);
+			if (xfrm_msg && xfrm_msg[0])
+				printf("%s%s%s\n", set, xfrm_msg, reset);
+		}
 	}
 	else if (lbl[1][0] == '/') {
-		printf("%sdeleted file mode %06o%s\n", set, one->mode, reset);
-		if (xfrm_msg && xfrm_msg[0])
-			printf("%s%s%s\n", set, xfrm_msg, reset);
+		if (is_git_diff) {
+			printf("%sdeleted file mode %06o%s\n",
+			       set, one->mode, reset);
+			if (xfrm_msg && xfrm_msg[0])
+				printf("%s%s%s\n", set, xfrm_msg, reset);
+		}
 	}
 	else {
-		if (one->mode != two->mode) {
-			printf("%sold mode %06o%s\n", set, one->mode, reset);
-			printf("%snew mode %06o%s\n", set, two->mode, reset);
+		if (is_git_diff) {
+			if (one->mode != two->mode) {
+				printf("%sold mode %06o%s\n",
+				       set, one->mode, reset);
+				printf("%snew mode %06o%s\n",
+				       set, two->mode, reset);
+			}
+			if (xfrm_msg && xfrm_msg[0])
+				printf("%s%s%s\n", set, xfrm_msg, reset);
 		}
-		if (xfrm_msg && xfrm_msg[0])
-			printf("%s%s%s\n", set, xfrm_msg, reset);
 		/*
 		 * we do not run diff between different kind
 		 * of objects.

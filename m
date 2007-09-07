From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] HEAD, ORIG_HEAD and FETCH_HEAD are really special.
Date: Fri, 07 Sep 2007 04:21:47 -0700
Message-ID: <7vd4wu67qs.fsf_-_@gitster.siamese.dyndns.org>
References: <1189115308.30308.9.camel@koto.keithp.com>
	<7vsl5r8jer.fsf@gitster.siamese.dyndns.org>
	<1189133898.30308.58.camel@koto.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Keith Packard <keithp@keithp.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 13:22:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITbuS-0005Ke-O1
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 13:22:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965181AbXIGLVy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 07:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965180AbXIGLVy
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 07:21:54 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:40690 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965172AbXIGLVx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 07:21:53 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 3496912E223;
	Fri,  7 Sep 2007 07:22:11 -0400 (EDT)
In-Reply-To: <1189133898.30308.58.camel@koto.keithp.com> (Keith Packard's
	message of "Thu, 06 Sep 2007 19:58:18 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58025>

Keith Packard <keithp@keithp.com> writes:

> On Thu, 2007-09-06 at 16:26 -0700, Junio C Hamano wrote:
> ...
>> Perhaps you have ".git/master" by mistake?
>
> oops.

Ok, that explains it; git is doing exactly what the user asked
it to do.

              5---6 side
             /
	1---2---3---4 master

The user has this history.  But he has a stray .git/master file,
perhaps created by hand by mistake (it would be very interesting
to find how that file got there in the first place), that points
at commit "3".  From a side branch, he says "git rebase master".

The first parameter to "git rebase" in a single parameter form
is "the commit on which to replay the changes my current branch
has".  It is not limited to a branch name.  IOW, it can be an
arbitrary object name, and one of the rules to translate a user
string that is supposed to mean an arbitrary object name goes
through this table:

        "%s", "refs/%s", "refs/tags/%s", "refs/heads/%s",
        "refs/remotes/%s", "refs/remotes/%s/HEAD"

For each entry in the above table, "%s" part of the entry is
replaced by the user string, and resulting string is used to see
if there is such a file under .git/ directory, and the first
match is used (this explanation is simplifying things a bit).

This rule has been there almost from the beginning.  The first
entry allowed you to have a tag A and a branch A at the same
time, while giving you a way to disambiguate them by spelling
them out as "refs/tags/A" and "refs/heads/A", respectively.
Also the first rule covered special "ref" names such as HEAD and
ORIG_HEAD.

Alas, there is one drawback of this rule.  His .git/master hides
refs/heads/master.  So essentially his command line said "I've
built a few commits since I forked from the history that leads
to commit 3; I want to replay my changes on top of that commit".
He meant to say 4, but said 3, and as a unfortunate consequence,
commit 4 is lost.

The above explanation is solely for understanding the situation
and, not meant to defend the current behaviour.  I think the
current behaviour is inviting mistakes and confusion.

This patch brings in a new world order by introducing a backward
incompatible change.  When the string the user gave us does not
contain any slash, we do not apply the first entry (i.e.
directly underneath .git/ without any "refs/***") unless the
name consists solely of uppercase letters or an underscore,
thereby ignoring .git/master.  The ones we often use, such as
HEAD and ORIG_HEAD are not affected by this change.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_name.c                |   35 ++++++++++++++++++++++++++++++++++
 t/t3407-rebase-confused.sh |   45 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+), 0 deletions(-)
 create mode 100755 t/t3407-rebase-confused.sh

diff --git a/sha1_name.c b/sha1_name.c
index 2d727d5..1b980ca 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -239,6 +239,35 @@ static int ambiguous_path(const char *path, int len)
 	return slash;
 }
 
+static int confused_ref(const char *str)
+{
+	char ch;
+	int seen_non_uppercase = 0;
+
+	/*
+	 * People create .git/master by mistake using hand-rolled
+	 * scripts and confuse themselves utterly.  Make sure this
+	 * does not match such a path.
+	 */
+	while ((ch = *str++) != '\0') {
+		if (ch == '/')
+			return 0;
+		if (!((ch == '_') ||
+		      ('A' <= ch && ch <= 'Z') ||
+		      ('0' <= ch && ch <= '9')))
+			seen_non_uppercase = 1;
+	}
+
+	/*
+	 * str did not have any slash and we are checking when
+	 * it hangs directly underneath .git/; the only valid
+	 * cases we currently have are HEAD, ORIG_HEAD, MERGE_HEAD and
+	 * FETCH_HEAD.  If we saw any non uppercase, non underscore,
+	 * we should ignore this string.
+	 */
+	return seen_non_uppercase;
+}
+
 static const char *ref_fmt[] = {
 	"%.*s",
 	"refs/%.*s",
@@ -259,6 +288,9 @@ int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
 		unsigned char sha1_from_ref[20];
 		unsigned char *this_result;
 
+		if ((p == ref_fmt) && confused_ref(str))
+			continue;
+
 		this_result = refs_found ? sha1_from_ref : sha1;
 		r = resolve_ref(mkpath(*p, len, str), this_result, 1, NULL);
 		if (r) {
@@ -283,6 +315,9 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 		char path[PATH_MAX];
 		const char *ref, *it;
 
+		if (p == ref_fmt && confused_ref(str))
+			continue;
+
 		strcpy(path, mkpath(*p, len, str));
 		ref = resolve_ref(path, hash, 0, NULL);
 		if (!ref)
diff --git a/t/t3407-rebase-confused.sh b/t/t3407-rebase-confused.sh
new file mode 100755
index 0000000..5254da6
--- /dev/null
+++ b/t/t3407-rebase-confused.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+
+test_description="Keithp's .git/master problem
+
+              5---6 side
+             /
+	1---2---3---4 master
+
+"
+
+. ./test-lib.sh
+
+build () {
+	echo "$1" >"$1" && git add "$1" && test_tick && git commit -m "$1"
+}
+
+test_expect_success setup '
+
+	build one &&
+	build two &&
+	git branch side &&
+	build three &&
+	git tag anchor &&
+	build four &&
+	git-checkout side &&
+	build five &&
+	build six &&
+	git update-ref master anchor &&
+	git tag -d anchor
+
+'
+
+test_expect_success rebase '
+
+	git rebase master
+
+'
+
+test_expect_success 'everybody is still there' '
+
+	test 6 = $(git log --pretty=oneline HEAD | wc -l)
+
+'
+
+test_done
-- 
1.5.3.1.879.g4d83f

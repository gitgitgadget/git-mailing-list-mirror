From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFR] gitattributes(5) documentation
Date: Thu, 19 Apr 2007 22:02:08 -0700
Message-ID: <7virbr4p0v.fsf@assigned-by-dhcp.cox.net>
References: <7vodly0xn7.fsf@assigned-by-dhcp.cox.net>
	<7vr6qlxexe.fsf@assigned-by-dhcp.cox.net>
	<7v647tcjr6.fsf@assigned-by-dhcp.cox.net>
	<7vslav4yv6.fsf_-_@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0704191835290.9964@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Apr 20 07:02:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HelGB-00053v-MT
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 07:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161155AbXDTFCL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 01:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422888AbXDTFCL
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 01:02:11 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:51698 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422722AbXDTFCK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 01:02:10 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070420050210.WLSK1226.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Fri, 20 Apr 2007 01:02:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id pH281W00K1kojtg0000000; Fri, 20 Apr 2007 01:02:09 -0400
In-Reply-To: <alpine.LFD.0.98.0704191835290.9964@woody.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 19 Apr 2007 18:45:01 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45061>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> This documented behaviour is non-optimal for a few reasons:
>  - it makes it impossible to say "this is text", and have it work on UNIX 
>    platforms ;)
>  - it makes it impossible to have "autocrlf=input", and then correct one 
>    single file that was incorrectly guessed to be binary, and have that 
>    file behave like other files.
>
> So I _think_ the right rules are:
>
>  - unspecified: use autocrlf *and* content detection logic
>  - unset: never do crlf<->lf ("binary")
>  - set: use autocrlf without content detection logic ("text")
>
> with possibly an added rule:
>
>  - set to value: "true" or "input" force that particular setting 
>    *regardless* of autocrlf, ie we'd always get CRLF even on UNIX.

A patch (only compile and testsuite tested but otherwise not
tested) is attached; loses more lines than it adds.

Here is a rewrite of the `crlf` section.

-- >8 --
Checking-out and checking-in
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The attribute `crlf` affects how the contents stored in the
repository are copied to the working tree files when commands
such as `git checkout` and `git merge` run.  It also affects how
git stores the contents you prepare in the working tree in the
repository upon `git add` and `git commit`.

Set::

	Setting the `crlf` attribute on a path is meant to mark
	the path as a "text" file.  'core.autocrlf' conversion
	takes place without guessing the content type by
	inspection.

Unset::

	Unsetting the `crlf` attribute on a path is meant to
	mark the path as a "binary" file.  The path never goes
	through line endings conversion upon checkin/checkout.

Unspecified::

	Unspecified `crlf` attribute tells git to apply the
	`core.autocrlf` conversion when the file content looks
	like text.

Set to string value "input"::

	This is similar to setting the attribute to `true`, but
	also forces git to act as if `core.autocrlf` is set to
	`input` for the path.

Any other value set to `crlf` attribute is ignored and git acts
as if the attribute is left unspecified.


The `core.autocrlf` conversion
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If the configuration variable `core.autocrlf` is false, no
conversion is done.

When `core.autocrlf` is true, it means that the platform wants
CRLF line endings for files in the working tree, and you want to
convert them back to the normal LF line endings when checking
in to the repository.

When `core.autocrlf` is set to "input", line endings are
converted to LF upon checkin, but there is no conversion done
upon checkout.
-- 8< --

 convert.c |   75 +++++++++++++++++++++---------------------------------------
 1 files changed, 26 insertions(+), 49 deletions(-)

diff --git a/convert.c b/convert.c
index a5f60c7..da64253 100644
--- a/convert.c
+++ b/convert.c
@@ -10,6 +10,11 @@
  * translation when the "auto_crlf" option is set.
  */
 
+#define CRLF_GUESS	(-1)
+#define CRLF_BINARY	0
+#define CRLF_TEXT	1
+#define CRLF_INPUT	2
+
 struct text_stat {
 	/* CR, LF and CRLF counts */
 	unsigned cr, lf, crlf;
@@ -74,13 +79,13 @@ static int is_binary(unsigned long size, struct text_stat *stats)
 	return 0;
 }
 
-static int crlf_to_git(const char *path, char **bufp, unsigned long *sizep, int guess)
+static int crlf_to_git(const char *path, char **bufp, unsigned long *sizep, int action)
 {
 	char *buffer, *nbuf;
 	unsigned long size, nsize;
 	struct text_stat stats;
 
-	if (guess && !auto_crlf)
+	if ((action == CRLF_BINARY) || (action == CRLF_GUESS && !auto_crlf))
 		return 0;
 
 	size = *sizep;
@@ -94,7 +99,7 @@ static int crlf_to_git(const char *path, char **bufp, unsigned long *sizep, int
 	if (!stats.cr)
 		return 0;
 
-	if (guess) {
+	if (action == CRLF_GUESS) {
 		/*
 		 * We're currently not going to even try to convert stuff
 		 * that has bare CR characters. Does anybody do that crazy
@@ -119,7 +124,12 @@ static int crlf_to_git(const char *path, char **bufp, unsigned long *sizep, int
 	*bufp = nbuf;
 	*sizep = nsize;
 
-	if (guess) {
+	if (action == CRLF_GUESS) {
+		/*
+		 * If we guessed, we already know we rejected a file with
+		 * lone CR, and we can strip a CR without looking at what
+		 * follow it.
+		 */
 		do {
 			unsigned char c = *buffer++;
 			if (c != '\r')
@@ -136,24 +146,15 @@ static int crlf_to_git(const char *path, char **bufp, unsigned long *sizep, int
 	return 1;
 }
 
-static int autocrlf_to_git(const char *path, char **bufp, unsigned long *sizep)
-{
-	return crlf_to_git(path, bufp, sizep, 1);
-}
-
-static int forcecrlf_to_git(const char *path, char **bufp, unsigned long *sizep)
-{
-	return crlf_to_git(path, bufp, sizep, 0);
-}
-
-static int crlf_to_working_tree(const char *path, char **bufp, unsigned long *sizep, int guess)
+static int crlf_to_worktree(const char *path, char **bufp, unsigned long *sizep, int action)
 {
 	char *buffer, *nbuf;
 	unsigned long size, nsize;
 	struct text_stat stats;
 	unsigned char last;
 
-	if (guess && auto_crlf <= 0)
+	if ((action == CRLF_BINARY) || (action == CRLF_INPUT) ||
+	    (action == CRLF_GUESS && auto_crlf <= 0))
 		return 0;
 
 	size = *sizep;
@@ -171,7 +172,7 @@ static int crlf_to_working_tree(const char *path, char **bufp, unsigned long *si
 	if (stats.lf == stats.crlf)
 		return 0;
 
-	if (guess) {
+	if (action == CRLF_GUESS) {
 		/* If we have any bare CR characters, we're not going to touch it */
 		if (stats.cr != stats.crlf)
 			return 0;
@@ -200,16 +201,6 @@ static int crlf_to_working_tree(const char *path, char **bufp, unsigned long *si
 	return 1;
 }
 
-static int autocrlf_to_working_tree(const char *path, char **bufp, unsigned long *sizep)
-{
-	return crlf_to_working_tree(path, bufp, sizep, 1);
-}
-
-static int forcecrlf_to_working_tree(const char *path, char **bufp, unsigned long *sizep)
-{
-	return crlf_to_working_tree(path, bufp, sizep, 0);
-}
-
 static void setup_crlf_check(struct git_attr_check *check)
 {
 	static struct git_attr *attr_crlf;
@@ -228,38 +219,24 @@ static int git_path_check_crlf(const char *path)
 	if (!git_checkattr(path, 1, &attr_crlf_check)) {
 		const char *value = attr_crlf_check.value;
 		if (ATTR_TRUE(value))
-			return 1;
+			return CRLF_TEXT;
 		else if (ATTR_FALSE(value))
-			return 0;
+			return CRLF_BINARY;
 		else if (ATTR_UNSET(value))
 			;
-		else
-			die("unknown value %s given to 'crlf' attribute",
-			    (char *)value);
+		else if (!strcmp(value, "input"))
+			return CRLF_INPUT;
+		/* fallthru */
 	}
-	return -1;
+	return CRLF_GUESS;
 }
 
 int convert_to_git(const char *path, char **bufp, unsigned long *sizep)
 {
-	switch (git_path_check_crlf(path)) {
-	case 0:
-		return 0;
-	case 1:
-		return forcecrlf_to_git(path, bufp, sizep);
-	default:
-		return autocrlf_to_git(path, bufp, sizep);
-	}
+	return crlf_to_git(path, bufp, sizep, git_path_check_crlf(path));
 }
 
 int convert_to_working_tree(const char *path, char **bufp, unsigned long *sizep)
 {
-	switch (git_path_check_crlf(path)) {
-	case 0:
-		return 0;
-	case 1:
-		return forcecrlf_to_working_tree(path, bufp, sizep);
-	default:
-		return autocrlf_to_working_tree(path, bufp, sizep);
-	}
+	return crlf_to_worktree(path, bufp, sizep, git_path_check_crlf(path));
 }

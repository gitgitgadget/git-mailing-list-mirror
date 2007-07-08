From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Per-path attribute based hunk header selection.
Date: Sun, 08 Jul 2007 00:23:53 -0700
Message-ID: <7v1wfj4auu.fsf@assigned-by-dhcp.cox.net>
References: <7v8x9tdlbv.fsf@assigned-by-dhcp.cox.net>
	<200707071011.l67AB9rg005792@mi0.bluebottle.com>
	<7vabu88qem.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707071317060.4093@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 08 09:24:00 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7R7d-0006vf-Pv
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 09:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752749AbXGHHXz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 03:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752629AbXGHHXz
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 03:23:55 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:57889 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669AbXGHHXy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 03:23:54 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070708072355.SKPS1204.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sun, 8 Jul 2007 03:23:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id LvPt1X0081kojtg0000000; Sun, 08 Jul 2007 03:23:54 -0400
In-Reply-To: <Pine.LNX.4.64.0707071317060.4093@racer.site> (Johannes
	Schindelin's message of "Sat, 7 Jul 2007 13:17:11 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51866>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > +	if (!strcmp(ident, "tex"))
>> > +		return "^\\\\\\(sub\\)*section{";
>
> It is always easier, and will never require C skills, to put this into the 
> config. With Junio's current version:
>
> 	echo '*.tex funcname=tex' >> .gitattributes
> 	echo '[funcname] tex = ^\(\\\(sub\)*section{.*\)' >> .git/config
>
> The problem is of course that the backslashes have to be escaped _both_ in 
> C and in regexps.

I think giving a reasonable set of basic language support as
built-in patterns is important for usability.  Otherwise the
users end up needing to have them in their $HOME/.gitconfig.

I am not sure if Java and LaTeX qualify as the first two most
important cases, but they are what we already have
demonstrated.  How about doing something like this?


-- >8 --
diff.c: make built-in hunk header pattern a separate table

This would hopefully make it easier to maintain.  Initially we
would have "java" and "tex" defined, as they are the only ones
we already have.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
diff --git a/diff.c b/diff.c
index b8473f5..cd6b0c4 100644
--- a/diff.c
+++ b/diff.c
@@ -1216,9 +1216,22 @@ static const char *funcname_pattern(const char *ident)
 	return NULL;
 }
 
+static struct builtin_funcname_pattern {
+	const char *name;
+	const char *pattern;
+} builtin_funcname_pattern[] = {
+	{ "java", "!^[ 	]*\\(catch\\|do\\|for\\|if\\|instanceof\\|"
+			"new\\|return\\|switch\\|throw\\|while\\)\n"
+			"^[ 	]*\\(\\([ 	]*"
+			"[A-Za-z_][A-Za-z_0-9]*\\)\\{2,\\}"
+			"[ 	]*([^;]*$\\)" },
+	{ "tex", "^\\(\\\\\\(sub\\)*section{.*\\)$" },
+};
+
 static const char *diff_funcname_pattern(struct diff_filespec *one)
 {
 	const char *ident, *pattern;
+	int i;
 
 	diff_filespec_check_attr(one);
 	ident = one->funcname_pattern_ident;
@@ -1240,12 +1253,9 @@ static const char *diff_funcname_pattern(struct diff_filespec *one)
 	 * And define built-in fallback patterns here.  Note that
 	 * these can be overriden by the user's config settings.
 	 */
-	if (!strcmp(ident, "java"))
-		return "!^[ 	]*\\(catch\\|do\\|for\\|if\\|instanceof\\|"
-			"new\\|return\\|switch\\|throw\\|while\\)\n"
-			"^[ 	]*\\(\\([ 	]*"
-			"[A-Za-z_][A-Za-z_0-9]*\\)\\{2,\\}"
-			"[ 	]*([^;]*$\\)";
+	for (i = 0; i < ARRAY_SIZE(builtin_funcname_pattern); i++)
+		if (!strcmp(ident, builtin_funcname_pattern[i].name))
+			return builtin_funcname_pattern[i].pattern;
 
 	return NULL;
 }

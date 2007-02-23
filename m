From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH, N'TH TRY] Teach git-diff-files the new option `--no-index`
Date: Fri, 23 Feb 2007 03:44:30 -0800
Message-ID: <7vmz353xpd.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0702201944340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vzm76fpia.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702221724090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vvehuf4ic.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702221926390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vmz36f1bv.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702222051490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vd542dji4.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702222148050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 23 12:44:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKYqp-0000iD-Sb
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 12:44:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbXBWLoc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 06:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbXBWLoc
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 06:44:32 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:48972 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932114AbXBWLob (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 06:44:31 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070223114431.WNKY2807.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Fri, 23 Feb 2007 06:44:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SzkW1W0021kojtg0000000; Fri, 23 Feb 2007 06:44:30 -0500
In-Reply-To: <Pine.LNX.4.63.0702222148050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 22 Feb 2007 21:50:10 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40441>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> With this flag and given two paths, git-diff-files behaves as a GNU diff
> lookalike (plus the git goodies like --check, colour, etc.).  This flag
> is also available in git-diff.  It also works outside of a git repository.
>
> In addition, if git-diff{,-files} is called without revision or stage
> parameter, and with exactly two paths at least one of which is not tracked,
> the default is --no-index.
>
> So, you can now say
>
> 	git diff /etc/inittab /etc/fstab
>
> and it actually works!

Modulo double slashes X-<.

        $ diff --git a//etc/inittab b//etc/fstab
        index 04eabd6..7314c1a 100644
        --- a//etc/inittab
        +++ b//etc/fstab
	@@ -1,69 +1,13 @@
	...

This problem is not new; this should fix it.

-- >8 --
diff-patch: Avoid emitting double-slashes in textual patch.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/diff.c b/diff.c
index 5ecb122..84937cb 100644
--- a/diff.c
+++ b/diff.c
@@ -219,6 +219,9 @@ static void emit_rewrite_diff(const char *name_a,
 	const char *new = diff_get_color(color_diff, DIFF_FILE_NEW);
 	const char *reset = diff_get_color(color_diff, DIFF_RESET);
 
+	name_a += (*name_a == '/');
+	name_b += (*name_b == '/');
+
 	name_a_tab = strchr(name_a, ' ') ? "\t" : "";
 	name_b_tab = strchr(name_b, ' ') ? "\t" : "";
 
@@ -1064,8 +1067,8 @@ static void builtin_diff(const char *name_a,
 	const char *set = diff_get_color(o->color_diff, DIFF_METAINFO);
 	const char *reset = diff_get_color(o->color_diff, DIFF_RESET);
 
-	a_one = quote_two("a/", name_a);
-	b_two = quote_two("b/", name_b);
+	a_one = quote_two("a/", name_a + (*name_a == '/'));
+	b_two = quote_two("b/", name_b + (*name_b == '/'));
 	lbl[0] = DIFF_FILE_VALID(one) ? a_one : "/dev/null";
 	lbl[1] = DIFF_FILE_VALID(two) ? b_two : "/dev/null";
 	printf("%sdiff --git %s %s%s\n", set, a_one, b_two, reset);

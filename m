From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Resurrect diff-tree-helper -R
Date: Sat, 14 May 2005 23:25:46 -0700
Message-ID: <7vr7g9uhsl.fsf@assigned-by-dhcp.cox.net>
References: <7v7jij3htp.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504301805300.2296@ppc970.osdl.org>
	<20050513224529.GF32232@pasky.ji.cz>
	<7vhdh691gs.fsf@assigned-by-dhcp.cox.net>
	<20050513233354.GK32232@pasky.ji.cz>
	<7vmzqy7k47.fsf@assigned-by-dhcp.cox.net>
	<7voebe63zs.fsf@assigned-by-dhcp.cox.net>
	<20050514150356.GK3905@pasky.ji.cz>
	<7vu0l5zsb4.fsf@assigned-by-dhcp.cox.net>
	<20050514233538.GY3905@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 08:26:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXCZf-0000Kv-G7
	for gcvg-git@gmane.org; Sun, 15 May 2005 08:26:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbVEOG0E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 02:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbVEOG0E
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 02:26:04 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:16308 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261495AbVEOGZs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2005 02:25:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050515062546.GNFG7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 15 May 2005 02:25:46 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050514233538.GY3905@pasky.ji.cz> (Petr Baudis's message of
 "Sun, 15 May 2005 01:35:38 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

>> Wait a minute.  Aren't we scanning starting from the first
>> '---\n'?  Why does what's in commit message matter?

PB> Ok, that changes the whole situation. I'll take your patches as they are
PB> now in that case. :-)

Shooooooooot.  Seriously.

I already am beginning to like "\n@. " very much; it is much
less distracting then the "# mode: " thing, especially with the
help from additional newline.

Could I have the following applied, pretty please?

------------
Tweak diff output a bit further to make a bit less distracting.

This adds a blank line before start of diffs for each file, and
also changes "# mode: " header to "@. ".  One justification is
that it tells more than just mode, and "@. " is visually a lot
less distracting.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

--- a/diff.c
+++ b/diff.c
@@ -83,7 +83,7 @@ static void builtin_diff(const char *nam
 			 struct diff_tempfile *temp)
 {
 	int i, next_at;
-	const char *git_prefix = "# mode: ";
+	const char *git_prefix = "\n@. ";
 	const char *diff_cmd = "diff -L'%s%s' -L'%s%s'";
 	const char *diff_arg  = "'%s' '%s'||:"; /* "||:" is to return 0 */
 	const char *input_name_sq[2];
@@ -128,15 +128,17 @@ static void builtin_diff(const char *nam
 	else if (!path1[1][0])
 		printf("%s%s . %s\n", git_prefix, temp[0].mode, name);
 	else {
-		if (strcmp(temp[0].mode, temp[1].mode))
+		if (strcmp(temp[0].mode, temp[1].mode)) {
 			printf("%s%s %s %s\n", git_prefix,
 			       temp[0].mode, temp[1].mode, name);
-
-		if (strncmp(temp[0].mode, temp[1].mode, 3))
-			/* we do not run diff between different kind
-			 * of objects.
-			 */
-			exit(0);
+			if (strncmp(temp[0].mode, temp[1].mode, 3))
+				/* we do not run diff between different kind
+				 * of objects.
+				 */
+				exit(0);
+		}
+		else
+			putchar('\n');
 	}
 	fflush(NULL);
 	execlp("/bin/sh","sh", "-c", cmd, NULL);



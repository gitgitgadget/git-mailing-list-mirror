From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] [COGITO] make cg-tag use git-check-ref-format
Date: Thu, 15 Dec 2005 18:17:19 -0800
Message-ID: <7virtplr9s.fsf@assigned-by-dhcp.cox.net>
References: <11344712912199-git-send-email-matlads@dsmagic.com>
	<7vy82p9rnb.fsf@assigned-by-dhcp.cox.net>
	<20051213170015.GD22159@pasky.or.cz>
	<7vu0dcalgo.fsf@assigned-by-dhcp.cox.net>
	<20051215222424.GA3094@steel.home>
	<7vacf2lyn4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 16 03:18:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1En59x-0005U3-4U
	for gcvg-git@gmane.org; Fri, 16 Dec 2005 03:17:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbVLPCRW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 21:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbVLPCRW
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 21:17:22 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:24704 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932079AbVLPCRW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2005 21:17:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051216021624.NTHN20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 15 Dec 2005 21:16:24 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <7vacf2lyn4.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 15 Dec 2005 15:38:07 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13728>

Junio C Hamano <junkio@cox.net> writes:

> The wildcard letters like ? and * I understand and sympathetic
> about somewhat.  Something like this:
>
>         name="*.sh" ;# this also comes from the end user
>         echo $name
>
> ends up showing every shell script in the current directory,
> and not literal '*.sh'.

So why don't we do this?

-- >8 --
Subject: [PATCH] Forbid pattern maching characters in refnames.

by marking '?', '*', and '[' as bad_ref_char().

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 Documentation/git-check-ref-format.txt |    8 +++++---
 refs.c                                 |    4 +++-
 2 files changed, 8 insertions(+), 4 deletions(-)

d04ec25a77249095b6d2af5a08fe131351f2d86d
diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index 636e951..f7f84c6 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -26,13 +26,15 @@ imposes the following rules on how refs 
 
 . It cannot have ASCII control character (i.e. bytes whose
   values are lower than \040, or \177 `DEL`), space, tilde `~`,
-  caret `{caret}`, or colon `:` anywhere;
+  caret `{caret}`, colon `:`, question-mark `?`, asterisk `*`,
+  or open bracket `[` anywhere;
 
 . It cannot end with a slash `/`.
 
 These rules makes it easy for shell script based tools to parse
-refnames, and also avoids ambiguities in certain refname
-expressions (see gitlink:git-rev-parse[1]).  Namely:
+refnames, pathname expansion by the shell when a refname is used
+unquoted (by mistake), and also avoids ambiguities in certain
+refname expressions (see gitlink:git-rev-parse[1]).  Namely:
 
 . double-dot `..` are often used as in `ref1..ref2`, and in some
   context this notation means `{caret}ref1 ref2` (i.e. not in
diff --git a/refs.c b/refs.c
index b8fcb98..0d63c1f 100644
--- a/refs.c
+++ b/refs.c
@@ -313,7 +313,9 @@ int write_ref_sha1(const char *ref, int 
 static inline int bad_ref_char(int ch)
 {
 	return (((unsigned) ch) <= ' ' ||
-		ch == '~' || ch == '^' || ch == ':');
+		ch == '~' || ch == '^' || ch == ':' ||
+		/* 2.13 Pattern Matching Notation */
+		ch == '?' || ch == '*' || ch == '[');
 }
 
 int check_ref_format(const char *ref)
-- 
0.99.9.GIT

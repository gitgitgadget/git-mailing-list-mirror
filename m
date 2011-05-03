From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [RFC/PATCH] userdiff.c: Avoid old glibc regex bug causing t4034-*.sh
 test failures
Date: Tue, 03 May 2011 18:49:21 +0100
Message-ID: <4DC04021.1040606@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, trast@student.ethz.ch,
	Junio C Hamano <gitster@pobox.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 03 19:52:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHJmG-0004nZ-2Q
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 19:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753849Ab1ECRwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2011 13:52:47 -0400
Received: from anchor-post-2.mail.demon.net ([195.173.77.133]:53582 "EHLO
	anchor-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753798Ab1ECRwq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2011 13:52:46 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1QHJkI-0003N1-kT; Tue, 03 May 2011 17:50:51 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172676>


In particular, this bug affects the word-diff regex for 'bibtex' and
'html', leading to the test failures in t4034-diff-words.sh. The bug
is described here:

    http://sourceware.org/bugzilla/show_bug.cgi?id=3957

and was fixed on 12-07-2007. In summary, when the REG_NEWLINE flag is
passed to regcomp(), a non-matching list ([^...]) not containing a
newline should not match a newline. However, in some old versions of
the glibc regex library, the newline character was indeed matched.

In order to fix the problem, we add an explicit '\n' to the list in
the non-matching list expression.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Junio,
    I recently mentioned that a couple of tests in t4034-*.sh were
failing for me on Linux. I have now looked into it, and the problem
turned out to be an old bug in the glibc regex routines. :-(

This is an RFC because:
    - A simple fix would be for me to put NO_REGEX=1 in my config.mak,
      since the compat/regex routines don't suffer this problem.
    - I suspect this bug is old enough that it will not affect many users.
    - I have not audited the other non-matching list expressions in
      userdiff.c
    - blame, grep and pickaxe all call regcomp() with the REG_NEWLINE
      flag, but get the regex from the user (eg from command line).

ATB,
Ramsay Jones

 userdiff.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/userdiff.c b/userdiff.c
index 1ff4797..2f9ba37 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -28,7 +28,7 @@ IPATTERN("fortran",
 	 "|[-+]?[0-9.]+([AaIiDdEeFfLlTtXx][Ss]?[-+]?[0-9.]*)?(_[a-zA-Z0-9][a-zA-Z0-9_]*)?"
 	 "|//|\\*\\*|::|[/<>=]="),
 PATTERNS("html", "^[ \t]*(<[Hh][1-6][ \t].*>.*)$",
-	 "[^<>= \t]+"),
+	 "[^<>= \t\n]+"),
 PATTERNS("java",
 	 "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
 	 "^[ \t]*(([A-Za-z_][A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*)$",
@@ -94,7 +94,7 @@ PATTERNS("ruby", "^[ \t]*((class|module|def)[ \t].*)$",
 	 "|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+|\\?(\\\\C-)?(\\\\M-)?."
 	 "|//=?|[-+*/<>%&^|=!]=|<<=?|>>=?|===|\\.{1,3}|::|[!=]~"),
 PATTERNS("bibtex", "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
-	 "[={}\"]|[^={}\" \t]+"),
+	 "[={}\"]|[^={}\" \t\n]+"),
 PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
 	 "\\\\[a-zA-Z@]+|\\\\.|[a-zA-Z0-9\x80-\xff]+"),
 PATTERNS("cpp",
-- 
1.7.5

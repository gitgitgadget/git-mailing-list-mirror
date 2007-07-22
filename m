From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Added 'git-rev-list --igrep' option for case insensitive grep
Date: Sat, 21 Jul 2007 23:17:17 -0700
Message-ID: <7vwswtrmhe.fsf@assigned-by-dhcp.cox.net>
References: <a1bbc6950707212233h6047ecfas645b71b9b4c6317e@mail.gmail.com>
	<7v8x99t25s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 08:17:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICUl1-00009Y-Vz
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 08:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675AbXGVGRT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 02:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751696AbXGVGRT
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 02:17:19 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:34435 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603AbXGVGRS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 02:17:18 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070722061718.IYXM1399.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sun, 22 Jul 2007 02:17:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SWHH1X00E1kojtg0000000; Sun, 22 Jul 2007 02:17:18 -0400
In-Reply-To: <7v8x99t25s.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 21 Jul 2007 22:53:19 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53222>

Junio C Hamano <gitster@pobox.com> writes:

> Are there notable side effects you would need to warn users
> about?
>
> For example, what is the difference between "--igrep=foo
> --author=bar" and "--grep=foo --author=bar"?

Nah, let's not try to be too subtle.  It does not work.

What I am wondering is if there is an unintended option name
conflict if we simply accept "-i" and "-E" as synonyms to
"--regexp-ignore-case" and "--extended-regexp".  The option
parser for log family in revision.c is used from many places,
so it is a bit hard to verify everobody to be absolutely sure,
but I do not think of any offhand.  There indeed are commands
that take "-i" to mean something other than ignore-case, but
ignore-case would not be meaningful for their operation.

So I would rather prefer this replacement patch.

-- >8 --
Synonyms: -i == --regexp-ignore-case, -E == --extended-regexp

These options to log family were too long to type.  Give them
shorter synonyms.

Fix the parsing of the long options while at it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-rev-list.txt |    7 ++++---
 revision.c                     |    6 ++++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 08e7573..f9fadaf 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -27,7 +27,8 @@ SYNOPSIS
 	     [ \--cherry-pick ]
 	     [ \--encoding[=<encoding>] ]
 	     [ \--(author|committer|grep)=<pattern> ]
-	     [ \--regexp-ignore-case ] [ \--extended-regexp ]
+	     [ \--regexp-ignore-case | \-i ]
+	     [ \--extended-regexp | \-E ]
 	     [ \--date={local|relative|default|iso|rfc|short} ]
 	     [ [\--objects | \--objects-edge] [ \--unpacked ] ]
 	     [ \--pretty | \--header ]
@@ -227,11 +228,11 @@ limiting may be applied.
 	Limit the commits output to ones with log message that
 	matches the specified pattern (regular expression).
 
---regexp-ignore-case::
+--regexp-ignore-case, -i::
 
 	Match the regexp limiting patterns without regard to letters case.
 
---extended-regexp::
+--extended-regexp, -E::
 
 	Consider the limiting patterns to be extended regular expressions
 	instead of the default basic regular expressions.
diff --git a/revision.c b/revision.c
index 7036cf2..00b75bc 100644
--- a/revision.c
+++ b/revision.c
@@ -1165,11 +1165,13 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				add_message_grep(revs, arg+7);
 				continue;
 			}
-			if (!prefixcmp(arg, "--extended-regexp")) {
+			if (!strcmp(arg, "--extended-regexp") ||
+			    !strcmp(arg, "-E")) {
 				regflags |= REG_EXTENDED;
 				continue;
 			}
-			if (!prefixcmp(arg, "--regexp-ignore-case")) {
+			if (!strcmp(arg, "--regexp-ignore-case") ||
+			    !strcmp(arg, "-i")) {
 				regflags |= REG_ICASE;
 				continue;
 			}

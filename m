From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH] Document conventions on static initialization and else cuddling
Date: Wed, 19 Sep 2012 20:00:02 +0100
Message-ID: <1348081202-17361-1-git-send-email-git@adamspiers.org>
References: <7v627pzsr7.fsf@alter.siamese.dyndns.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 21:00:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEPVV-0005ge-2z
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 21:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932867Ab2ISTAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 15:00:11 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:45054 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932315Ab2ISTAF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 15:00:05 -0400
Received: from localhost (f.8.b.2.1.5.e.f.f.f.4.f.0.4.2.0.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:240:f4ff:fe51:2b8f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 9508F2E39E
	for <git@vger.kernel.org>; Wed, 19 Sep 2012 20:00:03 +0100 (BST)
X-Mailer: git-send-email 1.7.12.147.g6d168f4
In-Reply-To: <7v627pzsr7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205977>

Signed-off-by: Adam Spiers <git@adamspiers.org>
---

I have begun work on fixing existing code to adhere to these
guidelines on braces, but there are currently a lot of violations,
which means any patches to fix them would be large.  So before I spend
any more time on it, I would like to check whether such patches would
be welcomed?  And if so, should I be doing that on the master branch?

I have also added some simple rules such as `check-brace-before-else'
to the top-level Makefile which perform appropriate `grep -n' commands
to detect violations and for example easily fix them via emacs' M-x
grep.  These rules can be invoked together via a `check-style' target.
Would this also be welcomed?  If so, should the checks all be
introduced in a single commit, or each check along with the code which
was fixed with its help?

BTW I briefly tried to find an existing tool out there which could
already do the checking for us, but only found ones like uncrustify
which rewrite code rather than warning on inconsistencies.  I also saw
that the kernel's scripts/checkpatch.pl only worked with patches and
was also extremely kernel-specific in the nature of its checks.

 Documentation/CodingGuidelines | 42 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 57da6aa..1a2851d 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -117,17 +117,49 @@ For C programs:
    "char * string".  This makes it easier to understand code
    like "char *string, c;".
 
+ - We avoid unnecessary explicit initialization of BSS-allocated vars
+   (static and globals) to zero or NULL:
+
+	static int n;
+	static char **ch;
+
+   rather than:
+
+	static int n = 0;
+	static char **ch = NULL;
+
+   These are superfluous according to ISO/IEC 9899:1999 (a.k.a. C99);
+   see item 10 in section 6.7.8 ("Initialization") of WG14 N1256 for
+   the exact text:
+
+     http://open-std.org/JTC1/SC22/WG14/www/docs/n1256.pdf
+
  - We avoid using braces unnecessarily.  I.e.
 
 	if (bla) {
 		x = 1;
 	}
 
-   is frowned upon.  A gray area is when the statement extends
-   over a few lines, and/or you have a lengthy comment atop of
-   it.  Also, like in the Linux kernel, if there is a long list
-   of "else if" statements, it can make sense to add braces to
-   single line blocks.
+   is frowned upon.  A gray area is when the statement extends over a
+   few lines, and/or you have a lengthy comment atop of it.  Also,
+   like in the Linux kernel, it can make sense to add braces to single
+   line blocks if there are already braces in another branch of the
+   same conditional, and/or there is long list of "else if"
+   statements.
+
+ - When braces are required, we cuddle "else" and "else if", so the
+   preceding closing brace appears on the same line, e.g.
+
+	if (foo) {
+		...;
+	} else if (bar) {
+		...;
+		...;
+	} else {
+		...;
+	}
+
+   following Linux kernel style, unless there is a good reason not to.
 
  - We try to avoid assignments inside if().
 
-- 
1.7.12.147.g6d168f4

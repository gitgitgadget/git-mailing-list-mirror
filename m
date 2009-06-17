From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH] avoid exponential regex match for java and objc function names
Date: Wed, 17 Jun 2009 16:26:06 +0200
Message-ID: <1245248766-14867-1-git-send-email-bonzini@gnu.org>
References: <20090617102332.GA32353@coredump.intra.peff.net>
Cc: peff@peff.net, gitster@pobox.com
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 17 16:26:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGw63-0000Sp-IF
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 16:26:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765165AbZFQO0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 10:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763701AbZFQO0U
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 10:26:20 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:49242 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762904AbZFQO0U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 10:26:20 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1MGw5j-0002Dr-0Z; Wed, 17 Jun 2009 10:26:19 -0400
X-Mailer: git-send-email 1.6.0.3
In-Reply-To: <20090617102332.GA32353@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121750>

In the old regex

^[ \t]*(([ \t]*[A-Za-z_][A-Za-z_0-9]*){2,}[ \t]*\([^;]*)$
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

you can backtrack arbitrarily from [A-Za-z_0-9]* into [A-Za-z_], thus
causing an exponential number of backtracks.  Ironically it also causes
the regex not to work as intended; for example "catch" can match the
underlined part of the regex, the first repetition matching "c" and
the second matching "atch".

The replacement regex avoids this problem, because it makes sure that
at least a space/tab is eaten on each repetition.  In other words,
a suffix of a repetition can never be a prefix of the next repetition.

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
---
 userdiff.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/userdiff.c b/userdiff.c
index d556da9..57529ae 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -13,7 +13,8 @@ PATTERNS("html", "^[ \t]*(<[Hh][1-6][ \t].*>.*)$",
 	 "[^<>= \t]+|[^[:space:]]|[\x80-\xff]+"),
 PATTERNS("java",
 	 "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
-	 "^[ \t]*(([ \t]*[A-Za-z_][A-Za-z_0-9]*){2,}[ \t]*\\([^;]*)$",
+	 "^[ \t]*(([A-Za-z_][A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*)$",
+	 /* -- */
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
 	 "|[-+*/<>%&^|=!]="
@@ -25,7 +26,7 @@ PATTERNS("objc",
 	 /* Objective-C methods */
 	 "^[ \t]*([-+][ \t]*\\([ \t]*[A-Za-z_][A-Za-z_0-9* \t]*\\)[ \t]*[A-Za-z_].*)$\n"
 	 /* C functions */
-	 "^[ \t]*(([ \t]*[A-Za-z_][A-Za-z_0-9]*){2,}[ \t]*\\([^;]*)$\n"
+	 "^[ \t]*(([A-Za-z_][A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*)$\n"
 	 /* Objective-C class/protocol definitions */
 	 "^(@(implementation|interface|protocol)[ \t].*)$",
 	 /* -- */
-- 
1.6.0.3

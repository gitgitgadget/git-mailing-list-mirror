From: Jonathan del Strother <jon.delStrother@bestbefore.tv>
Subject: [PATCH v2] Teach git diff about Objective-C syntax
Date: Wed,  1 Oct 2008 00:46:34 +0100
Message-ID: <1222818394-11547-1-git-send-email-jon.delStrother@bestbefore.tv>
References: <57518fd10809171630v97485aalcc5089f96082c0fc@mail.gmail.com>
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Ericsson <ae@op5.se>,
	Jonathan del Strother <jon.delStrother@bestbefore.tv>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 01 01:48:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkox5-0002Oc-Ht
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 01:48:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752739AbYI3XrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 19:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752267AbYI3XrO
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 19:47:14 -0400
Received: from cumberland.bestbefore.tv ([82.165.41.205]:52520 "EHLO
	cumberland.bestbefore.tv" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156AbYI3XrN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 19:47:13 -0400
Received: (qmail 15237 invoked from network); 1 Oct 2008 00:47:10 +0100
Received: from 87.114.2.154.plusnet.thn-ag3.dyn.plus.net (HELO localhost.localdomain) (87.114.2.154)
  by cumberland.bestbefore.tv with SMTP; 1 Oct 2008 00:47:10 +0100
X-Mailer: git-send-email 1.6.0.2.416.g8cab.dirty
In-Reply-To: <57518fd10809171630v97485aalcc5089f96082c0fc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97171>

Add support for recognition of Objective-C class & instance methods, C functions, and class implementation/interfaces.

Signed-off-by: Jonathan del Strother <jon.delStrother@bestbefore.tv>
---
This version is much the same, but rebuilt on top of 1883a0d3b to use the extended regexp stuff, and it doesn't attempt to tidy up other patterns.

I've been trying to make the objc-method matching line a bit more specific - I think I'm running into a bug (or more likely a misunderstanding) in the matching process.
Every pattern there uses either .*$ or [^;]*$ to match up to the end of a line.  But in trying to come up with a whitelist of characters to match up to the end of a line, I couldn't do it : there seems to be an invisible character at the end of the line that I can't match.
That is, a line containing just "FUNCNAME" (terminated by a newline) will be matched by the pattern "^(FUNCNAME.$)" but not "^(FUNCNAME$)".
Why is this?


 Documentation/gitattributes.txt |    2 ++
 diff.c                          |   10 ++++++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 2ae771f..2694559 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -315,6 +315,8 @@ patterns are available:
 
 - `java` suitable for source code in the Java language.
 
+- `objc` suitable for source code in the Objective-C language.
+
 - `pascal` suitable for source code in the Pascal/Delphi language.
 
 - `php` suitable for source code in the PHP language.
diff --git a/diff.c b/diff.c
index b001d7b..3694602 100644
--- a/diff.c
+++ b/diff.c
@@ -1429,6 +1429,16 @@ static const struct funcname_pattern_entry builtin_funcname_pattern[] = {
 	  "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
 	  "^[ \t]*(([ \t]*[A-Za-z_][A-Za-z_0-9]*){2,}[ \t]*\\([^;]*)$",
 	  REG_EXTENDED },
+	{ "objc",
+	  /* Negate C statements that can look like functions */
+	  "!^[ \t]*(do|for|if|else|return|switch|while)\n"
+	  /* Objective-C methods */
+	  "^[ \t]*([-+][ \t]*\\([ \t]*[A-Za-z_][A-Za-z_0-9* \t]*\\)[ \t]*[A-Za-z_].*)$\n"
+	  /* C functions */
+	  "^[ \t]*(([ \t]*[A-Za-z_][A-Za-z_0-9]*){2,}[ \t]*\\([^;]*)$\n"
+	  /* Objective-C class/protocol definitions */
+	  "^(@(implementation|interface|protocol)[ \t].*)$",
+	  REG_EXTENDED },
 	{ "pascal",
 	  "^((procedure|function|constructor|destructor|interface|"
 		"implementation|initialization|finalization)[ \t]*.*)$"
-- 
1.6.0.2.416.g8cab.dirty

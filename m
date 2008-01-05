From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] git-rev-parse --symbolic-full-name
Date: Sat, 05 Jan 2008 12:23:44 -0800
Message-ID: <7vk5mo81in.fsf_-_@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0712301700580.14355@wbgn129.biozentrum.uni-wuerzburg.de>
	<1199040667-31850-1-git-send-email-dpotapov@gmail.com>
	<7v7iiqppkw.fsf@gitster.siamese.dyndns.org>
	<20080104155114.GS3373@dpotapov.dyndns.org>
	<7vr6gxjpyn.fsf@gitster.siamese.dyndns.org>
	<alpine.LSU.1.00.0801051601490.10101@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 05 21:24:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBFZ9-0004UO-HL
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 21:24:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756649AbYAEUX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 15:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756642AbYAEUX4
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 15:23:56 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50610 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756636AbYAEUXz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 15:23:55 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CA984950;
	Sat,  5 Jan 2008 15:23:50 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A572494F;
	Sat,  5 Jan 2008 15:23:46 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0801051601490.10101@racer.site> (Johannes
	Schindelin's message of "Sat, 5 Jan 2008 16:03:55 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69682>

The plumbing level can understand that the user meant
"refs/heads/master" when the user says "master" or
"heads/master", but there is no easy way for the scripts to
figure it out without duplicating the dwim_ref() logic.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is the same patch as I showed yesterday but with a doc
   update.

 Documentation/git-rev-parse.txt |    7 +++++++
 builtin-rev-parse.c             |   37 ++++++++++++++++++++++++++++++++++---
 2 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 329fce0..0cedc13 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -70,6 +70,13 @@ OPTIONS
 	possible '{caret}' prefix); this option makes them output in a
 	form as close to the original input as possible.
 
+--symbolic-full-name::
+	This is similar to \--symbolic, but it omits input that
+	are not refs (i.e. branch or tag names; or more
+	explicitly disambiguating "heads/master" form, when you
+	want to name the "master" branch when there is an
+	unfortunately named tag "master"), and show them as full
+	refnames (e.g. "refs/heads/master").
 
 --all::
 	Show all refs found in `$GIT_DIR/refs`.
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 20d1789..b9af1a5 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -21,6 +21,9 @@ static const char *def;
 #define NORMAL 0
 #define REVERSED 1
 static int show_type = NORMAL;
+
+#define SHOW_SYMBOLIC_ASIS 1
+#define SHOW_SYMBOLIC_FULL 2
 static int symbolic;
 static int abbrev;
 static int output_sq;
@@ -103,8 +106,32 @@ static void show_rev(int type, const unsigned char *sha1, const char *name)
 
 	if (type != show_type)
 		putchar('^');
-	if (symbolic && name)
-		show(name);
+	if (symbolic && name) {
+		if (symbolic == SHOW_SYMBOLIC_FULL) {
+			unsigned char discard[20];
+			char *full;
+
+			switch (dwim_ref(name, strlen(name), discard, &full)) {
+			case 0:
+				/*
+				 * Not found -- not a ref.  We could
+				 * emit "name" here, but symbolic-full
+				 * users are interested in finding the
+				 * refs spelled in full, and they would
+				 * need to filter non-refs if we did so.
+				 */
+				break;
+			case 1: /* happy */
+				show(full);
+				break;
+			default: /* ambiguous */
+				error("refname '%s' is ambiguous", name);
+				break;
+			}
+		} else {
+			show(name);
+		}
+	}
 	else if (abbrev)
 		show(find_unique_abbrev(sha1, abbrev));
 	else
@@ -421,7 +448,11 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--symbolic")) {
-				symbolic = 1;
+				symbolic = SHOW_SYMBOLIC_ASIS;
+				continue;
+			}
+			if (!strcmp(arg, "--symbolic-full-name")) {
+				symbolic = SHOW_SYMBOLIC_FULL;
 				continue;
 			}
 			if (!strcmp(arg, "--all")) {
-- 
1.5.4.rc2.38.gd6da3

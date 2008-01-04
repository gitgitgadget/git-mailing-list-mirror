From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-filter-branch could be confused by similar names
Date: Fri, 04 Jan 2008 12:28:00 -0800
Message-ID: <7vr6gxjpyn.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0712301700580.14355@wbgn129.biozentrum.uni-wuerzburg.de>
	<1199040667-31850-1-git-send-email-dpotapov@gmail.com>
	<7v7iiqppkw.fsf@gitster.siamese.dyndns.org>
	<20080104155114.GS3373@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 04 21:28:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAt9q-0007e8-Oz
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 21:28:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181AbYADU2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 15:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754112AbYADU2R
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 15:28:17 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64481 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754001AbYADU2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 15:28:16 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 524F86DBB;
	Fri,  4 Jan 2008 15:28:14 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 781976DBA;
	Fri,  4 Jan 2008 15:28:09 -0500 (EST)
In-Reply-To: <20080104155114.GS3373@dpotapov.dyndns.org> (Dmitry Potapov's
	message of "Fri, 4 Jan 2008 18:51:15 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69601>

Dmitry Potapov <dpotapov@gmail.com> writes:

> It works only if the name "unambiguous" for git show-ref, which
> interprets refname differently than rev-list as I wrote above.
> Nevertheless, I believe we can use 'git show-ref' if we try
> something like this:

Ahh.

But at that point I would say that exposing the refname dwimming
logic to the scripts could be a much cleaner solution.  After
all, get_sha1_basic() knows what ref it used to come up with the
answer, but we are discarding that information.

How about making "rev-parse --symbolic-full-name" give what it
eventually dwimmed the given ref to, perhaps like the attached
patch?  Then you can do:

  git rev-parse --revs-only --symbolic-full-name "$@" >"$tempdir"/heads

without any need for the loop there in filter-branch.

---

 builtin-rev-parse.c |   37 ++++++++++++++++++++++++++++++++++---
 1 files changed, 34 insertions(+), 3 deletions(-)

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

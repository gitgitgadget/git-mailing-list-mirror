From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use --no-color option on git log commands.
Date: Mon, 26 Nov 2007 14:30:28 -0800
Message-ID: <7vr6icej23.fsf@gitster.siamese.dyndns.org>
References: <474B42EC.1000408@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Pascal Obry <pascal.obry@wanadoo.fr>
X-From: git-owner@vger.kernel.org Mon Nov 26 23:30:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwmTc-000426-J5
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 23:30:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755632AbXKZWae (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 17:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755129AbXKZWae
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 17:30:34 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:51333 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755030AbXKZWad (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 17:30:33 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 55F4E2F0;
	Mon, 26 Nov 2007 17:30:54 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id C2B129A17F;
	Mon, 26 Nov 2007 17:30:51 -0500 (EST)
In-Reply-To: <474B42EC.1000408@wanadoo.fr> (Pascal Obry's message of "Mon, 26
	Nov 2007 23:04:28 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66141>

Pascal Obry <pascal.obry@wanadoo.fr> writes:

> When colors are activated on the repository the git log output
> will contain control characters to set/reset the colors.

The patch is good as belt-and-suspender, thanks.

But I suspect that we should make 'true' to mean 'auto' someday in
git_config_colorbool().  Crazy people can set 'always' if they really
wanted to, but most normal people would not want color unless the output
goes to the terminal, I would think.

Something like this, perhaps...

---
 color.c |   25 ++++++++++++-------------
 1 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/color.c b/color.c
index 09d82ee..060d3cf 100644
--- a/color.c
+++ b/color.c
@@ -118,21 +118,24 @@ bad:
 
 int git_config_colorbool(const char *var, const char *value)
 {
-	if (!value)
-		return 1;
-	if (!strcasecmp(value, "auto")) {
-		if (isatty(1) || (pager_in_use && pager_use_color)) {
-			char *term = getenv("TERM");
-			if (term && strcmp(term, "dumb"))
-				return 1;
-		}
-		return 0;
-	}
-	if (!strcasecmp(value, "never"))
- 		return 0;
-	if (!strcasecmp(value, "always"))
-		return 1;
-	return git_config_bool(var, value);
+	if (value) {
+		if (!strcasecmp(value, "never"))
+			return 0;
+		if (!strcasecmp(value, "always"))
+			return 1;
+		if (!strcasecmp(value, "auto"))
+			goto auto;
+ 	}
+	if (!git_config_bool(var, value))
+ 		return 0;
+auto:
+	/* any normal truth value defaults to 'auto' */
+	if (isatty(1) || (pager_in_use && pager_use_color)) {
+		char *term = getenv("TERM");
+		if (term && strcmp(term, "dumb"))
+			return 1;
+	}
+	return 0;
 }
 
 static int color_vprintf(const char *color, const char *fmt,

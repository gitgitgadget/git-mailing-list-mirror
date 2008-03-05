From: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH] shortlog: take the first populated line of the description
Date: Wed, 5 Mar 2008 14:24:10 -0000
Message-ID: <1204727050.0@pinky>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 05 15:25:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWuY8-0003QS-Hn
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 15:24:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895AbYCEOYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 09:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbYCEOYN
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 09:24:13 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:1970 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827AbYCEOYM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 09:24:12 -0500
Received: from localhost ([127.0.0.1] helo=pinky)
	by hellhawk.shadowen.org with esmtp (Exim 4.63)
	(envelope-from <apw@shadowen.org>)
	id 1JWuXT-0007Co-H2
	for git@vger.kernel.org; Wed, 05 Mar 2008 14:24:11 +0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76219>


Way back the perl version of shortlog would take the first populated line
of the commit body.  The builtin version mearly takes the first line.
This leads to empty shortlog entries when there is some viable text in
the commit.

Reinstate this behaviour igoring all lines with nothing but whitespace.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---

	This seems to be an improvement, returning to the original
	behaviour.  I cannot think of any good reason not to take the first
	populated line for a shortlog.	The alternative less agressive
	compromise might be to skip only completly empty lines at the
	start, but I am not sure that adds any value.

	I seem to get a lot of these in converted SVN commits.

	Comments?

	-apw
---
 builtin-shortlog.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)
diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index af31aba..b22b0ed 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -70,11 +70,12 @@ static void insert_one_record(struct shortlog *log,
 	else
 		free(buffer);
 
+	/* Skip any leading whitespace, including any blank lines. */
+	while (*oneline && isspace(*oneline))
+		oneline++;
 	eol = strchr(oneline, '\n');
 	if (!eol)
 		eol = oneline + strlen(oneline);
-	while (*oneline && isspace(*oneline) && *oneline != '\n')
-		oneline++;
 	if (!prefixcmp(oneline, "[PATCH")) {
 		char *eob = strchr(oneline, ']');
 		if (eob && (!eol || eob < eol))

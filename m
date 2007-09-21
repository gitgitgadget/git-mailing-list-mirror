From: Michal Vitecek <fuf@mageo.cz>
Subject: [PATCH] Added a new placeholder '%cm' for full commit message
Date: Fri, 21 Sep 2007 12:14:20 +0200
Message-ID: <20070921101420.GD22869@mageo.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VuQYccsttdhdIfIP"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 21 12:33:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYfp1-0003NP-9f
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 12:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756019AbXIUKdM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 06:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756015AbXIUKdL
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 06:33:11 -0400
Received: from interactive-1.com ([193.85.232.82]:47494 "EHLO
	interactive-1.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756013AbXIUKdK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 06:33:10 -0400
X-Greylist: delayed 1128 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Sep 2007 06:33:10 EDT
Received: from interactive-1.com (localhost.localdomain [127.0.0.1])
	by interactive-1.com (Postfix) with ESMTP id 5A83023B310
	for <git@vger.kernel.org>; Fri, 21 Sep 2007 12:14:21 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58840>


--VuQYccsttdhdIfIP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

 Hello,

 I have added a new placeholder '%cm' for a full commit message. I made
 it because I want to use my own pretty format which currently only
 allows '%s' for subject and '%b' for body. But '%b' is substituted with
 <undefined> if the body is "missing" which I obviously don't like :)

 Thanks for consideration,
                        Michal
-- 
		fuf		(fuf@mageo.cz)

--VuQYccsttdhdIfIP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-Added-a-new-placeholder-cm-for-full-commit-messag.patch"

>From 5e22a989e6805d860b8477393fa8a6cc54f35193 Mon Sep 17 00:00:00 2001
From: Michal Vitecek <fuf@mageo.cz>
Date: Fri, 21 Sep 2007 12:02:57 +0200
Subject: [PATCH] Added a new placeholder '%cm' for full commit message

---
 Documentation/pretty-formats.txt |    1 +
 commit.c                         |   18 +++++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 0193c3c..26c42d3 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -117,6 +117,7 @@ The placeholders are:
 - '%e': encoding
 - '%s': subject
 - '%b': body
+- '%cm': commit message
 - '%Cred': switch color to red
 - '%Cgreen': switch color to green
 - '%Cblue': switch color to blue
diff --git a/commit.c b/commit.c
index 99f65ce..1e24e21 100644
--- a/commit.c
+++ b/commit.c
@@ -814,6 +814,7 @@ long format_commit_message(const struct commit *commit, const void *format,
 		{ "%e" },	/* encoding */
 		{ "%s" },	/* subject */
 		{ "%b" },	/* body */
+                { "%cm" },      /* commit message (subject and body) */
 		{ "%Cred" },	/* red */
 		{ "%Cgreen" },	/* green */
 		{ "%Cblue" },	/* blue */
@@ -835,12 +836,14 @@ long format_commit_message(const struct commit *commit, const void *format,
 		IENCODING,
 		ISUBJECT,
 		IBODY,
+                ICOMMIT_MESSAGE,
 		IRED, IGREEN, IBLUE, IRESET_COLOR,
 		INEWLINE,
 		ILEFT_RIGHT,
 	};
 	struct commit_list *p;
 	char parents[1024];
+        int cm_len = 0;
 	int i;
 	enum { HEADER, SUBJECT, BODY } state;
 	const char *msg = commit->buffer;
@@ -897,6 +900,7 @@ long format_commit_message(const struct commit *commit, const void *format,
 
 		if (state == SUBJECT) {
 			table[ISUBJECT].value = xstrndup(msg + i, eol - i);
+                        cm_len = eol - i + 2; /* + 2 for 2 newlines */
 			i = eol;
 		}
 		if (i == eol) {
@@ -915,8 +919,20 @@ long format_commit_message(const struct commit *commit, const void *format,
 				xstrndup(msg + i + 9, eol - i - 9);
 		i = eol;
 	}
-	if (msg[i])
+	if (msg[i]) {
 		table[IBODY].value = xstrdup(msg + i);
+                cm_len += strlen(msg + i);
+        }
+        if (cm_len) {
+            table[ICOMMIT_MESSAGE].value = xmalloc(cm_len + 1);
+            table[ICOMMIT_MESSAGE].value[0] = '\0';
+            if (table[ISUBJECT].value) {
+                strcpy(table[ICOMMIT_MESSAGE].value, table[ISUBJECT].value);
+                strcat(table[ICOMMIT_MESSAGE].value, "\n\n");
+            }
+            if (table[IBODY].value)
+                strcat(table[ICOMMIT_MESSAGE].value, table[IBODY].value);
+        }
 	for (i = 0; i < ARRAY_SIZE(table); i++)
 		if (!table[i].value)
 			interp_set_entry(table, i, "<unknown>");
-- 
1.5.3.1


--VuQYccsttdhdIfIP--

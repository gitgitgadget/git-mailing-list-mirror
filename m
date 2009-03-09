From: Heiko Voigt <git-list@hvoigt.net>
Subject: [CVSPS PATCH] fix: correct rev order in case commiters clocks were
 not syncronised
Date: Mon, 09 Mar 2009 12:26:18 +0100
Message-ID: <49B4FCDA.4030106@hvoigt.net>
References: <49A2EFC6.5000104@hvoigt.net> <49A37ED1.5090506@alum.mit.edu> <49AC1E88.1010709@hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>, ydirson@altern.org
X-From: git-owner@vger.kernel.org Mon Mar 09 12:27:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgdeA-0004Ww-UU
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 12:27:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbZCIL0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 07:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbZCIL0W
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 07:26:22 -0400
Received: from darksea.de ([83.133.111.250]:36654 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750728AbZCIL0V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 07:26:21 -0400
Received: (qmail 2825 invoked from network); 9 Mar 2009 12:26:11 +0100
Received: from unknown (HELO heiko-voigts-macbook.local) (127.0.0.1)
  by localhost with SMTP; 9 Mar 2009 12:26:11 +0100
User-Agent: Thunderbird 2.0.0.19 (Macintosh/20081209)
In-Reply-To: <49AC1E88.1010709@hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112688>

This fixes the following kind of cvsps issues:

 Structure of the test cvs repository

 Message   File:Content         Commit Time
 Rev 1     a: 1.1               2009-02-21 19:11:43 +0100
 Rev 2     a: 1.2    b: 1.1     2009-02-21 19:11:14 +0100
 Rev 3               b: 1.2     2009-02-21 19:11:43 +0100

 As you can see the commit of Rev 3 has the same time as
 Rev 1 this was leading to a broken estimation of patchset
 order.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
After precisely formulating my problem with cvsps I was curious if this
issue actually could be fixed. Additionally I don't want my test to be
disabled ;). This patch seems to fix it. Is Yann still maintaining the
patches for cvsps or should I forward this patch to someone else ?

Calculating with time_t like I did is probably not valid on all systems
if you know of a nicer, more portable solution please let me know.

 cvsps.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/cvsps.c b/cvsps.c
index 81c6e21..d5c30d4 100644
--- a/cvsps.c
+++ b/cvsps.c
@@ -259,6 +259,32 @@ int main(int argc, char *argv[])
     exit(0);
 }
 
+void detect_and_repair_time_skew(const char *last_date, char *date, int n,
+                                 const char *filename)
+{
+
+    time_t smaller;
+    time_t bigger;
+    struct tm *ts;
+
+    /* if last_date does not exist do nothing */
+    if (last_date[0] == '\0')
+        return;
+
+    /* important: because rlog is showing revisions backwards last_date should
+     * always be bigger than date */
+    convert_date(&bigger, last_date);
+    convert_date(&smaller, date);
+
+    if (difftime(bigger, smaller) <= 0) {
+        debug(DEBUG_APPMSG1, "broken revision date: %s -> %s file: %s, repairing.\n",
+              date, last_date, filename);
+        smaller = bigger - 1;
+        ts = gmtime(&smaller);
+        strftime(date, n, "%Y-%m-%d %H:%M:%S", ts);
+    }
+}
+
 static void load_from_cvs()
 {
     FILE * cvsfp;
@@ -267,6 +293,7 @@ static void load_from_cvs()
     CvsFile * file = NULL;
     PatchSetMember * psm = NULL;
     char datebuff[20];
+    char last_datebuff[20];
     char authbuff[AUTH_STR_MAX];
     int logbufflen = LOG_STR_MAX + 1;
     char * logbuff = malloc(logbufflen);
@@ -334,6 +361,8 @@ static void load_from_cvs()
 	exit(1);
     }
 
+    /* initialize the last_datebuff with value indicating invalid date */
+    last_datebuff[0]='\0';
     for (;;)
     {
 	char * tst;
@@ -474,8 +503,14 @@ static void load_from_cvs()
 	    {
 		if (psm)
 		{
+		    detect_and_repair_time_skew(last_datebuff, datebuff, 20, psm->file->filename);
 		    PatchSet * ps = get_patch_set(datebuff, logbuff, authbuff, psm->post_rev->branch, psm);
 		    patch_set_add_member(ps, psm);
+
+		    /* remember last revision */
+		    strncpy(last_datebuff, datebuff, 20);
+		    /* just to be sure */
+		    last_datebuff[19] = '\0';
 		}
 
 		logbuff[0] = 0;
@@ -487,8 +522,13 @@ static void load_from_cvs()
 	    {
 		if (psm)
 		{
+		    detect_and_repair_time_skew(last_datebuff, datebuff, 20, psm->file->filename);
 		    PatchSet * ps = get_patch_set(datebuff, logbuff, authbuff, psm->post_rev->branch, psm);
 		    patch_set_add_member(ps, psm);
+
+		    /* just finished the last revision of this file, set last_datebuff to invalid */
+		    last_datebuff[0]='\0';
+
 		    assign_pre_revision(psm, NULL);
 		}
 

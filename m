From: slavomir vlcek <svlc@inventati.org>
Subject: [PATCH/RFC] builtin: move builtin retrieval to get_builtin()
Date: Wed, 12 Nov 2014 23:07:28 +0100
Message-ID: <5463DA20.3080703@inventati.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, sschuberth@gmail.com
X-From: git-owner@vger.kernel.org Wed Nov 12 23:23:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XogK2-0000Yo-W2
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 23:23:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752510AbaKLWX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2014 17:23:27 -0500
Received: from latitanza.investici.org ([82.94.249.234]:32697 "EHLO
	latitanza.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176AbaKLWX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2014 17:23:26 -0500
X-Greylist: delayed 1141 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Nov 2014 17:23:26 EST
Received: from [82.94.249.234] (latitanza [82.94.249.234]) (Authenticated sender: svlc@inventati.org) by localhost (Postfix) with ESMTPSA id CF18C120A8A;
	Wed, 12 Nov 2014 22:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inventati.org;
	s=stigmate; t=1415829863;
	bh=ifWe0Q+WNTYpLUTUFOEahCZ5M0LobHmOgT6jl4/nsMY=;
	h=Date:From:To:Subject;
	b=TAcG2Eg69xarjNQJ3KeRcjp68OMLBAfHp+wD1HcmhWpQdYLaA+TBq2VXPtgNJKGet
	 Mg4Vq0OHVF3tf0udt8Iwj0+HB7nD6AS4DeS0oauke7aoijB7PWS8vSBQI9nDAEFG+R
	 IZvdmLR95cyAw2DvV/48bono/WYpDYMeVU+HHuAk=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
found a small code redundancy in a builtin command retrieval ('git.c').

For the "master" branch.

Thanks in advance for any suggestions.

Signed-off-by: slavomir vlcek <svlc@inventati.org>
---

>From 78228e3f7c3029d07827f973fa7992777d6e0cb9 Mon Sep 17 00:00:00 2001
From: slavomir vlcek <svlc@inventati.org>
Date: Wed, 12 Nov 2014 14:10:22 +0100
Subject: [PATCH] builtin: move builtin retrieval to get_builtin()

There was a redundant code for a builtin command retrieval
in 'handle_builtin()' and 'is_builtin()'.

This was solved by adding a new function 'get_builtin()'
and by making a boolean wrapper out of the 'is_builtin()'.
---


 git.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/git.c b/git.c
index 18fbf79..e32c5b8 100644
--- a/git.c
+++ b/git.c
@@ -487,15 +487,20 @@ static struct cmd_struct commands[] = {
 	{ "write-tree", cmd_write_tree, RUN_SETUP },
 };
 
-int is_builtin(const char *s)
+struct cmd_struct *get_builtin(const char *s)
 {
 	int i;
 	for (i = 0; i < ARRAY_SIZE(commands); i++) {
-		struct cmd_struct *p = commands+i;
+		struct cmd_struct *p = commands + i;
 		if (!strcmp(s, p->cmd))
-			return 1;
+			return p;
 	}
-	return 0;
+	return NULL;
+}
+
+int is_builtin(const char *s)
+{
+	return !!get_builtin(s);
 }
 
 static void handle_builtin(int argc, const char **argv)
@@ -503,6 +508,7 @@ static void handle_builtin(int argc, const char **argv)
 	const char *cmd = argv[0];
 	int i;
 	static const char ext[] = STRIP_EXTENSION;
+	struct cmd_struct *builtin;
 
 	if (sizeof(ext) > 1) {
 		i = strlen(argv[0]) - strlen(ext);
@@ -519,15 +525,12 @@ static void handle_builtin(int argc, const char **argv)
 		argv[0] = cmd = "help";
 	}
 
-	for (i = 0; i < ARRAY_SIZE(commands); i++) {
-		struct cmd_struct *p = commands+i;
-		if (strcmp(p->cmd, cmd))
-			continue;
-		if (saved_environment && (p->option & NO_SETUP)) {
+	builtin = get_builtin(cmd);
+	if (builtin) {
+		if (saved_environment && (builtin->option & NO_SETUP))
 			restore_env();
-			break;
-		}
-		exit(run_builtin(p, argc, argv));
+		else
+			exit(run_builtin(builtin, argc, argv));
 	}
 }
 
-- 
2.0.1

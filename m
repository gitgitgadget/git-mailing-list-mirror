From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 5/5] revert: add "--strategy" option to choose merge
	strategy
Date: Thu, 25 Mar 2010 05:58:17 +0100
Message-ID: <20100325045818.14832.74751.chriscool@tuxfamily.org>
References: <20100325045519.14832.65964.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Alexander Gladysh <agladysh@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 25 06:03:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NufES-0002Gs-Ug
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 06:03:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752196Ab0CYFD1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Mar 2010 01:03:27 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:49355 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750963Ab0CYFDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Mar 2010 01:03:25 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id A036C818073;
	Thu, 25 Mar 2010 06:03:15 +0100 (CET)
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 6C81E81804B;
	Thu, 25 Mar 2010 06:03:12 +0100 (CET)
X-git-sha1: 89bc8ced1d0f68685413bcf57540545c4074e5a3 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100325045519.14832.65964.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143156>

This patch makes it possible to use a different merge strategy when
cherry-picking. This is usefull mainly for debugging purposes as it
allows to see if some failures are caused by the merge strategy used or
not.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/revert.c |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 054f442..808eb53 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -43,6 +43,7 @@ static const char *commit_name;
 static int allow_rerere_auto;
 
 static const char *me;
+static const char *strategy;
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -60,6 +61,7 @@ static void parse_args(int argc, const char **argv)
 		OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by:"),
 		OPT_INTEGER('m', "mainline", &mainline, "parent number"),
 		OPT_RERERE_AUTOUPDATE(&allow_rerere_auto),
+		OPT_STRING(0, "strategy", &strategy, "strategy", "merge strategy"),
 		OPT_END(),
 		OPT_END(),
 		OPT_END(),
@@ -459,7 +461,24 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 		}
 	}
 
-	do_recursive_merge(base, next, head, oneline, &msgbuf, defmsg);
+	if (!strategy || !strcmp(strategy, "recursive") || action == REVERT)
+		do_recursive_merge(base, next, head, oneline, &msgbuf, defmsg);
+	else {
+		int res;
+		struct commit_list *common = NULL;
+		struct commit_list *remotes = NULL;
+		write_message(&msgbuf, defmsg);
+		commit_list_insert(base, &common);
+		commit_list_insert(next, &remotes);
+		res = try_merge_command(strategy, common,
+					sha1_to_hex(head), remotes);
+		if (res) {
+			fprintf(stderr, "Automatic %s with strategy %s failed.%s\n",
+				me, strategy, help_msg(commit_name));
+			rerere(allow_rerere_auto);
+			exit(1);
+		}
+	}
 
 	/*
 	 *
-- 
1.7.0.2.398.g89bc8ce

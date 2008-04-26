From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH] Allow cherry-pick (and revert) to add signoff line
Date: Sat, 26 Apr 2008 09:46:55 -0500
Message-ID: <1209221215-13476-1-git-send-email-dpmcgee@gmail.com>
References: <7vabjlupjc.fsf@gitster.siamese.dyndns.org>
Cc: B.Steinbrink@gmx.de, gitster@pobox.com,
	Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 26 16:47:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jplgu-0007mV-7J
	for gcvg-git-2@gmane.org; Sat, 26 Apr 2008 16:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752779AbYDZOrF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2008 10:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752536AbYDZOrE
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Apr 2008 10:47:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:56997 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640AbYDZOrB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2008 10:47:01 -0400
Received: by ug-out-1314.google.com with SMTP id z38so317712ugc.16
        for <git@vger.kernel.org>; Sat, 26 Apr 2008 07:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=0NxHG4qinoz05zcA3h+QNn2SUovi/Yh1Ykb4bmUC2Zk=;
        b=IGz6UxkN78XqYgbKU+VdLFkapPxF8DistJhgJDgetsMLagvZGhN8CaLD1Jy2kwPw8Tbf8uoGdmYVc41MdTmwlUZBFGAOTnxTWk/p3/fD2e6OQ2lWWurnUOAozR4cGVHfrQwsze52uh5YkhHuV6irpE6vHWE7UMZKOxOWHb/RAdk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZKjsBqCGcKeOsdZ6Vvmws55SyouaEfpKCbjPVZTVi0Pc4N48VHGZzqKis+5kX8h+IkwPL0ynnGcfC9EqEXkyUJRc1bJGqRuT/UMZhFa0evY5FFq7jvJOtFqljsTkEwpW6kk4MdP0Ji22smc6CkZsVy269KXAD6XcLi2qx0D4zU4=
Received: by 10.150.11.6 with SMTP id 6mr1876419ybk.11.1209221219403;
        Sat, 26 Apr 2008 07:46:59 -0700 (PDT)
Received: from localhost ( [76.193.177.245])
        by mx.google.com with ESMTPS id g5sm5576858wra.33.2008.04.26.07.46.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 26 Apr 2008 07:46:58 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <7vabjlupjc.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80379>

I often find myself pulling patches off of other peoples trees using
cherry-pick, and following it with an immediate 'git commit --amend -s'
command. Eliminate the need for a double commit by allowing signoff on a
cherry-pick or revert.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---

Resubmit using execv_git_cmd() directly. This reduces some code duplication
and allows for any other commit options to be propagated forth in the future.

 builtin-revert.c |   20 +++++++++++++++-----
 1 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/builtin-revert.c b/builtin-revert.c
index 607a2f0..3f08cfe 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -33,7 +33,7 @@ static const char * const cherry_pick_usage[] = {
 	NULL
 };
 
-static int edit, no_replay, no_commit, mainline;
+static int edit, no_replay, no_commit, mainline, signoff;
 static enum { REVERT, CHERRY_PICK } action;
 static struct commit *commit;
 
@@ -53,6 +53,7 @@ static void parse_args(int argc, const char **argv)
 		OPT_BOOLEAN('e', "edit", &edit, "edit the commit message"),
 		OPT_BOOLEAN('x', NULL, &no_replay, "append commit name when cherry-picking"),
 		OPT_BOOLEAN('r', NULL, &noop, "no-op (backward compatibility)"),
+		OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by: header"),
 		OPT_INTEGER('m', "mainline", &mainline, "parent number"),
 		OPT_END(),
 	};
@@ -404,10 +405,19 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	 */
 
 	if (!no_commit) {
-		if (edit)
-			return execl_git_cmd("commit", "-n", NULL);
-		else
-			return execl_git_cmd("commit", "-n", "-F", defmsg, NULL);
+		/* 6 is max possible length of our args array including NULL */
+		const char *args[6];
+		int i = 0;
+		args[i++] = "commit";
+		args[i++] = "-n";
+		if (signoff)
+			args[i++] = "-s";
+		if (!edit) {
+			args[i++] = "-F";
+			args[i++] = defmsg;
+		}
+		args[i] = NULL;
+		return execv_git_cmd(args);
 	}
 	free(reencoded_message);
 
-- 
1.5.5.1

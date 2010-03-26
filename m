From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2] pull: mention "pull", not "fetch" in the error message.
Date: Fri, 26 Mar 2010 16:03:56 +0100
Message-ID: <1269615836-13995-1-git-send-email-Matthieu.Moy@imag.fr>
References: <4BACC241.4010608@drmicha.warpmail.net>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 26 16:04:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvB5S-0004CH-1W
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 16:04:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754022Ab0CZPEc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 11:04:32 -0400
Received: from mx2.imag.fr ([129.88.30.17]:58415 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751710Ab0CZPEc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 11:04:32 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o2QF02Fw023440
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 26 Mar 2010 16:00:02 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NvB4o-0005vX-P6; Fri, 26 Mar 2010 16:03:58 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NvB4o-0003eM-O1; Fri, 26 Mar 2010 16:03:58 +0100
X-Mailer: git-send-email 1.7.0.2.204.g8940d.dirty
In-Reply-To: <4BACC241.4010608@drmicha.warpmail.net>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 26 Mar 2010 16:00:03 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o2QF02Fw023440
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1270220404.82302@5x3qqOJAmQDyA5Mc+AYT6Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143235>

For newbies who've just been taught "git pull", the error message
"Where do you want to fetch from today?" is indeed confusing. Change it
to "Where do you want to pull from today?" in case fetch was called from
pull.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Just fixed a typo in commit message since v1.

 builtin/fetch.c |    6 +++++-
 git-pull.sh     |    3 ++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 957be9f..f3246f5 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -842,8 +842,12 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)
 	int ref_nr = 0;
 	int exit_code;
 
+	char *cmd = getenv("GIT_USER_COMMAND");
+	if (cmd == NULL || cmd[0] == '\0')
+		cmd = "fetch";
+
 	if (!remote)
-		die("Where do you want to fetch from today?");
+		die("Where do you want to %s from today?", cmd);
 
 	transport = transport_get(remote, NULL);
 	transport_set_verbosity(transport, verbosity, progress);
diff --git a/git-pull.sh b/git-pull.sh
index 1a4729f..abc233b 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -216,7 +216,8 @@ test true = "$rebase" && {
 	done
 }
 orig_head=$(git rev-parse -q --verify HEAD)
-git fetch $verbosity $progress --update-head-ok "$@" || exit 1
+GIT_USER_COMMAND=pull \
+    git fetch $verbosity $progress --update-head-ok "$@" || exit 1
 
 curr_head=$(git rev-parse -q --verify HEAD)
 if test -n "$orig_head" && test "$curr_head" != "$orig_head"
-- 
1.7.0.2.204.g8940d.dirty

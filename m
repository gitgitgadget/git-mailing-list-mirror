From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v2 1/2] bisect: relax requirement for a working tree.
Date: Tue,  9 Aug 2011 11:21:39 +1000
Message-ID: <1312852900-29457-2-git-send-email-jon.seymour@gmail.com>
References: <1312852900-29457-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, chriscool@tuxfamily.org, j6t@kdbg.org,
	jnareb@gmail.com, jrnieder@gmail.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 09 03:22:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qqb1H-0005Vb-8B
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 03:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235Ab1HIBV7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 21:21:59 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:35417 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251Ab1HIBV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 21:21:58 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so9208568pzk.1
        for <git@vger.kernel.org>; Mon, 08 Aug 2011 18:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=CUmx4C7/mjHZHdV+fFfIwkeONjUO8MCTnR5Rq9nFLlY=;
        b=s4zZupUnQIGCugHQmsz0uSByOzGppkDZONhYKTciVrXsrBkEAjqlqKyvShwBeB4ocx
         F1OEa7VBlETL8FncbC5HNeAVG++tGHgcxaHPgTpyVT7qFdwA83+dc2PUkZyWO9ceG3Ah
         sZZKIsPMBK5QqgwSgj0WoyxJ/eU0JmqAC82sU=
Received: by 10.142.11.17 with SMTP id 17mr6639928wfk.144.1312852918185;
        Mon, 08 Aug 2011 18:21:58 -0700 (PDT)
Received: from localhost.localdomain (bh02i525f01.au.ibm.com [202.81.18.30])
        by mx.google.com with ESMTPS id v2sm5006171pbi.67.2011.08.08.18.21.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 08 Aug 2011 18:21:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.523.g2ad34
In-Reply-To: <1312852900-29457-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179015>

Now that bisection does not require checkout, it can work
on bare repositories too.

In this case, we default the checkout mode to --no-checkout,
thereby forcing the creation of BISECT_HEAD on either a manual
or automatic start.

The require_work_tree check in git-bisect.sh and the NEED_WORK_TREE
check in git.c are relaxed.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 Documentation/git-bisect.txt |    2 ++
 git-bisect.sh                |    8 ++++++--
 git.c                        |    2 +-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 41e6ca8..e4f46bc 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -273,6 +273,8 @@ it point to the commit that should be tested.
 +
 This option may be useful when the test you would perform in each step
 does not require a checked out tree.
++
+If the repository is bare, `--no-checkout` is assumed.
 
 EXAMPLES
 --------
diff --git a/git-bisect.sh b/git-bisect.sh
index 22c4da5..72f79d6 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -29,7 +29,6 @@ Please use "git help bisect" to get the full man page.'
 OPTIONS_SPEC=
 . git-sh-setup
 . git-sh-i18n
-require_work_tree
 
 _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
@@ -79,7 +78,12 @@ bisect_start() {
 	orig_args=$(git rev-parse --sq-quote "$@")
 	bad_seen=0
 	eval=''
-	mode=''
+	if test "z$(git rev-parse --is-bare-repository)" != zfalse
+	then
+		mode=--no-checkout
+	else
+		mode=
+	fi
 	while [ $# -gt 0 ]; do
 		arg="$1"
 		case "$arg" in
diff --git a/git.c b/git.c
index 8828c18..7fdcab2 100644
--- a/git.c
+++ b/git.c
@@ -320,7 +320,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "annotate", cmd_annotate, RUN_SETUP },
 		{ "apply", cmd_apply, RUN_SETUP_GENTLY },
 		{ "archive", cmd_archive },
-		{ "bisect--helper", cmd_bisect__helper, RUN_SETUP | NEED_WORK_TREE },
+		{ "bisect--helper", cmd_bisect__helper, RUN_SETUP },
 		{ "blame", cmd_blame, RUN_SETUP },
 		{ "branch", cmd_branch, RUN_SETUP },
 		{ "bundle", cmd_bundle, RUN_SETUP_GENTLY },
-- 
1.7.6.522.g810f.dirty

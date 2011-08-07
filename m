From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 1/3] bisect: relax requirement for a working tree.
Date: Sun,  7 Aug 2011 20:50:38 +1000
Message-ID: <1312714240-23647-2-git-send-email-jon.seymour@gmail.com>
References: <1312714240-23647-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, chriscool@tuxfamily.org, j6t@kdbg.org,
	jnareb@gmail.com, jrnieder@gmail.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 07 12:51:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qq0wu-0006pu-Ho
	for gcvg-git-2@lo.gmane.org; Sun, 07 Aug 2011 12:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999Ab1HGKu5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Aug 2011 06:50:57 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:50269 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858Ab1HGKu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2011 06:50:56 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so6576739pzk.1
        for <git@vger.kernel.org>; Sun, 07 Aug 2011 03:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=+Qs2FNx/cx1u4iZmyMNxvwgUr3hM+mgthQIGa492/r8=;
        b=V09o+zDy3aj/g0PoMH+xHtMUAwJQCuX0aTsBBZP2OfLjjvTV0FWg8tBpD/Cv7jmHik
         Hd/XPHfdAHVhi0f6/wJRVI9KRxNnO9Sa3EloaOitcCd0n9OYcKxomB4VCQ8y5rrbjrlN
         gvVUx6wHo3IS8zwcZCJgoZi42Alf6rSnEfRNI=
Received: by 10.142.192.11 with SMTP id p11mr4372823wff.352.1312714256017;
        Sun, 07 Aug 2011 03:50:56 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id m3sm2740179pbm.28.2011.08.07.03.50.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 07 Aug 2011 03:50:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.363.g9b380.dirty
In-Reply-To: <1312714240-23647-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178899>

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
 git-bisect.sh |    8 ++++++--
 git.c         |    2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 22c4da5..436cc07 100755
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
+	if test "z$(git rev-parse --is-bare-repository)" != "zfalse"
+	then
+		mode='--no-checkout'
+	else
+		mode=''
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
1.7.6.363.g9b380.dirty

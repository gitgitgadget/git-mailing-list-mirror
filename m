From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [PATCH v2 3/3] push: Add the --no-recurse-submodules option
Date: Wed, 27 Jul 2011 20:10:50 +0200
Message-ID: <1311790250-32454-4-git-send-email-iveqy@iveqy.com>
References: <1311790250-32454-1-git-send-email-iveqy@iveqy.com>
Cc: gitster@pobox.com, iveqy@iveqy.com, jens.lehmann@web.de,
	hvoigt@hvoigt.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 27 20:10:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qm8ZM-0000Fh-SW
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 20:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754593Ab1G0SKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 14:10:50 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:38265 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754671Ab1G0SKp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 14:10:45 -0400
Received: by ewy4 with SMTP id 4so1448480ewy.19
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 11:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=EtdggMayAcChYROxcQFZVsdYHVHJ3wZO92HZC2gx/MY=;
        b=LMgQIyMszM/rbmsVKxH0yfBNyY7Wt2cg53tFo22cRoaJhApNPewdWAXUWd/9dUFE4e
         Ytar8JToTg5MeqE4TsCQ7mmpRtZi9cRarHMIHWJ+0GeC1Q0z7mUqQFMUCKj4rwWS2eOq
         oACBpmBAoMIFncLKLJBmlXB8219+PI9jiwLcg=
Received: by 10.204.120.78 with SMTP id c14mr37477bkr.125.1311790243870;
        Wed, 27 Jul 2011 11:10:43 -0700 (PDT)
Received: from kolya (h-185-240.a189.priv.bahnhof.se [85.24.185.240])
        by mx.google.com with ESMTPS id x19sm36472bkt.42.2011.07.27.11.10.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Jul 2011 11:10:42 -0700 (PDT)
Received: from iveqy by kolya with local (Exim 4.72)
	(envelope-from <iveqy@kolya>)
	id 1Qm8ZH-0008S8-Mz; Wed, 27 Jul 2011 20:10:51 +0200
X-Mailer: git-send-email 1.7.6.236.g7ad21
In-Reply-To: <1311790250-32454-1-git-send-email-iveqy@iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177991>

This adds the option --no-recurse-submodules to push. That is, git
will not check if the submodules are pushed. -f or --force still also
disables this check. Documentation is also updated.

Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
Mentored-by: Jens Lehmann <Jens.Lehmann@web.de>
Mentored-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 Documentation/git-push.txt     |    6 ++++++
 builtin/push.c                 |    1 +
 t/t5531-deep-submodule-push.sh |    7 +++++++
 transport.c                    |    4 +++-
 transport.h                    |    1 +
 5 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 88acfcd..d63a57c 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -113,6 +113,8 @@ nor in any Push line of the corresponding remotes file---see below).
 	not an ancestor of the local ref used to overwrite it.
 	This flag disables the check.  This can cause the
 	remote repository to lose commits; use it with care.
++
+	This also enforces --no-recurse-submodules
 
 --repo=<repository>::
 	This option is only relevant if no <repository> argument is
@@ -162,6 +164,10 @@ useful if you write an alias or script around 'git push'.
 	is specified. This flag forces progress status even if the
 	standard error stream is not directed to a terminal.
 
+--no-recurse-submodules::
+	Don't check if all submodule commits this repository refers to are
+	pushed to their remotes.
+
 include::urls-remotes.txt[]
 
 OUTPUT
diff --git a/builtin/push.c b/builtin/push.c
index 9cebf9e..07a8b11 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -236,6 +236,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BIT('n' , "dry-run", &flags, "dry run", TRANSPORT_PUSH_DRY_RUN),
 		OPT_BIT( 0,  "porcelain", &flags, "machine-readable output", TRANSPORT_PUSH_PORCELAIN),
 		OPT_BIT('f', "force", &flags, "force updates", TRANSPORT_PUSH_FORCE),
+		OPT_BIT(0, "no-recurse-submodules", &flags, "do not recurse submodules", TRANSPORT_PUSH_NO_RECURSE_SUBMODULES),
 		OPT_BOOLEAN( 0 , "thin", &thin, "use thin pack"),
 		OPT_STRING( 0 , "receive-pack", &receivepack, "receive-pack", "receive pack program"),
 		OPT_STRING( 0 , "exec", &receivepack, "receive-pack", "receive pack program"),
diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index 15474c1..74c615c 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -124,4 +124,11 @@ test_expect_success 'push fails if submodule has no remote and is on the first s
 	)
 '
 
+test_expect_success 'push succeeds when --no-recurse-submodules is used' '
+	(
+		cd work &&
+		git push ../pub.git --no-recurse-submodules
+	)
+'
+
 test_done
diff --git a/transport.c b/transport.c
index e0fd435..9681560 100644
--- a/transport.c
+++ b/transport.c
@@ -1042,7 +1042,9 @@ int transport_push(struct transport *transport,
 			flags & TRANSPORT_PUSH_MIRROR,
 			flags & TRANSPORT_PUSH_FORCE);
 
-		if(!(flags & TRANSPORT_PUSH_FORCE) && !is_bare_repository()) {
+		if(!(flags & TRANSPORT_PUSH_NO_RECURSE_SUBMODULES) &&
+		   !(flags & TRANSPORT_PUSH_FORCE) &&
+		   !is_bare_repository()) {
 			struct ref *ref = remote_refs;
 			for (; ref; ref = ref->next)
 				if(!is_null_sha1(ref->new_sha1) && check_for_unpushed_submodule_commits(ref->new_sha1))
diff --git a/transport.h b/transport.h
index 161d724..c6ccf8c 100644
--- a/transport.h
+++ b/transport.h
@@ -101,6 +101,7 @@ struct transport {
 #define TRANSPORT_PUSH_MIRROR 8
 #define TRANSPORT_PUSH_PORCELAIN 16
 #define TRANSPORT_PUSH_SET_UPSTREAM 32
+#define TRANSPORT_PUSH_NO_RECURSE_SUBMODULES 64
 
 #define TRANSPORT_SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
 
-- 
1.7.6.236.g7ad21

From: =?utf-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
Subject: [PATCHv2 4/4] Rename push.default to push.mode
Date: Mon, 30 Mar 2009 12:11:43 +0200
Message-ID: <1238407903-28020-5-git-send-email-santi@agolina.net>
References: <1238407903-28020-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 30 12:15:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoEW2-0007Mz-2e
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 12:14:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758736AbZC3KMS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Mar 2009 06:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758687AbZC3KMS
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 06:12:18 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:57772 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758733AbZC3KMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 06:12:16 -0400
Received: by mail-fx0-f158.google.com with SMTP id 2so1882493fxm.37
        for <git@vger.kernel.org>; Mon, 30 Mar 2009 03:12:14 -0700 (PDT)
Received: by 10.223.126.66 with SMTP id b2mr3809160fas.18.1238407934300;
        Mon, 30 Mar 2009 03:12:14 -0700 (PDT)
Received: from localhost (p5B0D60BE.dip.t-dialin.net [91.13.96.190])
        by mx.google.com with ESMTPS id 22sm2224228fkr.14.2009.03.30.03.12.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Mar 2009 03:12:13 -0700 (PDT)
X-Mailer: git-send-email 1.6.1.258.g7ff14
In-Reply-To: <1238407903-28020-1-git-send-email-santi@agolina.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115130>

push.default was too generic, and also didn't specify if it was about
remote, refspec, branches, behaviour...

Signed-off-by: Santi B=C3=A9jar <santi@agolina.net>
---
 Documentation/RelNotes-1.6.3.txt |    2 +-
 Documentation/config.txt         |    4 ++--
 builtin-push.c                   |   16 ++++++++--------
 cache.h                          |   14 +++++++-------
 config.c                         |   10 +++++-----
 environment.c                    |    2 +-
 6 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/Documentation/RelNotes-1.6.3.txt b/Documentation/RelNotes-=
1.6.3.txt
index f0a2e41..67b2b66 100644
--- a/Documentation/RelNotes-1.6.3.txt
+++ b/Documentation/RelNotes-1.6.3.txt
@@ -24,7 +24,7 @@ receive.denyDeleteCurrent in the receiving repository=
=2E
=20
 When the user does not tell "git push" what to push, it has always
 pushed matching refs.  For some people it is unexpected, and a new
-configuration variable push.default has been introduced to allow
+configuration variable push.mode has been introduced to allow
 changing a different default behaviour.  To advertise the new feature,
 a big warning is issued if this is not configured and a git push witho=
ut
 arguments is attempted.
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 38ab785..80bb3a6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -480,7 +480,7 @@ branch.<name>.remote::
 branch.<name>.merge::
 	It defines, together with branch.<name>.remote, the upstream branch
 	for the given branch. It tells 'git-fetch'/'git-pull' which
-	branch to merge and can also afect 'git-push' (see push.default).
+	branch to merge and can also afect 'git-push' (see push.mode).
 	When in branch <name>, it tells 'git-fetch' the default
 	refspec to be marked for merging in FETCH_HEAD. The value is
 	handled like the remote part of a refspec, and must match a
@@ -1215,7 +1215,7 @@ pull.octopus::
 pull.twohead::
 	The default merge strategy to use when pulling a single branch.
=20
-push.default::
+push.mode::
 	Defines the action git push should take if no refspec is given
 	on the command line, no refspec is configured in the remote, and
 	no refspec is implied by any of the options given on the command
diff --git a/builtin-push.c b/builtin-push.c
index 2eabcd3..c2c4de1 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -72,7 +72,7 @@ static const char *warn_unconfigured_push_msg[] =3D {
 	"not necessarily be what you want to happen.",
 	"",
 	"You can specify what action you want to take in this case, and",
-	"avoid seeing this message again, by configuring 'push.default' to:",
+	"avoid seeing this message again, by configuring 'push.mode' to:",
 	"  'nothing'  : Do not push anything",
 	"  'matching' : Push all matching branches (default)",
 	"  'tracking' : Push the current branch to whatever it is tracking",
@@ -89,26 +89,26 @@ static void warn_unconfigured_push(void)
 static void setup_default_push_refspecs(void)
 {
 	git_config(git_default_config, NULL);
-	switch (push_default) {
-	case PUSH_DEFAULT_UNSPECIFIED:
+	switch (push_mode) {
+	case PUSH_MODE_UNSPECIFIED:
 		warn_unconfigured_push();
 		/* fallthrough */
=20
-	case PUSH_DEFAULT_MATCHING:
+	case PUSH_MODE_MATCHING:
 		add_refspec(":");
 		break;
=20
-	case PUSH_DEFAULT_TRACKING:
+	case PUSH_MODE_TRACKING:
 		setup_push_tracking();
 		break;
=20
-	case PUSH_DEFAULT_CURRENT:
+	case PUSH_MODE_CURRENT:
 		add_refspec("HEAD");
 		break;
=20
-	case PUSH_DEFAULT_NOTHING:
+	case PUSH_MODE_NOTHING:
 		die("You didn't specify any refspecs to push, and "
-		    "push.default is \"nothing\".");
+		    "push.mode is \"nothing\".");
 		break;
 	}
 }
diff --git a/cache.h b/cache.h
index 641529b..1625965 100644
--- a/cache.h
+++ b/cache.h
@@ -542,17 +542,17 @@ enum rebase_setup_type {
 	AUTOREBASE_ALWAYS,
 };
=20
-enum push_default_type {
-	PUSH_DEFAULT_UNSPECIFIED =3D -1,
-	PUSH_DEFAULT_NOTHING =3D 0,
-	PUSH_DEFAULT_MATCHING,
-	PUSH_DEFAULT_TRACKING,
-	PUSH_DEFAULT_CURRENT,
+enum push_mode_type {
+	PUSH_MODE_UNSPECIFIED =3D -1,
+	PUSH_MODE_NOTHING =3D 0,
+	PUSH_MODE_MATCHING,
+	PUSH_MODE_TRACKING,
+	PUSH_MODE_CURRENT,
 };
=20
 extern enum branch_track git_branch_track;
 extern enum rebase_setup_type autorebase;
-extern enum push_default_type push_default;
+extern enum push_mode_type push_mode;
=20
 #define GIT_REPO_VERSION 0
 extern int repository_format_version;
diff --git a/config.c b/config.c
index b76fe4c..ba02cfb 100644
--- a/config.c
+++ b/config.c
@@ -567,17 +567,17 @@ static int git_default_branch_config(const char *=
var, const char *value)
=20
 static int git_default_push_config(const char *var, const char *value)
 {
-	if (!strcmp(var, "push.default")) {
+	if (!strcmp(var, "push.mode")) {
 		if (!value)
 			return config_error_nonbool(var);
 		else if (!strcmp(value, "nothing"))
-			push_default =3D PUSH_DEFAULT_NOTHING;
+			push_mode =3D PUSH_MODE_NOTHING;
 		else if (!strcmp(value, "matching"))
-			push_default =3D PUSH_DEFAULT_MATCHING;
+			push_mode =3D PUSH_MODE_MATCHING;
 		else if (!strcmp(value, "tracking"))
-			push_default =3D PUSH_DEFAULT_TRACKING;
+			push_mode =3D PUSH_MODE_TRACKING;
 		else if (!strcmp(value, "current"))
-			push_default =3D PUSH_DEFAULT_CURRENT;
+			push_mode =3D PUSH_MODE_CURRENT;
 		else {
 			error("Malformed value for %s: %s", var, value);
 			return error("Must be one of nothing, matching, "
diff --git a/environment.c b/environment.c
index 4696885..c925ea4 100644
--- a/environment.c
+++ b/environment.c
@@ -42,7 +42,7 @@ enum safe_crlf safe_crlf =3D SAFE_CRLF_WARN;
 unsigned whitespace_rule_cfg =3D WS_DEFAULT_RULE;
 enum branch_track git_branch_track =3D BRANCH_TRACK_REMOTE;
 enum rebase_setup_type autorebase =3D AUTOREBASE_NEVER;
-enum push_default_type push_default =3D PUSH_DEFAULT_UNSPECIFIED;
+enum push_mode_type push_mode =3D PUSH_MODE_UNSPECIFIED;
=20
 /* Parallel index stat data preload? */
 int core_preload_index =3D 0;
--=20
1.6.1.258.g7ff14

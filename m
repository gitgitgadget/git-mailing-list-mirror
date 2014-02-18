From: =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
Subject: [PATCH v2 1/3] revert.c: Allow to specify -x via git-config
Date: Tue, 18 Feb 2014 22:27:40 +0100
Message-ID: <85b9fa68b1a5542817489ddbe186cbb7600599b0.1392758057.git.agx@sigxcpu.org>
References: <20140218192039.GC7855@google.com>
 <cover.1392758057.git.agx@sigxcpu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 18 22:28:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFsDH-0004wn-Dp
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 22:28:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978AbaBRV2F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 16:28:05 -0500
Received: from xvm-169-183.ghst.net ([95.142.169.183]:44666 "EHLO
	photon.sigxcpu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914AbaBRV2D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 16:28:03 -0500
Received: from honk.sigxcpu.org (localhost [IPv6:::1])
	by photon.sigxcpu.org (Postfix) with ESMTPS id 2C8066E5
	for <git@vger.kernel.org>; Tue, 18 Feb 2014 22:28:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by honk.sigxcpu.org (Postfix) with ESMTP id 80227FB02
	for <git@vger.kernel.org>; Tue, 18 Feb 2014 22:28:01 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from honk.sigxcpu.org ([127.0.0.1])
	by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7cJRvVsL36xX for <git@vger.kernel.org>;
	Tue, 18 Feb 2014 22:28:00 +0100 (CET)
X-Mailer: git-send-email 1.9.0.rc3
In-Reply-To: <cover.1392758057.git.agx@sigxcpu.org>
In-Reply-To: <cover.1392758057.git.agx@sigxcpu.org>
References: <cover.1392758057.git.agx@sigxcpu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242357>

Without this when maintaining stable branches it's easy to forget to use
-x to track where a patch was cherry-picked from.
---
 Documentation/config.txt          |  4 ++++
 Documentation/git-cherry-pick.txt |  8 ++++++++
 builtin/revert.c                  | 14 +++++++++++++-
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5f4d793..a47d045 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -794,6 +794,10 @@ browser.<tool>.path::
 	browse HTML help (see '-w' option in linkgit:git-help[1]) or a
 	working repository in gitweb (see linkgit:git-instaweb[1]).
 
+cherrypick.recordOrigin::
+	When cherry picking patches record the sha1 of the original
+	commit in the commit message. Defaults to `false`.
+
 clean.requireForce::
 	A boolean to make git-clean do nothing unless given -f,
 	-i or -n.   Defaults to true.
diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index c205d23..c0274bd 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -215,6 +215,14 @@ the working tree.
 spending extra time to avoid mistakes based on incorrectly matching
 context lines.
 
+CONFIGURATION
+-------------
+
+See linkgit:git-config[1] for core variables.
+
+cherrypick.recordOrigin::
+	Default for the `-x` option. Defaults to `false`.
+
 SEE ALSO
 --------
 linkgit:git-revert[1]
diff --git a/builtin/revert.c b/builtin/revert.c
index 87659c9..0c14af4 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -196,6 +196,18 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 	return res;
 }
 
+static int git_cherry_pick_config(const char *var, const char *value, void *cb)
+{
+	struct replay_opts *opts = cb;
+
+	if (!strcmp(var, "cherrypick.recordorigin")) {
+		opts->record_origin = git_config_bool (var, value);
+		return 0;
+	} else {
+		return git_config(git_default_config, NULL);
+	}
+}
+
 int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 {
 	struct replay_opts opts;
@@ -203,7 +215,7 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 
 	memset(&opts, 0, sizeof(opts));
 	opts.action = REPLAY_PICK;
-	git_config(git_default_config, NULL);
+	git_config(git_cherry_pick_config, &opts);
 	parse_args(argc, argv, &opts);
 	res = sequencer_pick_revisions(&opts);
 	if (res < 0)
-- 
1.9.0.rc3

From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2] receive-pack: optionally deny case clone refs
Date: Tue,  3 Jun 2014 23:13:27 -0400
Message-ID: <1401851607-8255-1-git-send-email-dturner@twitter.com>
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jun 04 05:13:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ws1eG-0000Xu-UA
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 05:13:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754486AbaFDDNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 23:13:49 -0400
Received: from mail-qa0-f51.google.com ([209.85.216.51]:58182 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753413AbaFDDNs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 23:13:48 -0400
Received: by mail-qa0-f51.google.com with SMTP id w8so6144646qac.38
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 20:13:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7p0sVylsXkfW4cIIZYw74hs6Ma/8rkdaQYIpDf3XevM=;
        b=S6SIQzB9Dpogsn8QXRpwaH6LvGkWAckp0EZf3RDIw+p5A/P3mPiigZaAu1+q4/tZu7
         zObs3aSOsaWGMiZ9PMTTaIijrHzYNLK2TwPx9EZN2k8JEDWxvYjEf/Z3fYmEm7WCLF3O
         UzAA9mR31j5J/TaX91Cthu/16QHhnvniHs18ZO9WBba/EuHqNA5oF2sE3If9hWDmtfz5
         2PF5pQiTRBFT3mz9XOARX/PveHS+AZ7VOFjI6sUDeGdIpYRfpx+CktP4vlBM/YBU0blA
         ZlnF1Djeee24O6UsUvbinW348qDr6Ld120u7IpclZmRJL3uECz+k609M2nNrgJcgSpor
         pyWw==
X-Gm-Message-State: ALoCoQn20m9spSwlpHDWEZYiPN/JIRcrqYz/PznZNq9wbhwqcQNPefxbA+DlOZazKMZdOv3T/BSW
X-Received: by 10.140.29.34 with SMTP id a31mr63048366qga.95.1401851628032;
        Tue, 03 Jun 2014 20:13:48 -0700 (PDT)
Received: from stross.twitter.corp ([8.25.196.25])
        by mx.google.com with ESMTPSA id g4sm2043011qay.6.2014.06.03.20.13.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jun 2014 20:13:47 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.0.rc1.18.gf763c0f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250711>

It is possible to have two branches which are the same but for case.
This works great on the case-sensitive filesystems, but not so well on
case-insensitive filesystems.  It is fairly typical to have
case-insensitive clients (Macs, say) with a case-sensitive server
(GNU/Linux).

Should a user attempt to pull on a Mac when there are case clone
branches with differing contents, they'll get an error message
containing something like "Ref refs/remotes/origin/lower is at
[sha-of-lowercase-branch] but expected [sha-of-uppercase-branch]....
(unable to update local ref)"

With a case-insensitive git server, if a branch called capital-M
Master (that differs from lowercase-m-master) is pushed, nobody else
can push to (lowercase-m) master until the branch is removed.

Create the option receive.denycaseclonebranches, which checks pushed
branches to ensure that they are not case clones of an existing
branch.  This setting is turned on by default if core.ignorecase is
set, but not otherwise.

Signed-off-by: David Turner <dturner@twitter.com>
---
 Documentation/config.txt           |  6 ++++++
 Documentation/git-push.txt         |  5 +++--
 Documentation/glossary-content.txt |  5 +++++
 builtin/receive-pack.c             | 27 +++++++++++++++++++++++-
 t/t5400-send-pack.sh               | 43 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 83 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1932e9b..4deddf8 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2053,6 +2053,12 @@ receive.unpackLimit::
 	especially on slow filesystems.  If not set, the value of
 	`transfer.unpackLimit` is used instead.
 
+receive.denyCaseCloneBranches::
+	If set to true, git-receive-pack will deny a ref update that creates
+	a ref which is the same but for case as an existing ref.  This is
+	useful when clients are on a case-insensitive filesystem, which
+	will cause errors when given refs which differ only in case.
+
 receive.denyDeletes::
 	If set to true, git-receive-pack will deny a ref update that deletes
 	the ref. Use this to prevent such a ref deletion via a push.
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 21cd455..0786fb3 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -323,8 +323,9 @@ remote rejected::
 	of the following safety options in effect:
 	`receive.denyCurrentBranch` (for pushes to the checked out
 	branch), `receive.denyNonFastForwards` (for forced
-	non-fast-forward updates), `receive.denyDeletes` or
-	`receive.denyDeleteCurrent`.  See linkgit:git-config[1].
+	non-fast-forward updates), `receive.denyDeletes`,
+	`receive.denyCaseCloneBranches` or `receive.denyDeleteCurrent`.
+	See linkgit:git-config[1].
 
 remote failure::
 	The remote end did not report the successful update of the ref,
diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index be0858c..ed5ac23 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -31,6 +31,11 @@
 [[def_cache]]cache::
 	Obsolete for: <<def_index,index>>.
 
+[[def_case_clone]]case clone::
+	Two entities (e.g. filenames or refs) that differ only in case.
+	These can cause problems on case-insensitive filesystems, and
+	Git has machinery to prevent these problems in various cases.
+
 [[def_chain]]chain::
 	A list of objects, where each <<def_object,object>> in the list contains
 	a reference to its successor (for example, the successor of a
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c323081..4df99c5 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -27,6 +27,7 @@ enum deny_action {
 
 static int deny_deletes;
 static int deny_non_fast_forwards;
+static int deny_case_clone_branches = DENY_UNCONFIGURED;
 static enum deny_action deny_current_branch = DENY_UNCONFIGURED;
 static enum deny_action deny_delete_current = DENY_UNCONFIGURED;
 static int receive_fsck_objects = -1;
@@ -69,6 +70,11 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 	if (status)
 		return status;
 
+	if (strcmp(var, "receive.denycaseclonebranches") == 0) {
+		deny_case_clone_branches = parse_deny_action(var, value);
+		return 0;
+	}
+
 	if (strcmp(var, "receive.denydeletes") == 0) {
 		deny_deletes = git_config_bool(var, value);
 		return 0;
@@ -468,6 +474,22 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
 	return 0;
 }
 
+static int is_case_clone(const char *refname, const unsigned char *sha1,
+			int flags, void *cb_data)
+{
+	const char *incoming_refname = cb_data;
+	return !strcasecmp(refname, incoming_refname) &&
+		strcmp(refname, incoming_refname);
+}
+
+static int ref_is_denied_case_clone(const char *name)
+{
+	if (!deny_case_clone_branches)
+		return 0;
+
+	return for_each_ref(is_case_clone, (void *) name);
+}
+
 static const char *update(struct command *cmd, struct shallow_info *si)
 {
 	const char *name = cmd->ref_name;
@@ -478,7 +500,8 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 	struct ref_lock *lock;
 
 	/* only refs/... are allowed */
-	if (!starts_with(name, "refs/") || check_refname_format(name + 5, 0)) {
+	if (!starts_with(name, "refs/") || check_refname_format(name + 5, 0) ||
+	    ref_is_denied_case_clone(name)) {
 		rp_error("refusing to create funny ref '%s' remotely", name);
 		return "funny refname";
 	}
@@ -1171,6 +1194,8 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		die("'%s' does not appear to be a git repository", dir);
 
 	git_config(receive_pack_config, NULL);
+	if (deny_case_clone_branches == DENY_UNCONFIGURED)
+		deny_case_clone_branches = ignore_case;
 
 	if (0 <= transfer_unpack_limit)
 		unpack_limit = transfer_unpack_limit;
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 0736bcb..fd95231 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -129,6 +129,49 @@ test_expect_success 'denyNonFastforwards trumps --force' '
 	test "$victim_orig" = "$victim_head"
 '
 
+test_expect_success 'denyCaseCloneBranches works' '
+	(
+	    cd victim &&
+	    git config receive.denyCaseCloneBranches true
+	    git config receive.denyDeletes false
+	) &&
+	git send-pack ./victim HEAD:refs/heads/caseclone &&
+	orig_ver=$(git rev-parse HEAD) &&
+	test_must_fail git send-pack ./victim HEAD^:refs/heads/CaseClone &&
+	#confirm that this had no effect upstream
+	(
+	    cd victim &&
+	    test_must_fail git rev-parse CaseClone &&
+	    remote_ver=$(git rev-parse caseclone) &&
+	    test $orig_ver = $remote_ver
+	) &&
+	git send-pack ./victim HEAD^:refs/heads/notacaseclone &&
+	test_must_fail git send-pack ./victim :CaseClone &&
+	#confirm that this had no effect upstream
+	(
+	    cd victim &&
+	    test_must_fail git rev-parse CaseClone &&
+	    remote_ver=$(git rev-parse caseclone) &&
+	    test $orig_ver = $remote_ver
+	) &&
+	git send-pack ./victim :caseclone &&
+	#confirm that this took effect upstream
+	(
+	    cd victim &&
+	    test_must_fail git rev-parse caseclone
+	)
+	#check that we can recreate a branch after deleting a
+	#case-clone of it
+	case_clone_ver=$(git rev-parse HEAD^)
+	git send-pack ./victim HEAD^:CaseClone &&
+	(
+	    cd victim &&
+	    test_must_fail git rev-parse caseclone &&
+	    remote_ver=$(git rev-parse CaseClone) &&
+	    test $case_clone_ver = $remote_ver
+	)
+'
+
 test_expect_success 'push --all excludes remote-tracking hierarchy' '
 	mkdir parent &&
 	(
-- 
2.0.0.rc1.18.gf763c0f

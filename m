From: David Turner <dturner@twopensource.com>
Subject: [PATCH] receive-pack: optionally deny case-clone refs
Date: Tue,  3 Jun 2014 15:14:56 -0400
Message-ID: <1401822896-816-1-git-send-email-dturner@twitter.com>
Cc: David Turner <dturner@twitter.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 21:15:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WruBD-00044o-02
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 21:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753897AbaFCTPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 15:15:23 -0400
Received: from mail-qa0-f44.google.com ([209.85.216.44]:65268 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752813AbaFCTPW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 15:15:22 -0400
Received: by mail-qa0-f44.google.com with SMTP id j7so5521640qaq.31
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 12:15:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oNOTz2mGNJVb3vu4dReCQfPBvOKfWcwRqY8kHU5Z+6E=;
        b=Zm/CbPNXUvpj5IV3UfMXJAAOx3PJYTFjRBl3pVgMW9jHBbScDjqpZkgQAnmlZ2AFfH
         84qc/zqCxYkgS/ZgvRJEbH2uPv+xViK9l6hNwOgpcSwIYPTYFvBKMrWzd+sLr4PQyrN0
         IkFFsX42ln4IxKTOA+lyiBL/OvUhseiB5z9HgxuF7gthNkZDqLaI81nBc7BYW7lKRZp+
         2t1G+ps3BkToF/C78wNYAvrgynk/EgvA+yvqNfgNxs71hIptJzdnfBa0bHaMkLNfVb9d
         RJefhhl/7p0Jfdb3yPyc4RagXFrRtlDwfmz+o5/Xqw5HHE0Be/G6O2yQhFRZUGVJ8ZtC
         TXXg==
X-Gm-Message-State: ALoCoQl1TYD9ozdU3akbWrhbWLu56l1gEtf/NE/yEO7FT5090wsl4Iibs4BYQGlI/1xuOGN8gA9U
X-Received: by 10.224.151.82 with SMTP id b18mr65017199qaw.27.1401822920899;
        Tue, 03 Jun 2014 12:15:20 -0700 (PDT)
Received: from stross.twitter.corp ([38.104.173.198])
        by mx.google.com with ESMTPSA id t4sm217550qat.4.2014.06.03.12.15.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jun 2014 12:15:19 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.0.rc1.18.gf763c0f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250640>

It is possible to have two branches which are the same but for case.
This works great on the case-sensitive filesystems, but not so well on
case-insensitive filesystems.  It is fairly typical to have
case-insensitive clients (Macs, say) with a case-sensitive server
(GNU/Linux).

Should a user attempt to pull on a Mac when there are case-clone
branches with differing contents, they'll get an error message
containing something like "Ref refs/remotes/origin/lower is at
[sha-of-lowercase-branch] but expected [sha-of-uppercase-branch]....
(unable to update local ref)"

With a case-insensitive git server, if a branch called capital-M
Master (that differs from lowercase-m-master) is pushed, nobody else
can push to (lowercase-m) master until the branch is removed.

Create the option receive.denycaseclonebranches, which checks pushed
branches to ensure that they are not case-clones of an existing
branch.  This setting is turned on by default if core.ignorecase is
set, but not otherwise.

Signed-off-by: David Turner <dturner@twitter.com>
---
 builtin/receive-pack.c | 29 ++++++++++++++++++++++++++++-
 t/t5400-send-pack.sh   | 20 ++++++++++++++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c323081..0894ded 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -27,6 +27,7 @@ enum deny_action {
 
 static int deny_deletes;
 static int deny_non_fast_forwards;
+static int deny_case_clone_branches = -1;
 static enum deny_action deny_current_branch = DENY_UNCONFIGURED;
 static enum deny_action deny_delete_current = DENY_UNCONFIGURED;
 static int receive_fsck_objects = -1;
@@ -69,6 +70,11 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 	if (status)
 		return status;
 
+	if (strcmp(var, "receive.denycaseclonebranches") == 0) {
+		deny_case_clone_branches = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (strcmp(var, "receive.denydeletes") == 0) {
 		deny_deletes = git_config_bool(var, value);
 		return 0;
@@ -468,6 +474,24 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
 	return 0;
 }
 
+static int is_case_clone(const char *refname, const unsigned char *sha1,
+			int flags, void *cb_data)
+{
+	const char* incoming_refname = cb_data;
+	return !strcasecmp(refname, incoming_refname) &&
+		strcmp(refname, incoming_refname);
+}
+
+static int ref_is_denied_case_clone(const char *name)
+{
+
+	if (!deny_case_clone_branches)
+		return 0;
+
+	return for_each_ref(is_case_clone, (void *) name);
+
+}
+
 static const char *update(struct command *cmd, struct shallow_info *si)
 {
 	const char *name = cmd->ref_name;
@@ -478,7 +502,8 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 	struct ref_lock *lock;
 
 	/* only refs/... are allowed */
-	if (!starts_with(name, "refs/") || check_refname_format(name + 5, 0)) {
+	if (!starts_with(name, "refs/") || check_refname_format(name + 5, 0) ||
+	    ref_is_denied_case_clone(name)) {
 		rp_error("refusing to create funny ref '%s' remotely", name);
 		return "funny refname";
 	}
@@ -1171,6 +1196,8 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		die("'%s' does not appear to be a git repository", dir);
 
 	git_config(receive_pack_config, NULL);
+	if (deny_case_clone_branches == -1)
+		deny_case_clone_branches = ignore_case;
 
 	if (0 <= transfer_unpack_limit)
 		unpack_limit = transfer_unpack_limit;
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 0736bcb..099c0e3 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -129,6 +129,26 @@ test_expect_success 'denyNonFastforwards trumps --force' '
 	test "$victim_orig" = "$victim_head"
 '
 
+if ! test_have_prereq CASE_INSENSITIVE_FS
+then
+test_expect_success 'denyCaseCloneBranches works' '
+	(
+	    cd victim &&
+	    git config receive.denyCaseCloneBranches true
+	    git config receive.denyDeletes false
+	) &&
+	git checkout -b caseclone &&
+	git send-pack ./victim caseclone &&
+	git checkout -b CaseClone &&
+	test_must_fail git send-pack ./victim CaseClone &&
+	git checkout -b notacaseclone &&
+	git send-pack ./victim notacaseclone &&
+	test_must_fail git send-pack ./victim :CaseClone &&
+	git send-pack ./victim :caseclone &&
+	git send-pack ./victim CaseClone
+'
+fi
+
 test_expect_success 'push --all excludes remote-tracking hierarchy' '
 	mkdir parent &&
 	(
-- 
2.0.0.rc1.18.gf763c0f

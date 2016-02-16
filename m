From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 00/15] config: make git_config_set die on failure
Date: Tue, 16 Feb 2016 13:56:27 +0100
Message-ID: <1455627402-752-1-git-send-email-ps@pks.im>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	ps@pks.im, Eric Sunshine <sunshine@sunshineco.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 14:00:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfFO-0004fp-EW
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:00:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbcBPNAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 08:00:44 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:44657 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932095AbcBPM4v (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2016 07:56:51 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id AE097208C5
	for <git@vger.kernel.org>; Tue, 16 Feb 2016 07:56:50 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 16 Feb 2016 07:56:50 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:message-id:subject:to
	:x-sasl-enc:x-sasl-enc; s=smtpout; bh=d9tvLC0EzUwpHqhGJ+i94dgdi9
	I=; b=dMVNLv5OX9C9jJnIIVfeDVPA2YCgPuZlWBtj720JPKj2eUZe+QVhUauRfA
	SATUcflHUdUMlurvdsdef3L9LShRWbGAq4jFPh9qRFE0wb2v0uWQe58tqQkOyc6t
	HRlc5fQN/TWs8zkYPbI9Ugk2kyHOF3VOSqsj3lQ0evaK+6oa8=
X-Sasl-enc: 51srMEneJZaL+YbmFqV6STL6NSjl70stVUFe06wxB8QY 1455627410
Received: from localhost (unknown [46.189.27.162])
	by mail.messagingengine.com (Postfix) with ESMTPA id 3A6AAC00014;
	Tue, 16 Feb 2016 07:56:50 -0500 (EST)
X-Mailer: git-send-email 2.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286355>

Fifth version of the config refactorings, version 4 can be found
at [1]. Besides fixing up the Signed-off's and a typo in a commit
message pointed out by Eric Sunshine the biggest changes relate
to install_branch_config.

Junio pointed out that it might not always be the most sensible
thing to die when install_branch_config fails. After thinking
about it I changed the behavior of the function to print an error
and advise message and return an error code. The error code is
then only used by the `git branch --set-upstream-to=` command to
abort early, as its main intent will usually be to set the
tracking information. The other callers (related to git-clone and
git-push) simply ignore the returned value while the messages are
still printed.

I think it does make sense to not abort clones and pushes when
the function fails. Setting the upstream information is only a
small part of these commands and especially when cloning a large
repository it is harmful to die as this would delete everything
that has just been cloned. The user can still fix up the remote
tracking branch afterwards.

[1]: http://article.gmane.org/gmane.comp.version-control.git/285250

Interdiff between v4 and v5:

diff --git a/branch.c b/branch.c
index 0c11023..06942ef 100644
--- a/branch.c
+++ b/branch.c
@@ -49,7 +49,13 @@ static int should_setup_rebase(const char *origin)
 	return 0;
 }
 
-void install_branch_config(int flag, const char *local, const char *origin, const char *remote)
+static const char tracking_advice[] =
+N_("\n"
+"After fixing the error cause you may try to fix up\n"
+"the remote tracking information by invoking\n"
+"\"git branch --set-upstream-to=\".");
+
+int install_branch_config(int flag, const char *local, const char *origin, const char *remote)
 {
 	const char *shortname = NULL;
 	struct strbuf key = STRBUF_INIT;
@@ -60,20 +66,23 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
 	    && !origin) {
 		warning(_("Not setting branch %s as its own upstream."),
 			local);
-		return;
+		return 0;
 	}
 
 	strbuf_addf(&key, "branch.%s.remote", local);
-	git_config_set(key.buf, origin ? origin : ".");
+	if (git_config_set_gently(key.buf, origin ? origin : ".") < 0)
+		goto out_err;
 
 	strbuf_reset(&key);
 	strbuf_addf(&key, "branch.%s.merge", local);
-	git_config_set(key.buf, remote);
+	if (git_config_set_gently(key.buf, remote) < 0)
+		goto out_err;
 
 	if (rebasing) {
 		strbuf_reset(&key);
 		strbuf_addf(&key, "branch.%s.rebase", local);
-		git_config_set(key.buf, "true");
+		if (git_config_set_gently(key.buf, "true") < 0)
+		    goto out_err;
 	}
 	strbuf_release(&key);
 
@@ -102,6 +111,14 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
 					  local, remote);
 		}
 	}
+
+	return 0;
+
+out_err:
+	strbuf_release(&key);
+	error(_("Unable to write upstream branch configuration"));
+	advise(_(tracking_advice));
+	return -1;
 }
 
 /*
@@ -134,8 +151,9 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 		die(_("Not tracking: ambiguous information for ref %s"),
 		    orig_ref);
 
-	install_branch_config(config_flags, new_ref, tracking.remote,
-			      tracking.src ? tracking.src : orig_ref);
+	if (install_branch_config(config_flags, new_ref, tracking.remote,
+			      tracking.src ? tracking.src : orig_ref) < 0)
+		exit(-1);
 
 	free(tracking.src);
 }
diff --git a/branch.h b/branch.h
index 8ce22f8..78ad438 100644
--- a/branch.h
+++ b/branch.h
@@ -43,10 +43,10 @@ void remove_branch_state(void);
 /*
  * Configure local branch "local" as downstream to branch "remote"
  * from remote "origin".  Used by git branch --set-upstream.
- * Dies if unable to install branch config.
+ * Returns 0 on success.
  */
 #define BRANCH_CONFIG_VERBOSE 01
-extern void install_branch_config(int flag, const char *local, const char *origin, const char *remote);
+extern int install_branch_config(int flag, const char *local, const char *origin, const char *remote);
 
 /*
  * Read branch description


Patrick Steinhardt (15):
  config: introduce set_or_die wrappers
  branch: report errors in tracking branch setup
  branch: die on config error when unsetting upstream
  branch: die on config error when editing branch description
  submodule: die on config error when linking modules
  submodule--helper: die on config error when cloning module
  remote: die on config error when setting URL
  remote: die on config error when setting/adding branches
  remote: die on config error when manipulating remotes
  clone: die on config error in cmd_clone
  init-db: die on config errors when initializing empty repo
  sequencer: die on config error when saving replay opts
  compat: die when unable to set core.precomposeunicode
  config: rename git_config_set to git_config_set_gently
  config: rename git_config_set_or_die to git_config_set

 branch.c                 | 45 +++++++++++++++++++++----------
 branch.h                 |  3 ++-
 builtin/branch.c         |  5 ++--
 builtin/clone.c          |  2 +-
 builtin/config.c         | 28 +++++++++----------
 builtin/init-db.c        |  2 +-
 builtin/remote.c         | 70 +++++++++++++++++-------------------------------
 cache.h                  | 14 ++++++----
 compat/precompose_utf8.c |  3 ++-
 config.c                 | 52 ++++++++++++++++++++++++++---------
 submodule.c              | 10 +++----
 t/t3200-branch.sh        | 16 ++++++++++-
 t/t5505-remote.sh        |  9 +++++++
 13 files changed, 154 insertions(+), 105 deletions(-)

-- 
2.7.1

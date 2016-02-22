From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v6 00/15] config: make git_config_set die on failure
Date: Mon, 22 Feb 2016 12:23:21 +0100
Message-ID: <1456140216-24169-1-git-send-email-ps@pks.im>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	ps@pks.im, Eric Sunshine <sunshine@sunshineco.com>,
	Stefan Beller <sbeller@google.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Michael Blume <blume.mike@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 12:24:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXobW-0000Ps-VA
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 12:24:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754497AbcBVLYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 06:24:36 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:43269 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754492AbcBVLYe (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Feb 2016 06:24:34 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 40D1D20C0D
	for <git@vger.kernel.org>; Mon, 22 Feb 2016 06:24:34 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 22 Feb 2016 06:24:34 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:message-id:subject:to
	:x-sasl-enc:x-sasl-enc; s=smtpout; bh=BhSzlyDQWuVyDQaHkVWbd9teUT
	E=; b=S8mi3Lt3vGTb/6unSGtmyWjZg53th7DU4rrShv7XKp19IMUnhINTK/xZTK
	UkI16HdwOEQZoF/94bryw38DymWHFDos9pQyIkXVIZrBB5dq3domH3ir26eZHUr1
	H/cxeY7vJBB/DQaku53lJlw5Isrey+kgO45l30145qFV9TEYU=
X-Sasl-enc: nHJ0nXhzm2iaxsACLt1EMc/3WOWZ87GwTyFO1CoIsRg7 1456140273
Received: from localhost (unknown [46.189.27.162])
	by mail.messagingengine.com (Postfix) with ESMTPA id 94B7C68015B;
	Mon, 22 Feb 2016 06:24:33 -0500 (EST)
X-Mailer: git-send-email 2.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286909>

Next revision of my patch series to improve error handling on
git_config_set. Only three small changes to v5 [1], thanks for
pointing these out:

    - fixed missing conversion of git_config_set_or_die in
      compat/precompose_utf8.c
    - fixed indentation in install_branch_config
    - improved advise message to give the complete command for
      fixing up the upstream configuration, including the actual
      tracking branch

[1]: http://article.gmane.org/gmane.comp.version-control.git/286355

Interdiff to v5:

diff --git a/branch.c b/branch.c
index 06942ef..c50ea42 100644
--- a/branch.c
+++ b/branch.c
@@ -53,7 +53,7 @@ static const char tracking_advice[] =
 N_("\n"
 "After fixing the error cause you may try to fix up\n"
 "the remote tracking information by invoking\n"
-"\"git branch --set-upstream-to=\".");
+"\"git branch --set-upstream-to=%s%s%s\".");
 
 int install_branch_config(int flag, const char *local, const char *origin, const char *remote)
 {
@@ -82,7 +82,7 @@ int install_branch_config(int flag, const char *local, const char *origin, const
 		strbuf_reset(&key);
 		strbuf_addf(&key, "branch.%s.rebase", local);
 		if (git_config_set_gently(key.buf, "true") < 0)
-		    goto out_err;
+			goto out_err;
 	}
 	strbuf_release(&key);
 
@@ -117,7 +117,12 @@ int install_branch_config(int flag, const char *local, const char *origin, const
 out_err:
 	strbuf_release(&key);
 	error(_("Unable to write upstream branch configuration"));
-	advise(_(tracking_advice));
+
+	advise(_(tracking_advice),
+	       origin ? origin : "",
+	       origin ? "/" : "",
+	       shortname ? shortname : remote);
+
 	return -1;
 }
 
diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index 9ff1ebe..dfbe6d8 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -50,8 +50,8 @@ void probe_utf8_pathname_composition(void)
 		close(output_fd);
 		git_path_buf(&path, "%s", auml_nfd);
 		precomposed_unicode = access(path.buf, R_OK) ? 0 : 1;
-		git_config_set_or_die("core.precomposeunicode",
-				      precomposed_unicode ? "true" : "false");
+		git_config_set("core.precomposeunicode",
+			       precomposed_unicode ? "true" : "false");
 		git_path_buf(&path, "%s", auml_nfc);
 		if (unlink(path.buf))
 			die_errno(_("failed to unlink '%s'"), path.buf);

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

 branch.c                 | 50 ++++++++++++++++++++++++----------
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
 13 files changed, 159 insertions(+), 105 deletions(-)

-- 
2.7.1

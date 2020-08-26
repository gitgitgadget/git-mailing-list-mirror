Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA5AC433E1
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 01:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 925FC2075E
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 01:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DRTrHp8U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgHZBRf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 21:17:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57642 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbgHZBRd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 21:17:33 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4DD3482FD9;
        Tue, 25 Aug 2020 21:17:29 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=V/fm9Ajw39oPmWmHUp0JYLwHZ
        kw=; b=DRTrHp8ULAy+Pwnr2PL4WGzzxuVNNcgc6qvJp6QeYjFukmrHbquCxJpd/
        oPIBDCcC9FMCfYvlo14AV7G2JnIG1KwwaTLdi7pMCzjc3kTG0+WNeTYkPVTpByYq
        5r6oa1vMgqAIp9lJjGaNNVPLUOL/kW9//DaDeBxYAEJCNz18wA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=IdK0xSlXY1vGYnhWlFB
        K7bJzjpPp3JZkpMWAca15Y+g+ZH1bxWKBFk3Rc86bENpCcROCd0iyHx6KCqEE4sZ
        e0ih5f3cz9k1rzcH3VfxqEGtpH0HuP9vUCmH8AWAwApdKMk2gPbmPgNN6djMkOOk
        zGhwnsh0zUErgsdrXRyOf5XQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4561F82FD8;
        Tue, 25 Aug 2020 21:17:29 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C215E82FD7;
        Tue, 25 Aug 2020 21:17:28 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v1 3/3] git: catch an attempt to run "git-foo"
Date:   Tue, 25 Aug 2020 18:17:18 -0700
Message-Id: <20200826011718.3186597-4-gitster@pobox.com>
X-Mailer: git-send-email 2.28.0-454-g5f859b1948
In-Reply-To: <20200826011718.3186597-1-gitster@pobox.com>
References: <xmqq1rjuz6n3.fsf_-_@gitster.c.googlers.com>
 <20200826011718.3186597-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: E880DC16-E739-11EA-8984-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we were to propose removing "git-foo" binaries from the
filesystem for built-in commands, we should first see if there are
users who will be affected by such a move.  When cmd_main() detects
we were called not as "git", but as "git-foo", give an error message
to ask the user to let us know and stop our removal plan, unless we
are running a selected few programs that MUST be callable in the
dashed form (e.g. "git-upload-pack").

Those who are always using "git foo" form will not be affected, but
those who trusted the promise we made to them 12 years ago that by
prepending the output of $(git --exec-path) to the list of
directories on their $PATH, they can safely keep writing
"git-cat-file" will be negatively affected as all their scripts
assuming the promise will be kept are now broken.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 command-list.txt | 11 +++++++----
 git.c            |  2 ++
 help.c           | 34 ++++++++++++++++++++++++++++++++++
 help.h           |  3 +++
 4 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/command-list.txt b/command-list.txt
index e5901f2213..1238f6ec8b 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -39,6 +39,9 @@
 # mainporcelain commands are completable so you don't need this
 # attribute.
 #
+# "onpath" attribute is used to mark that the command MUST appear
+# on $PATH (typically in /usr/bin) due to protocol requirement.
+#
 # As part of the Git man page list, the man(5/7) guides are also
 # specified here, which can only have "guide" attribute and nothing
 # else.
@@ -144,7 +147,7 @@ git-quiltimport                         foreignscmint=
erface
 git-range-diff                          mainporcelain
 git-read-tree                           plumbingmanipulators
 git-rebase                              mainporcelain           history
-git-receive-pack                        synchelpers
+git-receive-pack                        synchelpers        onpath
 git-reflog                              ancillarymanipulators           =
complete
 git-remote                              ancillarymanipulators           =
complete
 git-repack                              ancillarymanipulators           =
complete
@@ -159,7 +162,7 @@ git-rev-parse                           plumbinginter=
rogators
 git-rm                                  mainporcelain           worktree
 git-send-email                          foreignscminterface             =
complete
 git-send-pack                           synchingrepositories
-git-shell                               synchelpers
+git-shell                               synchelpers        onpath
 git-shortlog                            mainporcelain
 git-show                                mainporcelain           info
 git-show-branch                         ancillaryinterrogators          =
complete
@@ -182,8 +185,8 @@ git-unpack-objects                      plumbingmanip=
ulators
 git-update-index                        plumbingmanipulators
 git-update-ref                          plumbingmanipulators
 git-update-server-info                  synchingrepositories
-git-upload-archive                      synchelpers
-git-upload-pack                         synchelpers
+git-upload-archive                      synchelpers        onpath
+git-upload-pack                         synchelpers        onpath
 git-var                                 plumbinginterrogators
 git-verify-commit                       ancillaryinterrogators
 git-verify-pack                         plumbinginterrogators
diff --git a/git.c b/git.c
index 8bd1d7551d..927018bda7 100644
--- a/git.c
+++ b/git.c
@@ -839,6 +839,8 @@ int cmd_main(int argc, const char **argv)
 	 * that one cannot handle it.
 	 */
 	if (skip_prefix(cmd, "git-", &cmd)) {
+		warn_on_dashed_git(argv[0]);
+
 		argv[0] =3D cmd;
 		handle_builtin(argc, argv);
 		die(_("cannot handle %s as a builtin"), cmd);
diff --git a/help.c b/help.c
index d478afb2af..490d2bc3ae 100644
--- a/help.c
+++ b/help.c
@@ -720,3 +720,37 @@ NORETURN void help_unknown_ref(const char *ref, cons=
t char *cmd,
 	string_list_clear(&suggested_refs, 0);
 	exit(1);
 }
+
+static struct cmdname_help *find_cmdname_help(const char *name)
+{
+	int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(command_list); i++) {
+		if (!strcmp(command_list[i].name, name))
+			return &command_list[i];
+	}
+	return NULL;
+}
+
+void warn_on_dashed_git(const char *cmd)
+{
+	struct cmdname_help *cmdname;
+	static const char *still_in_use_var =3D "GIT_I_STILL_USE_DASHED_GIT";
+	static const char *still_in_use_msg =3D
+		N_("Use of '%s' in the dashed-form is nominated for removal.\n"
+		   "If you still use it, export '%s=3Dtrue'\n"
+		   "and send an e-mail to <git@vger.kernel.org>\n"
+		   "to let us know and stop our removal plan.  Thanks.\n");
+
+	if (!cmd)
+		return; /* git-help is OK */
+
+	cmdname =3D find_cmdname_help(cmd);
+	if (cmdname && (cmdname->category & CAT_onpath))
+		return; /* git-upload-pack and friends are OK */
+
+	if (!git_env_bool(still_in_use_var, 0)) {
+		fprintf(stderr, _(still_in_use_msg), cmd, still_in_use_var);
+		exit(1);
+	}
+}
diff --git a/help.h b/help.h
index dc02458855..d3de5e0d69 100644
--- a/help.h
+++ b/help.h
@@ -45,6 +45,9 @@ void get_version_info(struct strbuf *buf, int show_buil=
d_options);
  */
 NORETURN void help_unknown_ref(const char *ref, const char *cmd, const c=
har *error);
=20
+/* When the cmd_main() sees "git-foo", check if the user intended */
+void warn_on_dashed_git(const char *);
+
 static inline void list_config_item(struct string_list *list,
 				    const char *prefix,
 				    const char *str)
--=20
2.28.0-454-g5f859b1948


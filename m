Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2690C20365
	for <e@80x24.org>; Tue,  3 Oct 2017 10:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751571AbdJCK7j (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 06:59:39 -0400
Received: from a7-18.smtp-out.eu-west-1.amazonses.com ([54.240.7.18]:45746
        "EHLO a7-18.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751121AbdJCK7j (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 3 Oct 2017 06:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1507028377;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=Z0vFvaUODKgoFwbh4D37grkP192nxqgYFR/vJoiWqpY=;
        b=CyHvuf8BHlfeou3VzJGH/EyJTDGgL3NiFeSZbnN617BbjNkh41QaOS3lW8iUNeNM
        62mnZel5E1Hrpk6rKLZ4zBQ7Fe7Mkhfv3Il5JqkMlo0BnIi0CxKuhNhaNemqCi7PpSe
        hI+Iu376dRSDnIoDqH2S94BvlZp/xwOioIcSewgE=
From:   Damien <damien@dam.io>
To:     git@vger.kernel.org
Message-ID: <0102015ee1e41f17-927a8da1-ac14-4399-8424-fee8a82c2b0a-000000@eu-west-1.amazonses.com>
Subject: [PATCH] run-command.c: add hint when hook is not executable
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 3 Oct 2017 10:59:37 +0000
X-SES-Outgoing: 2017.10.03-54.240.7.18
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 Documentation/config.txt               | 2 ++
 advice.c                               | 2 ++
 advice.h                               | 1 +
 contrib/completion/git-completion.bash | 1 +
 run-command.c                          | 4 ++++
 5 files changed, 10 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1ac0ae6adb046..83b1884cf22fc 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -351,6 +351,8 @@ advice.*::
 	addEmbeddedRepo::
 		Advice on what to do when you've accidentally added one
 		git repo inside of another.
+	hookNotExecutable::
+		Shown when an hook is there but not executable.
 --
 
 core.fileMode::
diff --git a/advice.c b/advice.c
index d81e1cb7425b0..969ba149daeec 100644
--- a/advice.c
+++ b/advice.c
@@ -17,6 +17,7 @@ int advice_set_upstream_failure = 1;
 int advice_object_name_warning = 1;
 int advice_rm_hints = 1;
 int advice_add_embedded_repo = 1;
+int advice_hook_not_executable = 1;
 
 static struct {
 	const char *name;
@@ -38,6 +39,7 @@ static struct {
 	{ "objectnamewarning", &advice_object_name_warning },
 	{ "rmhints", &advice_rm_hints },
 	{ "addembeddedrepo", &advice_add_embedded_repo },
+	{ "hooknotexecutable", &advice_hook_not_executable},
 
 	/* make this an alias for backward compatibility */
 	{ "pushnonfastforward", &advice_push_update_rejected }
diff --git a/advice.h b/advice.h
index c84a44531c7d8..061492976b362 100644
--- a/advice.h
+++ b/advice.h
@@ -19,6 +19,7 @@ extern int advice_set_upstream_failure;
 extern int advice_object_name_warning;
 extern int advice_rm_hints;
 extern int advice_add_embedded_repo;
+extern int advice_hook_not_executable;
 
 int git_default_advice_config(const char *var, const char *value);
 __attribute__((format (printf, 1, 2)))
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index d93441747523a..6324db0c44f17 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2350,6 +2350,7 @@ _git_config ()
 		advice.rmHints
 		advice.statusHints
 		advice.statusUoption
+		advice.hookNotExecutable
 		alias.
 		am.keepcr
 		am.threeWay
diff --git a/run-command.c b/run-command.c
index b5e6eb37c0eb3..95d93a23bf87e 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1174,6 +1174,10 @@ const char *find_hook(const char *name)
 		if (access(path.buf, X_OK) >= 0)
 			return path.buf;
 #endif
+		if (advice_hook_not_executable) {
+			advise(_("The '%s' hook was ignored because it's not set as executable."
+				"\nYou can disable this warning with `git config advice.hookNotExecutable false`"), name);
+		}
 		return NULL;
 	}
 	return path.buf;

--
https://github.com/git/git/pull/411

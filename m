Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0894C433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 03:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344945AbhLBD6d (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 22:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344727AbhLBD6c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 22:58:32 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EBDC061574
        for <git@vger.kernel.org>; Wed,  1 Dec 2021 19:55:10 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id kl8so23842216qvb.3
        for <git@vger.kernel.org>; Wed, 01 Dec 2021 19:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9FYLX1ebTnBu7jT15Sukm9S6hJVlYNZuw/4hUkk9JnM=;
        b=l+Fom5GE2Y+VU/NEwmj7tOWEtPJNHmDuqFkrDbU9+BPXnTDqFwzlvnfljepHJknF+7
         +sE8+Sn0JpyLdS+jVFNE4JR+KkNtsheNsXpeZNly9eR6D2FZfl0HN5I3Cw3gm/MUBEAd
         mQbVwXgAZfgfhjbBjOs2yzQSh6uQL3VGRUEiIFtFKZoUkbQNhcmVV0JD6TDTc3QMQqtP
         o9NQPpwPwo2ryiFsIZA2OdX3TejAiL0lRlzY7MP2bGIYq3AumnitngX5XqWcNpmFY0la
         BDaZ6DljC9dKLsN/LRGz+18oMRa/MvTCAUXTMrVkZhi1m67C+YaGIOrZcGEKc8dUY8RN
         TIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9FYLX1ebTnBu7jT15Sukm9S6hJVlYNZuw/4hUkk9JnM=;
        b=MPm9rguSZb2aInxVVwpdrBaYJAwXrIAuvHZsG4ghOjnfreWdKbRPdWF8LCpuEDchnn
         N7OBmbBsMvLRX+WTf37aj+vF7+FrDLG9b/cb/+kj6aJKFXNBgBR8Ryarm9V055gUcZ6w
         zxFK6sZW/yKOYA6G1YGzo1Y3Mbm6lnO+yRKb96QnHTFabxav0KGt87OvLzqTQ2q0FqDT
         NmwH0yro2IAqDXwsqgJJbs57/6f1TcXXlB3BvA7YS3SJJ7eqqio5fdHxUfLc+/oio8zq
         z9PnKvW06JwwUTw8tNvaATtH4vloqj0/21DcmPTqY6151a5pGikF1AMGJWwK41jkB7Ir
         dW8A==
X-Gm-Message-State: AOAM53175WUkkO3dStVIZsi7j3uz3ReSqj4TEfr2/wFjbM11r88Yx1Wf
        rP/a7ZE3M/g3HW7m76OCGp696tgeOgU=
X-Google-Smtp-Source: ABdhPJyHeYhb9osJC2gK9wgF9pVnZ+CHAn7kgTQ/m7gB7WvxFjisPE4vJbKUa16Q5FQMKMow0OoGPg==
X-Received: by 2002:a05:6214:27cd:: with SMTP id ge13mr10718099qvb.81.1638417309962;
        Wed, 01 Dec 2021 19:55:09 -0800 (PST)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id q20sm881949qkl.53.2021.12.01.19.55.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Dec 2021 19:55:09 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, chris.torek@gmail.com,
        phillip.wood@dunelm.org.uk, Johannes.Schindelin@gmx.de
Subject: [RFC PATCH 2/3] editor: allow for saving/restoring terminal state
Date:   Wed,  1 Dec 2021 19:54:45 -0800
Message-Id: <20211202035446.1154-3-carenas@gmail.com>
X-Mailer: git-send-email 2.34.1.460.g364565cfab
In-Reply-To: <20211202035446.1154-1-carenas@gmail.com>
References: <20211202035446.1154-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

When EDITOR is invoked to modify a commit message (or do some
other editing), and it is a terminal mode editor, it will need to
change the terminal settings, and if it misbehaves could leave the
terminal output damaged as shown in recent reports from Windows
Terminal[1]

Instead use the functions provided by compat/terminal to save the
settings of the terminal and recover safely, but only do so if
the editor is known to have issues and unless the user has told
us through a boolean configuration "editor.stty" that it is safe
not to do so.

[1] https://github.com/microsoft/terminal/issues/9359
---
The commit message was contributed by me, but the rest comes from:
https://lore.kernel.org/git/xmqq7dcnyh5o.fsf@gitster.g/
Signed-of-by is missing as I didn't know what would be preferred
or if the Author will be ok with my grammar (ginger free grammar
check seems to approve, otherwise)

 editor.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/editor.c b/editor.c
index fdd3eeafa9..70d3f80966 100644
--- a/editor.c
+++ b/editor.c
@@ -3,6 +3,7 @@
 #include "strbuf.h"
 #include "run-command.h"
 #include "sigchain.h"
+#include "compat/terminal.h"
 
 #ifndef DEFAULT_EDITOR
 #define DEFAULT_EDITOR "vi"
@@ -47,6 +48,16 @@ const char *git_sequence_editor(void)
 	return editor;
 }
 
+static int prepare_term(const char *editor)
+{
+	int need_saverestore = !strcmp(editor, "vi");
+
+	git_config_get_bool("editor.stty", &need_saverestore);
+	if (need_saverestore)
+		return save_term(1);
+	return 0;
+}
+
 static int launch_specified_editor(const char *editor, const char *path,
 				   struct strbuf *buffer, const char *const *env)
 {
@@ -57,7 +68,7 @@ static int launch_specified_editor(const char *editor, const char *path,
 		struct strbuf realpath = STRBUF_INIT;
 		const char *args[] = { editor, NULL, NULL };
 		struct child_process p = CHILD_PROCESS_INIT;
-		int ret, sig;
+		int ret, sig, need_restore = 0;
 		int print_waiting_for_editor = advice_enabled(ADVICE_WAITING_FOR_EDITOR) && isatty(2);
 
 		if (print_waiting_for_editor) {
@@ -83,7 +94,10 @@ static int launch_specified_editor(const char *editor, const char *path,
 		p.env = env;
 		p.use_shell = 1;
 		p.trace2_child_class = "editor";
+		need_restore = prepare_term(editor);
 		if (start_command(&p) < 0) {
+			if (need_restore)
+				restore_term();
 			strbuf_release(&realpath);
 			return error("unable to start editor '%s'", editor);
 		}
@@ -91,6 +105,8 @@ static int launch_specified_editor(const char *editor, const char *path,
 		sigchain_push(SIGINT, SIG_IGN);
 		sigchain_push(SIGQUIT, SIG_IGN);
 		ret = finish_command(&p);
+		if (need_restore)
+			restore_term();
 		strbuf_release(&realpath);
 		sig = ret - 128;
 		sigchain_pop(SIGINT);
-- 
2.34.1.460.g364565cfab


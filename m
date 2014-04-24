From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 11/12] cherry-pick: add --action-name option
Date: Wed, 23 Apr 2014 21:44:50 -0500
Message-ID: <1398307491-21314-12-git-send-email-felipe.contreras@gmail.com>
References: <1398307491-21314-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 24 04:56:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd9pY-0007v0-Vg
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 04:56:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278AbaDXC4C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 22:56:02 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:59884 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119AbaDXCz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 22:55:57 -0400
Received: by mail-oa0-f51.google.com with SMTP id i4so1977580oah.24
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 19:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1QL284/tguc0Mh/RutQT+PtB53TqzaG70h3QAP7m8g4=;
        b=tFXXAVuyN2cbeLON8I1f4zyOhIwj4gonZgcZ/shrmVRDP1QXmerPtrLiwd9zfTTmaP
         MiM3nQO0pqbWHTLqoe4mYWjtC6Rug8Y46GU267tdeUShjeMfhdpVQACOpbef3mAQUVpq
         Tjeo3eb7/roB4U3dPDg7xJFlvg6EBgNdg7TcMybNQaWrKbXFiqPK+TYxig4Ylenknbz7
         DbYyIY0peCydsglytD7USsaETjeAQzPRs/nFDSWKtx+df3tzr3yqPkcUgzij9y2eeKFd
         Z4QYhUcGoLrwB/mOw+AmcKnygiTadTCSTafd30tKRjGAPSSBp5hs30ha3A17ZTFiTdxV
         Q+dw==
X-Received: by 10.60.131.172 with SMTP id on12mr45941984oeb.18.1398308157183;
        Wed, 23 Apr 2014 19:55:57 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id te6sm11869532oec.2.2014.04.23.19.55.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Apr 2014 19:55:55 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.2.gfbaae8c
In-Reply-To: <1398307491-21314-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246925>

So it can be used by other tools (e.g. git rebase), and the right action
is passed to the hooks and notes rewrite stuff.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/revert.c | 2 ++
 sequencer.c      | 4 ++++
 sequencer.h      | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/builtin/revert.c b/builtin/revert.c
index 54fba63..a24b689 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -99,6 +99,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 		OPT_END(),
 		OPT_END(),
 		OPT_END(),
+		OPT_END(),
 	};
 
 	if (opts->action == REPLAY_PICK) {
@@ -109,6 +110,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 			OPT_BOOL(0, "allow-empty-message", &opts->allow_empty_message, N_("allow commits with empty messages")),
 			OPT_BOOL(0, "keep-redundant-commits", &opts->keep_redundant_commits, N_("keep redundant, empty commits")),
 			OPT_BOOL(0, "skip-empty", &opts->skip_empty, N_("skip empty commits")),
+			OPT_STRING(0, "action-name", &opts->action_name, N_("name"), N_("action name")),
 			OPT_END(),
 		};
 		if (parse_options_concat(options, ARRAY_SIZE(options), cp_extra))
diff --git a/sequencer.c b/sequencer.c
index fc0dd04..ed59d75 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -832,6 +832,8 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 		opts->xopts[opts->xopts_nr++] = xstrdup(value);
 	} else if (!strcmp(key, "options.allow-rerere-auto"))
 		opts->allow_rerere_auto = git_config_int(key, value);
+	else if (!strcmp(key, "options.action-name"))
+		git_config_string(&opts->action_name, key, value);
 	else
 		return error(_("Invalid key: %s"), key);
 
@@ -1015,6 +1017,8 @@ static void save_opts(struct replay_opts *opts)
 		git_config_set_in_file(opts_file, "options.allow-rerere-auto", buf.buf);
 		strbuf_release(&buf);
 	}
+	if (opts->action_name)
+		git_config_set_in_file(opts_file, "options.action-name", opts->action_name);
 }
 
 static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
diff --git a/sequencer.h b/sequencer.h
index efec1b5..6dfffaa 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -48,6 +48,8 @@ struct replay_opts {
 
 	/* Only used by REPLAY_NONE */
 	struct rev_info *revs;
+
+	const char *action_name;
 };
 
 int sequencer_pick_revisions(struct replay_opts *opts);
-- 
1.9.2+fc1.2.gfbaae8c

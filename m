From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 17/36] cherry-pick: don't store skipped commit
Date: Sun,  9 Jun 2013 14:24:31 -0500
Message-ID: <1370805890-3453-18-git-send-email-felipe.contreras@gmail.com>
References: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 21:27:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllHK-0003fR-DM
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:27:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323Ab3FIT1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:27:36 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:36567 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309Ab3FIT1d (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:27:33 -0400
Received: by mail-oa0-f51.google.com with SMTP id i4so940544oah.24
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 12:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=E4a606BbeR9V++cwxtV8/Qn1yZJ0U7l2QzTZIIy4Nd0=;
        b=T4OLkLyKpcvzqosLjbF5M79YAc1/7B1lUaGWTbP2hE2KdPcKu8nQqZJhvsjgp1ZNkN
         CkwZN9RGVA+fFvj7aofzBxQQDn/bn5Zbuw2rWIY9F2qxg6PCovGn2tE7DVfomZuHS07d
         ZHwx5sHvBc4N0vsWYhK68cM6kHbBjGFiuIyvEy5qXOg0XAr4QitE/hn0yZfz1n3GQnjv
         Tmt13ce7IiDi7ktXPTd9dYzMiEiJEUxcPmfhiSrEos6nw69auBiyhWVS2uHew1Q9TeKZ
         3OJNiSBxFKqWUpq8WBe7CNI14Pc3EYGOVKJ3wIQx+gMw382okw5woG/gTD9D5qgVjsFn
         I+RA==
X-Received: by 10.182.129.42 with SMTP id nt10mr5490466obb.54.1370806052927;
        Sun, 09 Jun 2013 12:27:32 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id r4sm16278213oem.3.2013.06.09.12.27.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 12:27:32 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227124>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/sequencer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/sequencer.c b/builtin/sequencer.c
index 24034f2..d40fda9 100644
--- a/builtin/sequencer.c
+++ b/builtin/sequencer.c
@@ -953,7 +953,7 @@ static int continue_single_pick(void)
 	return run_command_v_opt(argv, RUN_GIT_CMD);
 }
 
-static int sequencer_continue(struct replay_opts *opts)
+static int sequencer_continue(struct replay_opts *opts, int skip)
 {
 	struct commit_list *todo_list = NULL;
 
@@ -973,7 +973,7 @@ static int sequencer_continue(struct replay_opts *opts)
 	}
 	if (index_differs_from("HEAD", 0))
 		return error_dirty_index(opts);
-	if (opts->action == REPLAY_PICK) {
+	if (opts->action == REPLAY_PICK && !skip) {
 		unsigned char to[20];
 		if (!read_ref("HEAD", to))
 			add_rewritten(&rewritten, todo_list->item->object.sha1, to);
@@ -1001,7 +1001,7 @@ static int sequencer_skip(struct replay_opts *opts)
 	if (ret)
 		return ret;
 
-	return sequencer_continue(opts);
+	return sequencer_continue(opts, 1);
 }
 
 static int single_pick(struct commit *cmit, struct replay_opts *opts)
@@ -1033,7 +1033,7 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 	if (opts->subcommand == REPLAY_ROLLBACK)
 		return sequencer_rollback(opts);
 	if (opts->subcommand == REPLAY_CONTINUE)
-		return sequencer_continue(opts);
+		return sequencer_continue(opts, 0);
 	if (opts->subcommand == REPLAY_SKIP)
 		return sequencer_skip(opts);
 
-- 
1.8.3.698.g079b096

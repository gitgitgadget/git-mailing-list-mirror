From: David Turner <dturner@twopensource.com>
Subject: [PATCH 5/5] sequencer: replace write_cherry_pick_head with update_ref
Date: Mon, 27 Jul 2015 16:08:40 -0400
Message-ID: <1438027720-23074-6-git-send-email-dturner@twopensource.com>
References: <1438027720-23074-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, sunshine@sunshineco.com,
	philipoakley@iee.org
X-From: git-owner@vger.kernel.org Mon Jul 27 22:09:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJoht-00047X-Ql
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 22:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754742AbbG0UI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 16:08:57 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:32780 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754729AbbG0UIw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 16:08:52 -0400
Received: by qkdl129 with SMTP id l129so43755659qkd.0
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 13:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kpeB4PvvU++ziEQgbk6bNELkh94vU9kZSIzUikp9EDM=;
        b=QS+08GirOofOqIS8u7Curl3mE5w6HsahTIoNTOlglMbi7HZDbQypsC4iCrFZmWn/Jd
         HNiXkO9nw0rte7sdsOXYt1MqjyTODar1aicaAl364FWZgE9OUY9YOCu1iolJhf015e99
         xOHHxN7BYzvgAgNl56YVkby0GIjy6EG6xYUofaDaYL0WfTFb7MgARHahgj5hqKyOlpDQ
         J3TFVufkzwsuYAuwiCm3HL9JBlQjpu52yjaoiUlLUOEGVxMtD710mC/RZzRfi0dKeaiU
         jnQ5cJ8htpZ4GrhH4GbBIpv53s7xk/OXi+NZKlv3RGk+2GCGW9hKhoWIEt7a276naTOF
         /dew==
X-Gm-Message-State: ALoCoQleeth8iGbUoF/mq8y82C59NXZ4O3EPq/g1vPSYXOLi5hhAIym8JZz2tAHCc3VL7u1JpJz+
X-Received: by 10.55.43.84 with SMTP id r81mr44130387qkh.8.1438027732102;
        Mon, 27 Jul 2015 13:08:52 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 34sm9893690qkz.38.2015.07.27.13.08.50
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jul 2015 13:08:51 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1438027720-23074-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274704>

Now update_ref (via write_pseudoref) does almost exactly what
write_cherry_pick_head did, so we can remove write_cherry_pick_head
and just use update_ref.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 sequencer.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index c4f4b7d..554a704 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -158,23 +158,6 @@ static void free_message(struct commit *commit, struct commit_message *msg)
 	unuse_commit_buffer(commit, msg->message);
 }
 
-static void write_cherry_pick_head(struct commit *commit, const char *pseudoref)
-{
-	const char *filename;
-	int fd;
-	struct strbuf buf = STRBUF_INIT;
-
-	strbuf_addf(&buf, "%s\n", sha1_to_hex(commit->object.sha1));
-
-	filename = git_path("%s", pseudoref);
-	fd = open(filename, O_WRONLY | O_CREAT, 0666);
-	if (fd < 0)
-		die_errno(_("Could not open '%s' for writing"), filename);
-	if (write_in_full(fd, buf.buf, buf.len) != buf.len || close(fd))
-		die_errno(_("Could not write to '%s'"), filename);
-	strbuf_release(&buf);
-}
-
 static void print_advice(int show_hint, struct replay_opts *opts)
 {
 	char *msg = getenv("GIT_CHERRY_PICK_HELP");
@@ -607,9 +590,11 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 	 * write it at all.
 	 */
 	if (opts->action == REPLAY_PICK && !opts->no_commit && (res == 0 || res == 1))
-		write_cherry_pick_head(commit, "CHERRY_PICK_HEAD");
+		update_ref(NULL, "CHERRY_PICK_HEAD", commit->object.sha1, NULL,
+			   REF_NODEREF, UPDATE_REFS_DIE_ON_ERR);
 	if (opts->action == REPLAY_REVERT && ((opts->no_commit && res == 0) || res == 1))
-		write_cherry_pick_head(commit, "REVERT_HEAD");
+		update_ref(NULL, "REVERT_HEAD", commit->object.sha1, NULL,
+			   REF_NODEREF, UPDATE_REFS_DIE_ON_ERR);
 
 	if (res) {
 		error(opts->action == REPLAY_REVERT
-- 
2.0.4.315.gad8727a-twtrsrc

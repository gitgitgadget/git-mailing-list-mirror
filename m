From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 5/5] sequencer: replace write_cherry_pick_head with update_ref
Date: Wed, 29 Jul 2015 13:58:08 -0400
Message-ID: <1438192688-8048-6-git-send-email-dturner@twopensource.com>
References: <1438192688-8048-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, sunshine@sunshineco.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Jul 29 19:58:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKVci-0002jr-HV
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 19:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753963AbbG2R6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 13:58:33 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34410 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753823AbbG2R62 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 13:58:28 -0400
Received: by qkfc129 with SMTP id c129so8414396qkf.1
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 10:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kpeB4PvvU++ziEQgbk6bNELkh94vU9kZSIzUikp9EDM=;
        b=dThrffQ4qTbgRuNXDrXjzwTyoa7O0yeVEKpEUyfjygBa4sCS4BLpo1s2LS18Wa7sUm
         Rzrz8mZ5fX1e/v/FBiMxC2QrVVbNgX1KdsUxfWzCOnXU2U+T66LekEV+tiHHX2eC5UVe
         qF93XgpVbNl619uoJ5Qy7n8+m/wJTXduns3UNcP0NMeJDdYch6ThW4bPGNfpYJ88RYlA
         iPx3Pz/KLWt2uc2F4dOe7a2djZ1wl98SGTM8hJh7TBAHLnUXFllpCZ79uVmEWjD4jUtr
         dEBeiGep2q4p1/DW4VXkZfJbYUz2+fzXSqYOoCJydfAMJ3VabgV+cjCFZtbTUL+b1gMm
         ytuA==
X-Gm-Message-State: ALoCoQlkszc8+K8qYbL84Mc+qtCahHwfrNTk1+JS6RXFGJrLCApuFoNpwP20CW4eMh+WlQRIIKZU
X-Received: by 10.55.18.151 with SMTP id 23mr63577190qks.90.1438192707479;
        Wed, 29 Jul 2015 10:58:27 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id w68sm14275247qge.18.2015.07.29.10.58.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Jul 2015 10:58:26 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1438192688-8048-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274932>

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

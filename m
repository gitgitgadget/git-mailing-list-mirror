From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 5/5] sequencer: replace write_cherry_pick_head with update_ref
Date: Fri, 31 Jul 2015 02:06:21 -0400
Message-ID: <1438322781-21181-5-git-send-email-dturner@twopensource.com>
References: <1438322781-21181-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 31 08:06:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZL3Sy-0002Ly-CR
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 08:06:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752283AbbGaGGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 02:06:43 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:32978 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737AbbGaGGe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 02:06:34 -0400
Received: by qkdg63 with SMTP id g63so25928912qkd.0
        for <git@vger.kernel.org>; Thu, 30 Jul 2015 23:06:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kpeB4PvvU++ziEQgbk6bNELkh94vU9kZSIzUikp9EDM=;
        b=gQi5L0CJjK2q9/U4nf0rDH4BuecfR+Vq93EpYMnRBew2EM8gYNdFkm2ofqyVVvx72h
         gtnvM8d9JvpIi7HTgdLp/nUsyfc4ruR1O4K0cHO1K1gLA81xpyx+4HiymSbaXz4q3GOf
         5dPPD9x+iYzCSS3sTd55N/s6j7LKyFkByQAicu1wwbswIR/NZ3eqUQurXh3GEYLvtS+w
         FYZx1jkvc2rt5s/0k2Tg5UNfiDt3udP2ZjzIJ7K02W036l+Nu8eO9BBr+xP/VuLW2ei5
         eQkkWa38DISsZugAB2zS0SGCN5lYiw1EzqiOLyu1TxTyBZsjaNbVUnQiuK+jbO3Fs0DT
         wDbQ==
X-Gm-Message-State: ALoCoQm4ThJaaLAlxjfoJJZOIC+TWqBPGfHziBi0TvOPpVX2CswrrI+rGimd7wGPjypUXDYogrdV
X-Received: by 10.55.21.94 with SMTP id f91mr1522179qkh.51.1438322793432;
        Thu, 30 Jul 2015 23:06:33 -0700 (PDT)
Received: from ubuntu.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id c35sm1737073qgc.47.2015.07.30.23.06.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Jul 2015 23:06:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1438322781-21181-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275040>

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

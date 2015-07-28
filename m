From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 6/6] sequencer: replace write_cherry_pick_head with update_ref
Date: Tue, 28 Jul 2015 14:12:24 -0400
Message-ID: <1438107144-24293-7-git-send-email-dturner@twopensource.com>
References: <1438107144-24293-1-git-send-email-dturner@twopensource.com>
Cc: mhagger@alum.mit.edu, sunshine@sunshineco.com,
	philipoakley@iee.org, David Turner <dturner@twopensource.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 20:13:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK9NR-000563-VV
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 20:13:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333AbbG1SNQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 14:13:16 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:35734 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753085AbbG1SMu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 14:12:50 -0400
Received: by qgii95 with SMTP id i95so79988429qgi.2
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 11:12:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kpeB4PvvU++ziEQgbk6bNELkh94vU9kZSIzUikp9EDM=;
        b=Gy7T2oU/iSTyNn558Nebqv5uQ2JVhtzgvCaxlqgk8E79O1pJXsl4OSOZzUlIr3dCAt
         rCNb1R6XA3m71CYTFpFB57ouIfqaDDKs3rU4yMCl5AqRKWnGpMOny7FqPfz9RsmNWvvd
         pa7+4rPxJgk8pK95nDhPpTc0xKDvNqRmHycK3aGej+5MbTuCL/jhzAyhjQl7YEwj2V66
         TM55yLwPv5Nd7J0/zGIrVAYIbmaQtzAa9cwgFVWdWSdhHga0ypOkJojEPPxC4D3e8ZLj
         GFnX7z0FdpIP9upTHYOpo/LiGNnPGTTdlyqYQ9AfTBBrUyiM3yH5tG91Fs8FhMFi2GKa
         ywUQ==
X-Gm-Message-State: ALoCoQnpbbK+L3E39I965uK8ABTWwJdMErfrgseJAR4jPdZyYCgvArOfg7jQb8oq33PO5W9Kne/X
X-Received: by 10.140.97.199 with SMTP id m65mr5701017qge.40.1438107169910;
        Tue, 28 Jul 2015 11:12:49 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 34sm11653540qkz.38.2015.07.28.11.12.48
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Jul 2015 11:12:49 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1438107144-24293-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274807>

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

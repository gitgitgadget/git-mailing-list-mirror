From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH v0] fast-import: Add drop command
Date: Sat, 24 Sep 2011 16:27:45 +0100
Message-ID: <1316878065-11782-2-git-send-email-vitor.hda@gmail.com>
References: <1316878065-11782-1-git-send-email-vitor.hda@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 24 17:28:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7U9T-0008DP-GH
	for gcvg-git-2@lo.gmane.org; Sat, 24 Sep 2011 17:28:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423Ab1IXP2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Sep 2011 11:28:19 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64730 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832Ab1IXP2N (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Sep 2011 11:28:13 -0400
Received: by wwf22 with SMTP id 22so4873798wwf.1
        for <git@vger.kernel.org>; Sat, 24 Sep 2011 08:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=/xNYzNyDLttcGFh0A33s7iG9LpVKU7zM1VCE3baDX44=;
        b=f9YeaC9oAvvyHbyrQKrAAr1fmT3PWN69r636MUr31z7fzBKUvIyonHmSdGZ1yNQQKt
         8L+i1lSUN5rGIsH1AFYYkKaLRqwJ4prxt45VMxkyl3oduSwSgb/0oKzOMUJ6Txbr/VGs
         +m5wyN7+Ont9YPW+m/UMJBMYi3xZBoS8DbcIk=
Received: by 10.216.88.212 with SMTP id a62mr5057842wef.43.1316878092231;
        Sat, 24 Sep 2011 08:28:12 -0700 (PDT)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt. [77.54.216.111])
        by mx.google.com with ESMTPS id fr18sm21661126wbb.9.2011.09.24.08.28.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 24 Sep 2011 08:28:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.rc2.11.g4aecf.dirty
In-Reply-To: <1316878065-11782-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182031>

The drop command deletes the given branch reference, allowing
fast-import to actively ignore it in the final checks.

Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
---
 fast-import.c |   35 ++++++++++++++++++++++++++++++++++-
 1 files changed, 34 insertions(+), 1 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 742e7da..906bbf4 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -743,6 +743,29 @@ static struct branch *new_branch(const char *name)
 	return b;
 }
 
+static void release_tree_entry(struct tree_entry *e);
+static void drop_branch(const char *name)
+{
+	unsigned int hc = hc_str(name, strlen(name)) % branch_table_sz;
+	struct branch *b_prev = NULL, *b = NULL;
+	struct ref_lock *lock;
+	unsigned char old_sha1[20];
+
+	for (b = branch_table[hc]; b; b = b->table_next_branch) {
+		if (!strcmp(name, b->name)) {
+			release_tree_entry(&b->branch_tree);
+			if (b_prev)
+				b_prev->table_next_branch = b->table_next_branch;
+			branch_table[hc] = NULL;
+			branch_count--;
+		}
+		b_prev = b;
+	}
+
+	if (!read_ref(name, old_sha1))
+		delete_ref(name, old_sha1, 0)
+}
+
 static unsigned int hc_entries(unsigned int cnt)
 {
 	cnt = cnt & 7 ? (cnt / 8) + 1 : cnt / 8;
@@ -776,7 +799,6 @@ static struct tree_content *new_tree_content(unsigned int cnt)
 	return t;
 }
 
-static void release_tree_entry(struct tree_entry *e);
 static void release_tree_content(struct tree_content *t)
 {
 	struct avail_tree_content *f = (struct avail_tree_content*)t;
@@ -2793,6 +2815,15 @@ static void parse_reset_branch(void)
 		unread_command_buf = 1;
 }
 
+static void parse_drop_branch(void)
+{
+	char *sp;
+
+	/* Obtain the branch name from the rest of our command */
+	sp = strchr(command_buf.buf, ' ') + 1;
+	drop_branch(sp);
+}
+
 static void cat_blob_write(const char *buf, unsigned long size)
 {
 	if (write_in_full(cat_blob_fd, buf, size) != size)
@@ -3332,6 +3363,8 @@ int main(int argc, const char **argv)
 			parse_new_tag();
 		else if (!prefixcmp(command_buf.buf, "reset "))
 			parse_reset_branch();
+		else if (!prefixcmp(command_buf.buf, "drop "))
+			parse_drop_branch();
 		else if (!strcmp("checkpoint", command_buf.buf))
 			parse_checkpoint();
 		else if (!strcmp("done", command_buf.buf))
-- 
1.7.7.rc2.11.g4aecf.dirty

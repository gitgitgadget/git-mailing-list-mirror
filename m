From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 04/18] revert: don't die when write_message() fails
Date: Thu, 25 Nov 2010 22:20:35 +0100
Message-ID: <20101125212050.5188.41232.chriscool@tuxfamily.org>
References: <20101125210138.5188.13115.chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 26 06:54:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLrGb-0006bE-17
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 06:54:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798Ab0KZFye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Nov 2010 00:54:34 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:47326 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751724Ab0KZFye (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 00:54:34 -0500
Received: from localhost6.localdomain6 (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id D8591A61DE;
	Fri, 26 Nov 2010 06:54:26 +0100 (CET)
X-git-sha1: 6558e7c1bbf4bd7f683dd1aaa5f9ea3260ec973e 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20101125210138.5188.13115.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162187>

Instead we will just return an error code.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/revert.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 9649d37..947e666 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -257,17 +257,19 @@ static void print_advice(void)
 		       find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV));
 }
 
-static void write_message(struct strbuf *msgbuf, const char *filename)
+static int write_message(struct strbuf *msgbuf, const char *filename)
 {
 	static struct lock_file msg_file;
 
 	int msg_fd = hold_lock_file_for_update(&msg_file, filename,
 					       LOCK_DIE_ON_ERROR);
 	if (write_in_full(msg_fd, msgbuf->buf, msgbuf->len) < 0)
-		die_errno("Could not write to %s.", filename);
+		return error_errno("Could not write to %s.", filename);
 	strbuf_release(msgbuf);
 	if (commit_lock_file(&msg_file) < 0)
-		die("Error wrapping up %s", filename);
+		return error("Error wrapping up %s", filename);
+
+	return 0;
 }
 
 static struct tree *empty_tree(void)
@@ -397,7 +399,7 @@ static int do_pick_commit(void)
 	struct commit_message msg = { NULL, NULL, NULL, NULL, NULL };
 	char *defmsg = NULL;
 	struct strbuf msgbuf = STRBUF_INIT;
-	int res;
+	int res, write_res;
 
 	if (no_commit) {
 		/*
@@ -495,12 +497,16 @@ static int do_pick_commit(void)
 	if (!strategy || !strcmp(strategy, "recursive") || action == REVERT) {
 		res = do_recursive_merge(base, next, base_label, next_label,
 					 head, &msgbuf);
-		write_message(&msgbuf, defmsg);
+		write_res = write_message(&msgbuf, defmsg);
+		if (write_res)
+			return write_res;
 	} else {
 		struct commit_list *common = NULL;
 		struct commit_list *remotes = NULL;
 
-		write_message(&msgbuf, defmsg);
+		write_res = write_message(&msgbuf, defmsg);
+		if (write_res)
+			return write_res;
 
 		commit_list_insert(base, &common);
 		commit_list_insert(next, &remotes);
-- 
1.7.3.2.504.g59d466

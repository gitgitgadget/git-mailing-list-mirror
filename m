From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 11/18] revert: add get_todo_content() and
	create_todo_file()
Date: Thu, 25 Nov 2010 22:20:42 +0100
Message-ID: <20101125212050.5188.30170.chriscool@tuxfamily.org>
References: <20101125210138.5188.13115.chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 26 06:56:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLrIf-0007NM-47
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 06:56:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240Ab0KZFzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Nov 2010 00:55:13 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:47755 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752126Ab0KZFzM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 00:55:12 -0500
Received: from localhost6.localdomain6 (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 71622A6209;
	Fri, 26 Nov 2010 06:55:05 +0100 (CET)
X-git-sha1: 1225f09e208544ceae2321ebf6f8c4b1fe0e3cfb 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20101125210138.5188.13115.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162193>

These static functions will make it possible to write "todo"
and "done" files. These files will list the actions (cherry
picks or reverts) that are still to be completed and that
have already been done respectively.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/revert.c |   63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 8b50e0c..7429be2 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -177,6 +177,69 @@ static char *get_encoding(const char *message, const unsigned char *sha1)
 	return NULL;
 }
 
+static void get_todo_content(struct strbuf *buf, struct commit_list *list,
+			     const char *line_prefix, struct args_info *info)
+{
+	struct commit_list *cur = list;
+	struct strbuf cmd = STRBUF_INIT;
+
+	if (line_prefix)
+		strbuf_addstr(&cmd, line_prefix);
+	strbuf_addstr(&cmd, info->action == REVERT ? "revert " : "pick ");
+	if (info->no_commit)
+		strbuf_addstr(&cmd, "-n ");
+	if (info->edit)
+		strbuf_addstr(&cmd, "-e ");
+	if (info->signoff)
+		strbuf_addstr(&cmd, "-s ");
+	if (info->mainline)
+		strbuf_addf(&cmd, "-m %d ", info->mainline);
+	if (info->allow_rerere_auto)
+		strbuf_addstr(&cmd, "--rerere-autoupdate ");
+	if (info->strategy)
+		strbuf_addf(&cmd, "--strategy %s ", info->strategy);
+	if (info->no_replay)
+		strbuf_addstr(&cmd, "-x ");
+	if (info->allow_ff)
+		strbuf_addstr(&cmd, "--ff ");
+
+	for (; cur; cur = cur->next) {
+		struct commit_message msg = { NULL, NULL, NULL, NULL, NULL };
+		const unsigned char *sha1 = cur->item->object.sha1;
+		if (get_message(cur->item->buffer, sha1, &msg) != 0)
+			die("Cannot get commit message for %s",
+			    sha1_to_hex(sha1));
+		strbuf_addbuf(buf, &cmd);
+		strbuf_addf(buf, " %s # %s\n",
+			    find_unique_abbrev(sha1, DEFAULT_ABBREV),
+			    msg.subject);
+		free_message(&msg);
+	}
+
+	strbuf_release(&cmd);
+}
+
+static void create_todo_file(const char *filepath, int append,
+			     struct commit_list *list, const char *line_prefix,
+			     struct args_info *info)
+{
+	int fd, flags;
+	struct strbuf buf = STRBUF_INIT;
+
+	get_todo_content(&buf, list, line_prefix, info);
+
+	flags = O_WRONLY | O_CREAT | (append ? O_APPEND : O_TRUNC);
+	fd = open(filepath, flags, 0666);
+	if (fd < 0)
+		die_errno("Could not open file '%s' for writing", filepath);
+
+	write_or_whine(fd, buf.buf, buf.len, filepath);
+
+	close(fd);
+
+	strbuf_release(&buf);
+}
+
 static void add_message_to_msg(struct strbuf *msgbuf, const char *message,
 			       const unsigned char *sha1)
 {
-- 
1.7.3.2.504.g59d466

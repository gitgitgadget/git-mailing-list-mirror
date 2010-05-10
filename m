From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 7/8] fmt-merge-msg: add function to append shortlog only
Date: Tue, 11 May 2010 01:17:51 +0800
Message-ID: <1273511872-4924-8-git-send-email-rctay89@gmail.com>
References: <1273511872-4924-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	"Miklos Vajna" <vmiklos@frugalware.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 10 19:18:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBWd1-0007lB-1v
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 19:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755920Ab0EJRSc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 13:18:32 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:63452 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755909Ab0EJRSa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 13:18:30 -0400
Received: by mail-pw0-f46.google.com with SMTP id 5so1771315pwi.19
        for <git@vger.kernel.org>; Mon, 10 May 2010 10:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Pit7Idz533f1POoxlD/x8sAEXraMH3yUU3OAeQFj8PI=;
        b=PrfwLbYebAMJfcNNoDqjbHhkXt/xz1jaMZgQXp/nKd/ynNsyVq4NnsFB9KG82rADso
         yzBD2GMAr9Br/AL+iZAI11NPl1XMVEmA95iXSyxvLLZel1CSMozB7XlwHIW6pi/Nm34f
         uOjLrsJVnPz3oEp01sFp/AtSYfvKCcTgItsOs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=w2I1nmIC4+eKFSdypi5hm+Xr/jfD2Avpz5w5pCMfIZ7Q1F+vnQlr95h12vCmwwDej1
         IdTSawON+WCif8Z5JbLidgtTn8SsrS2ys2D3uBPjm8FmTsMS3WfNq9pm5ZPOMvVVZPBq
         qEqxaApUY4noVj7RjxYB+dF41lnsm8gtb8xY8=
Received: by 10.115.134.13 with SMTP id l13mr2428149wan.200.1273511910213;
        Mon, 10 May 2010 10:18:30 -0700 (PDT)
Received: from localhost.localdomain (cm71.zeta153.maxonline.com.sg [116.87.153.71])
        by mx.google.com with ESMTPS id v13sm27449213wav.2.2010.05.10.10.18.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 May 2010 10:18:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.337.gbd0bc
In-Reply-To: <1273511872-4924-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146836>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 builtin.h               |    1 +
 builtin/fmt-merge-msg.c |   13 +++++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/builtin.h b/builtin.h
index 5c887ef..b614d12 100644
--- a/builtin.h
+++ b/builtin.h
@@ -16,6 +16,7 @@ extern const char *help_unknown_cmd(const char *cmd);
 extern void prune_packed_objects(int);
 extern int fmt_merge_msg(int merge_summary, struct strbuf *in,
 	struct strbuf *out);
+extern int fmt_merge_msg_shortlog(struct strbuf *in, struct strbuf *out);
 extern int commit_notes(struct notes_tree *t, const char *msg);
 
 struct notes_rewrite_cfg {
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index d0160cb..48548cf 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -255,8 +255,8 @@ static void do_fmt_merge_msg_title(struct strbuf *out,
 		strbuf_addf(out, " into %s\n", current_branch);
 }
 
-static int do_fmt_merge_msg(int merge_summary, struct strbuf *in,
-	struct strbuf *out) {
+static int do_fmt_merge_msg(int merge_title, int merge_summary,
+	struct strbuf *in, struct strbuf *out) {
 	int limit = 20, i = 0, pos = 0;
 	unsigned char head_sha1[20];
 	const char *current_branch;
@@ -285,7 +285,8 @@ static int do_fmt_merge_msg(int merge_summary, struct strbuf *in,
 	if (!srcs.nr)
 		return 0;
 
-	do_fmt_merge_msg_title(out, current_branch);
+	if (merge_title)
+		do_fmt_merge_msg_title(out, current_branch);
 
 	if (merge_summary) {
 		struct commit *head;
@@ -305,7 +306,11 @@ static int do_fmt_merge_msg(int merge_summary, struct strbuf *in,
 }
 
 int fmt_merge_msg(int merge_summary, struct strbuf *in, struct strbuf *out) {
-	return do_fmt_merge_msg(merge_summary, in, out);
+	return do_fmt_merge_msg(1, merge_summary, in, out);
+}
+
+int fmt_merge_msg_shortlog(struct strbuf *in, struct strbuf *out) {
+	return do_fmt_merge_msg(0, 1, in, out);
 }
 
 int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
-- 
1.7.1.189.g07419

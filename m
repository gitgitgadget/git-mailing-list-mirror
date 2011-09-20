From: Alexey Shumkin <zapped@mail.ru>
Subject: [PATCH v3 2/2] pretty: user format ignores i18n.logOutputEncoding setting
Date: Tue, 20 Sep 2011 12:21:32 +0400
Message-ID: <1316506892-6072-2-git-send-email-zapped@mail.ru>
References: <1316506892-6072-1-git-send-email-zapped@mail.ru>
Cc: Alexey Shumkin <zapped@mail.ru>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 10:21:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5vaK-0005d8-Si
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 10:21:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754451Ab1ITIVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 04:21:40 -0400
Received: from smtp1.mail.ru ([94.100.176.129]:45007 "EHLO smtp1.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753687Ab1ITIVi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 04:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail;
	h=Sender:References:In-Reply-To:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=k2gDAEnTTXXtZDdGgei29sGoBOoLH036G7G8hi1wYlI=;
	b=W1vpA/5fRrIkZd98fXjkxDvO+5HjoKDAHqIpsjrr82p10glZNtn77BAOBIA7gEBoXqP+N2nHbnftiViba5gSUNgol087VP4nlFAPKb3lswrHCajktLdGRU1lbNab4wdQ;
Received: from [91.77.19.104] (port=32235 helo=zappedws)
	by smtp1.mail.ru with asmtp 
	id 1R5vaD-0002Az-00; Tue, 20 Sep 2011 12:21:37 +0400
Received: from Alex by zappedws with local (Exim 4.76)
	(envelope-from <zapped@mail.ru>)
	id 1R5vaB-0001aq-1s; Tue, 20 Sep 2011 12:21:35 +0400
X-Mailer: git-send-email 1.7.6.3.4.gf71f
In-Reply-To: <1316506892-6072-1-git-send-email-zapped@mail.ru>
In-Reply-To: <7v1uvptjhr.fsf@alter.siamese.dyndns.org>
References: <7v1uvptjhr.fsf@alter.siamese.dyndns.org>
X-Spam: Not detected
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181740>

The following two commands are expected to give the same output to a terminal:

	$ git log --oneline --no-color
	$ git log --pretty=format:'%h %s'

However, the former pays attention to i18n.logOutputEncoding
configuration, while the latter does not when it format "%s".
Log messages written in an encoding i18n.commitEncoding which differs
from terminal encoding are shown corrupted with the latter even
when i18n.logOutputEncoding and terminal encoding are the same.

The same corruption is true for
	$ git diff --submodule=log
and
	$ git rev-list --pretty=format:%s HEAD

Signed-off-by: Alexey Shumkin <zapped@mail.ru>
---
 builtin/rev-list.c |    1 +
 builtin/shortlog.c |    1 +
 log-tree.c         |    1 +
 submodule.c        |    3 +++
 4 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 56727e8..831077d 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -105,6 +105,7 @@ static void show_commit(struct commit *commit, void *data)
 		ctx.abbrev = revs->abbrev;
 		ctx.date_mode = revs->date_mode;
 		ctx.fmt = revs->commit_format;
+		ctx.output_encoding = get_log_output_encoding();
 		pretty_print_commit(&ctx, commit, &buf);
 		if (revs->graph) {
 			if (buf.len) {
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 37f3193..eba4086 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -163,6 +163,7 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 		ctx.subject = "";
 		ctx.after_subject = "";
 		ctx.date_mode = DATE_NORMAL;
+		ctx.output_encoding = get_log_output_encoding();
 		pretty_print_commit(&ctx, commit, &ufbuf);
 		buffer = ufbuf.buf;
 	} else if (*buffer) {
diff --git a/log-tree.c b/log-tree.c
index e945701..39913d7 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -488,6 +488,7 @@ void show_log(struct rev_info *opt)
 	ctx.preserve_subject = opt->preserve_subject;
 	ctx.reflog_info = opt->reflog_info;
 	ctx.fmt = opt->commit_format;
+	ctx.output_encoding = get_log_output_encoding();
 	pretty_print_commit(&ctx, commit, &msgbuf);
 
 	if (opt->add_signoff)
diff --git a/submodule.c b/submodule.c
index b648927..8c96de7 100644
--- a/submodule.c
+++ b/submodule.c
@@ -213,10 +213,13 @@ static void print_submodule_summary(struct rev_info *rev, FILE *f,
 	static const char format[] = "  %m %s";
 	struct strbuf sb = STRBUF_INIT;
 	struct commit *commit;
+	const char *log_output_encoding;
 
+	log_output_encoding = get_log_output_encoding();
 	while ((commit = get_revision(rev))) {
 		struct pretty_print_context ctx = {0};
 		ctx.date_mode = rev->date_mode;
+		ctx.output_encoding = log_output_encoding;
 		strbuf_setlen(&sb, 0);
 		if (commit->object.flags & SYMMETRIC_LEFT) {
 			if (del)
-- 
1.7.6.3.4.gf71f

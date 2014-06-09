From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v2 07/19] builtin/checkout: simplify via strbuf_set()
Date: Mon,  9 Jun 2014 15:19:26 -0700
Message-ID: <4a675aa5439b7f1cc932e3c28cfdad051dd0eb5b.1402348696.git.jmmahler@gmail.com>
References: <cover.1402348696.git.jmmahler@gmail.com>
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 00:20:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu7vy-0000iU-0y
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 00:20:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbaFIWUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 18:20:50 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:46596 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932097AbaFIWUs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 18:20:48 -0400
Received: by mail-pb0-f51.google.com with SMTP id rp16so63859pbb.38
        for <git@vger.kernel.org>; Mon, 09 Jun 2014 15:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=nLp8StCkOyuP7QXB3EK7zB8owal8Tny83QnvEUOMJec=;
        b=BokzjXFMbGUbMTcCbsc79ojK4u74EXMOJsxEBMVPAmlQAJjoH0XqCO5xCXITgtw+20
         tEQsIS3qSv4eMob3rAI9xrFs2XVWG6EZl5Rl+G7yY/PtK57V/bZer4ExzO3nuVJo7ksU
         jSxAE/2/rerNT3od8WP8/aSKjljkgbXFv4xHg6BViL6hVldJJYkLbkrodZELQNG5ppHk
         NwQU1kHBqd1xNE5nRSxParrndF7kxhAfdC1EPB9xVMgzF/fF4jo1h+dbZvraWhuKdOq2
         /Z1myyGIyOMLC3oUomqVLtX3Ztj8ZVtCBNeZSTWp9gAjJx+0LH8fVXYWog27ODY0At8g
         zCEQ==
X-Received: by 10.68.231.196 with SMTP id ti4mr7558232pbc.48.1402352448518;
        Mon, 09 Jun 2014 15:20:48 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id cz3sm65861077pbc.9.2014.06.09.15.20.45
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 09 Jun 2014 15:20:47 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Mon, 09 Jun 2014 15:20:44 -0700
X-Mailer: git-send-email 2.0.0.592.gf55b190
In-Reply-To: <cover.1402348696.git.jmmahler@gmail.com>
In-Reply-To: <cover.1402348696.git.jmmahler@gmail.com>
References: <cover.1402348696.git.jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251115>

Simplify cases where a strbuf_reset is immediately followed by a
strbuf_add by using strbuf_set operations.

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 builtin/checkout.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 9cbe7d1..38fc0ce 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -912,8 +912,7 @@ static int prepare_linked_checkout(const struct checkout_opts *opts,
 			  sb_git.buf);
 	junk_work_tree = path;
 
-	strbuf_reset(&sb);
-	strbuf_addf(&sb, "%s/gitdir", sb_repo.buf);
+	strbuf_setf(&sb, "%s/gitdir", sb_repo.buf);
 	write_file(sb.buf, 1, "%s\n", real_path(sb_git.buf));
 	write_file(sb_git.buf, 1, "gitdir: %s/repos/%s\n",
 		   real_path(get_git_common_dir()), name);
@@ -923,11 +922,9 @@ static int prepare_linked_checkout(const struct checkout_opts *opts,
 	 * value would do because this value will be ignored and
 	 * replaced at the next (real) checkout.
 	 */
-	strbuf_reset(&sb);
-	strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
+	strbuf_setf(&sb, "%s/HEAD", sb_repo.buf);
 	write_file(sb.buf, 1, "%s\n", sha1_to_hex(new->commit->object.sha1));
-	strbuf_reset(&sb);
-	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
+	strbuf_setf(&sb, "%s/commondir", sb_repo.buf);
 	write_file(sb.buf, 1, "../..\n");
 
 	if (!opts->quiet)
@@ -942,8 +939,7 @@ static int prepare_linked_checkout(const struct checkout_opts *opts,
 	ret = run_command(&cp);
 	if (!ret)
 		is_junk = 0;
-	strbuf_reset(&sb);
-	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
+	strbuf_setf(&sb, "%s/locked", sb_repo.buf);
 	unlink_or_warn(sb.buf);
 	strbuf_release(&sb);
 	strbuf_release(&sb_repo);
@@ -1048,8 +1044,7 @@ static void check_linked_checkouts(struct branch_info *new)
 		return;
 	}
 
-	strbuf_reset(&path);
-	strbuf_addf(&path, "%s/HEAD", get_git_common_dir());
+	strbuf_setf(&path, "%s/HEAD", get_git_common_dir());
 	/*
 	 * $GIT_COMMON_DIR/HEAD is practically outside
 	 * $GIT_DIR so resolve_ref_unsafe() won't work (it
@@ -1064,8 +1059,7 @@ static void check_linked_checkouts(struct branch_info *new)
 	while ((d = readdir(dir)) != NULL) {
 		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
 			continue;
-		strbuf_reset(&path);
-		strbuf_addf(&path, "%s/repos/%s/HEAD",
+		strbuf_setf(&path, "%s/repos/%s/HEAD",
 			    get_git_common_dir(), d->d_name);
 		if (check_linked_checkout(new, d->d_name, path.buf))
 			break;
-- 
2.0.0.592.gf55b190

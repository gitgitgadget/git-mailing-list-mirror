From: Johan Herland <johan@herland.net>
Subject: [PATCH 1/3] finish_copy_notes_for_rewrite(): Let caller provide commit message
Date: Wed, 12 Jun 2013 02:12:59 +0200
Message-ID: <1370995981-1553-2-git-send-email-johan@herland.net>
References: <7vehc8a05n.fsf@alter.siamese.dyndns.org>
 <1370995981-1553-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, jrnieder@gmail.com, pclouds@gmail.com,
	artagnon@gmail.com, john@keeping.me.uk, vfr@lyx.org, peff@peff.net,
	felipe.contreras@gmail.com, torvalds@linux-foundation.org,
	johan@herland.net, Thomas Rast <trast@inf.ethz.ch>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jun 12 02:13:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmYh4-0005GZ-TO
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 02:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756428Ab3FLANj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 20:13:39 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:51830 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755642Ab3FLANi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 20:13:38 -0400
Received: by mail-la0-f49.google.com with SMTP id ea20so3812106lab.8
        for <git@vger.kernel.org>; Tue, 11 Jun 2013 17:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=UOwr/L0e1B+ltOXb4nRe0Wa2hnkr50K6Sl8MLG8CA1U=;
        b=hLGiuY79hByMXdWMLnx1O7V3Hb7qPB5L6pmHyeSLU1wUZxymzPPjGLY7goUjtTPCWB
         sr0z/twySKDTfbi2XMtlr2XtTTZYe1ILwmjjoE5RlCV5I++1l45RU1Wjwl6z0ev5w8YQ
         tWyXan1sLBAtePzBNxThARp2FvidbAHLpkYhGUmeBgt2qttDDpHyA0C5uuPWQdnU77Ll
         8/TFgXtyiEeJNXIapoSWAjhWtnS06gn3GaWuo5Gmq76yrg8XGbrD9Nif5FPUN9h1HlYO
         pUYu+dOSqcGuvEqusi21MOdn4rzDiAV5q2ijhb/PYicn6QXfzD9Jz7LCItd8Ufu4uVo4
         fPWQ==
X-Received: by 10.152.44.225 with SMTP id h1mr8343096lam.90.1370996016899;
        Tue, 11 Jun 2013 17:13:36 -0700 (PDT)
Received: from gamma.herland (cm-84.208.177.71.getinternet.no. [84.208.177.71])
        by mx.google.com with ESMTPSA id x3sm7102525lag.6.2013.06.11.17.13.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 11 Jun 2013 17:13:35 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3.704.g33f7d4f
In-Reply-To: <1370995981-1553-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227581>

When copying notes for a rewritten object, the resulting notes commit
would have the following hardcoded commit message:

  Notes added by 'git notes copy'

This is obviously bogus when the notes rewriting is performed by
'git commit --amend'.

Therefore, let the caller specify an appropriate notes commit message
instead of hardcoding it. The above message is used for 'git notes copy',
but when calling finish_copy_notes_for_rewrite() from builtin/commit.c,
we use the following message instead:

  Notes added by 'git commit --amend'

Cc: Thomas Rast <trast@inf.ethz.ch>
Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin.h        | 2 +-
 builtin/commit.c | 2 +-
 builtin/notes.c  | 9 +++++----
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/builtin.h b/builtin.h
index faef559..78fb14d 100644
--- a/builtin.h
+++ b/builtin.h
@@ -36,7 +36,7 @@ struct notes_rewrite_cfg {
 struct notes_rewrite_cfg *init_copy_notes_for_rewrite(const char *cmd);
 int copy_note_for_rewrite(struct notes_rewrite_cfg *c,
 			  const unsigned char *from_obj, const unsigned char *to_obj);
-void finish_copy_notes_for_rewrite(struct notes_rewrite_cfg *c);
+void finish_copy_notes_for_rewrite(struct notes_rewrite_cfg *c, const char *msg);
 
 extern int textconv_object(const char *path, unsigned mode, const unsigned char *sha1, int sha1_valid, char **buf, unsigned long *buf_size);
 
diff --git a/builtin/commit.c b/builtin/commit.c
index d2f30d9..f8df8ca 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1591,7 +1591,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		if (cfg) {
 			/* we are amending, so current_head is not NULL */
 			copy_note_for_rewrite(cfg, current_head->object.sha1, sha1);
-			finish_copy_notes_for_rewrite(cfg);
+			finish_copy_notes_for_rewrite(cfg, "Notes added by 'git commit --amend'");
 		}
 		run_rewrite_hook(current_head->object.sha1, sha1);
 	}
diff --git a/builtin/notes.c b/builtin/notes.c
index 57748a6..6a80714 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -403,11 +403,11 @@ int copy_note_for_rewrite(struct notes_rewrite_cfg *c,
 	return ret;
 }
 
-void finish_copy_notes_for_rewrite(struct notes_rewrite_cfg *c)
+void finish_copy_notes_for_rewrite(struct notes_rewrite_cfg *c, const char *msg)
 {
 	int i;
 	for (i = 0; c->trees[i]; i++) {
-		commit_notes(c->trees[i], "Notes added by 'git notes copy'");
+		commit_notes(c->trees[i], msg);
 		free_notes(c->trees[i]);
 	}
 	free(c->trees);
@@ -420,6 +420,7 @@ static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
 	struct notes_rewrite_cfg *c = NULL;
 	struct notes_tree *t = NULL;
 	int ret = 0;
+	const char *msg = "Notes added by 'git notes copy'";
 
 	if (rewrite_cmd) {
 		c = init_copy_notes_for_rewrite(rewrite_cmd);
@@ -461,10 +462,10 @@ static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
 	}
 
 	if (!rewrite_cmd) {
-		commit_notes(t, "Notes added by 'git notes copy'");
+		commit_notes(t, msg);
 		free_notes(t);
 	} else {
-		finish_copy_notes_for_rewrite(c);
+		finish_copy_notes_for_rewrite(c, msg);
 	}
 	return ret;
 }
-- 
1.8.1.3.704.g33f7d4f

From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 14/16] worktree: avoid resolving HEAD unnecessarily
Date: Fri, 10 Jul 2015 20:05:44 -0400
Message-ID: <1436573146-3893-15-git-send-email-sunshine@sunshineco.com>
References: <1436573146-3893-1-git-send-email-sunshine@sunshineco.com>
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 11 09:34:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDpIX-0003fb-RG
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jul 2015 09:34:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752672AbbGKHeF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2015 03:34:05 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:33973 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752409AbbGKHeD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2015 03:34:03 -0400
Received: by igvi1 with SMTP id i1so4453896igv.1
        for <git@vger.kernel.org>; Sat, 11 Jul 2015 00:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=63olkHHMVqks3O3NTjrTEuEPfFC7cyPSnH6Zb//E9iM=;
        b=pSg0GV5jWei/PgJnEYoBLQ1oU6p2uU+uyORWNAl1R3+oaHkCZyrUxmxnJqFYVgzQjL
         moRgYV8/94BWOatFrxgdEdY5Cqzg7/oCk95DFTcOCTGU6ORyqpVKq0qyfYF8XQJQPa+l
         gR+M4I99WlO+FnsVgBE+iEHNmMgv1AksAFSHDO9bbgYe+h/XR3mNwvNM2Z4PxV5uMUGr
         PStvKpCt7c2d8C2SFm091rsa/YeEnpx5aqg6sOYDMI0olbZPQrFGr7skGrAoBv8xyjmK
         0a8MG2UNecatG04CkHuzhpdv4BLXP+sXk1kCi+lBY3LvHRvJA1fJdNsbvs9aGNUclSEH
         EdIA==
X-Received: by 10.50.90.179 with SMTP id bx19mr1216926igb.43.1436573200083;
        Fri, 10 Jul 2015 17:06:40 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id g81sm7533321ioi.20.2015.07.10.17.06.39
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jul 2015 17:06:39 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.201.ga12d9f8
In-Reply-To: <1436573146-3893-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273866>

Now that git-worktree sets HEAD explicitly to its final value via either
git-symbolic-ref or git-update-ref, rather than relying upon
git-checkout to do so, the "hack" for pacifying is_git_directory() with
a temporary HEAD, though still necessary, can be simplified.

Since the real HEAD is now populated with its proper final value, the
value of the temporary HEAD truly no longer matters, and any value which
looks like an object ID is good enough to satisfy is_git_directory().
Therefore, just set the temporary HEAD to a literal value rather than
going through the effort of resolving the current branch's HEAD.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/worktree.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 94c1701..9101a3c 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -191,7 +191,6 @@ static int add_worktree(const char *path, const char *refname,
 	int counter = 0, len, ret;
 	struct strbuf symref = STRBUF_INIT;
 	struct commit *commit = NULL;
-	unsigned char rev[20];
 
 	if (file_exists(path) && !is_empty_dir(path))
 		die(_("'%s' already exists"), path);
@@ -249,20 +248,14 @@ static int add_worktree(const char *path, const char *refname,
 		   real_path(get_git_common_dir()), name);
 	/*
 	 * This is to keep resolve_ref() happy. We need a valid HEAD
-	 * or is_git_directory() will reject the directory. Moreover, HEAD
-	 * in the new worktree must resolve to the same value as HEAD in
-	 * the current tree since the command invoked to populate the new
-	 * worktree will be handed the branch/ref specified by the user.
-	 * For instance, if the user asks for the new worktree to be based
-	 * at HEAD~5, then the resolved HEAD~5 in the new worktree must
-	 * match the resolved HEAD~5 in the current tree in order to match
-	 * the user's expectation.
+	 * or is_git_directory() will reject the directory. Any value which
+	 * looks like an object ID will do since it will be immediately
+	 * replaced by the symbolic-ref or update-ref invocation in the new
+	 * worktree.
 	 */
-	if (!resolve_ref_unsafe("HEAD", 0, rev, NULL))
-		die(_("unable to resolve HEAD"));
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
-	write_file(sb.buf, 1, "%s\n", sha1_to_hex(rev));
+	write_file(sb.buf, 1, "0000000000000000000000000000000000000000\n");
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
 	write_file(sb.buf, 1, "../..\n");
-- 
2.5.0.rc1.201.ga12d9f8

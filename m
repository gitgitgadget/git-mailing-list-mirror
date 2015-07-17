From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 20/22] worktree: avoid resolving HEAD unnecessarily
Date: Fri, 17 Jul 2015 19:00:15 -0400
Message-ID: <1437174017-81687-21-git-send-email-sunshine@sunshineco.com>
References: <1437174017-81687-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 01:01:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGEdS-0002S0-M0
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 01:01:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754081AbbGQXBc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 19:01:32 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:35998 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754049AbbGQXBb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 19:01:31 -0400
Received: by igbij6 with SMTP id ij6so47746758igb.1
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 16:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mbaarnW0RSQkD6bPYzzXYwsEgfqtXGq0Z2eornA7fDc=;
        b=aWMIoRoDBoSzVE4powdjdsNt4EzQN7Wh31S5/wXWAMRDWd5GXqEbgmKNzFViX0y9li
         QCZ3qieKtaSsznsgZOhGYxh4A+odXQPhm5e6Kp/B7Z6l/sX2swUqo7gEePAcYFf0onc+
         ZLvZqLCVVxNqhLNOcI97VcNemRtTsPelidFwThIQuWFEna1gBmIu39JmZYZBb8Vrcix3
         muKN/KIdCGJIQPOWG/jZq7dFpf6w2+JpQ2WtCaLc9XHcI4fmrTyUg+DjSXhmWOx/DR9j
         8S0C9z0gFjosjYyTEm4bqeW3y0CqiYGGn1J2gliVGH5JF2a0efgqhWbwlCVvonHkayqA
         fmyQ==
X-Received: by 10.50.98.3 with SMTP id ee3mr974355igb.10.1437174090781;
        Fri, 17 Jul 2015 16:01:30 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id 140sm8414824ion.16.2015.07.17.16.01.30
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Jul 2015 16:01:30 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.378.g0af52e8
In-Reply-To: <1437174017-81687-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274136>

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

No changes since v2.

 builtin/worktree.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 79d088c..4619308 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -192,7 +192,6 @@ static int add_worktree(const char *path, const char *refname,
 	int counter = 0, len, ret;
 	struct strbuf symref = STRBUF_INIT;
 	struct commit *commit = NULL;
-	unsigned char rev[20];
 
 	if (file_exists(path) && !is_empty_dir(path))
 		die(_("'%s' already exists"), path);
@@ -253,20 +252,14 @@ static int add_worktree(const char *path, const char *refname,
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
2.5.0.rc2.378.g0af52e8
